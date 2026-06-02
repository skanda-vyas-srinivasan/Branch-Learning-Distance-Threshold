#!/usr/bin/env python3
"""Run the Zjz12138 Learn2Branch/Ecole fork on a Vast.ai instance.

This runner assumes a plain Ubuntu/PyTorch/CUDA Docker environment. It does
not use Conda, condacolab, Colab, or Google Drive. Progress is checkpointed by
committing the fork model artifacts to the current Git repository and pushing
them to GitHub.

Run:
    GITHUB_TOKEN=mytoken python vast_runner_zjz.py

Sample-only run with archive copy:
    L2B_STAGE=samples SAMPLE_ARCHIVE_DIR=/mnt/gdrive GITHUB_TOKEN=mytoken python vast_runner_zjz.py

Train-only run after restoring/downloading the archive:
    L2B_STAGE=train SAMPLE_ARCHIVE_PATH=/path/to/samples_setcover_500r_1000c_0.05d.tar.gz GITHUB_TOKEN=mytoken python vast_runner_zjz.py
"""

from __future__ import annotations

import importlib.util
import hashlib
import json
import os
import shutil
import subprocess
import sys
import tarfile
import threading
import time
from pathlib import Path


ROOT = Path(os.environ.get("L2B_ROOT", Path.cwd())).resolve()
WORK_DIR = ROOT / "vast_work_zjz"
ECOLE_REPO = WORK_DIR / "learn2branch-ecole-zjz"
ORIGINAL_REPO = WORK_DIR / "learn2branch"

NROWS = 500
NCOLS = 1000
DENSITY = 0.05
SEED = 0

N_TRAIN_INSTANCES = 10_000
N_VALID_INSTANCES = 2_000
N_TEST_INSTANCES = 2_000

TRAIN_SAMPLES = 100_000
VALID_SAMPLES = 20_000
TEST_SAMPLES = 0
NODE_RECORD_PROB = 0.05
SAMPLE_TIME_LIMIT = 3600
N_JOBS = 8

MAX_EPOCHS = 1000
EPOCH_SAMPLES = 10_000
BATCH_SIZE = int(os.environ.get("L2B_BATCH_SIZE", "32"))
PRETRAIN_BATCH_SIZE = int(os.environ.get("L2B_PRETRAIN_BATCH_SIZE", "32"))
VALID_BATCH_SIZE = int(os.environ.get("L2B_VALID_BATCH_SIZE", "32"))
SAMPLE_LOG_EVERY = 10
SAMPLE_CHECKPOINT_EVERY = 5_000

SAMPLE_DIR = ECOLE_REPO / "data" / "samples" / "setcover" / "500r_1000c_0.05d"
INSTANCE_DIR = ECOLE_REPO / "data" / "instances" / "setcover"
MODEL_DIR = ECOLE_REPO / "model_zjz" / "setcover" / str(SEED)
ARTIFACT_DIR = WORK_DIR / "artifacts"
SAMPLE_ARCHIVE = ARTIFACT_DIR / "samples_setcover_500r_1000c_0.05d.tar.gz"
SAMPLE_MANIFEST = ARTIFACT_DIR / "samples_setcover_500r_1000c_0.05d_manifest.json"

REMOTE_URL = "https://{token}@github.com/skanda-vyas-srinivasan/Branch-Learning-Distance-Threshold.git"


def run(args: list[str], cwd: Path | None = None, check: bool = True) -> subprocess.CompletedProcess:
    print("+", " ".join(str(a) for a in args), flush=True)
    return subprocess.run(args, cwd=cwd, check=check)


def run_capture(args: list[str], cwd: Path | None = None, check: bool = True) -> subprocess.CompletedProcess:
    return subprocess.run(args, cwd=cwd, check=check, text=True, capture_output=True)


def require_python_311() -> None:
    if sys.version_info[:2] != (3, 11):
        raise RuntimeError(
            "Vast runner requires Python 3.11.x because Ecole wheels/env support "
            f"are Python-version sensitive. Current Python is {sys.version}. "
            "Run with a Python 3.11 Docker image or install Python 3.11 first."
        )


