# Database result audit — 2026-07-15

Source: direct read from MySQL database `faers_adr` after the user reran `submission_outputs_v10.sql`.

Purpose: determine whether the issues found from the earlier partial CSV exports still exist.

## Result table availability

All expected v10 result tables were present in the database:

| Table | Rows |
|---|---:|
| `tmp_v10_log` | 11 |
| `res_v10_pt_signals_all` | 2,612 |
| `res_v10_pt_signals_strict_four_algorithm` | 734 |
| `res_v10_soc_summary_all` | 122 |
| `res_v10_soc_summary_strict_positive` | 99 |
| `res_v10_soc_signals_all` | 131 |
| `res_v10_soc_signals_strict_positive` | 11 |
| `res_v10_tto_summary` | 5 |
| `res_v10_tto_distribution` | 31 |
| `res_v10_tto_weibull_input` | 18,138 |

## SQL execution log

| Step | Row count |
|---|---:|
| Step 0: configuration initialized | 4 |
| Step 2: target primary-suspect drug reports | 14,781 |
| Step 2b: pooled plus agent-specific analysis base rows | 29,562 |
| Step 3: target PT records after filters | 85,622 |
| Step 4: PT rows with a >= minimum count | 2,612 |
| Step 6: complete PT signal rows | 2,612 |
| Step 6b: strict four-algorithm PT signal rows | 734 |
| Step 7A: complete SOC-level signal rows | 131 |
| Step 7A2: strict four-algorithm SOC signal rows | 11 |
| Step 7: SOC summary rows | 122 |
| Step 8: evaluable TTO report rows | 18,138 |

## POOLED report and AE/PT record counts

| Analysis group | Analysis-base rows | Distinct reports | PT record rows after filters | Distinct reports in PT records | Distinct PTs in PT records |
|---|---:|---:|---:|---:|---:|
| POOLED | 14,781 | 14,781 | 42,811 | 14,762 | 2,173 |
| Ioversol | 3,272 | 3,272 | 9,289 | 3,271 | 850 |
| Iohexol | 6,443 | 6,443 | 19,263 | 6,432 | 1,465 |
| Iopamidol | 2,797 | 2,797 | 7,397 | 2,792 | 1,109 |
| Iodixanol | 2,269 | 2,269 | 6,862 | 2,267 | 908 |

The current SQL therefore gives 14,781 POOLED analysis-base reports and 42,811 POOLED PT records after filters. These differ from the manuscript placeholders of 14,780 reports and 42,808 AE records.

## PT signal counts

| Analysis group | PT rows | Strict four-algorithm PT rows | Core ROR/PRR rows | ROR-positive rows | PRR-positive rows | BCPNN-positive rows | MGPS-positive rows |
|---|---:|---:|---:|---:|---:|---:|---:|
| POOLED | 951 | 230 | 410 | 440 | 411 | 487 | 230 |
| Ioversol | 340 | 115 | 188 | 198 | 188 | 222 | 115 |
| Iohexol | 593 | 169 | 289 | 306 | 292 | 335 | 169 |
| Iopamidol | 382 | 99 | 196 | 205 | 197 | 222 | 99 |
| Iodixanol | 346 | 121 | 203 | 209 | 203 | 227 | 121 |

The previously carried-forward statement that SQL identified 24 positive PT signals is not supported by the current v10 database results. Under the current strict four-algorithm SQL definition, POOLED has 230 strict positive PT rows. Across POOLED plus four agent-specific groups, the strict table has 734 rows.

## SOC signal counts

| Analysis group | SOC rows | Strict four-algorithm SOC rows | Core ROR/PRR rows | ROR-positive rows | PRR-positive rows | BCPNN-positive rows | MGPS-positive rows |
|---|---:|---:|---:|---:|---:|---:|---:|
| POOLED | 27 | 2 | 4 | 9 | 4 | 9 | 2 |
| Ioversol | 26 | 3 | 6 | 8 | 6 | 8 | 3 |
| Iohexol | 27 | 3 | 4 | 9 | 4 | 9 | 3 |
| Iopamidol | 27 | 1 | 3 | 7 | 3 | 7 | 1 |
| Iodixanol | 24 | 2 | 6 | 9 | 6 | 9 | 2 |

