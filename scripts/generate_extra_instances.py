#!/usr/bin/env python3
"""Generate extra synthetic MILP families for the distance-gating experiment."""

from __future__ import annotations

import argparse
import contextlib
import math
import os
import random
from pathlib import Path
from typing import Callable


EXTRA_CLASSES = [
    "setpacking",
    "setpartitioning",
    "vertexcover",
    "binpacking",
    "generalized_assignment",
]


def solve_node_count(path: Path, time_limit: int) -> tuple[int | None, str]:
    import pyscipopt

    model = pyscipopt.Model()
    model.hideOutput(True)
    model.setParam("limits/time", float(time_limit))
    model.readProblem(str(path))
    model.optimize()
    try:
        nodes = int(model.getNNodes())
    except Exception:
        nodes = None
    return nodes, str(model.getStatus())


def write_problem(model, path: Path) -> None:
    with open(os.devnull, "w", encoding="utf-8") as sink:
        with contextlib.redirect_stdout(sink), contextlib.redirect_stderr(sink):
            model.writeProblem(str(path))


def write_setpacking(path: Path, rng: random.Random) -> None:
    import pyscipopt

    n_elements = rng.randint(70, 110)
    n_sets = rng.randint(220, 420)
    model = pyscipopt.Model()
    model.hideOutput(True)

    variables = []
    memberships = [[] for _ in range(n_elements)]
    for j in range(n_sets):
        size = rng.randint(2, min(10, n_elements))
        elems = rng.sample(range(n_elements), size)
        profit = rng.randint(5, 100) + 0.2 * size
        var = model.addVar(vtype="B", name=f"x_{j}", obj=-profit)
        variables.append(var)
        for elem in elems:
            memberships[elem].append(var)

    for elem, vars_for_elem in enumerate(memberships):
        if vars_for_elem:
            model.addCons(sum(vars_for_elem) <= 1, name=f"pack_{elem}")

    write_problem(model, path)


def write_setpartitioning(path: Path, rng: random.Random) -> None:
    import pyscipopt

    n_elements = rng.randint(60, 100)
    n_sets = rng.randint(220, 420)
    model = pyscipopt.Model()
    model.hideOutput(True)

    columns: list[list[int]] = []
    shuffled = list(range(n_elements))
    rng.shuffle(shuffled)
    cursor = 0
    while cursor < n_elements:
        size = min(rng.randint(1, 5), n_elements - cursor)
        columns.append(shuffled[cursor : cursor + size])
        cursor += size

    while len(columns) < n_sets:
        size = rng.randint(2, min(9, n_elements))
        columns.append(rng.sample(range(n_elements), size))

    memberships = [[] for _ in range(n_elements)]
    for j, elems in enumerate(columns):
        cost = rng.randint(1, 90) + 0.1 * len(elems)
        var = model.addVar(vtype="B", name=f"x_{j}", obj=cost)
        for elem in elems:
            memberships[elem].append(var)

    for elem, vars_for_elem in enumerate(memberships):
        model.addCons(sum(vars_for_elem) == 1, name=f"partition_{elem}")

    write_problem(model, path)