def pip_install_missing() -> None:
    required_modules = {
        "ecole": "ecole",
        "pyscipopt": "pyscipopt",
        "torch_geometric": "torch-geometric",
        "numpy": "numpy",
        "scipy": "scipy",
        "pandas": "pandas",
        "matplotlib": "matplotlib",
    }
    missing = []
    for module_name, package_name in required_modules.items():
        if importlib.util.find_spec(module_name) is None:
            missing.append(package_name)

    if missing:
        run([sys.executable, "-m", "pip", "install", "-U", *missing])
    else:
        print("python dependencies already installed", flush=True)


def print_system_info() -> None:
    print(f"python: {sys.executable} {sys.version}", flush=True)
    total, used, free = shutil.disk_usage(ROOT)
    print(
        "disk: "
        f"total={total / 1024**3:.1f}GB "
        f"used={used / 1024**3:.1f}GB "
        f"free={free / 1024**3:.1f}GB "
        f"path={ROOT}",
        flush=True,
    )

    try:
        import torch

        print(f"torch: {torch.__version__}", flush=True)
        print(f"cuda available: {torch.cuda.is_available()}", flush=True)
        print(f"cuda version: {torch.version.cuda}", flush=True)
        if torch.cuda.is_available():
            print(f"gpu: {torch.cuda.get_device_name(0)}", flush=True)
    except Exception as exc:
        print(f"torch inspection failed: {exc}", flush=True)

    run(["nvidia-smi"], check=False)


def heartbeat(stop_event: threading.Event, label: str, interval_seconds: int = 60) -> None:
    elapsed = 0
    while not stop_event.wait(interval_seconds):
        elapsed += interval_seconds
        print(f"[heartbeat] {label}: still running after {elapsed // 60} min", flush=True)


def git_setup() -> None:
    token = os.environ.get("GITHUB_TOKEN")
    if not token:
        raise RuntimeError("GITHUB_TOKEN is required. Run as: GITHUB_TOKEN=mytoken python vast_runner.py")

    if not (ROOT / ".git").exists():
        raise RuntimeError(f"{ROOT} is not a Git repository. Run vast_runner.py from the repo root.")

    run(["git", "remote", "set-url", "origin", REMOTE_URL.format(token=token)], cwd=ROOT)
    run(["git", "config", "user.email", os.environ.get("GIT_AUTHOR_EMAIL", "vast-runner@users.noreply.github.com")], cwd=ROOT)
    run(["git", "config", "user.name", os.environ.get("GIT_AUTHOR_NAME", "vast-runner")], cwd=ROOT)


def git_commit_push(message: str, paths: list[Path]) -> None:
    git_setup()
    existing_paths = [p for p in paths if p.exists()]
    if not existing_paths:
        print(f"[git] no existing paths for checkpoint: {message}", flush=True)
        return

    run(["git", "add", "-f", "--", *[str(p.relative_to(ROOT)) for p in existing_paths]], cwd=ROOT)
    status = run_capture(["git", "status", "--porcelain", "--", *[str(p.relative_to(ROOT)) for p in existing_paths]], cwd=ROOT)
    if not status.stdout.strip():
        print(f"[git] no changes to commit for: {message}", flush=True)
        return

    run(["git", "commit", "-m", message], cwd=ROOT)
    run(["git", "push"], cwd=ROOT)
    print(f"[git] pushed checkpoint: {message}", flush=True)


def remove_nested_git_metadata(path: Path) -> None:
    nested_git = path / ".git"
    if nested_git.exists():
        shutil.rmtree(nested_git)


def ensure_repos() -> None:
    WORK_DIR.mkdir(parents=True, exist_ok=True)
    if not ECOLE_REPO.exists():
        run(["git", "clone", "--depth", "1", "https://github.com/Zjz12138/learn2branch-ecole.git", str(ECOLE_REPO)])
        remove_nested_git_metadata(ECOLE_REPO)
    if not ORIGINAL_REPO.exists():
        run(["git", "clone", "--depth", "1", "https://github.com/ds4dm/learn2branch.git", str(ORIGINAL_REPO)])
        remove_nested_git_metadata(ORIGINAL_REPO)