The earlier missing-SOC-table issue is resolved in the database: `res_v10_soc_signals_all` and `res_v10_soc_signals_strict_positive` exist. However, "9 positive SOCs" is not the strict four-algorithm result. For POOLED, 9 SOCs are ROR-positive and 9 are BCPNN-positive, whereas only 2 are strict four-algorithm positive.

## POOLED SOC-level result interpretation

For POOLED true SOC-level disproportionality, the strict four-algorithm positive SOCs are:

| SOC | Cases | ROR | PRR | IC | EBGM | EBGM05 |
|---|---:|---:|---:|---:|---:|---:|
| Skin and subcutaneous tissue disorders | 5,259 | 4.92 | 3.53 | 1.82 | 3.52 | 2.09 |
| Immune system disorders | 2,981 | 8.53 | 7.01 | 2.80 | 6.97 | 4.14 |

Other POOLED SOCs can be described by their individual algorithm flags if needed, but they should not be called strict four-algorithm positive.

## TTO counts

| Analysis group | Evaluable TTO rows | Distinct primary IDs in Weibull input | Same-day reports (%) | Within 1 day reports (%) | Within 30 days reports (%) | Median TTO |
|---|---:|---:|---:|---:|---:|---:|
| POOLED | 9,069 | 8,987 | 8,010 (88.32%) | 8,450 (93.17%) | 9,019 (99.45%) | 0 |
| Ioversol | 1,483 | 1,477 | 1,354 (91.30%) | 1,399 (94.34%) | 1,482 (99.93%) | 0 |
| Iohexol | 4,564 | 4,525 | 4,164 (91.24%) | 4,328 (94.83%) | 4,543 (99.54%) | 0 |
| Iopamidol | 1,367 | 1,356 | 1,240 (90.71%) | 1,294 (94.66%) | 1,353 (98.98%) | 0 |
| Iodixanol | 1,655 | 1,629 | 1,252 (75.65%) | 1,429 (86.34%) | 1,641 (99.15%) | 0 |

The manuscript placeholder of 12,588 evaluable TTO reports is not supported by the current v10 database results. Current SQL gives 9,069 POOLED evaluable TTO rows. In the POOLED Weibull input, 69 primary IDs have multiple TTO rows, contributing 151 rows, so Methods/Results must distinguish TTO rows from distinct reports if using the current table as written.

## Judgment on previously identified issues

| Previously identified issue | Current judgment |
|---|---|
| Missing expected exports | Resolved in database. All expected v10 tables are present. |
| `2.csv` looked like SOC summary rather than true SOC-level disproportionality | Resolved at the database level. True SOC-level tables now exist, but the old `2.csv` should still not be used as the SOC disproportionality result. |
| 24 positive PTs vs 230 strict POOLED PT rows | Still unresolved as a manuscript/results discrepancy. The current v10 SQL supports 230 strict POOLED PT rows, not 24. |
| 12,588 evaluable TTO reports vs 9,069 current SQL rows | Still unresolved as a manuscript/results discrepancy. The current v10 SQL supports 9,069 POOLED TTO rows. |
| 27 SOCs and 9 positive SOCs | Partly resolved by clarifying algorithm level. POOLED has 27 SOC rows; 9 are ROR-positive and 9 are BCPNN-positive, but only 2 are strict four-algorithm positive. |
| 14,780 reports and 42,808 AE records | Still needs reconciliation. The current SQL log/table counts support 14,781 POOLED analysis-base rows and 42,811 POOLED PT records after filters. |

## Manuscript handling

Do not use the older placeholders of 14,780 reports, 42,808 AE records, 24 positive PT signals, 9 strict positive SOCs, or 12,588 evaluable TTO reports unless the author provides the older extraction rules and confirms that those are the intended manuscript definitions.

For a v10-SQL-consistent manuscript, use:

- 14,781 POOLED analysis-base reports;
- 42,811 POOLED PT records after filters;
- 951 POOLED PT rows with at least 3 cases;
- 230 POOLED strict four-algorithm PT signals;
- 27 POOLED SOC rows;
- 2 POOLED strict four-algorithm SOC signals, with 9 SOCs positive by ROR and 9 by BCPNN if single-algorithm results are discussed;
- 9,069 POOLED TTO rows, with 8,987 distinct primary IDs in the Weibull input.
