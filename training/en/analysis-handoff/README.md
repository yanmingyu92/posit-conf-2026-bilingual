# Multi-site Data Quality and Analysis Handoff

Author: **Jaime Yan**. An original integrated lab; allow 90–120 minutes. Requires R ≥ 4.1 and uses base R without additional packages.

You are responsible for an analysis handoff. Three sites submit quality-score observations. The recipient needs to trace excluded rows, understand mean denominators, and rebuild the chart and summary in a fresh R session. Business teams can interpret sites as stores or operational locations; research analysts can use the task to practice multi-site data intake and quality checks.

**All data are artificially constructed. `quality_score` is a simulated business-quality score, not a clinical endpoint, patient record, or treatment effect. The chart is descriptive; differences between site means cannot be interpreted as causal or treatment effects.**

## Files and data contract

| File | Purpose |
|---|---|
| `synthetic-observations.csv` | 31 simulated input rows, including one exact duplicate, two out-of-range values, and three missing scores |
| `starter.R` | Runnable initial inspection and function interfaces to implement |
| `solution.R` | Runnable reference implementation |
| `check.R` | Acceptance script for the reference or your implementation |

Columns must appear in this order: `record_id, site, observed_on, quality_score`. IDs are artificial identifiers prefixed with `SYN`. Sites must be North, Central, or South. Dates use strict `YYYY-MM-DD` formatting. Scores range from 0 to 100, **including both endpoints**; blank values are missing.

Use these rules:

1. Missing columns, changed column order, missing IDs, unknown sites, invalid dates, and nonnumeric scores must cause import to fail with a useful error location.
2. For an exactly duplicated ID and record, retain the first row. If records sharing an ID conflict, stop and ask the data owner to resolve the conflict. Do not silently select a version.
3. Exclude out-of-range scores and record the reason. Retain records with missing scores: include them in `n_records` and `n_missing`, but exclude them from the mean denominator, `n_observed`.
4. Always output all three sites. A site with no records or entirely missing scores must have `NA` for its mean and median, not zero.
5. The audit field `source_row` counts input data rows, excluding the CSV header. Every input row must have one disposition record.

## Copy → Adapt → Create

**For the first 60 minutes, do not use AI or open solution.R.** You may consult R's built-in help. Write expectations before running checks.

1. **Copy, 15 minutes:** Run the starter and inspect columns and types. Write how scores of 0, 100, missing, -1, and 101 should be handled. Explain why import initially preserves character values. Locate a duplicate ID.
2. **Adapt, 30 minutes:** Implement the starter's four functions in your own `learner.R`. Import, clean, and summarize according to the rules, preserving `n_records = n_observed + n_missing`. Keep the original data and create a row-level audit. Conflicting duplicate IDs must produce an error.
3. **Create, 30–45 minutes:** Complete `run_handoff(input, output_dir)`. Export a summary CSV, audit CSV, and chart showing observed and missing counts. Label the data as simulated. Write a one-page handoff note covering the data contract, exclusions, denominators, rerun command, and limitations.
4. **AI-assisted review, 15 minutes:** Save your own implementation and check results first, then ask AI to find boundary weaknesses. Record one verified finding with evidence, or state honestly that none was found. AI's comments alone are not a sufficient submission.

## Running from the repository root

In Windows PowerShell, if `Rscript` is not on PATH, use the full path to your installed Rscript.exe.

```powershell
Rscript training/analysis-handoff/starter.R
Rscript training/analysis-handoff/solution.R .qa/analysis-handoff
Rscript training/analysis-handoff/check.R .qa/analysis-handoff-check
```

Check your implementation:

```powershell
Rscript training/analysis-handoff/check.R .qa/analysis-handoff-learner training/analysis-handoff/learner.R
```

In a repository checkout, both languages share the code and CSV in `training/analysis-handoff/`. In the English ZIP, those files and this guide are placed together under the same path. Run the commands from the directory containing `training/`.

Your `learner.R` should define only the four functions, or guard its direct-execution entry with `if (sys.nframe() == 0L)`. Sourcing it must not launch the handoff. Preserve the starter/solution argument and return contracts: cleaning returns `list(data, audit)`; summary columns are `site, n_records, n_observed, n_missing, mean_score, median_score`; audit dispositions are `retained, exact_duplicate, out_of_range`.

Outputs are `site-summary.csv`, `row-audit.csv`, and `site-quality.png`, written to the specified `.qa/` subdirectory. Submit your function source, one-page handoff note, and acceptance results. Use the generated chart and tables without overwriting the simulated input.

## Acceptance and assessment

Cleaning should retain 28 rows, with 25 scores contributing to means. North, Central, and South have 7, 9, and 9 observed scores respectively, with means of 50, 530/9, and 485/9. Automated checks also cover retention of 0 and 100, entirely missing sites, empty data, conflicting duplicates, invalid numeric values, invalid dates, unknown sites, and export read-back.

| Dimension | Meets expectations: 1 | Strong: 2 | Excellent: 3 |
|---|---|---|---|
| Inputs and boundaries | Imports ordinary input | Passes all required boundary checks | Errors locate the problem, with evidence for a useful additional boundary |
| Traceable cleaning | Correct exclusions and summaries | Every row is traceable and denominators are clear | Explains conflict rules and the impact of changes |
| Functions and reruns | All four functions run | One command rebuilds outputs in a fresh R session | Configurable output paths and no hidden object dependencies |
| Handoff communication | Supplies CSVs and a chart | Clearly labels simulated data, missing counts, and denominators | Recipient can rerun and understand limitations without oral explanation |

Maximum score: 12. A suggested passing standard is at least one point in every dimension plus passing acceptance checks. Assess explainability and traceability, rather than graphical complexity. Automated acceptance does not exhaustively establish the rules for real production data.

## Optional extensions

Before adding a site or a second batch, identify which contracts should become configurable. Design two tests against accumulating duplicates across batches. Clinical and pharmaceutical readers can discuss additional independent approvals and traceability information needed in a real workflow. Renaming a simulated score as an efficacy variable does not make it suitable for treatment-effect inference.
