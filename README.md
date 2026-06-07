# Branch Learning Distance Threshold

Code for an exploratory project testing whether Maudet-Danoy MILP instance distance can help explain transfer behavior in learned branching. A Learn2Branch-style policy trained on set-cover instances is evaluated on other MILP families using relative node count as the main transfer metric.

Full explanation and discussion are in the accompanying write-up: **An Exploratory Look at Branch Learning Transfer**.

## What To Run

Create the environment:

```bash
conda env create -f environment.yml
conda activate ecole
```

Open the notebook:

```bash
jupyter notebook experiment.ipynb
```

Then run the notebook cells in order.

For a quick smoke run, change the notebook settings to:

```python
N_PER_CLASS = 3
TIME_LIMIT = 10
```

For the full run used in the write-up:

```python
N_PER_CLASS = 100
TIME_LIMIT = 300
```

## What Is Already Included

```text
experiment.ipynb                  Main experiment notebook
milp_distance/                    Distance and branching evaluation code
models/baseline_setcover/         Trained set-cover branching model
data/instances/                   MILP instances used by the notebook
results/final_100/                Saved outputs from the final run
```

The baseline model is already included, so retraining is not required to reproduce the notebook experiment.

## Main Outputs

The notebook writes results under:

```text
results/final_100/
```

The most important files are:

```text
raw_results.csv
summary_by_class.csv
scatter_distance_rnc_jittered_no_line.png
box_degradation_by_class.png
```

If `raw_results.csv` already exists, the notebook can reuse completed evaluations instead of starting from scratch.
