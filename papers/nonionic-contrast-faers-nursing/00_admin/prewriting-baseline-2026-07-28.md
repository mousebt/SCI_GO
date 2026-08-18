# 正式撰写前材料基线（2026-07-28）

## 基线结论

本项目已完成研究方向、目标期刊、核心论证、FAERS结果口径、本院审计定位、术语边界、证据边界及候选数字化实现边界的前置论证，现转入正式论文撰写阶段。

## 一句话论证

在非离子型碘造影剂护理不良事件上报中，本研究以ICSR/MedDRA定义通用报告骨架，以FAERS不成比例和发生时间分析确定造影剂特异的事件与时间提示，并以本院5年39例登记记录 **[待核实]** 诊断既有记录的字段及关系完整性，从而形成标准化、来源可追溯且必须人工审核的上报需求规格；数字化和大语言模型仅为候选实现，本研究不主张其已改善上报效果。

## 已锁定的前置决策

1. 目标期刊：优先 *Nursing Open*，退稿后再评估 *Current Medical Science*。
2. 文章类型：定量实证研究，并以循证上报需求规格作为分析性产出。
3. 主线：`ICSR/MedDRA通用要求 + FAERS造影剂特异知识 → 本院文档缺口 → 上报需求规格 → 候选数字化实现 → guardrails与人工审核`。
4. FAERS负责识别报告重点，不估计发生率、不证明因果、不比较药物绝对安全性。
5. 本院39例仅用于诊断现有记录的字段和关系完整性，不能凭数量推断或量化漏报。
6. 需求映射列入结果，但每项需求必须具有预设、透明、可追溯的证据来源。
7. LLM不进入标题和实证结果，只作为未来可能的草稿生成层；不得自动判断因果、严重性、可报告性、治疗或自动提交。
8. 原始ADR图片不进入当前文本分析链，不进行图像转录或多模态处理。

## 前置材料入口

- 项目元数据：`paper.yaml`
- 研究简报：`01_planning/research-brief.md`
- 外部评审大纲：`01_planning/project-outline-for-external-ai-review-2026-07-28.md`
- 术语表：`02_evidence/terminology.csv`
- 主张—证据表：`02_evidence/claim-evidence.csv`
- FAERS结果审计：`02_evidence/source-data/database-result-audit-2026-07-15.md`
- FAERS清洗边界：`02_evidence/faers-cleaning-boundary-audit-2026-07-28.md`
- 本院审计输入清单：`02_evidence/local-audit-required-inputs.md`
- 本院数据模板：`02_evidence/local-clinical-record-template.csv`
- 文献证据地图：`05_references/two-paper-evidence-map-2026-07-28.md`、`05_references/additional-two-paper-evidence-map-2026-07-28.md`
- 外部评审原文：`06_review/external-review-gemini-2026-07-28-02.md`
- 需求规格：`03_manuscript/supplementary/reporting-requirements-specification.md`
- JSON Schema：`03_manuscript/supplementary/reporting-draft.schema.json`
- Guardrail规则：`03_manuscript/supplementary/guardrail-rules.csv`
- 中文正式撰写母稿：`03_manuscript/main-zh.md`
- 英文投稿工作稿：`03_manuscript/main.md`
- 全量材料清单与校验值：`00_admin/prewriting-materials-manifest-2026-07-28.csv`

## 已验证的结果口径

- POOLED分析基础报告：14,781份。
- POOLED PT记录：42,811条。
- 达到最低病例数阈值的PT结果：951条。
- 严格4算法POOLED PT信号：230个。
- 严格SOC信号：2个。
- POOLED TTO记录：9,069条；同日8,010条（88.32%）；1日内8,450条（93.17%）。
- Weibull形状参数beta = 0.686271；尺度参数 = 0.958471日。

## 正式撰写时仍不得跨越的缺口

- 本院5年研究期、39例来源和授权调阅路径尚未核实。
- 本院字段完整性和关系完整性汇总尚未完成。
- 第二评价者、分歧解决及一致性统计尚未落实。
- 本院伦理批准、豁免或质量改进认定尚未确认。
- `demo_clean`、`drug_clean`上游构建、随访版本去重和删除文件处理仍需补充。
- 正式ICSR最低字段指南引文仍需锁定。
- 利益相关者需求确认和任何数字工具的前瞻性验证均尚未开展。

## 撰写入口

按照项目写作规则，从结果开始定稿。第3.1～3.3节FAERS结果可以进入正式文字打磨；第3.4～3.5节必须保留占位符，直至本院汇总数据完成；第3.6节只能报告具有可追溯来源的需求映射。中文稿用于作者内容审阅，英文稿用于目标期刊投稿版本迭代。