def barabasi_albert_edges(n_nodes: int, affinity: int, rng: random.Random) -> set[tuple[int, int]]:
    edges: set[tuple[int, int]] = set()
    degrees = [0 for _ in range(n_nodes)]
    for i in range(affinity + 1):
        for j in range(i + 1, affinity + 1):
            edges.add((i, j))
            degrees[i] += 1
            degrees[j] += 1

    for node in range(affinity + 1, n_nodes):
        targets: set[int] = set()
        while len(targets) < affinity:
            total_degree = sum(degrees[:node])
            if total_degree <= 0:
                candidate = rng.randrange(node)
            else:
                draw = rng.uniform(0, total_degree)
                acc = 0.0
                candidate = 0
                for old in range(node):
                    acc += degrees[old]
                    if acc >= draw:
                        candidate = old
                        break
            targets.add(candidate)
        for target in targets:
            u, v = sorted((node, target))
            edges.add((u, v))
            degrees[u] += 1
            degrees[v] += 1

    extra_edges = rng.randint(n_nodes // 4, n_nodes // 2)
    while extra_edges > 0:
        u = rng.randrange(n_nodes)
        v = rng.randrange(n_nodes)
        if u == v:
            continue
        edge = tuple(sorted((u, v)))
        if edge not in edges:
            edges.add(edge)
            extra_edges -= 1
    return edges


def write_vertexcover(path: Path, rng: random.Random) -> None:
    import pyscipopt

    n_nodes = rng.randint(120, 220)
    affinity = rng.randint(2, 5)
    edges = barabasi_albert_edges(n_nodes, affinity, rng)
    model = pyscipopt.Model()
    model.hideOutput(True)

    variables = [
        model.addVar(vtype="B", name=f"x_{i}", obj=rng.randint(1, 50))
        for i in range(n_nodes)
    ]
    for k, (u, v) in enumerate(sorted(edges)):
        model.addCons(variables[u] + variables[v] >= 1, name=f"edge_{k}")

    write_problem(model, path)


def write_binpacking(path: Path, rng: random.Random) -> None:
    import pyscipopt

    n_items = rng.randint(32, 48)
    capacity = rng.randint(55, 85)
    weights = [rng.randint(max(4, capacity // 8), max(5, capacity // 2)) for _ in range(n_items)]
    n_bins = math.ceil(sum(weights) / capacity) + rng.randint(2, 5)
    model = pyscipopt.Model()
    model.hideOutput(True)

    used = [model.addVar(vtype="B", name=f"y_{j}", obj=1.0) for j in range(n_bins)]
    assign = [
        [model.addVar(vtype="B", name=f"x_{i}_{j}") for j in range(n_bins)]
        for i in range(n_items)
    ]

    for i in range(n_items):
        model.addCons(sum(assign[i][j] for j in range(n_bins)) == 1, name=f"assign_{i}")
    for j in range(n_bins):
        model.addCons(
            sum(weights[i] * assign[i][j] for i in range(n_items)) <= capacity * used[j],
            name=f"capacity_{j}",
        )
    for j in range(n_bins - 1):
        model.addCons(used[j] >= used[j + 1], name=f"symmetry_{j}")

    write_problem(model, path)


def write_generalized_assignment(path: Path, rng: random.Random) -> None:
    import pyscipopt

    n_items = rng.randint(90, 140)
    n_agents = rng.randint(16, 24)
    weights = [[rng.randint(3, 35) for _ in range(n_agents)] for _ in range(n_items)]
    profits = [[rng.randint(5, 120) for _ in range(n_agents)] for _ in range(n_items)]

    base_assignment = [rng.randrange(n_agents) for _ in range(n_items)]
    base_loads = [0 for _ in range(n_agents)]
    for item, agent in enumerate(base_assignment):
        base_loads[agent] += weights[item][agent]
    capacities = [max(1, base_loads[j] + rng.randint(0, 4)) for j in range(n_agents)]

    model = pyscipopt.Model()
    model.hideOutput(True)
    assign = []
    for i in range(n_items):
        row = []
        for j in range(n_agents):
            row.append(model.addVar(vtype="B", name=f"x_{i}_{j}", obj=-profits[i][j]))
        assign.append(row)

    for i in range(n_items):
        model.addCons(sum(assign[i][j] for j in range(n_agents)) == 1, name=f"assign_{i}")
    for j in range(n_agents):
        model.addCons(
            sum(weights[i][j] * assign[i][j] for i in range(n_items)) <= capacities[j],
            name=f"capacity_{j}",
        )

    write_problem(model, path)


WRITERS: dict[str, Callable[[Path, random.Random], None]] = {
    "setpacking": write_setpacking,
    "setpartitioning": write_setpartitioning,
    "vertexcover": write_vertexcover,
    "binpacking": write_binpacking,
    "generalized_assignment": write_generalized_assignment,
}


def existing_instances(dest_dir: Path) -> list[Path]:
    return sorted(dest_dir.glob("*.lp")) + sorted(dest_dir.glob("*.mps"))


def generate_class(
    class_name: str,
    dest_root: Path,
    target_count: int,
    attempts: int,
    seed: int,
    min_nodes: int,
    time_limit: int,
) -> list[Path]:
    if class_name not in WRITERS:
        raise ValueError(f"unknown class {class_name!r}; choose from {sorted(WRITERS)}")

    dest_dir = dest_root / f"eval_{class_name}"
    dest_dir.mkdir(parents=True, exist_ok=True)
    kept = existing_instances(dest_dir)[:target_count]
    writer = WRITERS[class_name]
    attempt = 0

    while len(kept) < target_count and attempt < attempts:
        rng = random.Random(seed + 100_000 * EXTRA_CLASSES.index(class_name) + attempt)
        tmp_path = dest_dir / f"{class_name}_candidate_{attempt:04d}.mps"
        final_path = dest_dir / f"{class_name}_{len(kept):03d}.mps"
        attempt += 1

        writer(tmp_path, rng)
        nodes, status = solve_node_count(tmp_path, time_limit=time_limit)
        if nodes is None or nodes < min_nodes:
            tmp_path.unlink(missing_ok=True)
            print(f"{class_name}: reject {tmp_path.name} nodes={nodes} status={status}", flush=True)
            continue

        tmp_path.replace(final_path)
        kept.append(final_path)
        print(f"{class_name}: kept {final_path.name} nodes={nodes} status={status}", flush=True)

    print(f"{class_name}: {len(kept)}/{target_count} available in {dest_dir}", flush=True)
    return kept


def generate_extra_dataset(
    dest_root: str | Path = "data/instances",
    classes: list[str] | None = None,
    target_count: int = 50,
    attempts: int = 500,
    seed: int = 0,
    min_nodes: int = 1,
    time_limit: int = 10,
) -> dict[str, list[Path]]:
    dest = Path(dest_root)
    results = {}
    for class_name in classes or EXTRA_CLASSES:
        results[class_name] = generate_class(
            class_name=class_name,
            dest_root=dest,
            target_count=target_count,
            attempts=attempts,
            seed=seed,
            min_nodes=min_nodes,
            time_limit=time_limit,
        )
    return results


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--dest", default="data/instances")
    parser.add_argument("--target", type=int, default=50)
    parser.add_argument("--attempts", type=int, default=500)
    parser.add_argument("--seed", type=int, default=0)
    parser.add_argument("--min-nodes", type=int, default=1)
    parser.add_argument("--time-limit", type=int, default=10)
    parser.add_argument("--classes", nargs="*", default=EXTRA_CLASSES)
    args = parser.parse_args()

    generate_extra_dataset(
        dest_root=args.dest,
        classes=args.classes,
        target_count=args.target,
        attempts=args.attempts,
        seed=args.seed,
        min_nodes=args.min_nodes,
        time_limit=args.time_limit,
    )


if __name__ == "__main__":
    main()
