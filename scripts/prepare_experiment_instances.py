#!/usr/bin/env python3
"""Prepare the curated MILP instance folders used by experiment.ipynb."""

from __future__ import annotations

import argparse
import re
import shutil
from pathlib import Path

from scripts.generate_extra_instances import EXTRA_CLASSES, generate_extra_dataset


ROOT = Path(__file__).resolve().parents[1]


def natural_key(path: Path) -> list[object]:
    return [int(part) if part.isdigit() else part for part in re.split(r"(\d+)", path.name)]


def find_instances(path: Path) -> list[Path]:
    return sorted(list(path.glob("*.lp")) + list(path.glob("*.mps")), key=natural_key)


def first_existing(candidates: list[Path], minimum: int) -> Path | None:
    for candidate in candidates:
        if len(find_instances(candidate)) >= minimum:
            return candidate
    return None


def clear_generated_files(dest: Path) -> None:
    dest.mkdir(parents=True, exist_ok=True)
    for path in find_instances(dest):
        path.unlink()


def copy_curated(source: Path, dest: Path, prefix: str, count: int) -> list[Path]:
    files = find_instances(source)
    if len(files) < count:
        raise RuntimeError(f"need {count} instances in {source}, found {len(files)}")

    clear_generated_files(dest)
    copied = []
    for idx, src in enumerate(files[:count]):
        target = dest / f"{prefix}_{idx:03d}{src.suffix}"
        shutil.copy2(src, target)
        copied.append(target)
    print(f"{dest.name}: copied {len(copied)} from {source}", flush=True)
    return copied


def prepare_official_instances(dest_root: Path, count: int) -> None:
    sources = {
        "reference_setcover": (
            [
                ROOT / "setcover_instances" / "train",
                ROOT / "vast_work" / "learn2branch-ecole" / "data" / "instances" / "setcover" / "train_500r_1000c_0.05d",
            ],
            "setcover_reference",
        ),
        "eval_setcover": (
            [
                ROOT / "setcover_instances" / "test",
                ROOT / "setcover_instances" / "valid",
                ROOT / "vast_work" / "learn2branch-ecole" / "data" / "instances" / "setcover" / "valid_500r_1000c_0.05d",
            ],
            "setcover",
        ),
        "eval_cauctions": (
            [ROOT / "vast_work" / "learn2branch" / "data" / "instances" / "cauctions" / "transfer_100_500"],
            "cauctions",
        ),
        "eval_facilities": (
            [ROOT / "vast_work" / "learn2branch" / "data" / "instances" / "facilities" / "transfer_100_100_5"],
            "facilities",
        ),
        "eval_indset": (
            [ROOT / "vast_work" / "learn2branch" / "data" / "instances" / "indset" / "transfer_500_4"],
            "indset",
        ),
        "eval_mknapsack": (
            [
                ROOT / "vast_work" / "learn2branch" / "data" / "instances" / "mknapsack" / "transfer_100_6",
                ROOT / "generated_instances" / "multidim_knapsack",
            ],
            "mknapsack",
        ),
        "eval_setpartitioning": (
            [ROOT / "generated_instances" / "set_partitioning"],
            "setpartitioning",
        ),
        "eval_binpacking": (
            [ROOT / "generated_instances" / "bin_packing"],
            "binpacking",
        ),
    }

    for dest_name, (candidates, prefix) in sources.items():
        source = first_existing(candidates, count)
        if source is None:
            counts = {str(path): len(find_instances(path)) for path in candidates}
            raise RuntimeError(f"could not find {count} source instances for {dest_name}; counts={counts}")
        copy_curated(source, dest_root / dest_name, prefix, count)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--dest", default=ROOT / "data" / "instances", type=Path)
    parser.add_argument("--count", default=50, type=int)
    parser.add_argument("--seed", default=0, type=int)
    parser.add_argument("--attempts", default=500, type=int)
    parser.add_argument("--time-limit", default=10, type=int)
    parser.add_argument("--min-nodes", default=1, type=int)
    parser.add_argument("--skip-extra-generation", action="store_true")
    args = parser.parse_args()

    dest = args.dest.resolve()
    dest.mkdir(parents=True, exist_ok=True)
    prepare_official_instances(dest, args.count)

    if not args.skip_extra_generation:
        generate_extra_dataset(
            dest_root=dest,
            classes=EXTRA_CLASSES,
            target_count=args.count,
            attempts=args.attempts,
            seed=args.seed,
            min_nodes=args.min_nodes,
            time_limit=args.time_limit,
        )

    print(f"prepared curated instances under {dest}", flush=True)


if __name__ == "__main__":
    main()
