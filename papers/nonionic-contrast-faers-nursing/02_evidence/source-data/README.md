# 数据与结果来源

保存用于论文主张的表格、统计输出和结果材料。大型或敏感数据只记录受控存储位置、版本与校验值。

## 2026-07-15 SQL outputs

User-supplied SQL exports are saved as `1.csv` through `6.csv`. The inferred mapping, row counts, hashes, missing expected exports, and manuscript-use cautions are documented in `sql-output-audit-2026-07-15.md`.

`res_v10_tto_weibull_parameters.csv` was generated from `6.csv` using `02_evidence/methods-source/sql/fit_weibull_tto.py`.

After the SQL was rerun, database tables were read directly from MySQL database `faers_adr`; the current judgment is documented in `database-result-audit-2026-07-15.md`. Use the database audit rather than the earlier partial CSV audit for deciding whether prior discrepancies still exist.

`pooled-priority-pt-signals-top30-2026-07-15.tsv` contains the main-text priority PT display set: POOLED strict four-algorithm signals with at least 10 reports, ranked by EBGM05, top 30.

## 2026-07-15 table package

Main-text table source files:

- `main-table1-analysis-overview-2026-07-15.tsv`
- `main-table1b-pooled-report-characteristics-2026-07-15.tsv`
- `main-table2-priority-pt-signals-top30-2026-07-15.tsv`
- `main-table3-soc-signals-pooled-2026-07-15.tsv`
- `main-table4-tto-summary-2026-07-15.tsv`

Supplementary table source files:

- `supp-table-s1-full-pooled-strict-pt-signals-2026-07-15.tsv`
- `supp-table-s2-full-soc-signals-all-groups-2026-07-15.tsv`
- `supp-table-s3-full-strict-pt-signals-all-groups-2026-07-15.tsv`
- `supp-table-s4-tto-distribution-2026-07-15.tsv`
- `supp-table-s5-report-characteristics-all-groups-2026-07-15.tsv`

Captions and manuscript-use notes are in `03_manuscript/tables/table-package-2026-07-15.md`.
