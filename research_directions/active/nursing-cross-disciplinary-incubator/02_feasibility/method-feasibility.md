# Method feasibility

Direction ID: `nursing-cross-disciplinary-incubator`

## Candidate methods

| Method | Fits which question | Readiness | Risk |
|---|---|---|---|
| Disproportionality analysis: ROR, PRR, BCPNN, MGPS | 药物/器械/护理相关不良事件信号识别 | high; 已在现有论文项目中使用 | 需要完整公式、阈值、背景集和可复现输出 |
| Time-to-onset + Weibull shape parameter | 不良事件发生时间特征 | moderate-high; 可用 Python 实现 | 日期缺失、部分日期、负值/异常值处理必须透明 |
| SOC/PT 分层风险画像 | 护理监测重点和宣教重点 | high | MedDRA 版本和标准英文名必须核对 |
| NLP/LLM 信息抽取 | 护理文书、不良事件报告、交接班摘要 | moderate | 需要人工标注金标准和隐私治理 |
| 质量评价量表 / 一致性评价 | AI 生成护理记录、交接班内容、宣教文本 | moderate | 评价标准需要可靠；最好有人类专家评分 |
| 流程挖掘 / 时间序列分析 | 护理流程、告警疲劳、工作负荷 | moderate-low | 数据准备成本高 |

## Method minimum standard

无论选择哪一个方向，都必须先满足：

1. 一句话研究问题能说清楚“护理为什么需要这个结果”。
2. 每个主要变量有来源、定义、清洗规则和缺失处理。
3. 每个统计/模型输出能复现。
4. 不把相关性、信号或模型预测写成因果结论。
5. 所有 AI 辅助内容保留审计记录。

## Reproducibility requirements

- 保存原始 SQL、Python 脚本、参数、运行日期和输出表。
- 每个候选题保留数据流程图：原始记录数、去重、排除、纳入、分层。
- 若使用 MedDRA，记录版本、PT/SOC 映射和旧术语处理规则。
- 若使用 LLM，记录模型版本、提示词、抽样设置、人工核验规则和失败案例。
