以 **Nursing Open 审稿人**（关注护理实践落地、临床可行性、护士工作负荷与文档质量）与 **药物警戒方法学专家**（关注 SRS 数据局限性、信号挖掘严谨性、ICSR E2B(R3) 数据结构与需求工程推导）的双重视角，对修订后的项目大纲（Project Outline v0.11 及 Working Draft）进行了全面深度审计。

---

### 一、 核心检查事项审计结论

#### 1. 单一递进论证与拼盘风险 (Single Information Chain vs. Stacking)

* **审计结论：** 基本成功，但仍有局部“技术脱密”不彻底的痕迹。


* **专家评价：** 大纲通过“**Universal ICSR Framework + FAERS Specific Priorities $\rightarrow$ Local Documentation Gap Diagnosis $\rightarrow$ Evidence-informed Specification Requirements**”形成了清晰的“数据-问题-需求”递进链条。这不再是三个平行技术的拼盘，而是一个标准的需求工程（Requirement Engineering / System Specification）流程。


* **残留隐患：** 在 Discussion 部分（4.4节），虽然标题修改为了“Requirements for standardization...”，但内文依然花费了不小的篇幅讨论“Mobile text/voice capture”和“LLM-assisted draft generation”的具体实现细节。作为未验证的构想，如果讨论过深，审稿人仍会产生“作者试图强行展示 AI 概念”的拼盘感。



#### 2. ICSR/MedDRA 通用要求与 FAERS 特异提示的分工

* **审计结论：** 非常合理且方法学严密。


* **专家评价：**
* **ICSR / E2B(R3) 标准：** 担当“骨架（Structure & Minimum Validity Criteria）”，确保报告符合 ICH 监管质量要求（如四要素：可识别患者、报告者、怀疑药物、不良事件）。


* **FAERS 信号与 TTO：** 担当“肌肉/动态提示（Smart Prompts & Timing Triggers）”，例如针对渗漏（Extravasation）、造影剂脑病（Contrast Encephalopathy）、喉头水肿等高风险 PT 设立动态追问字段。


* **隔离策略：** 方案明确规定“FAERS 提示不能锁定自由文本输入”，保留了自由文本和原始描述（Original Text preservation），完美避免了由于信号提示造成的“锚定效应（Anchoring Bias）”。





#### 3. 本院 39 例作为“诊断性文档审计”的成立性

* **审计结论：** 方法学定位成立，但防守边界需进一步收紧。


* **专家评价：**
* **定位正确：** 大纲已明确声明 39 例**不用于**计算发生率、评估漏报率或做推断性统计，仅作为“诊断性质量审计（Diagnostic Quality Audit）”，用以证明“即使事件被记录，其字段完整性（Field Completeness）与逻辑关联性（Relationship Completeness）依然缺失”。


* **关键缺陷：** 5 年 39 例在临床上依然显得极少（提示极度漏报），大纲在 9.8 节与 4.3 节明确指出“39 例本身不能量化漏报率”，这是极佳的防御。但若审稿人质疑这 39 例的选择偏差（Selection Bias），目前缺乏明确的纳入/排除标准描述（Inclusion/Exclusion criteria 仍标注为 `[VERIFY]`）。





#### 4. Mapping 放在 Results 的方法学基础

* **审计结论：** 具备充分的方法学依据，但需明确其性质为“分析性产物（Analytical Output）”。


* **专家评价：**
* 在健康信息学（Health Informatics）与需求工程研究中，**矩阵/规范体系（Specification Matrix）本身就是实证分析的导出产物（Derived Output）**，完全可以且应当作为 Results 的最后一节（Section 3.6）。


* 如果放在 Discussion，会使前面 FAERS 和 Local Audit 的数据失去“落脚点”；放在 Results 则构成了完整的“数据分析 $\rightarrow$ 需求映射”逻辑闭环。





#### 5. 是否仍存在夸大声明 (Overclaims Check)

* **审计结论：** 文本合规度极高，防守极其严密。


* **专家评价：** 大纲在 Section 15（Claims must not make）以及全文多处（如 Section 3, 5, 8.5, 9.8, Discussion）设置了非常严苛的语义界限：
* 严格区分了“设计目标（Design Objectives）”与“验证结果（Demonstrated Outcomes）”。


* 全面禁用了“improved completeness”、“increased reporting rate”、“proven accuracy”等已完成态动词，全篇采用“is designed to support”、“intended mechanism”等中性词汇。





