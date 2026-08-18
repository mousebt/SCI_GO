# 论文完善路线图 / Manuscript Development Roadmap

> 日期 / Date: 2026-07-29  
> 适用稿件 / Manuscript: `03_manuscript/main-zh-core-draft-2026-07-29.md`  
> 核心原则 / Core principle: 先完成证据闭环，再扩写文字；不把项目设想写成已证实结果。 / Close the evidence loop before expanding the prose; do not present a proposed workflow as a demonstrated effect.

## 1. 当前版本的作用 / Purpose of the Current Draft

**中文：** 当前稿只负责把研究问题、证据来源、干预流程、评价指标和结论边界讲清楚。它不是投稿终稿，也不应在本院数据、字段证据和语音评价完成前进一步强化结论。

**English:** The current draft is intended to clarify the research question, evidence sources, intervention workflow, outcomes, and inferential boundaries. It is not submission-ready, and its conclusions should not be strengthened until the local dataset, evidence-based field set, and voice-assisted evaluation are completed.

## 2. 第一优先级：核对本院数据 / Priority 1: Reconcile the Local Dataset

**中文：**

1. 明确5年观察期的起止日期，并提供约9,500人次检查的原始统计来源。
2. 解释“39份记录”与当前CSV文件“44行”的差异。
3. 为CSV补充数据字典和表头，确认每列的正式含义及文件编码。
4. 核对重复编号，确定其属于重复录入、同一患者多次事件，还是不同就诊事件。
5. 定义分析单位：患者、检查、事件或报告。未经定义不得计算比例。
6. 保留原始文件不变，另建去标识化分析表，并记录所有排除、合并和修正规则。
7. 在去重后报告最终样本数、事件类别和字段缺失率。

**English:**

1. Confirm the exact five-year observation period and document the source of the approximately 9,500 contrast-enhanced examinations.
2. Reconcile the stated 39 reports with the 44 rows in the current CSV file.
3. Add a data dictionary and column headers, and confirm the formal meaning and encoding of each field.
4. Review the duplicated identifier and determine whether it represents duplicate entry, recurrent events in one patient, or separate encounters.
5. Define the unit of analysis: patient, examination, event, or report. No proportion should be calculated before this definition is fixed.
6. Preserve the raw file and create a separate de-identified analysis table with an auditable record of exclusions, merges, and corrections.
7. After deduplication, report the final sample size, event categories, and field-level missingness.

## 3. 第二优先级：完成基线质量审计 / Priority 2: Complete the Baseline Quality Audit

**中文：** 建立逐份记录评分表，至少评价患者信息、产品与给药信息、事件描述、发生时间、处置、结局，以及“给药—事件—处置—结局”关系。建议由两名评价者独立评分，报告一致性；分歧通过预设规则解决。核心结果应是字段完整率和关系明确率，而不是39/9,500这一描述性登记比例。

**English:** Develop a report-level scoring form covering, at minimum, patient information, product and administration details, event description, onset time, management, outcome, and the relationships among administration, event, management, and outcome. Two independent reviewers should preferably score the records, with inter-rater agreement reported and disagreements resolved using prespecified rules. The primary baseline findings should be field completeness and relationship explicitness, not the descriptive ratio of 39/9,500.

## 4. 第三优先级：定稿循证字段 / Priority 3: Finalize the Evidence-Based Field Set

**中文：**

1. 选择并引用正式个例安全性报告规范，区分必填、条件必填和可选字段。
2. 将本院基线缺口映射到规范字段。
3. 将FAERS结果仅转化为造影剂特异性的事件和时间询问提示。
4. 由护理、影像、药物警戒和信息学专家复核字段的必要性、可理解性与临床可操作性。
5. 形成字段字典、允许值、缺失状态、追问规则和来源标记。
6. 保存“规范字段—FAERS证据—本院缺口—最终提示”的可追溯映射表。

**English:**

1. Select and cite formal individual case safety report standards, distinguishing required, conditionally required, and optional fields.
2. Map local baseline deficiencies to the formal reporting fields.
3. Translate FAERS findings only into contrast-specific event and timing prompts.
4. Obtain multidisciplinary review from nursing, radiology, pharmacovigilance, and informatics experts for necessity, clarity, and clinical usability.
5. Produce a field dictionary, permitted values, missingness states, follow-up rules, and provenance labels.
6. Maintain a traceable mapping from formal standards, FAERS evidence, and local gaps to each final prompt.

## 5. 第四优先级：定义并锁定语音评价研究 / Priority 4: Define and Lock the Voice-Assisted Evaluation

**中文：**

