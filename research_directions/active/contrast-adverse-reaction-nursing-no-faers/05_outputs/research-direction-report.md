# Research direction report

Direction ID: `contrast-adverse-reaction-nursing-no-faers`

Title: 造影剂临床不良反应与护理研究（不使用FAERS）

Date: 2026-07-29

## 1. One-sentence direction

在增强CT护理场景中，本方向利用本院造影剂不良反应登记、关联护理记录和专家字段标准，评价记录的完整性与可复核性，并进一步测试标准化记录方案的实施效果；不使用FAERS作为主要证据，也不在缺少对照和结局数据时声称降低不良反应或改善患者结局。

## 2. Why this may matter

- Reader relevance: 影像护士承担造影前评估、给药观察、异常识别、升级响应、记录与患者告知。
- Clinical/research need: 当前44例登记多为极短症状标签，不能可靠支持事件复核、团队交接或再次暴露管理。
- Possible nursing/clinical/publication value: 建立可审计的造影剂反应护理最小字段集，并用实际流程终点评价标准化记录方案。

## 3. Candidate paperable questions

| Rank | Candidate question | Data needed | Article type | Feasibility | Comment |
|---:|---|---|---|---:|---|
| 1 | 造影剂不良反应护理记录的完整性与可复核性如何？ | 事件登记＋关联护理记录＋专家字段标准 | retrospective documentation audit | 3.8/5 | 最快降低不确定性；需补完整记录 |
| 2 | 标准化记录表＋护士培训能否改善核心字段完整度？ | 实施前后记录、时间、工作负荷、可用性 | quality improvement / implementation | 4.1/5 | 最有发表价值，但需要前瞻性实施 |
| 3 | 中重度反应后的记录—告知—转诊—再次暴露闭环是否完整？ | 中重度病例及纵向EHR | continuity-of-care audit | 3.0/5 | 临床意义强，受病例数量限制 |
| 4 | 外渗风险分层 | 检查级分母和大量外渗事件 | cohort / prediction | 2.0/5 | 当前7例外渗不足，竞争研究样本很大 |
| 5 | 真实中文护理口述的LLM结构化 | 真实配对文本、专家金标准、独立测试集 | nursing informatics validation | 2.8/5 | 可作为后续，不宜用当前合成数据宣称临床准确 |

## 4. Landscape and competitors

| Topic/competitor | What exists | Gap | Risk |
|---|---|---|---|
| 标准化反应记录 | 2025 ESUR更新指南要求造影剂特异和标准化记录 | 将指南要求转化为护理记录质量终点和实施流程 | 仅做字段表而无实施评价会偏弱 |
| 外渗风险 | 2023年224例前瞻性队列、2025年378,082次CT队列、2026年范围综述 | 可研究本地流程落实，而非复制小样本风险模型 | 当前事件数不足 |
| ADR报告改进 | 2024年混合方法护理实施研究和Cochrane综述 | 造影剂特异、病例级记录质量和工作负荷仍可研究 | 一般知识态度问卷较饱和 |
| LLM临床记录抽取 | 2026年已有372份真实EHR和专家金标准的ADE提取研究 | 中文护理口述、语义来源约束和人机工作流可差异化 | 当前真实数据和专家金标准不足 |

## 5. Feasibility summary

| Dimension | Score 1-5 | Evidence | Main risk |
|---|---:|---|---|
| Data availability | 2 | 现有44例，但关联完整记录和检查级分母未确认 | 数据访问可能阻断 |
| Method feasibility | 4 | 审计、字段共识和前后实施方法可执行 | 需预设评分规则 |
| Ethics/governance | 3 | 可去标识化，但本院资料和护士参与需审批 | 伦理和信息治理 |
| Novelty/saturation | 3 | 记录质量/实施有空间，外渗预测与一般问卷较拥挤 | 必须保持造影剂特异性 |
| Journal fit | 4 | 与影像护理、护理信息学、患者安全相符 | 单纯小样本描述稿偏弱 |
| Speed to manuscript | 3 | 基线材料已有 | 完整记录和前瞻数据尚缺 |

## 6. Recommendation

Recommended decision:

- [ ] Proceed to paper
- [x] Revise direction
- [ ] Park for later
- [ ] Reject

Reason:

方向比“FAERS＋护理＋LLM”更清晰，也有近3年指南和护理实施文献支撑；但当前44条简短登记不能直接支撑风险预测或临床效果论文。应先验证能否关联到完整护理记录和检查级台账，再决定进入“记录质量审计”还是“前瞻性实施评价”。

## 7. Boundaries

This direction should not claim:

- 不从44/约9,500计算发生率，除非获得完整检查级分母和一致事件定义。
- 不把记录完整性改善解释为患者结局改善。
- 不把指南建议当作本院已执行或已有效。
- 不用合成病例替代真实临床验证。
- 不在没有专家金标准时报告LLM临床准确性。

## 8. Evidence needed before promotion

- 20例真实事件的完整记录可得性试查。
- 检查级台账和事件登记是否可稳定关联。
- 伦理/治理路径及是否允许前瞻性护士实施评价。
- 可参与字段共识和双人标注的临床专家数量。
