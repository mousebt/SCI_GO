# 论文完善路线图 v0.2 / Manuscript Development Roadmap v0.2

> 本版取代同日v0.1路线图。 / This version supersedes the earlier roadmap dated 2026-07-29.  
> 已确认本院共有44例；重复编号为录入错误，不删除病例。 / The local dataset contains 44 confirmed cases; the repeated identifier is a data-entry error and does not warrant case exclusion.

## 1. 当前任务 / Immediate Tasks

**中文：**

1. 确认5年观察期起止日期和约9,500人次检查的统计来源。
2. 为44例数据补充表头和数据字典，并建立去标识化分析表。
3. 将44例均定义为独立不良事件案例；编号错误不影响例数。
4. 采用多标签方式编码症状，因为同一案例可能同时出现恶心、呕吐、皮疹或其他表现。
5. 由两名评价者复核症状分类，并计算类别频数和比例。
6. 审计每例记录的患者、造影剂、给药、时间、事件、处置、结局及关系字段。

**English:**

1. Confirm the exact five-year period and the source of the approximately 9,500 examinations.
2. Add headers and a data dictionary for all 44 cases and create a de-identified analysis table.
3. Treat all 44 rows as independent adverse-event cases; the identifier error does not change the case count.
4. Apply multi-label symptom coding because one case may include nausea, vomiting, rash, or other concurrent manifestations.
5. Use two reviewers to verify symptom coding and calculate category frequencies and percentages.
6. Audit patient, contrast agent, administration, timing, event, management, outcome, and relationship fields for every case.

## 2. 核心结果表 / Core Results Tables

**中文：**

- 表1：44例患者基本特征及症状类别。
- 表2：现有记录各核心字段的完整率。
- 表3：给药—事件—处置—结局关系的明确率。
- 表4：FAERS证据与最终采集提示的映射。
- 表5：现行记录与语音辅助记录的质量及工作负担比较。

**English:**

- Table 1: Patient characteristics and symptom categories for the 44 cases.
- Table 2: Completeness of core fields in existing records.
- Table 3: Explicitness of administration–event–management–outcome relationships.
- Table 4: Mapping of FAERS evidence to final data-capture prompts.
- Table 5: Report quality and workload under current versus voice-assisted documentation.

## 3. 循证字段定稿 / Finalizing the Evidence-Based Fields

**中文：** 正式报告规范决定核心字段；本院44例的缺失情况决定改进重点；FAERS只补充造影剂特异性的症状和时间提示。最终形成字段名称、定义、允许值、缺失状态、追问规则和证据来源，并由护理、影像和药物警戒专家复核。

**English:** Formal reporting standards should define the core fields; missingness in the 44 local cases should determine improvement priorities; FAERS should only add contrast-specific event and timing prompts. The final specification should include field names, definitions, permitted values, missingness states, follow-up rules, and provenance, followed by nursing, radiology, and pharmacovigilance review.

## 4. 语音辅助评价 / Voice-Assisted Evaluation

**中文：** 在实施前锁定比较组、主要结局、评分规则、样本量和统计方案。主要结局为字段完整性和关系明确性；次要结局包括记录时间、修改量、工作负担、可用性、转写准确性和源文本忠实度。模型不得补写事实、自动判断因果或绕过护士审核。

**English:** Before implementation, lock the comparator, primary outcomes, scoring rules, sample-size rationale, and statistical plan. Primary outcomes are field completeness and relationship explicitness. Secondary outcomes include documentation time, editing burden, workload, usability, transcription accuracy, and source fidelity. The model must not invent facts, determine causality automatically, or bypass nurse review.

## 5. 写作顺序 / Writing Order

**中文：**

1. 完成44例症状分类及字段质量审计。
2. 完成循证字段和来源映射。
3. 完成语音辅助对照评价。
4. 先重写结果，再调整方法和讨论。
5. 最后更新摘要、结论、标题及参考文献。

**English:**

1. Complete symptom classification and field-quality auditing for all 44 cases.
2. Finalize the evidence-based fields and provenance mapping.
3. Complete the controlled voice-assisted evaluation.
4. Rewrite the Results first, then align the Methods and Discussion.
5. Update the abstract, conclusion, title, and references last.

## 6. 当前不能声称 / Claims Not Yet Supported

**中文：**

- 44/9,500不是发生率或漏报率。
- FAERS信号不是因果关系或临床严重程度。
- 语音、LLM或RAG尚未被证明能够改善报告质量或降低护士负担。
- 症状类别精确比例须待统一编码和双人复核。

**English:**

- The ratio 44/9,500 is neither an incidence rate nor an underreporting rate.
- A FAERS signal is not evidence of causality or clinical severity.
- Voice capture, LLMs, and RAG have not yet been shown to improve report quality or reduce nursing burden.
- Exact symptom-category percentages require standardized coding and dual review.