def patch_scripts() -> None:
    train_py = ECOLE_REPO / "03_train_gnn.py"

    text = train_py.read_text()
    text = text.replace(
        "    running_dir = f\"model_1/{args.problem}/{args.seed}\"",
        "    running_dir = f\"model_zjz/{args.problem}/{args.seed}\"",
    )
    text = text.replace(
        "    logfile = os.path.join(running_dir, f'train_BGCN_{args.problem}_log.txt')",
        "    logfile = os.path.join(running_dir, 'train_log.txt')",
    )
    text = text.replace(
        "torch.save(policy.state_dict(), pathlib.Path(running_dir)/f'train_BGCN_{args.problem}_params.pkl')",
        "torch.save(policy.state_dict(), pathlib.Path(running_dir)/'train_params.pkl')",
    )
    text = text.replace(
        "policy.load_state_dict(torch.load(pathlib.Path(running_dir)/f'train_BGCN_{args.problem}_params.pkl'))",
        "policy.load_state_dict(torch.load(pathlib.Path(running_dir)/'train_params.pkl'))",
    )
    train_py.write_text(text)

    run([sys.executable, "-m", "py_compile", str(train_py)])
    print("fork output path patch applied", flush=True)

def sample_count(split: str = "train") -> int:
    return len(list((SAMPLE_DIR / split).glob("sample_*.pkl")))


def sample_counts() -> dict[str, int]:
    return {split: sample_count(split) for split in ("train", "valid", "test")}


def total_sample_count() -> int:
    return sum(sample_count(split) for split in ("train", "valid", "test"))


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def archive_samples() -> None:
    counts = sample_counts()
    if counts["train"] < TRAIN_SAMPLES or counts["valid"] < VALID_SAMPLES:
        raise RuntimeError(
            "refusing to archive incomplete samples: "
            f"train={counts['train']}/{TRAIN_SAMPLES}, valid={counts['valid']}/{VALID_SAMPLES}"
        )

    ARTIFACT_DIR.mkdir(parents=True, exist_ok=True)
    tmp_archive = SAMPLE_ARCHIVE.with_name(f"{SAMPLE_ARCHIVE.name}.tmp")
    if tmp_archive.exists():
        tmp_archive.unlink()

    print(f"[sample-archive] creating {SAMPLE_ARCHIVE}", flush=True)
    with tarfile.open(tmp_archive, "w:gz") as tar:
        tar.add(SAMPLE_DIR, arcname="data/samples/setcover/500r_1000c_0.05d")
    tmp_archive.replace(SAMPLE_ARCHIVE)

    archive_sha256 = sha256_file(SAMPLE_ARCHIVE)
    manifest = {
        "archive": SAMPLE_ARCHIVE.name,
        "sha256": archive_sha256,
        "bytes": SAMPLE_ARCHIVE.stat().st_size,
        "sample_counts": counts,
        "settings": {
            "nrows": NROWS,
            "ncols": NCOLS,
            "density": DENSITY,
            "seed": SEED,
            "train_samples": TRAIN_SAMPLES,
            "valid_samples": VALID_SAMPLES,
            "test_samples": TEST_SAMPLES,
            "node_record_prob": NODE_RECORD_PROB,
        },
    }
    SAMPLE_MANIFEST.write_text(json.dumps(manifest, indent=2) + "\n")
    print(
        f"[sample-archive] wrote {SAMPLE_ARCHIVE} "
        f"({SAMPLE_ARCHIVE.stat().st_size / 1024**3:.2f}GB, sha256={archive_sha256})",
        flush=True,
    )

    archive_dir = os.environ.get("SAMPLE_ARCHIVE_DIR")
    if archive_dir:
        destination = Path(archive_dir).expanduser().resolve()
        destination.mkdir(parents=True, exist_ok=True)
        print(f"[sample-archive] copying archive and manifest to {destination}", flush=True)
        shutil.copy2(SAMPLE_ARCHIVE, destination / SAMPLE_ARCHIVE.name)
        shutil.copy2(SAMPLE_MANIFEST, destination / SAMPLE_MANIFEST.name)
        print("[sample-archive] copy complete", flush=True)


