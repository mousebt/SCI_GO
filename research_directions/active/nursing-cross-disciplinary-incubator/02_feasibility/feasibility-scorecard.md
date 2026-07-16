# Feasibility scorecard

Direction ID: `nursing-cross-disciplinary-incubator`

Title: 护理跨界研究方向孵化

Scoring: 1 = weak/blocking, 5 = strong/low risk.

| Dimension | Score | Current evidence | Missing evidence | Action |
|---|---:|---|---|---|
| Data availability | 5 | FAERS 等公共数据库可直接使用；现有项目已有 SQL/Python 经验 | 具体选择哪类护理相关暴露/事件 | 从现有 FAERS 工作流中抽一个护理安全问题试跑 |
| Data quality | 3 | 公共自发报告数据库适合信号检测，但存在报告偏倚、缺失和因果限制 | 每个候选题的缺失率、重复记录、术语映射情况 | 建立候选题的数据审计表 |
| Sample size plausibility | 4 | 药物/器械/不良事件主题通常样本量足够 | 小众暴露或护理相关事件可能样本不足 | 先用宽检索估算病例数 |
| Method feasibility | 4 | ROR/PRR/BCPNN/MGPS、TTO、Weibull 等已有路线；Python 可承接 | 是否需要更复杂模型或亚组分析 | 先保持可复现的标准信号检测方法 |
| Ethics/governance | 5 | 公共匿名数据库伦理阻力最低 | 若加入本院数据则需伦理/数据授权 | 第一篇优先不依赖本院个人数据 |
| Literature saturation | 3 | 药物警戒和 AI 都有大量研究；护理切入点可能仍有空间 | 目标题目是否已有高度相似文章 | 做一次正式文献查重 |
| Nursing/clinical relevance | 4 | 可落到护理评估、宣教、监测、处置和不良事件上报 | 必须避免只写“统计发现” | 每个研究问题强制写 nursing implication |
| Journal fit | 4 | Nursing Open、BMC Nursing、patient-safety/health-services 类期刊可考虑 | 各刊是否接受 FAERS/数据库研究需逐刊确认 | 建立期刊匹配表 |
| Speed to manuscript | 5 | 若复用公共数据和现有脚本，最快 | 仍需标准英文表述、补公式和补数据表 | 用一个最小题目生成样稿 |
| Overall publication feasibility | 4 | 最适合作为当前系统的第一个跨界方向 | 新颖性和护理定位是主要不确定性 | 推荐进入候选题细化，不直接立项 |

## Red flags

- 如果研究对象和结局都不是护理能解释或干预的，护理期刊会觉得“不像护理文章”。
- 如果只追热点，比如“护理 + AI”，但没有真实护理数据或明确评价标准，很容易变成空泛综述。
- 如果一开始选择可穿戴或本院文本数据，伦理和数据治理可能拖慢 1-3 个月。

## Fastest uncertainty-reducing step

- 用 1 天做 3 个候选题的病例数预筛：每个题只看暴露词典、关键 PT/SOC、总报告数、阳性信号数和是否能写出护理含义。病例数和护理含义都过关，再进入正式方向立项。
