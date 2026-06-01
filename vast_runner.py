#!/usr/bin/env python3
"""Run the Learn2Branch/Ecole setcover pipeline on a Vast.ai instance.

This runner assumes a plain Ubuntu/PyTorch/CUDA Docker environment. It does
not use Conda, condacolab, Colab, or Google Drive. Progress is checkpointed by
committing generated artifacts to the current Git repository and pushing them
to GitHub.

Run:
    GITHUB_TOKEN=mytoken python vast_runner.py
"""

from __future__ import annotations

import importlib.util
import os
import shutil
import subprocess
import sys
import threading
import time
from pathlib import Path


ROOT = Path(os.environ.get("L2B_ROOT", Path.cwd())).resolve()
WORK_DIR = ROOT / "vast_work"
ECOLE_REPO = WORK_DIR / "learn2branch-ecole"
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
BATCH_SIZE = 32
SAMPLE_LOG_EVERY = 10
SAMPLE_CHECKPOINT_EVERY = 5_000

SAMPLE_DIR = ECOLE_REPO / "data" / "samples" / "setcover" / "500r_1000c_0.05d"
INSTANCE_DIR = ECOLE_REPO / "data" / "instances" / "setcover"
MODEL_DIR = ECOLE_REPO / "model" / "setcover" / str(SEED)

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
        run(["git", "clone", "--depth", "1", "https://github.com/ds4dm/learn2branch-ecole.git", str(ECOLE_REPO)])
        remove_nested_git_metadata(ECOLE_REPO)
    if not ORIGINAL_REPO.exists():
        run(["git", "clone", "--depth", "1", "https://github.com/ds4dm/learn2branch.git", str(ORIGINAL_REPO)])
        remove_nested_git_metadata(ORIGINAL_REPO)


