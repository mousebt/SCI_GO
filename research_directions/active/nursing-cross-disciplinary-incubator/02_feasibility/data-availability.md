# Data availability

Direction ID: `nursing-cross-disciplinary-incubator`

## Candidate data sources

| Data source | Owner/access | Fields likely needed | Access status | Risk |
|---|---|---|---|---|
| FAERS | Public FDA quarterly files | demographics, drug, reaction/PT, outcome, report dates, therapy dates | available via existing workflow | spontaneous reporting bias; no incidence denominator |
| OpenFDA / FAERS API | Public API | same as FAERS but easier quick count | available if network/API accessible | API limits and transformation differences |
| MIMIC-IV / MIMIC nursing-related tables | credentialed public clinical database | notes, chart events, ICU outcomes, timestamps | possible but requires credentialed access | nursing variables need careful mapping |
| 本院不良事件登记 | hospital internal | event category, severity, department, nursing action, outcome | unknown | ethics and governance required |
| 本院护理记录/交接班记录 | hospital internal | narrative notes, timestamps, nursing diagnosis/interventions | unknown | high privacy and de-identification burden |
| 可穿戴/远程监测数据 | local/prospective or external datasets | step count, sleep, HR, fall alerts, symptom scores | unknown | slow collection, device variability |
| 公共气象/环境数据 | public | temperature, pollution, extreme-weather days | available | must link to nursing workload or patient outcome data |

## Minimum viable dataset

第一优先方向的最小数据集：FAERS 中某一类护理相关风险暴露 + PT/SOC 反应术语 + 报告时间/治疗时间 + 结局字段。若能补充本院“总使用量/不良事件登记/护理处置记录”，可作为外部临床解释，但不作为第一篇论文的必要条件。

## Data blockers

- 护理文本、交接班记录和本院不良事件原始明细均涉及隐私，不应在没有伦理/授权前作为主数据。
- 可穿戴方向若无现成数据集，不建议作为当前第一篇。
- 气候健康方向需要护理工作量或照护需求指标，否则护理贡献不足。
