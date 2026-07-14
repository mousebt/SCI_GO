# FAERS reproducibility and author-clarification checklist

Updated: 2026-07-14

Purpose: track the methods/evidence items needed before the Nursing Open submission. This file converts the author's latest clarifications into manuscript actions, without inventing data.

## Current interpretation

Nursing Open was searched for directly comparable FAERS precedents on 2026-07-14, but no clear Nursing Open FAERS precedent was identified from web/PubMed-style searches. Therefore, a quarter-by-quarter FAERS download inventory should be treated as a reproducibility safeguard rather than a proven Nursing Open house requirement.

FDA's official AEMS/FAERS quarterly data page lists 2025 Q4, with ASCII and XML files available. The page currently displays an internally inconsistent posted date for 2025 Q4 (`posted on 27-Jan-2025` despite the quarter being October-December 2025). Record the FDA page verbatim in the supplement and, if needed, note that the official page confirms file availability while the displayed posting date appears inconsistent.

## Item-by-item status

| Item | Author clarification | Manuscript handling | Status |
|---|---|---|---|
| Raw analysis scripts / SQL / reproducible workflow | SQL statements can be provided. | Archive SQL in `02_evidence/methods-source/sql/`; describe SQL pipeline in Methods and cite supplementary SQL file. | Pending author file |
| FAERS quarter download list and download dates | Need to know how to provide; check whether Nursing Open requires it. | Not found as a Nursing Open-specific requirement; still prepare a supplementary quarter inventory with quarter, FDA URL, file type, file name, download date, file size/hash if available, import status. | Needed for robustness |
| 2025 Q4 release and inclusion | FDA official quarterly page lists 2025 Q4 ASCII/XML files. | State that 2025 Q4 was included only if the downloaded local file and import log confirm it. | Official availability verified; local inclusion pending |
| Deduplication flow counts | Counts are in Figure 1 of the Chinese manuscript. | Extract pre-deduplication count, deduplicated count, deleted-case exclusion count and final included count into Results/Figure 1. | Source available; extraction pending |
| Four-drug search dictionary | Dictionary is in SQL script; cleaning rules were completed earlier outside SQL. | Put dictionary in SQL archive and document non-SQL cleaning rules in a separate data-dictionary note. | Pending author file |
| MedDRA version and mappings | MedDRA 28.0; PT mapping, old terms and SOC allocation used MedDRA default settings. | Methods can state MedDRA 28.0 and default PT/SOC mapping, but the exact software/source used for mapping should still be named if available. | Partly resolved |
| ROR/PRR/BCPNN/MGPS formulae and thresholds | Formulae are already in the manuscript. | Keep formulae in Methods; complete the output tables, especially EBGM and EBGM05, before submission. | Formulae available; outputs pending |
| Separate results for four contrast agents | Not performed; can be performed if needed. | Recommended: keep pooled analysis as primary, add agent-specific results as sensitivity/supplement if SQL can produce stable counts. If not done, justify pooling and avoid between-agent comparative claims. | Decision/action pending |
| 27 SOCs and 9 positive SOC values | To be provided after SQL runs. | Insert full SOC table, with 9 positive SOCs highlighted. | Pending SQL |
| 24 positive PT table and MedDRA English names | To be provided after SQL runs. | Insert complete PT table and verify all English PT names against MedDRA 28.0. | Pending SQL |
| TTO cleaning, fields, same-day events, median/IQR, Weibull parameters | No extra TTO cleaning; date fields were cleaned previously. | Methods should say TTO used pre-cleaned date fields; still requires exact date fields, partial-date rule, same-day definition, median/IQR and Weibull estimate/CI. | Partly resolved |

## Recommended supplement files

1. `supplementary_sql_pipeline.sql` or equivalent SQL export.
2. `supplementary_faers_quarter_inventory.csv`.
3. `supplementary_drug_dictionary.csv`.
4. `supplementary_cleaning_rules.md`.
5. `supplementary_soc_full_results.csv`.
6. `supplementary_pt_full_results.csv`.
7. `supplementary_tto_analysis_output.csv`.