def patch_scripts() -> None:
    dataset_py = ECOLE_REPO / "02_generate_dataset.py"
    train_py = ECOLE_REPO / "03_train_gnn.py"
    utilities_py = ECOLE_REPO / "utilities.py"

    text = dataset_py.read_text()
    if "--train-size" not in text:
        text = text.replace(
            "    parser.add_argument(\n"
            "        '-j', '--njobs',\n"
            "        help='Number of parallel jobs.',\n"
            "        type=int,\n"
            "        default=1,\n"
            "    )",
            "    parser.add_argument(\n"
            "        '-j', '--njobs',\n"
            "        help='Number of parallel jobs.',\n"
            "        type=int,\n"
            "        default=1,\n"
            "    )\n"
            "    parser.add_argument('--train-size', type=int, default=100000)\n"
            "    parser.add_argument('--valid-size', type=int, default=20000)\n"
            "    parser.add_argument('--test-size', type=int, default=20000)\n"
            "    parser.add_argument('--node-record-prob', type=float, default=0.05)\n"
            "    parser.add_argument('--time-limit', type=float, default=None)",
        )
        text = text.replace(
            "    train_size = 100000\n"
            "    valid_size = 20000\n"
            "    test_size = 20000\n"
            "    node_record_prob = 0.05",
            "    train_size = args.train_size\n"
            "    valid_size = args.valid_size\n"
            "    test_size = args.test_size\n"
            "    node_record_prob = args.node_record_prob",
        )
        text = text.replace(
            '    print(f"{len(instances_train)} train instances for {train_size} samples")',
            "    if args.time_limit is not None:\n"
            "        time_limit = args.time_limit\n\n"
            '    print(f"{len(instances_train)} train instances for {train_size} samples")',
        )
        text = text.replace(
            "collect_samples(instances_valid, out_dir + '/valid', rng, test_size,",
            "collect_samples(instances_valid, out_dir + '/valid', rng, valid_size,",
        )
        dataset_py.write_text(text)
        text = dataset_py.read_text()

    if "existing_samples = len(glob.glob(f'{out_dir}/sample_*.pkl'))" not in text:
        text = text.replace(
            "    os.makedirs(out_dir, exist_ok=True)\n"
            "\n"
            "    # start workers",
            "    os.makedirs(out_dir, exist_ok=True)\n"
            "    existing_samples = len(glob.glob(f'{out_dir}/sample_*.pkl'))\n"
            "    if existing_samples >= n_samples:\n"
            "        print(f'Done collecting samples for {out_dir}: already has {existing_samples}/{n_samples}')\n"
            "        return\n"
            "\n"
            "    # start workers",
        )
        text = text.replace(
            "    tmp_samples_dir = f'{out_dir}/tmp'\n"
            "    os.makedirs(tmp_samples_dir, exist_ok=True)",
            "    tmp_samples_dir = f'{out_dir}/tmp'\n"
            "    shutil.rmtree(tmp_samples_dir, ignore_errors=True)\n"
            "    os.makedirs(tmp_samples_dir, exist_ok=True)",
        )
        text = text.replace(
            "    i = 0\n"
            "    in_buffer = 0\n"
            "    while i < n_samples:",
            "    i = existing_samples\n"
            "    in_buffer = 0\n"
            "    print(f'Resuming {out_dir}: {existing_samples}/{n_samples} samples already exist')\n"
            "    while i < n_samples:",
        )
        dataset_py.write_text(text)

    text = train_py.read_text()
    if "--max-epochs" not in text:
        text = text.replace(
            "    parser.add_argument(\n"
            "        '-g', '--gpu',\n"
            "        help='CUDA GPU id (-1 for CPU).',\n"
            "        type=int,\n"
            "        default=0,\n"
            "    )",
            "    parser.add_argument(\n"
            "        '-g', '--gpu',\n"
            "        help='CUDA GPU id (-1 for CPU).',\n"
            "        type=int,\n"
            "        default=0,\n"
            "    )\n"
            "    parser.add_argument('--max-epochs', type=int, default=1000)\n"
            "    parser.add_argument('--epoch-samples', type=int, default=10000)\n"
            "    parser.add_argument('--batch-size', type=int, default=32)\n"
            "    parser.add_argument('--pretrain-batch-size', type=int, default=128)\n"
            "    parser.add_argument('--valid-batch-size', type=int, default=128)",
        )
        text = text.replace(
            "    max_epochs = 1000\n"
            "    batch_size = 32\n"
            "    pretrain_batch_size = 128\n"
            "    valid_batch_size = 128",
            "    max_epochs = args.max_epochs\n"
            "    batch_size = args.batch_size\n"
            "    pretrain_batch_size = args.pretrain_batch_size\n"
            "    valid_batch_size = args.valid_batch_size",
        )
        text = text.replace(
            "int(np.floor(10000/batch_size))*batch_size",
            "int(np.floor(args.epoch_samples/batch_size))*batch_size",
        )
    text = text.replace(
        "Scheduler(optimizer, mode='min', patience=10, factor=0.2, verbose=True)",
        "Scheduler(optimizer, mode='min', patience=10, factor=0.2)",
    )
    train_py.write_text(text)

    text = utilities_py.read_text()
    if "_is_better" not in text[text.find("class Scheduler") :]:
        text = text.replace(
            "        if self.is_better(current, self.best):",
            "        is_better = self.is_better if hasattr(self, 'is_better') else self._is_better\n"
            "        if is_better(current, self.best):",
        )
        utilities_py.write_text(text)

    run(
        [
            sys.executable,
            "-m",
            "py_compile",
            str(dataset_py),
            str(train_py),
            str(utilities_py),
        ]
    )
    print("patches applied", flush=True)


def sample_count(split: str = "train") -> int:
    return len(list((SAMPLE_DIR / split).glob("sample_*.pkl")))


def total_sample_count() -> int:
    return sum(sample_count(split) for split in ("train", "valid", "test"))


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
    import torch

    gpu_id = "0" if torch.cuda.is_available() else "-1"
    args = [
        sys.executable,
        "03_train_gnn.py",
        "setcover",
        "-s",
        str(SEED),
        "-g",
        gpu_id,
        "--max-epochs",
        str(MAX_EPOCHS),
        "--epoch-samples",
        str(EPOCH_SAMPLES),
        "--batch-size",
        str(BATCH_SIZE),
        "--pretrain-batch-size",
        "128",
        "--valid-batch-size",
        "128",
    ]
    run_in_thread_with_monitor(args, ECOLE_REPO, "training")
    git_commit_push(
        "Vast training complete",
        [MODEL_DIR / "train_params.pkl", MODEL_DIR / "train_log.txt"],
    )


def main() -> None:
    require_python_311()
    print_system_info()
    git_setup()
    pip_install_missing()

    import ecole
    import torch
    import torch_geometric

    print(f"ecole: {ecole.__version__}", flush=True)
    print(f"torch_geometric: {torch_geometric.__version__}", flush=True)
    print(f"cuda available after dependency setup: {torch.cuda.is_available()}", flush=True)

    ensure_repos()
    patch_scripts()

    generate_instances()
    collect_samples()
    train_model()
    print("vast runner finished", flush=True)


if __name__ == "__main__":
    main()
