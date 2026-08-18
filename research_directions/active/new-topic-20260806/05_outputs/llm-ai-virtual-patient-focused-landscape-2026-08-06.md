# LLM / AI + 虚拟病人：聚焦检索与方向判断

检索日期：2026-08-06  
阶段：研究方向探讨（未转入论文项目）

## 一句话方向

研究 LLM/生成式 AI 驱动的虚拟病人如何支持护理沟通、临床推理、护理诊断和护理文书，并以真实性、准确性、安全性、效率及人工修订负担为核心结局。

## 本轮边界

核心纳入：LLM/生成式 AI/AI agent 明确参与虚拟病人、模拟病人或虚拟病人记录的生成、交互、反馈或护理决策支持。

背景或排除：传统桌面虚拟病人、普通 VR、无 AI 的虚拟标准化病人、仅回答患者健康问题的聊天机器人、数字孪生/合成数据但无护理或临床交互任务的研究。

## MCP 检索概况

- 来源：PubMed、Crossref、arXiv；核心条目再按 DOI 回查。
- 检索概念：virtual/simulated/digital patient × LLM/ChatGPT/GenAI/multi-agent/RAG，并增加 nursing、documentation、clinical reasoning 等限制。
- 护理限定的 PubMed 窄检索返回 11 条；其中包含直接实证研究、综述、方案和若干仅部分相关研究。
- arXiv 因本地 SSL 证书校验失败，未形成可核验结果；Scopus 因本地 pybliometrics 未配置，本轮未计入。
- 以下数量是方向判断所用的“经核验核心证据”，不是系统综述式最终纳入数。

## 按研究类型分类

### A. LLM 直接扮演虚拟病人（核心交互型）

1. **Creating virtual patients using large language models: scalable, global, and low cost**（2025）  
   DOI: 10.1080/0142159X.2024.2376879  
   贡献：展示用 GPT-3.5/GPT-4 低成本构建交互式虚拟病人及自动反馈的可行路径；更偏方法/观点性示范，适合作为技术起点。

2. **A Language Model–Powered Simulated Patient With Automated Feedback for History Taking: Prospective Study**（2024）  
   DOI: 10.2196/59213  
   贡献：106 次对话、1894 个问答对；GPT-4 角色回答在 99% 以上案例中被认为医学上合理，与人工评价者总体一致性 κ=0.832，但部分反馈类别一致性不足。

3. **A large language model digital patient system enhances ophthalmology history taking skills**（2025）  
   DOI: 10.1038/s41746-025-01841-6  
   贡献：把去标识 EHR 转为可语音交互并提供反馈的数字病人；单中心随机对照研究 N=84，支持 LLM 数字病人的技能训练价值。对象是医学学习者，可作为护理研究设计的高质量参照。

4. **Use of a generative pre-trained transformer-based virtual patient for health assessment and communication training in nursing education: A mixed-methods study**（2025）  
   DOI: 10.1016/j.nepr.2025.104536  
   贡献：目前与“护理 + GPT 虚拟病人”最直接的实证文章之一；28 名准护士使用急性阑尾炎虚拟病人进行健康评估与沟通训练。样本较小，主要属于教育场景。

5. **Preparing for meeting patients: A generative AI-enhanced virtual reality patient encounter practice**（2026）  
   DOI: 10.1016/j.ecns.2025.101889  
   贡献：将 GenAI 与 VR 病人会面练习结合，期刊直接面向护理模拟；本轮 Crossref 可核验题录，但未取得摘要，具体设计与结局仍需全文核查 `[VERIFY]`。

### B. 虚拟病人数据 → 护理诊断与文书（核心工作流型）

1. **Development of a Nursing Diagnosis/Record Generative AI System Based on Virtual Patient Data**（2024）  
   DOI: 10.3233/SHTI240275  
   贡献：使用 50,000 条虚拟病人护理记录进行训练/微调，覆盖 NANDA、Focus DAR、SOAPIE 和叙事记录，并由 40 名有经验护士测试。属于会议论文集章节，证据层级和报告完整性有限。

2. **Generative AI-Based Nursing Diagnosis and Documentation Recommendation Using Virtual Patient Electronic Nursing Record Data**（2025）  
   DOI: 10.4258/hir.2025.31.2.156  
   贡献：40 名护士比较传统记录与基于 ChatGPT-4 API 的 SmartENR；报告记录耗时由 467.18±314.77 秒降至 182.68±99.71 秒，同时显示准确性和可用性仍需提升。与临床护理效率、安全和人工修订负担最贴近。

说明：上述两篇来自同一研究团队且技术路线连续，不应当作两个完全独立的外部验证样本。

