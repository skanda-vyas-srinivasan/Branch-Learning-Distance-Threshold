#!/usr/bin/env python3
"""Run the Learn2Branch/Ecole setcover Colab pipeline with conda Python.

Colab's notebook kernel can remain on the system Python while condacolab's
packages live under /usr/local/bin/python. This script is meant to be invoked
with /usr/local/bin/python from a Colab cell.
"""

from __future__ import annotations

import importlib.util
import os
import shutil
import subprocess
import sys
import tarfile
import threading
import time
from pathlib import Path

import numpy as np


ROOT = Path(os.environ.get("L2B_ROOT", "/content"))
ECOLE_REPO = ROOT / "learn2branch-ecole"
ORIGINAL_REPO = ROOT / "learn2branch"
DRIVE_DIR = Path("/content/drive/MyDrive/learn2branch_setcover_100k")

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
N_JOBS = 4

MAX_EPOCHS = 1000
EPOCH_SAMPLES = 10_000
BATCH_SIZE = 32
SAMPLE_LOG_EVERY = 10
SAMPLE_CHECKPOINT_EVERY = 5_000
TRAIN_CHECKPOINT_EVERY_SECONDS = 600
ARCHIVE_FINAL_SAMPLES = os.environ.get("L2B_ARCHIVE_FINAL_SAMPLES", "0") == "1"

INSTANCE_ARCHIVE = DRIVE_DIR / "instances_setcover_500r_1000c_0.05d.tar.gz"
SAMPLE_ARCHIVE = DRIVE_DIR / "samples_500r_1000c_0.05d.tar.gz"
LATEST_SAMPLE_CHECKPOINT = DRIVE_DIR / "partial_samples_latest_500r_1000c_0.05d.tar.gz"
LATEST_SAMPLE_COUNT = DRIVE_DIR / "partial_samples_latest_count.txt"
SAMPLE_DIR = ECOLE_REPO / "data" / "samples" / "setcover" / "500r_1000c_0.05d"
MIN_INSTANCE_ARCHIVE_BYTES = 100 * 1024 * 1024
ARCHIVE_TMP_DIR = ROOT / "learn2branch_archive_tmp"


def run(args: list[str], cwd: Path | None = None) -> None:
    print("+", " ".join(args), flush=True)
    subprocess.run(args, cwd=cwd, check=True)


def directory_size_mb(path: Path) -> float:
    total = 0
    if not path.exists():
        return 0.0
    for item in path.rglob("*"):
        if item.is_file():
            try:
                total += item.stat().st_size
            except OSError:
                pass
    return total / (1024 * 1024)


def heartbeat(stop_event: threading.Event, label: str, interval_seconds: int = 60) -> None:
    elapsed = 0
    while not stop_event.wait(interval_seconds):
        elapsed += interval_seconds
        print(f"[heartbeat] {label}: still running after {elapsed // 60} min", flush=True)


def tar_is_readable(path: Path) -> bool:
    try:
        with tarfile.open(path, "r:gz") as tar:
            tar.getmembers()
        return True
    except (OSError, tarfile.TarError, EOFError):
        return False


def ensure_repos() -> None:
    if not ECOLE_REPO.exists():
        run(["git", "clone", "https://github.com/ds4dm/learn2branch-ecole.git", str(ECOLE_REPO)])
    if not ORIGINAL_REPO.exists():
        run(["git", "clone", "https://github.com/ds4dm/learn2branch.git", str(ORIGINAL_REPO)])


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


def generate_instances() -> None:
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


def tar_directory(source: Path, target: Path, *, skip_existing: bool = False) -> None:
    if skip_existing and target.exists() and target.stat().st_size >= MIN_INSTANCE_ARCHIVE_BYTES:
        size_mb = target.stat().st_size / (1024 * 1024)
        print(f"[archive] checking existing archive ({size_mb:.1f} MB): {target}", flush=True)
        if tar_is_readable(target):
            print(f"[archive] existing archive is readable, skipping: {target}", flush=True)
            return
        print(f"[archive] existing archive is corrupt/incomplete, rebuilding: {target}", flush=True)

    target.parent.mkdir(parents=True, exist_ok=True)
    ARCHIVE_TMP_DIR.mkdir(parents=True, exist_ok=True)
    local_tmp = ARCHIVE_TMP_DIR / f"{target.name}.tmp"
    local_tmp.unlink(missing_ok=True)

    source_mb = directory_size_mb(source)
    print(f"[archive] start {source} -> {target} ({source_mb:.1f} MB input)", flush=True)
    start = time.monotonic()
    stop_event = threading.Event()
    thread = threading.Thread(target=heartbeat, args=(stop_event, f"archive {target.name}"), daemon=True)
    thread.start()
    with tarfile.open(local_tmp, "w:gz") as tar:
        tar.add(source, arcname=source.name)
    stop_event.set()
    thread.join(timeout=1)

    if not tar_is_readable(local_tmp):
        raise RuntimeError(f"archive failed integrity check: {local_tmp}")

    shutil.copy2(local_tmp, target)
    elapsed = time.monotonic() - start
    size_mb = target.stat().st_size / (1024 * 1024)
    print(f"[archive] done {target} ({size_mb:.1f} MB output, {elapsed / 60:.1f} min)", flush=True)


