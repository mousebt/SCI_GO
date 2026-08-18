# Table package — 2026-07-15

This table package follows the v10 SQL result definitions and the 2026-07-15 result-definition decision. Values supersede older manuscript placeholders.

## Main-text tables

### Table 1. Analysis overview and report characteristics for four non-ionic iodinated contrast media in FAERS

Source files:

- `02_evidence/source-data/main-table1-analysis-overview-2026-07-15.tsv`
- `02_evidence/source-data/main-table1b-pooled-report-characteristics-2026-07-15.tsv`

Purpose: report the analysis-base report counts, PT-record counts, and POOLED demographic/report characteristics.

Suggested caption:

Table 1. Analysis overview and report characteristics for FAERS reports involving ioversol, iohexol, iopamidol and iodixanol. Counts represent FAERS report rows and PT records after v10 SQL filtering, not exposed-patient denominators or incidence estimates.

Notes:

- Primary Results should lead with the POOLED row.
- Agent-specific rows are stratified descriptive outputs and should not be used to rank absolute drug safety.
- Report characteristics are shown for the POOLED analysis group. Country values are database `country_clean` codes.

### Table 2. Top-ranked pooled PT-level disproportionality signals

Source file: `02_evidence/source-data/main-table2-priority-pt-signals-top30-2026-07-15.tsv`

Purpose: main-text priority PT table.

Suggested caption:

Table 2. Top 30 POOLED preferred-term signals among strict four-algorithm positive PTs with at least 10 reports, ranked by EBGM05. The complete POOLED strict PT signal set contained 230 PTs and is provided in Supplementary Table S1.

Notes:

- This table is a prioritization/display subset, not the full signal count.
- State in Methods that ranking by EBGM05 was used to reduce overemphasis on unstable high ROR values from very small cell counts.
- Keep PT names as exported unless a MedDRA verification pass standardizes capitalization.

### Table 3. Pooled SOC-level disproportionality results

Source file: `02_evidence/source-data/main-table3-soc-signals-pooled-2026-07-15.tsv`

Purpose: main-text SOC table.

Suggested caption:

Table 3. Pooled SOC-level disproportionality results for four non-ionic iodinated contrast media. Two SOCs met the strict four-algorithm definition; single-algorithm positivity is shown separately to avoid conflating screening flags with strict multi-algorithm signals.

Notes:

- In the POOLED analysis, 27 SOCs were evaluated.
- Immune system disorders and skin and subcutaneous tissue disorders met the strict four-algorithm definition.
- Nine SOCs were ROR-positive and nine were BCPNN-positive, but these should not be called strict four-algorithm positive.

### Table 4. Time-to-onset summary

Source file: `02_evidence/source-data/main-table4-tto-summary-2026-07-15.tsv`

Purpose: main-text TTO table.

Suggested caption:

Table 4. Time-to-onset summary for pooled and agent-specific analysis groups. TTO rows required usable event and treatment-start dates and were restricted to 0-730 days. Rows are not exposed-patient denominators; distinct primary IDs in the Weibull input are shown separately.

Notes:

- Primary Results should lead with the POOLED row: 9,069 evaluable TTO rows, 8,010 same-day rows (88.32%), and 8,450 within-1-day rows (93.17%).
- The full TTO distribution appears in Supplementary Table S4.

## Supplementary tables

### Supplementary Table S1. Complete POOLED strict PT signal set

Source file: `02_evidence/source-data/supp-table-s1-full-pooled-strict-pt-signals-2026-07-15.tsv`

Rows: 230

Suggested caption:

Supplementary Table S1. Complete POOLED preferred-term signal set meeting all four prespecified disproportionality criteria.

### Supplementary Table S2. Complete SOC-level results across all analysis groups

Source file: `02_evidence/source-data/supp-table-s2-full-soc-signals-all-groups-2026-07-15.tsv`

Rows: 131

Suggested caption:

Supplementary Table S2. Complete SOC-level disproportionality results for pooled and agent-specific analysis groups.

### Supplementary Table S3. Complete strict PT signal set across all analysis groups

Source file: `02_evidence/source-data/supp-table-s3-full-strict-pt-signals-all-groups-2026-07-15.tsv`

Rows: 734

Suggested caption:

Supplementary Table S3. Complete preferred-term signal set meeting all four prespecified criteria across pooled and agent-specific analysis groups.

### Supplementary Table S4. TTO distribution

Source file: `02_evidence/source-data/supp-table-s4-tto-distribution-2026-07-15.tsv`

Rows: 31

Suggested caption:

Supplementary Table S4. Time-to-onset distribution by analysis group.

### Supplementary Table S5. Report characteristics across analysis groups

Source file: `02_evidence/source-data/supp-table-s5-report-characteristics-all-groups-2026-07-15.tsv`

Rows: 489

Suggested caption:

Supplementary Table S5. Sex, age group, reporter-country code and reporter-qualification distributions for pooled and agent-specific analysis groups.

## Remaining table tasks

- Decide whether Table 2 should be shortened to top 20 if the journal layout is tight; if so, keep the top-30 file as supplementary or source evidence.
- Run a MedDRA capitalization/standard-name pass before final submission if the exported PT names retain all-caps legacy strings.