def samples_complete() -> bool:
    counts = sample_counts()
    return counts["train"] >= TRAIN_SAMPLES and counts["valid"] >= VALID_SAMPLES


def find_sample_archive_for_restore() -> Path | None:
    explicit_path = os.environ.get("SAMPLE_ARCHIVE_PATH")
    if explicit_path:
        path = Path(explicit_path).expanduser().resolve()
        if not path.exists():
            raise RuntimeError(f"SAMPLE_ARCHIVE_PATH does not exist: {path}")
        return path

    archive_dir = os.environ.get("SAMPLE_ARCHIVE_DIR")
    if archive_dir:
        path = Path(archive_dir).expanduser().resolve() / SAMPLE_ARCHIVE.name
        if path.exists():
            return path

    if SAMPLE_ARCHIVE.exists():
        return SAMPLE_ARCHIVE
    return None


def restore_samples_from_archive_if_needed() -> None:
    if samples_complete():
        print(f"samples already available locally: {sample_counts()}", flush=True)
        return

    archive_path = find_sample_archive_for_restore()
    if archive_path is None:
        raise RuntimeError(
            "samples are not complete locally and no archive was found. "
            "Set SAMPLE_ARCHIVE_PATH=/path/to/samples_setcover_500r_1000c_0.05d.tar.gz "
            "or rerun L2B_STAGE=samples first."
        )

    print(f"[sample-archive] restoring samples from {archive_path}", flush=True)
    destination_root = ECOLE_REPO.resolve()
    with tarfile.open(archive_path, "r:gz") as tar:
        for member in tar.getmembers():
            target = (destination_root / member.name).resolve()
            if destination_root != target and destination_root not in target.parents:
                raise RuntimeError(f"unsafe path in sample archive: {member.name}")
        tar.extractall(destination_root)

    if not samples_complete():
        raise RuntimeError(f"sample archive restore did not produce complete samples: {sample_counts()}")
    print(f"[sample-archive] restore complete: {sample_counts()}", flush=True)


def generate_instances() -> None:
    import numpy as np

    sys.path.insert(0, str(ORIGINAL_REPO))
    spec = importlib.util.spec_from_file_location(
        "l2b_generator", ORIGINAL_REPO / "01_generate_instances.py"
    )
    if spec is None or spec.loader is None:
        raise RuntimeError("could not load Learn2Branch instance generator")
    l2b_generator = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(l2b_generator)

    def generate_split(split_name: str, n_instances: int, seed: int) -> None:
        out_dir = (
            ECOLE_REPO
            / "data"
            / "instances"
            / "setcover"
            / f"{split_name}_{NROWS}r_{NCOLS}c_{DENSITY}d"
        )
        out_dir.mkdir(parents=True, exist_ok=True)
        existing = len(list(out_dir.glob("instance_*.lp")))
        if existing >= n_instances:
            print(f"{split_name}: already has {existing}/{n_instances}", flush=True)
            return

        rng = np.random.RandomState(seed)
        for i in range(existing, n_instances):
            filename = out_dir / f"instance_{i + 1}.lp"
            l2b_generator.generate_setcover(
                NROWS, NCOLS, DENSITY, str(filename), rng, max_coef=100
            )
            if (i + 1) % 100 == 0 or (i + 1) == n_instances:
                print(f"{split_name}: generated {i + 1}/{n_instances}", flush=True)

    generate_split("train", N_TRAIN_INSTANCES, SEED)
    generate_split("valid", N_VALID_INSTANCES, SEED + 1)
    generate_split("test", N_TEST_INSTANCES, SEED + 2)


def run_in_thread_with_monitor(args: list[str], cwd: Path, monitor_label: str) -> None:
    error: list[BaseException] = []

    def target() -> None:
        try:
            run(args, cwd=cwd)
        except BaseException as exc:
            error.append(exc)

    thread = threading.Thread(target=target, daemon=True)
    thread.start()
    last_heartbeat = time.monotonic()
    while thread.is_alive():
        if time.monotonic() - last_heartbeat >= 60:
            print(f"[heartbeat] {monitor_label}: still running", flush=True)
            last_heartbeat = time.monotonic()
        time.sleep(5)
    thread.join()
    if error:
        raise error[0]


