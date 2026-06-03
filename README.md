# MILP Distance Gating for Learned Branching

This repository tests whether a Maudet-style MILP instance distance can act as a pre-solve gate for learned branching.

The trained model is a Learn2Branch/Ecole GNN trained on setcover instances. The experiment compares vanilla SCIP against ML branching on MILP instances at different distances from the setcover training distribution.

## Repository Layout

```text
experiment.ipynb                 Main experiment notebook
milp_distance/                   Maudet-style distance implementation
models/baseline_setcover/        Trained setcover GNN weights and log
models/learn2branch_gnn.py       Vendored Learn2Branch GNN definition
scripts/generate_extra_instances.py
scripts/prepare_experiment_instances.py
runners/vast_runner.py           Optional Vast.ai retraining runner
data/instances/                  Curated 50-per-class evaluation instances
results/                         Experiment CSVs and plots after running
```

The repository intentionally tracks curated MILP instances, model weights, source code, and final CSV/PNG results. It does not track Ecole training samples, tarballs, external cloned repos, or local scratch runs.

## Environment

Use Python 3.11 with Ecole:

```bash
conda env create -f environment.yml
conda activate ecole
```

If you already have a compatible environment:

```bash
python -m pip install -r requirements.txt
```

Expected core packages:

```text
ecole 0.8.x
pyscipopt
torch
torch-geometric
numpy / pandas / scipy / matplotlib
```

## Instances

The experiment uses 50 setcover reference instances and 10 evaluation classes with 50 instances each:

```text
reference_setcover
eval_setcover
eval_cauctions
eval_facilities
eval_indset
eval_mknapsack
eval_setpacking
eval_setpartitioning
eval_vertexcover
eval_binpacking
eval_generalized_assignment
```

If the curated folders need to be rebuilt locally:

```bash
conda run -n ecole python -m scripts.prepare_experiment_instances --count 50
```

## Running The Experiment

Open `experiment.ipynb` in the `ecole` kernel and run cells in order.

The expensive cell is Cell 6. It solves each evaluation instance twice:

```text
vanilla SCIP
ML branching with the trained GNN
```

For a quick smoke run, edit Cell 6:

```python
N_PER_CLASS = 3
TIME_LIMIT = 10
```

For the intended run:

```python
N_PER_CLASS = 50
TIME_LIMIT = 60
```

## Saved Outputs

The notebook writes reusable artifacts under `results/`:

```text
raw_results.csv
failures.csv
distance_cache.csv
instance_inventory.csv
instance_stats.csv
dataset_inventory.csv
summary_by_class.csv
distance_summary_by_class.csv
solver_summary_by_class.csv
threshold_table.csv
correlation_summary.csv
leave_one_class_out.csv
within_class_correlations.csv
*.png plots
```

`raw_results.csv` is the important expensive output. If it exists, Cell 6 resumes and skips completed instances.

## Training Artifacts

The baseline trained model is:

```text
models/baseline_setcover/train_params.pkl
models/baseline_setcover/train_log.txt
```

The original 100k/20k Ecole sample archive is not tracked in Git because it is too large. It was stored externally as:

```text
samples_setcover_500r_1000c_0.05d.tar.gz
sha256: 8c2511c47282a5f33e14b554b62cdc19924ab5957e6a46c4f4f4b3916afac047
```
