# Result definition decision — 2026-07-15

Decision source: user instruction on 2026-07-15.

> 与旧数据不一致的，按新的数据来，24个和230个要斟酌一下，230个是全量的，但一般faers挖掘，只会取高分的，这个度参考行业惯例来做

## One-sentence argument

In FAERS reports for four non-ionic iodinated contrast media, the v10 SQL analysis identifies a broad set of statistically positive disproportionality signals; the manuscript should report the complete strict signal set transparently while highlighting a smaller, prespecified, high-priority subset for clinically readable nursing interpretation.

## Locked result hierarchy

Use the new v10 SQL database results when they differ from older manuscript placeholders.

| Result layer | Definition | Manuscript use |
|---|---|---|
| Full signal set | All POOLED PT rows meeting the strict four-algorithm criteria in `res_v10_pt_signals_strict_four_algorithm` | Report in Results as the complete statistical signal count: 230 PT signals. Provide the full table as supplementary material. |
| Main-text priority PT set | POOLED strict four-algorithm PT rows with `cases >= 10`, ranked by `EBGM05` descending; show the top 30 rows | Use as the main-text PT table and narrative basis. Label as "top-ranked priority PT signals", not "all positive PT signals". |
| SOC full set | All POOLED rows in `res_v10_soc_signals_all` | Report as 27 SOCs assessed. |
| SOC strict set | POOLED rows in `res_v10_soc_signals_strict_positive` | Report as 2 strict four-algorithm positive SOCs. |
| SOC single-algorithm pattern | POOLED SOC rows with individual signal flags | If needed, state that 9 SOCs were ROR-positive and 9 were BCPNN-positive, but do not call them strict four-algorithm positive. |
| TTO set | POOLED rows in `res_v10_tto_summary` / `res_v10_tto_weibull_input` | Report 9,069 evaluable TTO rows; note 8,987 distinct primary IDs in the Weibull input if discussing row/report distinction. |

## Rationale for not using "24 positive PTs"

The current v10 SQL database does not support 24 as the total number of positive PT signals. The strict POOLED PT table contains 230 rows, and the full strict table across POOLED plus four agent-specific groups contains 734 rows.

The number 24 may have reflected an older display convention, a hand-curated table, or a stricter unpublished prioritization rule. It should not be presented as the SQL-derived positive PT count unless the older extraction rule is recovered and explicitly chosen.

## Rationale for main-text Top 30

FAERS disproportionality mining commonly yields many statistically flagged drug-event pairs. A readable manuscript should separate:

1. full algorithmic output for reproducibility; and
2. a smaller main-text subset for interpretation.

The selected main-text rule is:

`analysis_group = POOLED`
`is_strict_four_algorithm_signal = 1`
`cases >= 10`
`ORDER BY EBGM05 DESC, cases DESC`
`LIMIT 30`

This rule avoids selecting only by raw ROR, which can be dominated by very rare PTs. `EBGM05` is used as the primary ranking statistic because it is the lower confidence bound of a shrinkage estimate and is more conservative for prioritizing signals. The `cases >= 10` floor avoids giving main-text prominence to three-case or five-case terms while preserving rare but recurrent signals.

The exported top-30 table is:

`02_evidence/source-data/pooled-priority-pt-signals-top30-2026-07-15.tsv`

## Wording to use later

Recommended Results wording:

"The v10 SQL analysis identified 230 POOLED PT-level signals that met all four prespecified disproportionality criteria. Because this full signal set is too large for a main-text clinical table, the primary PT table presents the 30 highest-ranked POOLED signals among strict four-algorithm signals with at least 10 reports, ordered by EBGM05. The complete 230-signal table is provided as supplementary material."

Recommended Methods wording:

"For interpretability, all strict four-algorithm PT signals were retained as the complete statistical output. The main-text priority table was prespecified as the top 30 POOLED strict signals with at least 10 reports, ranked by EBGM05; this conservative shrinkage-bound ranking was used to reduce overemphasis on unstable high ROR values from very small cell counts."

## Remaining implementation tasks

- Export the full 230-row POOLED strict PT table as supplementary material.
- Export the full 27-row POOLED SOC table and the 2-row strict SOC table.
- Update `claim-evidence.csv` from 24 positive PT signals to 230 full strict PT signals plus top-30 priority display.
- Update `03_manuscript/main.md` Results, Methods, Abstract, and tables using the new v10 SQL definitions.