def tar_directory_atomic(source: Path, target: Path) -> None:
    if not source.exists():
        print(f"checkpoint skipped: missing {source}", flush=True)
        return
    ARCHIVE_TMP_DIR.mkdir(parents=True, exist_ok=True)
    tmp_target = ARCHIVE_TMP_DIR / f"{target.name}.tmp"
    target.parent.mkdir(parents=True, exist_ok=True)
    tmp_target.unlink(missing_ok=True)
    source_mb = directory_size_mb(source)
    print(f"[checkpoint-archive] start {source} -> {target} ({source_mb:.1f} MB input)", flush=True)
    start = time.monotonic()
    stop_event = threading.Event()
    thread = threading.Thread(
        target=heartbeat,
        args=(stop_event, f"checkpoint archive {target.name}"),
        daemon=True,
    )
    thread.start()
    with tarfile.open(tmp_target, "w:gz") as tar:
        tar.add(source, arcname=source.name)
    stop_event.set()
    thread.join(timeout=1)

    if not tar_is_readable(tmp_target):
        raise RuntimeError(f"checkpoint archive failed integrity check: {tmp_target}")

    shutil.copy2(tmp_target, target)
    elapsed = time.monotonic() - start
    size_mb = target.stat().st_size / (1024 * 1024)
    print(f"[checkpoint-archive] done {target} ({size_mb:.1f} MB output, {elapsed / 60:.1f} min)", flush=True)


def extract_archive(archive: Path, target_dir: Path) -> None:
    size_mb = archive.stat().st_size / (1024 * 1024)
    print(f"[extract] start {archive} -> {target_dir} ({size_mb:.1f} MB)", flush=True)
    target_dir.mkdir(parents=True, exist_ok=True)
    start = time.monotonic()
    stop_event = threading.Event()
    thread = threading.Thread(target=heartbeat, args=(stop_event, f"extract {archive.name}"), daemon=True)
    thread.start()
    with tarfile.open(archive, "r:gz") as tar:
        tar.extractall(target_dir)
    stop_event.set()
    thread.join(timeout=1)
    elapsed = time.monotonic() - start
    print(f"[extract] done {archive} ({elapsed / 60:.1f} min)", flush=True)


def latest_partial_sample_archive() -> Path | None:
    archives = sorted(
        list(DRIVE_DIR.glob("partial_samples_500r_1000c_0.05d_*.tar.gz"))
        + list(DRIVE_DIR.glob("partial_samples_latest_500r_1000c_0.05d.tar.gz"))
    )
    return archives[-1] if archives else None


def sample_count(split: str = "train") -> int:
    return len(list((SAMPLE_DIR / split).glob("sample_*.pkl")))


def total_sample_count() -> int:
    return sum(sample_count(split) for split in ("train", "valid", "test"))


def checkpoint_samples(label: str) -> None:
    count = total_sample_count()
    print(f"[checkpoint] {label}: saving {count} samples to Drive", flush=True)
    tar_directory_atomic(SAMPLE_DIR, LATEST_SAMPLE_CHECKPOINT)
    LATEST_SAMPLE_COUNT.write_text(f"{count}\n")
    print(
        f"[checkpoint] {label}: saved {LATEST_SAMPLE_CHECKPOINT.name} with {count} samples",
        flush=True,
    )


