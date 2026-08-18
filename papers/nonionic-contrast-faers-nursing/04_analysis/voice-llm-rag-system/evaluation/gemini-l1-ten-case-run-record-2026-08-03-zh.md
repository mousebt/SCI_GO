# Gemini 2.5 Flash十例L1工程试跑记录

日期：2026-08-03  
状态：10例工程试跑与人工结构审计完成

## 配置

- 输入：`expert_constructed_text_candidates_100_80_20_v2.json`
- 病例：`TXT82-001`至`TXT82-010`
- 难度与评价层：L1，routine
- 提供商：Google Gemini API原生`generateContent`
- 模型：`gemini-2.5-flash`
- temperature：0
- thinkingBudget：0
- workers：1
- RAG知识库：`8f2e8f8c742e`
- 最终运行：`runs/20260803T013715Z-gemini-text-corpus-n10/`

## 汇总结果

- 请求10例，成功10例，错误0例。
- 总耗时52.068秒，平均5.207秒/例。
- 护栏后非空事实逐字来源检查125项，缺少逐字来源0项。
- `pending_human_review`：10/10。
- `automated_submission_permitted=false`：10/10。
- 安全标记：0。
- 2例正确标记`outcome`缺失。
- 当前单元测试11/11通过。

## 人工结构审计

逐例检查事件、处置、转归、缺失状态及安全状态：

- 未发现完全重复事件、处置或转归；
- 未再出现结局措辞被写入事件严重度；
- 未再出现“观察区”被误判为护理动作；
- `TXT82-004`和`TXT82-009`分别保留“继续观察”与“转入留观区继续观察”，对应原文前后两个独立动作，不判定为重复；
- `TXT82-005`和`TXT82-010`只保留完整结局“症状缓解”，不再追加子串“缓解”；
- `TXT82-002`和`TXT82-007`正确保持转归缺失。

## 解释边界

本轮支持Gemini流程可在10条L1完全合成文本上返回结构可解析、逐字来源受约束且保持人工审核状态的报告。由于尚无独立专家金标准，不能报告准确率、召回率、F1、临床有效性或临床安全性。本轮也不能外推至L2-L5。

## 输出哈希

- `reports.json`: `E1C3D6DB2C00920564E8910BA279CE314F27577DF8FCB531A204C0D1F0EA7463`
- `summary.json`: `8442F77142AF22CA71CD5CA1A1591A6BE65DEA73DA21EFB79967C0C81648686C`
- `errors.json`: `A5338D955B09046EC0B16F3A9625B7955C763AAE07DC722E474E6078745F932F`
