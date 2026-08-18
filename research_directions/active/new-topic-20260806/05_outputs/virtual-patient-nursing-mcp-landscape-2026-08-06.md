# 虚拟病人 + 护理：MCP文献景观与方向判断

日期：2026-08-06  
状态：研究方向探讨，未转入论文项目  
工作流：`research-direction` + `multi-source-search`

## 一句话方向

> 在护理教育或护理信息学场景中，使用传统或生成式AI驱动的虚拟病人提供可重复、受控的临床交互或虚拟病例数据，并评价临床推理、沟通、护理诊断/文书质量与安全边界；不得把模拟表现直接外推为真实患者获益。

## 检索范围

五组MCP检索概念：

1. virtual patient + nursing；
2. virtual standardized/simulated patient + nursing；
3. virtual patient + chatbot/conversational agent/avatar/digital human + nursing；
4. virtual/synthetic patient + LLM/ChatGPT/GenAI + nursing；
5. virtual patient data/virtual ENR + nursing diagnosis/documentation/care plan。

来源：PubMed、CrossRef、arXiv；另尝试Scopus补充检索。

## 检索审计

- 五组PubMed/CrossRef/arXiv查询共返回240条合并记录。
- 按DOI优先、规范化标题次优去重，并要求题名或摘要同时出现虚拟病人与护理概念后，得到55条候选记录。
- 年份范围：2010–2026。
- 2023–2026年候选记录29条，显示GenAI虚拟病人研究近年明显增多。
- 自动初分：虚拟病人模拟与护理教育25条、虚拟标准化病人13条、LLM/生成式AI虚拟病人8条、对话代理/虚拟人8条、虚拟病人数据与护理文书1条。
- 上述55条仍包含虚拟课堂、患者门户、一般沉浸式技术、手术室模拟等假阳性，不能全部视为直接支持证据。
- arXiv五组均因本机SSL证书链错误失败。
- Scopus因本机缺少 `C:\Users\XuJianhao\.config\pybliometrics.cfg` 未能检索；这不是“Scopus无结果”。

## 已核验的核心论文

| 类别 | 年份 | 论文 | 设计/意义 | DOI |
|---|---:|---|---|---|
| GenAI虚拟病人综述 | 2026 | *GenAI-Supported Virtual Patients in Health Care Education: Systematic Review* | 系统总结GenAI虚拟病人的设计、实施与教育效果 | 10.2196/82756 |
| 精神科访谈 | 2026 | *Effectiveness of AI-enhanced virtual patients for psychiatric interview training...* | 系统综述与Meta分析 | 10.3389/fmed.2026.1834636 |
| 护理临床推理 | 2026 | *Effect of desktop virtual patient simulation on clinical reasoning skills of nursing students* | 系统综述与Meta分析，纳入24项研究、1875名护生 | 10.1016/j.nepr.2026.104822 |
| GPT虚拟病人 | 2025 | *Use of a GPT-based virtual patient for health assessment and communication training in nursing education* | 混合方法研究；28名韩国准新护士与急性阑尾炎虚拟病人互动 | 10.1016/j.nepr.2025.104536 |
| AI虚拟病人体验 | 2025 | *Exploring nursing students' perspectives and experiences with AI-driven patient interactions during a simulated placement* | 15名精神健康护理学生的质性研究 | 10.1016/j.nepr.2025.104500 |
| LLM虚拟病人综述 | 2025 | *Large Language Model-Based Virtual Patient Simulations in Medical and Nursing Education: A Review* | 综述2023–2025年40项研究，提出6类实现路径与安全挑战 | 10.3390/app152211917 |
| 多智能体虚拟病人 | 2025 | *A Generative Multi-Agent Virtual Patient Framework for Nursing Education with RAG-Based Safety Guardrails* | 叙事、生理和评价三智能体，结合RAG与一致性检查；期刊质量仍需核验 | 10.6913/mrhk.070403 |
| 虚拟ENR护理文书 | 2025 | *Generative AI-Based Nursing Diagnosis and Documentation Recommendation Using Virtual Patient ENR Data* | 40名护士比较传统与AI辅助文书 | 10.4258/hir.2025.31.2.156 |
| 虚拟病人数据训练 | 2024 | *Development of a Nursing Diagnosis/Record Generative AI System Based on Virtual Patient Data* | 以50,000条虚拟护理记录训练/微调并由40名护士测试 | 10.3233/SHTI240275 |
| AI虚拟咨询 | 2019 | *A Virtual Counseling Application Using Artificial Intelligence for Communication Skills Training in Nursing Education* | 开发并测试AI虚拟病人沟通训练应用 | 10.2196/14658 |
| 传统虚拟病人推理 | 2014 | *Clinical reasoning in nursing, a think-aloud study using virtual patients* | 以虚拟病人和出声思维研究护理临床推理 | 10.1016/j.nedt.2013.07.010 |
| 家暴护理准备度 | 2026 | *Virtual patients in nursing education for readiness in encountering patients exposed to domestic violence* | 解释性序贯混合方法研究；CrossRef有题录，摘要待补 | 10.1016/j.nedt.2026.107123 |

