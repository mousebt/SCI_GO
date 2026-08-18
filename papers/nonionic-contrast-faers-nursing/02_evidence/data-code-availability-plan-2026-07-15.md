# Data and code availability plan

Date: 2026-07-15

Target journal: Nursing Open

## One-sentence availability logic

This manuscript uses public FAERS/AEMS data plus author-generated SQL/Python outputs and possible institutional local nursing records; therefore, public regulatory data, aggregate table sources and analysis scripts should be shareable, while individual local clinical records require institutional control or omission.

## Dataset inventory and access route

| Item | Current location/source | Access route | Submission handling |
|---|---|---|---|
| FAERS/AEMS raw quarterly files, 2004 Q1-2025 Q4 | FDA AEMS latest quarterly data files page and FAERS quarterly data extract files portal | Reused public source | Cite FDA source and provide quarter-level download inventory before submission |
| Main-text aggregate table sources | `02_evidence/source-data/main-table*.tsv` | Within paper/supplement or public repository | Provide as supplementary source data or deposit in a public repository |
| Supplementary aggregate table sources | `02_evidence/source-data/supp-table-*.tsv` | Within paper/supplement or public repository | Provide as supplementary tables/source data |
| SQL scripts | `02_evidence/methods-source/sql/submission_outputs_v10.sql` and archived source SQL | Supplementary code or public repository | Provide exact script version; repository DOI optional but preferred |
| Weibull fitting script | `02_evidence/methods-source/sql/fit_weibull_tto.py` | Supplementary code or public repository | Provide script with package versions already recorded in Methods |
| Drug-cleaning dictionary/rules | Upstream `drug_clean`; export not yet documented | Pending author decision | Provide dictionary/rules if permitted; otherwise document construction and restrictions |
| MedDRA electronic files | Imported MySQL MedDRA source tables (`meddra_soc`, `meddra_smq`) | Restricted/licensed third-party source | Do not redistribute files; document version, imported filenames and mapping procedure |
| Local clinical and nursing records | Institutional clinical/nursing records; extraction pending | Restricted institutional data or omitted | Share only aggregate summaries if approved; individual records not public |

## Required author decisions before submission

1. Confirm whether local clinical nursing record data will be included, omitted, or described as pending.
2. Provide institutional ethics/exemption/quality-improvement determination and consent-waiver wording for any local record component.
3. Choose the code/data sharing route: supplementary files only, public repository, or both.
4. Provide FAERS quarterly download dates and inventory if available.
5. Confirm whether the `drug_clean` dictionary or construction rules can be shared.

## Current draft statement status

The main manuscript and title page now contain a ready-to-edit statement that separates public FAERS/AEMS data, aggregate result tables, analysis code, MedDRA source restrictions and local clinical-record restrictions. Remaining placeholders are intentionally marked as author input rather than inferred.
