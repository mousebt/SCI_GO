# Development log — 2026-07-14

Paper: `nonionic-contrast-faers-nursing`

Target journal route: Nursing Open first; Current Medical Science fallback.

Current branch: `main`

End-of-day status: working tree clean after commit `b284eb4`.

## Main decisions today

1. Use the Chinese manuscript tables provisionally for Results while waiting for rerun SQL outputs.
2. Treat 24 positive PTs as the complete SQL-derived result; treat the 20 rows in the Chinese manuscript table as a display convention, not a contradiction.
3. Keep pooled four-agent analysis as the main analysis, while preparing agent-specific outputs for sensitivity/supplementary reporting.
4. EBGM/EBGM05 values will be finalized only after rerunning the updated SQL.
5. The complete SOC table means true SOC-level disproportionality analysis across all SOCs, not merely a summary of PTs grouped by SOC.
6. Weibull fitting should use Python rather than R by default.

## Files added or materially changed

### SQL and analysis reproducibility

- `02_evidence/methods-source/sql/单药挖掘最终优化版.sql`
  - Author-provided original SQL source.
  - Preserved as an original source file.

- `02_evidence/methods-source/sql/sql-audit-2026-07-14.md`
  - Records what the original SQL supports and what remained missing.

- `02_evidence/methods-source/sql/submission_outputs_v10.sql`
  - New submission-oriented SQL script.
  - Adds pooled and agent-specific analysis groups.
  - Adds `pt_standard_en`.
  - Exports `EBGM` and `EBGM05`.
  - Creates strict four-algorithm PT signal outputs.
  - Creates true SOC-level signal tables:
    - `res_v10_soc_signals_all`
    - `res_v10_soc_signals_strict_positive`
  - Creates TTO outputs:
    - `res_v10_tto_summary`
    - `res_v10_tto_distribution`
    - `res_v10_tto_weibull_input`
  - Fixed MySQL error 1071 by changing text indexes to prefix indexes, e.g. `pt(191)`, `soc_en(191)`, `analysis_group(50)`.

- `02_evidence/methods-source/sql/fit_weibull_tto.py`
  - Default Python script for Weibull shape/scale and 95% CI.
  - Requires exported `res_v10_tto_weibull_input.csv`.
  - Local syntax check passed.
  - Local environment has `numpy`, `pandas`, and `scipy`.

- `02_evidence/methods-source/sql/fit_weibull_tto.R`
  - Retained as historical fallback only; Python is now default.

### Evidence tracking

- `02_evidence/source-data/chinese-manuscript-extracted-tables.md`
  - Extracted 3 tables from the Chinese Word manuscript.
  - Table 3 displays 20 positive PT rows; author clarified full SQL result has 24 positive PTs.

- `02_evidence/faers-reproducibility-checklist.md`
  - Updated with SQL, PT, SOC, EBGM/EBGM05, TTO and Weibull status.

### Manuscript

- `03_manuscript/main.md`
  - Results wording updated to say:
    - 24 positive PTs are SQL-derived;
    - 20 displayed rows come from Chinese manuscript table convention;
    - EBGM/EBGM05 and complete SOC/PT outputs remain pending rerun.

### Review and audit

- `06_review/change-log.md`
  - Updated after each substantive change.

## Git commits created today in this segment

- `8ddfa39` — document FAERS reproducibility gaps
- `a808643` — audit provided SQL source
- `8d6f8ee` — add submission SQL outputs
- `cf76a4f` — use Chinese source tables provisionally
- `1f7dcec` — add SOC and Weibull outputs
- `e72e717` — add Python Weibull fitting script
- `b284eb4` — fix MySQL long index error

## Known unresolved items

1. Rerun `submission_outputs_v10.sql` in MySQL.
2. Export the required SQL result tables.
3. Run `fit_weibull_tto.py` on exported `res_v10_tto_weibull_input.csv`.
4. Verify EBGM/EBGM05.
5. Confirm complete 24-PT positive list and standard English MedDRA PT names.
6. Confirm complete SOC table and the 9 positive SOC values.
7. Provide FAERS quarter-level download/import inventory.
8. Provide upstream `drug_clean` construction rules or a drug dictionary export.
9. Later add local hospital clinical/nursing record data if available; leave blank otherwise.