def collect_samples() -> None:
    if sample_count("train") >= TRAIN_SAMPLES and sample_count("valid") >= VALID_SAMPLES:
        print(
            f"samples already complete: train={sample_count('train')}/{TRAIN_SAMPLES}, "
            f"valid={sample_count('valid')}/{VALID_SAMPLES}",
            flush=True,
        )
        return

    args = [
        sys.executable,
        "02_generate_dataset.py",
        "setcover",
        "-j",
        str(N_JOBS),
        "--train-size",
        str(TRAIN_SAMPLES),
        "--valid-size",
        str(VALID_SAMPLES),
        "--test-size",
        str(TEST_SAMPLES),
        "--node-record-prob",
        str(NODE_RECORD_PROB),
        "--time-limit",
        str(SAMPLE_TIME_LIMIT),
    ]

    error: list[BaseException] = []

    def target() -> None:
        try:
            run(args, cwd=ECOLE_REPO)
        except BaseException as exc:
            error.append(exc)

    thread = threading.Thread(target=target, daemon=True)
    thread.start()
    last_logged = (total_sample_count() // SAMPLE_LOG_EVERY) * SAMPLE_LOG_EVERY
    last_local_checkpoint = (total_sample_count() // SAMPLE_CHECKPOINT_EVERY) * SAMPLE_CHECKPOINT_EVERY
    last_heartbeat = time.monotonic()

    while thread.is_alive():
        count = total_sample_count()
        if count >= last_logged + SAMPLE_LOG_EVERY:
            last_logged = (count // SAMPLE_LOG_EVERY) * SAMPLE_LOG_EVERY
            print(f"[sample-progress] {count} samples written", flush=True)
        if count >= last_local_checkpoint + SAMPLE_CHECKPOINT_EVERY:
            last_local_checkpoint = (count // SAMPLE_CHECKPOINT_EVERY) * SAMPLE_CHECKPOINT_EVERY
            print(
                f"[sample-checkpoint] {last_local_checkpoint} samples visible locally; "
                "not pushing sample files",
                flush=True,
            )
        if time.monotonic() - last_heartbeat >= 60:
            print(f"[sample-heartbeat] generator running, {count} samples currently visible", flush=True)
            last_heartbeat = time.monotonic()
        time.sleep(5)

    thread.join()
    if error:
        raise error[0]

    count = total_sample_count()
    print(f"[sample-progress] generator exited with {count} samples written", flush=True)


def train_model() -> None:
    os.environ.setdefault("PYTORCH_CUDA_ALLOC_CONF", "expandable_segments:True")

    import torch

    gpu_id = "0" if torch.cuda.is_available() else "-1"
    args = [
        sys.executable,
        "03_train_gnn.py",
        "--problem",
        "setcover",
        "-s",
        str(SEED),
        "-g",
        gpu_id,
    ]
    run_in_thread_with_monitor(args, ECOLE_REPO, "training")
    git_commit_push(
        "Vast Zjz fork training complete",
        [MODEL_DIR / "train_params.pkl", MODEL_DIR / "train_log.txt"],
    )


def main() -> None:
    stage = os.environ.get("L2B_STAGE", "all").lower()
    valid_stages = {"all", "samples", "train"}
    if stage not in valid_stages:
        raise RuntimeError(f"L2B_STAGE must be one of {sorted(valid_stages)}, got {stage!r}")

    require_python_311()
    print_system_info()
    pip_install_missing()

    import ecole
    import torch
    import torch_geometric

    print(f"ecole: {ecole.__version__}", flush=True)
    print(f"torch_geometric: {torch_geometric.__version__}", flush=True)
    print(f"cuda available after dependency setup: {torch.cuda.is_available()}", flush=True)

    ensure_repos()
    patch_scripts()

    if stage in {"all", "samples"}:
        generate_instances()
        collect_samples()
        archive_samples()
        if stage == "samples":
            print("vast runner finished after sample generation/archive", flush=True)
            return

    if stage in {"all", "train"}:
        restore_samples_from_archive_if_needed()
        train_model()
    print("vast runner finished", flush=True)


if __name__ == "__main__":
    main()