#### 6. 术语一致性检查 (AE vs. sADR vs. ADE)

* **审计结论：** 仍存在局部混用，需要进一步“精准化清扫”。


* **专家评价：**
* 大纲与 Draft 中同时出现了 ADE（Adverse Drug Event）、AE（Adverse Event）、ADR（Adverse Drug Reaction）以及 suspected contrast-related adverse events。


* **方法学纠偏：** 在药物警戒中：
* **FAERS 数据：** 是 spontaneous reports，抓取的是 **Suspected Adverse Event / Suspected ADR**。


* **护理临床现场：** 护士观察并填报的是“怀疑与造影剂相关的事件”，因果关系未定，属于 **Suspected Adverse Reaction (sADR)** 或 **Suspected Contrast-Related Adverse Event**。


* **混用风险：** 全文标题和主线使用的是“Adverse Event (AE)”，但在 4. Section 及部分段落中出现了“ADE/AE reporting information chain”。**ADE 包含给药错误、撤药反应等更大范畴，而本研究集中在造影剂过敏/毒性反应，应统一为 Suspected Contrast-Related Adverse Event (sAE/sADR)**。







#### 7. 导致拒稿的关键缺失项 (Fatal Flaws / Missing Elements)

1.  ethics / IRB 状态明确性： 至今仍为 `[EVIDENCE NEEDED]`。*Nursing Open* 对涉及临床病例回顾的 IRB 批号或豁免声明（Waiver）查验极严，无批号直接 Desk Reject。


2. **双人独立编码与可靠性（Inter-rater Reliability）：** 39 例本地表单的审计缺乏独立的第二评审人（Second Reviewer）和 Kappa 值。单人 Coding 会被质疑严重的主观偏见（Subjective Bias）。


3. **FAERS 数据去重与清洗细节缺乏：** 2.3 节提到依赖数据库内部的 `demo_clean` 和 `drug_clean`，但未给出具体的清洗规则（如 FDA CASEID / PRIMARYID 的处理逻辑，以及品牌名到通用名的映射表）。



---

### 二、 评审意见分类处理表 (Actionable Peer Review Advice)

按照要求，将评审意见严格分为**必须修改（Mandatory Modifications）**、建议修改（Recommended Modifications）**和**可以保留（Keep As-Is）三类：

```
+-----------------------------------------------------------------------------------+
|                            一、 必须修改 (Mandatory Modifications)                 |
+-----------------------------------------------------------------------------------+

```

#### 1. 补全双人独立编码与 Inter-rater Reliability (Q9, Section 9.6)

* **评审理由：** 39 例本地表单的“Documented / Partial / Missing”分类属于主观定性评价。如果仅由第一作者一人完成，缺乏科学可重复性，审稿人会直接否定 Section 3.4/3.5 的结果。


* **修改要求：** 必须在方法学中明确安排第二位独立评审人（如资深护理质控专家或药物警戒药师），进行双盲 Coding，并汇报 Cohen's kappa 值及一致率（Raw Agreement）。



#### 2. 彻底明确 IRB / Ethics Approval Status (Section 2.10, Declarations)

* **评审理由：** 涉及本院 39 例病历/护理记录调阅，必须有明确的伦理委员会批件号（IRB Approval Number）或官方伦理豁免证明（Ethics Waiver）。


* **修改要求：** 决不能带着 `[EVIDENCE NEEDED]` 投稿。若无法在投稿前取得伦理批件，必须按照 Declarations 中的备用方案——**彻底移除本地 39 例组件**，将文章退缩为纯粹的“FAERS 挖掘 + 基于文献与 ICSR 的需求工程规范”。



#### 3. 严格统一全篇术语系统 (Terminology Consistency)

* **评审理由：** 混用 AE、ADE、ADR 会降低文章的方法学专业度。


* **修改要求：** 全篇（包括图表和 Section 4 结构框图）全面剔除“ADE”术语。统一使用：


* **FAERS 层面：** Suspected Adverse Events (sAEs)；


* **护理/本地层面：** Suspected Contrast-Related Adverse Events (sAEs) 或 Suspected Adverse Drug Reactions (sADRs)。





#### 4. 补充 39 例本地审计的纳入/排除标准与数据调阅路径 (Section 9.1)

* **评审理由：** 审稿人必定质疑“5 年为何只有 39 例”。


