# FAERS reproducibility and author-clarification checklist

Updated: 2026-07-15

Purpose: track the methods/evidence items needed before the Nursing Open submission. This file converts the author's latest clarifications into manuscript actions, without inventing data.

## Current interpretation

Nursing Open was searched for directly comparable FAERS precedents on 2026-07-14, but no clear Nursing Open FAERS precedent was identified from web/PubMed-style searches. Therefore, a quarter-by-quarter FAERS download inventory should be treated as a reproducibility safeguard rather than a proven Nursing Open house requirement.

FDA's official AEMS/FAERS quarterly data page lists 2025 Q4, with ASCII and XML files available. The page currently displays an internally inconsistent posted date for 2025 Q4 (`posted on 27-Jan-2025` despite the quarter being October-December 2025). Record the FDA page verbatim in the supplement and, if needed, note that the official page confirms file availability while the displayed posting date appears inconsistent.

## Item-by-item status

| Item | Author clarification | Manuscript handling | Status |
|---|---|---|---|
| Raw analysis scripts / SQL / reproducible workflow | SQL file provided: `单药挖掘最终优化版.sql`. | SQL archived in `02_evidence/methods-source/sql/`; audit saved in `sql-audit-2026-07-14.md`. | Partly resolved; execution outputs pending |
| FAERS quarter download list and download dates | Need to know how to provide; check whether Nursing Open requires it. | Not found as a Nursing Open-specific requirement; still prepare a supplementary quarter inventory with quarter, FDA URL, file type, file name, download date, file size/hash if available, import status. | Needed for robustness |
| 2025 Q4 release and inclusion | FDA official quarterly page lists 2025 Q4 ASCII/XML files. | State that 2025 Q4 was included only if the downloaded local file and import log confirm it. | Official availability verified; local inclusion pending |
| Deduplication flow counts | Counts are in Figure 1 of the Chinese manuscript. | Extract pre-deduplication count, deduplicated count, deleted-case exclusion count and final included count into Results/Figure 1. | Source available; extraction pending |
| Four-drug search dictionary | SQL target list contains `Ioversol`, `Iohexol`, `Iopamidol`, `Iodixanol`; cleaning rules were completed earlier outside SQL. | SQL documents generic target names, but brand names/spelling variants/salts are likely upstream in `drug_clean`; document those non-SQL cleaning rules separately. | Partly resolved |
| MedDRA version and mappings | MedDRA 28.0; PT mapping, old terms and SOC allocation used MedDRA default settings. User clarified on 2026-07-15 that MySQL tables `meddra_smq` and `meddra_soc` are electronic versions of the MedDRA files. | Methods can state MedDRA 28.0 and default PT/SOC mapping based on imported MedDRA electronic files. Keep the imported file names/version and import process traceable in the supplement if available. | Mostly resolved; import trace details still desirable |
| ROR/PRR/BCPNN/MGPS formulae and thresholds | Formulae are already in the manuscript; original SQL calculates ROR, PRR, chi-square, IC, IC025, EBGM and `EB05`. | `submission_outputs_v10.sql` exports `EB05 AS EBGM05` and creates both ROR/PRR core and strict four-algorithm signal tables. | Script prepared; execution outputs pending |
| Separate results for four contrast agents | Original SQL pooled all four drugs. | `submission_outputs_v10.sql` creates `POOLED` plus agent-specific analysis groups for Ioversol, Iohexol, Iopamidol and Iodixanol. | Script prepared; execution outputs pending |
| 27 SOCs and 9 positive SOC values | To be provided after SQL runs. | Insert full SOC table, with 9 positive SOCs highlighted. | Pending SQL |
| 24 positive PT table and MedDRA English names | To be provided after SQL runs. | Insert complete PT table and verify all English PT names against MedDRA 28.0. | Pending SQL |
| Chinese source result tables | User instructed to use Chinese manuscript tables first. Word extraction found 3 tables: report characteristics/frequent PTs, frequent PT disproportionality rows, and displayed positive PT rows. | Source tables archived in `02_evidence/source-data/chinese-manuscript-extracted-tables.md`; author clarified that 24 positive PTs are SQL-derived and the Chinese table displays 20 rows by convention. | Provisional source available; full SQL export pending |
| TTO cleaning, fields, same-day events, median/IQR, Weibull parameters | SQL uses `demo_clean.event_dt` and `ther.start_dt`, requires 8-digit dates, and retains `tto_days` 0-730. No extra TTO cleaning beyond this SQL filter is shown. | `submission_outputs_v10.sql` exports same-day, within-1-day, within-30-day, median and nearest-rank Q1/Q3 plus `res_v10_tto_weibull_input`; `fit_weibull_tto.py` fits Weibull shape/scale and 95%CI after CSV export. | Scripts prepared; execution outputs pending |

## 2026-07-15 SQL output receipt

Six user-supplied CSV exports were received in `02_evidence/source-data/` and audited in `source-data/sql-output-audit-2026-07-15.md`. `res_v10_tto_weibull_parameters.csv` was generated from `6.csv`.

Do not yet move these values into the manuscript because the exported values diverge from the carried-forward working interpretation: `1.csv` contains 230 POOLED strict four-algorithm PT rows, and `3.csv` contains 9,069 POOLED evaluable TTO reports. The previous placeholders referenced 24 positive PT signals and 12,588 evaluable TTO reports. The true SOC-level disproportionality exports are also still missing or not identifiable among the six CSV files.

The MedDRA mapping source is now partly clarified: `meddra_smq` and `meddra_soc` in MySQL are electronic versions of the MedDRA files, not ad hoc author-created tables. Record the specific imported MedDRA filenames/version if available before final submission.

## 2026-07-15 direct database read after SQL rerun

The rerun results were read directly from MySQL database `faers_adr` and audited in `source-data/database-result-audit-2026-07-15.md`. All expected v10 result tables are now present, including `tmp_v10_log`, `res_v10_pt_signals_strict_four_algorithm`, `res_v10_soc_signals_all`, and `res_v10_soc_signals_strict_positive`.

The previous missing-table/export problem is resolved. The remaining issues are result-definition discrepancies: current v10 SQL supports 14,781 POOLED analysis-base reports, 42,811 POOLED PT records after filters, 230 strict POOLED PT signals, 2 strict POOLED SOC signals, and 9,069 POOLED TTO rows. These differ from manuscript placeholders carrying 14,780 reports, 42,808 AE records, 24 positive PT signals, 9 positive SOCs if interpreted as strict four-algorithm SOCs, and 12,588 evaluable TTO reports.

## 2026-07-15 result-definition decision

The user instructed that discrepancies should follow the new SQL data. For the 24-vs-230 PT issue, use 230 as the full POOLED strict four-algorithm signal count and present a prespecified high-priority main-text subset rather than calling 24 the SQL-derived signal count.

Main-text PT display rule: POOLED strict four-algorithm PT signals with `cases >= 10`, ranked by `EBGM05` descending, top 30 rows. Full statistical output remains the 230-row POOLED strict PT table. Details are recorded in `02_evidence/result-definition-decision-2026-07-15.md`, and the top-30 table is exported as `source-data/pooled-priority-pt-signals-top30-2026-07-15.tsv`.

## Recommended supplement files

1. `supplementary_sql_pipeline.sql` or equivalent SQL export.
2. `supplementary_faers_quarter_inventory.csv`.
3. `supplementary_drug_dictionary.csv`.
4. `supplementary_cleaning_rules.md`.
5. `supplementary_soc_full_results.csv`.
6. `supplementary_pt_full_results.csv`.
7. `supplementary_tto_analysis_output.csv`.