1. 确定研究设计：真实病例前瞻性研究、模拟病例交叉试验，或分阶段实施研究。
2. 明确比较组：现行记录方式与语音辅助方式。
3. 预先指定主要结局为字段完整性和关系明确性。
4. 预先指定次要结局：记录时间、修改量、工作负担、可用性、转写准确性和源文本忠实度。
5. 建立由临床专家确认的参考答案或评分金标准。
6. 说明模型、提示词、知识库版本、温度等可复现参数，并冻结测试版本。
7. 记录所有事实性增写、遗漏、错误归类及护士纠正。
8. 完成样本量依据、统计分析计划、伦理审批、音频安全与权限方案。

**English:**

1. Select the study design: a prospective real-case study, a simulated-case crossover trial, or a phased implementation study.
2. Define the comparator: current documentation versus voice-assisted documentation.
3. Prespecify field completeness and relationship explicitness as primary outcomes.
4. Prespecify documentation time, editing burden, workload, usability, transcription accuracy, and source fidelity as secondary outcomes.
5. Establish a clinician-adjudicated reference standard or scoring gold standard.
6. Document reproducible model, prompt, knowledge-base version, temperature, and related settings, and freeze the evaluated version.
7. Capture all unsupported additions, omissions, misclassifications, and nurse corrections.
8. Complete the sample-size rationale, statistical analysis plan, ethics review, audio-security plan, and access controls.

## 6. 写作与结果填充顺序 / Writing and Result-Filling Order

**中文：**

1. 先完成本院数据清理表和基线质量结果表。
2. 再完成循证字段表和来源映射表。
3. 锁定语音评价方案后再实施并生成结果表。
4. 先重写结果，再据结果压缩方法和讨论。
5. 最后重写摘要、标题、结论和参考文献。

**English:**

1. Complete the local data-cleaning table and baseline-quality results table first.
2. Then finalize the evidence-based field table and provenance mapping.
3. Implement the voice evaluation only after the protocol is locked and generate the corresponding results tables.
4. Rewrite the Results first, then align and compress the Methods and Discussion.
5. Rewrite the abstract, title, conclusion, and references last.

## 7. 建议形成的表图 / Recommended Tables and Figures

| 编号 / No. | 中文 / Chinese | English |
|---|---|---|
| 表1 | 本院样本清理流程与最终分析集 | Local data-cleaning flow and final analysis set |
| 表2 | 既有记录的字段完整性与关系明确性 | Field completeness and relationship explicitness of existing records |
| 表3 | FAERS事件与时间证据及其采集用途 | FAERS event/timing evidence and its use in data capture |
| 表4 | 最终循证字段、来源和追问规则 | Final evidence-based fields, provenance, and follow-up rules |
| 表5 | 现行方式与语音辅助方式的主要及次要结局 | Primary and secondary outcomes for current versus voice-assisted documentation |
| 图1 | 研究逻辑：本院质量缺口—FAERS补充—语音辅助—质量评价 | Study logic: local quality gap–FAERS enrichment–voice assistance–quality evaluation |
| 图2 | 护士口述到审核确认报告的工作流程 | Workflow from nurse narration to reviewed and confirmed report |

## 8. 在证据完成前不得声称的内容 / Claims Prohibited Until Evidence Is Available

**中文：**

- 不得将39/9,500解释为发生率或漏报率。
- 不得声称FAERS证明造影剂与某事件之间的因果关系。
- 不得声称大语言模型已经提高报告质量或降低护士负担。
- 不得把FAERS中的高频或信号术语直接写成临床严重程度。
- 不得将模型生成内容视为无需护士审核的最终报告。
- 不得在未完成核对前报告本院事件类别的精确比例。

**English:**

- Do not interpret 39/9,500 as an incidence or underreporting rate.
- Do not claim that FAERS establishes causality between a contrast agent and an event.
- Do not claim that the LLM has improved report quality or reduced nursing burden before evaluation.
- Do not equate frequent or signaled FAERS terms with clinical severity.
- Do not treat model-generated content as a final report that bypasses nurse review.
- Do not report exact local event-category proportions before reconciliation is complete.

## 9. 完成标准 / Completion Criteria

**中文：** 当且仅当以下材料齐备时，可把当前“研究框架稿”升级为完整论文：本院分析集及审计轨迹、基线质量结果、正式字段证据、最终知识库版本、冻结的语音评价方案、完整评价结果、伦理与数据安全说明，以及逐条核验的参考文献。

**English:** The current framework draft may be upgraded to a complete manuscript only when the following are available: a reconciled local analysis set with an audit trail, baseline-quality results, formal evidence for the field set, a finalized knowledge-base version, a frozen voice-evaluation protocol, complete evaluation results, ethics and data-security documentation, and fully verified references.