* **修改要求：** 在 Section 2.7 中补齐这 39 例是如何从医院不良事件上报系统（OA/HIS/PV System）中检索出来的（检索词、筛选流程、排除的具体非造影剂事件数）。



```
+-----------------------------------------------------------------------------------+
|                            二、 建议修改 (Recommended Modifications)               |
+-----------------------------------------------------------------------------------+

```

#### 5. 进一步缩减 Discussion 中对 LLM / App 实现细节的描绘 (Section 4.4)

* **评审理由：** 目前 Discussion 4.4 依然讨论了 Voice capture、Mobile UI 等，极易诱发审稿人攻击“你根本没做 App，凭什么讨论这些”。


* **修改建议：** 将 Discussion 4.4 的重心完全放在“**抽象需求（Abstract Requirements）**”上，例如“为何字段关联性（Relationship Linking）在护理记录中至关重要”，而不是“Mobile 界面应该怎么设计”。



#### 6. 强化“护理实践与护士工作负荷”的讨论视角 (Section 1, Section 4)

* **评审理由：** *Nursing Open* 的核心读者是护士。目前大纲的方法学色彩偏重（Pharmacovigilance/Informatics），护理特色略显不足。


* **修改建议：** 在 Introduction 和 Discussion 中，增加对“**造影室/放射科护士临床工作流（Radiology Nursing Workflow）**”的切入：护士在面对突发过敏/渗漏时，救治是第一位的，现有的繁琐填报系统导致护士只能“事后补记”或“简要记录”，从而产生了 Documentation Gap。本规范的最终目的是为了“保护护士免受复杂填表的困扰，同时确保质控合规”。



#### 7. 在 Supplementary Material 中提供完整的伪代码和 Guardrail 规则

* **评审理由：** 应对审稿人质疑“Paper Exercise（纸上谈兵）”的最强武器，就是展现出“极高完成度的需求规范”。


* **修改建议：** 在 Supplement 中附上完整的 JSON Schema、逻辑校验判定树（如：`If event_date > current_date THEN flag_error`）和字段映射字典。让审稿人意识到：虽然没有写代码，但研究产出了工业级可直接交付的 Specification。



```
+-----------------------------------------------------------------------------------+
|                               三、 可以保留 (Keep As-Is)                          |
+-----------------------------------------------------------------------------------+

```

#### 8. 推荐标题（Recommended Title）的去 LLM 化设计

* **保留理由：** 推荐标题 `FAERS Signals and Local Documentation Gaps for Non-Ionic Iodinated Contrast Media: Defining Requirements for a Standardized, Human-Reviewed Nursing Adverse-Event Reporting Workflow` **完全不提 LLM**，极其稳妥地避开了审稿人的预判偏见，坚决保留。



#### 9. 三大设计目标（Design Objectives）与否定声明（Claims Must Not Make）

* **保留理由：** Section 5 和 Section 15 建立的防守墙是整篇文章最出彩的地方，将“设计意图”与“实证结果”割离，彻底锁死了审稿人关于“未进行 AI 临床验证”的攻击路线，务必完封保留。



#### 10. Table 4 (Evidence-to-Requirement Mapping) 置于 Section 3.6 Results 的结构安排

* **保留理由：** 逻辑顺畅，将数据分析（FAERS + Gap）直接转化为结果产物（Specification Matrix），赋予了文章极强的重构感与学术厚度。



#### 11. FAERS 四算法严格筛选（Strict 4-Algorithm Criteria）与 Shrinkage Ranking

* **保留理由：** 采用了 ROR + PRR + BCPNN + EBGM 严格交集，并用 EBGM05 进行降序排列（Section 8.3/3.2），方法学达到了顶级 Pharmacovigilance 期刊的标准，展现了极高的方法学严谨性，务必保留。



---

### 三、 审稿人总结意见 (Overall Reviewer Recommendation)

**修改后重投（Major Revision Prior to Full Manuscript Draft）**

这份项目大纲在**逻辑防御**与**自我审查**方面表现出了极高的学术水准。只要团队在正式撰写全文前完成 **IRB 批号补齐、双人独立 Coding Kappa 值计算、以及全篇 sAE/sADR 术语统一**，该文稿将具备极强的抗打击能力，能够非常顺畅地通过 *Nursing Open* 或 *Current Medical Science* 的同行评审。