
# Spam Ham Classification

This repository contains the preprocessing script, cleaned dataset, and a
Jupyter notebook used to train and evaluate spam vs ham classifiers on a
combined SMS + Enron dataset.

**Contents**
- `spam ham dataset making.R` — R preprocessing script that prepares and
	merges datasets, samples Enron spam rows, and writes cleaned CSVs.
- `Enron + SpamHam SMS cleaned datasets.csv` — final combined cleaned dataset
	used by the notebook (already included in the repo).
- `Spam_Ham.ipynb` — notebook with EDA, feature engineering (TF-IDF), model
	pipelines (ComplementNB, LinearSVC, LogisticRegression), hyperparameter
	tuning, ensembling, and evaluation/plots.
- `requirements.txt` — Python dependencies for running the notebook.
- `.gitignore` — common ignores for R and Python temporary files.

**Quick Start**
1. (Optional) Create a virtual environment and activate it.

```bash
python -m venv .venv
source .venv/bin/activate  # macOS / Linux
.venv\Scripts\activate     # Windows PowerShell
```

2. Install Python dependencies:

```bash
pip install -r requirements.txt
```

3. (Optional) Re-run preprocessing (if you want to regenerate `combined.csv`):

**Requires**: R (recommended >= 4.0) to run the preprocessing script. Install R from https://cran.r-project.org/ and ensure `Rscript` is available on your PATH.

```bash
Rscript "spam ham dataset making.R"
```

4. Open and run `Spam_Ham.ipynb` in JupyterLab / VS Code to reproduce experiments.

**Data**
- The file `Enron + SpamHam SMS cleaned datasets.csv` is the combined, cleaned
	dataset used by the notebook; it already contains `cleaned_text` and `type`
	columns expected by the notebook.

**Notes & Tips**
- The repository intentionally does not include a license file per request.
- If you change dataset paths, update `DATASET_PATH` in the notebook.
- The R script uses base R and writes outputs as UTF-8 encoded CSV files.

**Author**: Jad Al Karim