### C. 证据综合与方法地图

1. **Large Language Model-Based Virtual Patient Simulations in Medical and Nursing Education: A Review**（2025）  
   DOI: 10.3390/app152211917  
   贡献：覆盖 2023–2025 年 40 项研究并归纳实施类型，适合搭建分类框架。

2. **Large Language Model-Based Virtual Patients for Simulated Clinical Learning: A Scoping Review**（2026）  
   DOI: 10.3390/aimed1010007  
   贡献：纳入 21 项研究；多数为小样本试点（样本中位数 21），多采用 GPT 动态文本对话，未报告更高层级的临床/组织结局；11 项报告幻觉或不准确输出。

3. **Large Language Model–Based Virtual Patient Systems for History-Taking in Medical Education: Comprehensive Systematic Review**（2026）  
   DOI: 10.2196/79039  
   贡献：纳入 39 项研究；指出多病共存、罕见病、标准指标、数据透明度和外部效度不足；常见样本仅 10–50 名学生和 3–10 名专家。

4. **GenAI-Supported Virtual Patients in Health Care Education: Systematic Review**（2026）  
   DOI: 10.2196/82756  
   贡献：纳入 15 项实证研究、总 N=645；只有 6 项对照研究、3 项 RCT，且普遍干预短、单次使用、自评结局多、教育理论支撑不足。

5. **Effectiveness of AI-enhanced virtual patients for psychiatric interview training in health professions education: a meta-analysis**（2026）  
   DOI: 10.3389/fmed.2026.1834636  
   贡献：纳入 10 项研究、约 450 名参与者，提示访谈表现、知识和信心改善，但研究设计和质量差异明显；护理学生仅为混合人群的一部分。

## 方向判断

### 方向 1：LLM 虚拟病人用于护理沟通/评估训练

- 可行性：高；现成 LLM、病例脚本和对话评价框架容易搭建。
- 拥挤度：快速升高。2025–2026 年已有多篇综述，单纯“ChatGPT 扮演患者 + 满意度/接受度”创新性弱。
- 值得做的升级：采用对照设计；用盲法专家评分；测量信息遗漏、诱导性回答、角色漂移、幻觉、共情质量和迁移到标准化病人/真实临床的能力。

### 方向 2：AI 虚拟病人记录用于护理诊断与文书

- 可行性：中到高，取决于是否能获得规范病例、护理术语体系和护士专家。
- 拥挤度：相对较低；直接证据目前主要集中在同一团队的两项工作。
- 发表潜力：优于泛教育满意度研究，尤其适合比较“通用 LLM、RAG/规则约束 LLM、护士独立完成、护士+AI协同”四种模式。
- 推荐结局：诊断准确性、关键护理问题召回率、错误/幻觉率、禁忌建议、记录完整性、完成时间、人工修订比例、认知负荷和跨病例一致性。

### 方向 3：多智能体/RAG 安全约束的护理虚拟病人

- 可行性：中；技术和评价工作量较高。
- 研究空白：综述已将 multi-agent、知识图谱和 RAG 列为提升真实性与安全性的路线，但护理专科的直接高质量验证仍少。
- 风险：若只做系统开发、不设置基线模型和安全性评价，容易成为技术展示，护理学贡献不足。

## 当前优先建议

最值得继续收敛的是：

> **基于虚拟病人电子护理记录，比较通用 LLM 与护理知识约束型 LLM（RAG/术语规则）在护理诊断和护理文书生成中的准确性、安全性、效率及人工修订负担。**

备选教育方向：

> **面向高风险沟通场景的 LLM 虚拟病人：评价角色一致性、情绪反应、关键信息披露、护理学生沟通表现及技能迁移，而非只测满意度。**

## 最快下一步

1. 选一个护理任务：护理评估/交班、精神科危机沟通、护理诊断或护理记录。
2. 确定研究对象是护士、护理学生，还是纯模型基准测试。
3. 建立 20–50 个专家审定的虚拟病例及错误风险标签 `[VERIFY: 数量需按设计与资源确定]`。
4. 预先定义主结局，优先选“关键问题召回率或专家评分准确性”，避免把满意度设为唯一主结局。
5. 设置至少一个基线：人工、通用 LLM、知识约束 LLM或传统脚本虚拟病人。

## 局限与待补检

- 本轮不是系统综述，检索式和纳排尚未注册，不能宣称文献穷尽。
- arXiv 与 Scopus 本轮未正常获取；还需补充 CINAHL、Embase、Web of Science 才能形成正式证据地图。
- 2026 年文献较新，卷期、最终出版状态和全文细节需在正式立项前再次核验。
