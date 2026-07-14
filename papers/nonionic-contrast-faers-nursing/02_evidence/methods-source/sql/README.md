# SQL and reproducible analysis source

Place author-provided SQL statements and reproducible analysis notes here.

Current files:

- `单药挖掘最终优化版.sql` — author-provided FAERS disproportionality/TTO SQL, SHA-256 `4BCA601F8AEC454EC7C2747191B1C5C15BC5E33C811736F688B62C0E5BEA1342`.
- `sql-audit-2026-07-14.md` — audit of what this SQL supports and what still needs export or correction.
- `submission_outputs_v10.sql` — Codex-generated submission output script that preserves the original SQL, adds pooled plus agent-specific outputs, exports `EB05 AS EBGM05`, creates core ROR/PRR and strict four-algorithm signal tables, and exports SOC/TTO/reproducibility tables. Not yet executed against the database.
- `fit_weibull_tto.R` — companion R script for fitting Weibull shape/scale and 95% confidence intervals from the exported `res_v10_tto_weibull_input` table.

Minimum expected contents before submission:

- FAERS import or table-construction SQL, if available.
- Drug search dictionary SQL or lookup tables for ioversol, iohexol, iopamidol and iodixanol.
- Query or export SQL for deduplication counts, deleted-case exclusions and final inclusion flow.
- Query or export SQL for SOC-level and PT-level disproportionality outputs.
- Query or export SQL for TTO cohort construction, if SQL was used.

If a cleaning step was completed outside SQL, document it in `supplementary_cleaning_rules.md` rather than hiding it inside the manuscript prose.
