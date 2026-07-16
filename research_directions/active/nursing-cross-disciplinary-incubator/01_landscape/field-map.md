# Field map

Direction ID: `nursing-cross-disciplinary-incubator`

## Core field

护理学的核心问题不是“护理人员做了什么”这么窄，而是：患者在照护流程中如何更安全、更及时、更连续地被发现风险、解释风险、处置风险和记录风险。跨界方向最好围绕这个核心来接外部方法。

## Adjacent fields

| Adjacent field | Why relevant | Potential contribution | Risk |
|---|---|---|---|
| 患者安全 / 药物警戒 / 真实世界数据 | 护理与不良事件监测、风险识别、患者教育和处置流程高度相关；公共数据库可快速起步 | FAERS、MIMIC、公开不良事件数据或本院登记数据可做信号识别、风险画像、护理监测建议 | 若只做药物统计，护理贡献会变弱，需要把结果落到护理评估、宣教、监测或流程 |
| AI / LLM / 护理文书 | 护理记录、交接班、出院指导、不良事件报告是典型文本场景；AI 热度高 | 可做记录质量评价、信息抽取、护理交接摘要、风险提示、AI 辅助文书一致性验证 | 本院文本数据涉及隐私和伦理；纯模型论文竞争激烈 |
| 可穿戴传感 / 远程护理 | 跌倒、睡眠、活动、疼痛、疲乏、康复依从性都可由传感器补充观察 | 可产生连续照护数据，适合慢病、老年、术后、肿瘤护理 | 数据采集慢，设备和伦理成本较高，短期发文速度一般 |
| 人因工程 / 流程挖掘 / 质量改进 | 护理流程是安全事件高发点；可以研究工作负荷、交接、告警疲劳、流程瓶颈 | 可把护理管理数据转化为流程优化证据 | 需要院内时间戳、事件流或护理管理数据；方法门槛中等 |
| 气候健康 / 灾害护理 / 脆弱人群 | 热浪、空气污染、极端天气对老年、慢病、急诊护理需求影响越来越明显 | 可结合公共气象/环境数据与护理工作量、急诊就诊、风险宣教 | 护理特征容易被公共卫生叙事淹没，需要明确护理干预或护理需求指标 |

## Possible niche

当前最适合先试的 niche 是：**护理 + 真实世界数据/药物警戒/患者安全**。理由是它能复用现有 FAERS 与 SQL/Python 能力，伦理门槛低，能快速形成“风险识别 → 护理监测/宣教/处置建议 → 患者安全”的论文逻辑。

第二梯队可以考虑：**护理 + AI 文书/交接班质量**。这个方向更热，但数据治理和伦理更麻烦，适合在已有本院脱敏文本、护理记录评分标准或模拟案例库之后推进。

## Terminology seeds

- nursing-sensitive adverse events
- patient safety
- pharmacovigilance
- real-world data
- nursing surveillance
- adverse event reporting
- clinical documentation
- nursing handoff
- large language models
- wearable sensors
- process mining
- human factors engineering
