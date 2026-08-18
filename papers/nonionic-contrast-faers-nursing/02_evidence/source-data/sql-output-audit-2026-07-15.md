# SQL output audit — 2026-07-15

Source folder: `02_evidence/source-data/`

User reported that the SQL statements were executed and six CSV files were exported as `1.csv` through `6.csv`.

MedDRA source clarification: the MySQL tables `meddra_smq` and `meddra_soc` are electronic versions of the MedDRA files. They should be treated as MedDRA source imports rather than ad hoc mapping tables; the final supplement should still record the imported MedDRA filenames/version if available.

## File inventory

| File | Inferred table/query | Rows | SHA-256 |
|---|---:|---:|---|
| `1.csv` | `res_v10_pt_signals_all` | 2,612 | `405E8A740C7A7D14CB68DCBE56020E408C3D0BCCD2EB5BB27752ED75366F7292` |
| `2.csv` | `res_v10_soc_summary_all` PT-derived SOC summary, not true SOC-level disproportionality | 122 | `F9AA19DE387531F5E09DDF8D9A4552B740F5239A425CCA2F620047B29D0D96F7` |
| `3.csv` | `res_v10_tto_summary` | 5 | `209F8A78E2E3ABBA28FCF23C4E98A364AB4F1CE1ADBD0958F01C311460B81C80` |
| `4.csv` | `res_v10_tto_distribution` | 31 | `77843EDC65CBF60C5D4D98256123F3EDA23E6F385550AF13B9FF57D910E19054` |
| `5.csv` | `res_v10_tto_base` | 18,138 | `968F3D62EB2EF0AAEEEC53F15E14C80568663317D9F3A8EDA6B53C9D95558F95` |
| `6.csv` | `res_v10_tto_weibull_input` | 18,138 | `BB39E66475D9F7CEC081C5FB69313C11793E97ACF964A1519C5ED7BDB4EDB53C` |
| `res_v10_tto_weibull_parameters.csv` | Python Weibull fit from `6.csv` | 5 | `A258B2E7EDC892C180990685C7AF098CDFF95AE231F3656FEB8D7B0AAC1EF690` |

## Confirmed summaries

PT signal table (`1.csv`):

| Analysis group | PT rows | Strict four-algorithm rows | Core ROR/PRR rows |
|---|---:|---:|---:|
| POOLED | 951 | 230 | 410 |
| Iodixanol | 346 | 121 | 203 |
| Iohexol | 593 | 169 | 289 |
| Iopamidol | 382 | 99 | 196 |
| Ioversol | 340 | 115 | 188 |

TTO summary (`3.csv`):

| Analysis group | Evaluable TTO reports | Same-day reports (%) | Within 1 day reports (%) | Within 30 days reports (%) | Median TTO |
|---|---:|---:|---:|---:|---:|
| POOLED | 9,069 | 8,010 (88.32%) | 8,450 (93.17%) | 9,019 (99.45%) | 0 |
| Iodixanol | 1,655 | 1,252 (75.65%) | 1,429 (86.34%) | 1,641 (99.15%) | 0 |
| Iohexol | 4,564 | 4,164 (91.24%) | 4,328 (94.83%) | 4,543 (99.54%) | 0 |
| Iopamidol | 1,367 | 1,240 (90.71%) | 1,294 (94.66%) | 1,353 (98.98%) | 0 |
| Ioversol | 1,483 | 1,354 (91.30%) | 1,399 (94.34%) | 1,482 (99.93%) | 0 |

Weibull fit (`res_v10_tto_weibull_parameters.csv`):

| Analysis group | n | Shape beta | Scale | Convergence flag | Optimizer message |
|---|---:|---:|---:|---:|---|
| POOLED | 9,069 | 0.686271 | 0.958471 | 0 | Optimization terminated successfully. |
| Iodixanol | 1,655 | 0.653357 | 1.255621 | 1 | Desired error not necessarily achieved due to precision loss. |
| Iohexol | 4,564 | 0.699287 | 0.886055 | 1 | Desired error not necessarily achieved due to precision loss. |
| Iopamidol | 1,367 | 0.625819 | 0.993069 | 1 | Desired error not necessarily achieved due to precision loss. |
| Ioversol | 1,483 | 0.869976 | 0.827298 | 1 | Desired error not necessarily achieved due to precision loss. |

## Missing or ambiguous exports

The handoff expected the following output tables. They were not found among the six CSV files as exported:

- `tmp_v10_log`
- `res_v10_pt_signals_strict_four_algorithm` as a separate table
- `res_v10_soc_summary_strict_positive`
- `res_v10_soc_signals_all`, the true SOC-level disproportionality table with `a/b/c/d`, `ROR`, `PRR`, `IC`, `IC025`, `EBGM`, `EBGM05`, and signal flags
- `res_v10_soc_signals_strict_positive`

`2.csv` should not be used as the complete SOC disproportionality result because its columns are PT-derived SOC summary fields (`pt_count`, `summed_pt_case_count`, `max_ROR`, `max_EBGM`) rather than true SOC-level disproportionality fields.

## Manuscript handling

Do not replace manuscript placeholders with these values yet. The new SQL outputs differ from the previous working interpretation in two high-impact places:

- POOLED strict four-algorithm PT rows are 230 in `1.csv`, not the previously carried-forward 24 positive PT signals.
- POOLED evaluable TTO reports are 9,069 in `3.csv`, not the previously carried-forward 12,588.

These differences require author/statistical review before Results, Abstract, tables, or figures are updated.