## 研究格局

### 1. 传统虚拟病人护理教学：证据已经较成熟

虚拟病人用于临床推理、病史采集、沟通、肿瘤护理、精神健康、家暴照护和跨专业学习已有多年研究。2026年Meta分析纳入24项研究，说明再做普通“虚拟病人是否提高护生学习效果”课题已较拥挤。

### 2. GenAI/LLM虚拟病人：正在快速增长

2025–2026年已出现GPT虚拟病人混合方法研究、AI驱动模拟实习质性研究、系统综述、Meta分析和LLM虚拟病人综述。仅搭建ChatGPT角色扮演病人并做满意度调查，创新性很可能不足。

### 3. 虚拟病人数据用于护理诊断与文书：较聚焦

两项直接研究使用虚拟患者电子护理记录或虚拟护理记录数据，开发护理诊断与文书推荐系统。这条路线可避免直接暴露真实患者数据，但模型在虚拟数据上的表现不能自动证明真实临床有效性。

### 4. 安全受控的多智能体虚拟病人：有概念先例

多智能体、RAG、安全护栏、生理一致性和自动评价已被提出。新的研究必须提供真实可审计的系统实现、冻结测试集、专家参考标准和错误分析，不能只发表概念框架。

## 候选课题排序

### 1. 虚拟病人数据驱动的护理诊断/文书系统评价

- finished-paper support: **至少2篇**直接完成研究。
- 类型：中风险，较高发表价值。
- 可发表增量：统一NANDA/护理程序框架；字段/关系准确性；幻觉与严重遗漏；护士修订时间；虚拟到真实数据的迁移评价。
- 主要风险：虚拟数据外部效度有限；需要清楚披露数据生成规则与模型训练泄漏。

### 2. GPT虚拟病人用于护理沟通与健康评估

- finished-paper support: **至少3篇**直接护理实证研究，包括2019年AI虚拟咨询、2025年GPT虚拟病人混合方法研究和AI模拟实习质性研究。
- 类型：quick-win到中风险，但竞争快速增加。
- 可发表增量：动态追问、多轮一致性、情绪与文化响应、错误反馈、延迟保持和迁移到新病例。
- 不建议：只比较前后满意度或自我效能。

### 3. GenAI虚拟病人促进临床推理

- finished-paper support: **至少1篇Meta分析（纳入24项传统桌面虚拟病人研究）**；另有GenAI系统综述和新兴实证研究。
- 类型：中风险。
- 可发表增量：将传统静态虚拟病例与LLM动态病人随机比较；使用客观临床推理评分、错误类型、认知负荷和延迟测量。
- 风险：传统虚拟病人证据成熟，必须证明GenAI带来的明确增量。

### 4. 带RAG和安全护栏的多智能体虚拟病人

- finished-paper support: **至少1篇候选完成论文**，但期刊质量和全文证据仍需进一步核验。
- 类型：高风险、探索性。
- 可发表增量：病例事实源、角色一致性、生理状态转换、拒答/升级机制、专家盲评和可复现实验。
- 风险：若只有架构描述而没有独立评价，很难形成强护理研究。

### 5. 精神健康/精神科访谈虚拟病人

- finished-paper support: **至少1篇Meta分析**，并有护理学生模拟实习质性研究及精神科护理虚拟标准化病人研究。
- 类型：中风险。
- 可发表增量：危机识别、自杀风险升级、共情但不越权、创伤知情沟通和人工接管。
- 风险：安全和伦理要求高，不能让未经验证系统直接接触真实高风险患者。

## 初步可行性

| 维度 | 评分 | 说明 |
|---|---:|---|
| 护理相关性 | 5/5 | 可直接对应沟通、评估、诊断、文书和临床推理 |
| 方法可行性 | 4/5 | 虚拟病例、LLM、专家评分和随机教育研究均可实现 |
| 数据可得性 | 3–4/5 | 虚拟数据较容易获得，但必须有透明生成规则和专家核验 |
| 伦理治理 | 4/5（纯模拟） | 不涉及真实患者时风险较低；若使用真实记录生成病例则下降 |
| 文献饱和度 | 2/5（普通教学） | 传统虚拟病人教学较拥挤 |
| 文献饱和度 | 3/5（虚拟数据文书） | 已有先例但仍可细分 |
| 临床外部效度 | 2/5 | 纯虚拟病人结果不能直接外推真实临床 |
| 整体发表可行性 | 3–4/5 | 聚焦具体护理任务并采用客观结局时可行 |

## 推荐

**revise direction：不要做泛化的“虚拟病人用于护理教学”，优先收缩为以下二选一：**

1. **偏护理信息学：**虚拟病人ENR数据驱动的护理诊断/文书质量与安全评价；
2. **偏护理教育：**GPT虚拟病人与传统静态虚拟病人在临床推理或沟通训练中的随机比较。

如果继续坚持“非护理教育类”边界，优先选择第一条。其最快的不确定性降低步骤是确认：现有或可生成的虚拟病人数据字段、护理诊断标准、可参与的护理专家数量，以及是否能设置独立锁定测试集。