def run_with_sample_monitor(args: list[str], cwd: Path | None = None) -> None:
    print("+", " ".join(args), flush=True)
    process = subprocess.Popen(args, cwd=cwd)
    last_logged = (total_sample_count() // SAMPLE_LOG_EVERY) * SAMPLE_LOG_EVERY
    last_checkpoint = (total_sample_count() // SAMPLE_CHECKPOINT_EVERY) * SAMPLE_CHECKPOINT_EVERY
    last_heartbeat = time.monotonic()

    while process.poll() is None:
        count = total_sample_count()
        if count >= last_logged + SAMPLE_LOG_EVERY:
            last_logged = (count // SAMPLE_LOG_EVERY) * SAMPLE_LOG_EVERY
            print(f"[sample-progress] {count} samples written", flush=True)
        if count >= last_checkpoint + SAMPLE_CHECKPOINT_EVERY:
            last_checkpoint = (count // SAMPLE_CHECKPOINT_EVERY) * SAMPLE_CHECKPOINT_EVERY
            checkpoint_samples(f"{last_checkpoint}_samples")
        if time.monotonic() - last_heartbeat >= 60:
            print(f"[sample-heartbeat] generator running, {count} samples currently visible", flush=True)
            last_heartbeat = time.monotonic()
        time.sleep(5)

    return_code = process.wait()
    count = total_sample_count()
    print(f"[sample-progress] generator exited with {count} samples written", flush=True)
    if count > 0:
        checkpoint_samples("generator_exit")
    if return_code != 0:
        raise subprocess.CalledProcessError(return_code, args)


def restore_drive_checkpoints() -> None:
    instances_dir = ECOLE_REPO / "data" / "instances" / "setcover"
    if not instances_dir.exists() and INSTANCE_ARCHIVE.exists():
        extract_archive(INSTANCE_ARCHIVE, instances_dir.parent)

    if not SAMPLE_DIR.exists():
        partial = latest_partial_sample_archive()
        if partial is not None:
            extract_archive(partial, SAMPLE_DIR.parent)
            print(f"restored train samples: {sample_count('train')}", flush=True)


def save_artifacts() -> None:
    DRIVE_DIR.mkdir(parents=True, exist_ok=True)
    model_dir = ECOLE_REPO / "model" / "setcover" / str(SEED)
    if (model_dir / "train_params.pkl").exists():
        shutil.copy2(model_dir / "train_params.pkl", DRIVE_DIR / "train_params_seed0.pkl")
    if (model_dir / "train_log.txt").exists():
        shutil.copy2(model_dir / "train_log.txt", DRIVE_DIR / "train_log_seed0.txt")


def checkpoint_training(label: str) -> None:
    model_dir = ECOLE_REPO / "model" / "setcover" / str(SEED)
    copied = []
    if (model_dir / "train_params.pkl").exists():
        shutil.copy2(model_dir / "train_params.pkl", DRIVE_DIR / "train_params_latest.pkl")
        copied.append("train_params_latest.pkl")
    if (model_dir / "train_log.txt").exists():
        shutil.copy2(model_dir / "train_log.txt", DRIVE_DIR / "train_log_latest.txt")
        copied.append("train_log_latest.txt")
    if copied:
        print(f"[train-checkpoint] {label}: copied {', '.join(copied)}", flush=True)


def run_training_with_monitor(args: list[str], cwd: Path | None = None) -> None:
    print("+", " ".join(args), flush=True)
    process = subprocess.Popen(args, cwd=cwd)
    log_path = ECOLE_REPO / "model" / "setcover" / str(SEED) / "train_log.txt"
    printed_lines = 0
    last_checkpoint_time = time.monotonic()
    last_heartbeat = time.monotonic()

    while process.poll() is None:
        if log_path.exists():
            lines = log_path.read_text(errors="replace").splitlines()
            for line in lines[printed_lines:]:
                print(f"[train-log] {line}", flush=True)
            printed_lines = len(lines)

        if time.monotonic() - last_checkpoint_time >= TRAIN_CHECKPOINT_EVERY_SECONDS:
            checkpoint_training("periodic")
            last_checkpoint_time = time.monotonic()

        if time.monotonic() - last_heartbeat >= 60:
            print("[train-heartbeat] training process still running", flush=True)
            last_heartbeat = time.monotonic()

        time.sleep(15)

    return_code = process.wait()
    if log_path.exists():
        lines = log_path.read_text(errors="replace").splitlines()
        for line in lines[printed_lines:]:
            print(f"[train-log] {line}", flush=True)

    checkpoint_training("training_exit")
    if return_code != 0:
        raise subprocess.CalledProcessError(return_code, args)


def main() -> None:
    print(f"runner started with {sys.executable}: {sys.version}", flush=True)
    DRIVE_DIR.mkdir(parents=True, exist_ok=True)
    ensure_repos()
    restore_drive_checkpoints()

    import ecole
    import torch
    import torch_geometric

    print(f"ecole: {ecole.__version__}", flush=True)
    print(f"torch: {torch.__version__}", flush=True)
    print(f"torch_geometric: {torch_geometric.__version__}", flush=True)
    print(f"cuda available: {torch.cuda.is_available()}", flush=True)
    if torch.cuda.is_available():
        print(f"gpu: {torch.cuda.get_device_name(0)}", flush=True)

    patch_scripts()
    generate_instances()
    tar_directory(
        ECOLE_REPO / "data" / "instances" / "setcover",
        INSTANCE_ARCHIVE,
        skip_existing=True,
    )

    if sample_count("train") >= TRAIN_SAMPLES:
        print(f"train samples already complete: {sample_count('train')}/{TRAIN_SAMPLES}", flush=True)
    else:
        run_with_sample_monitor(
            [
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
            ],
            cwd=ECOLE_REPO,
        )

    for split in ("train", "valid", "test"):
        count = sample_count(split)
        print(f"{split} samples: {count}", flush=True)
    if ARCHIVE_FINAL_SAMPLES:
        tar_directory(SAMPLE_DIR, SAMPLE_ARCHIVE)
    else:
        print("skipping full pre-training sample archive by default; periodic checkpoints remain enabled", flush=True)

    run_training_with_monitor(
        [
            sys.executable,
            "03_train_gnn.py",
            "setcover",
            "-s",
            str(SEED),
            "-g",
            "0",
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
        ],
        cwd=ECOLE_REPO,
    )
    save_artifacts()
    print(f"artifacts saved in {DRIVE_DIR}", flush=True)


if __name__ == "__main__":
    main()
