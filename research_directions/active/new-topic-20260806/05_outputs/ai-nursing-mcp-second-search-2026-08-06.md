# AI + 护理：第二轮 MCP 多源检索记录

检索日期：2026-08-06  
工作流：`multi-source-search`  
项目状态：研究方向探讨，未转入论文项目

## 检索范围

本轮将“AI + 护理”拆为四组概念：

1. 护理教育与护生；
2. 护理临床决策与临床推理；
3. 护理文书、交接、护理诊断与护理计划；
4. 真实护理工作流、护士工作量与患者安全。

使用 academic-search MCP 并行检索 PubMed、CrossRef 和 arXiv，每组最多返回 25 条/来源。目标年份为 2024–2026；MCP 返回后再按年份和护理相关性筛选。

## 检索审计

- 四组共返回 200 条合并记录。
- 按 2024–2026、护理相关性、DOI 优先和规范化标题次优去重后，得到 64 条候选记录。
- 年份分布：2024 年 11 条、2025 年 33 条、2026 年 20 条。
- 自动题名分类：44 条实证或其他研究、15 条综述、5 条评论/叙述性文章；该分类仅用于筛选，最终文章类型仍需逐篇全文核验。
- PubMed 与 CrossRef 正常返回结果。
- arXiv 四组均失败：`SSL: CERTIFICATE_VERIFY_FAILED`。因此本轮不能声称覆盖 arXiv。
- 宽检索混入了与 AI 无直接关系、仅涉及护士工作量或患者安全的假阳性；这些记录未计入下面的已核验支持证据。

## DOI 二次核验的代表性已完成论文

| 主题 | 年份 | 研究 | 设计/价值 | DOI |
|---|---:|---|---|---|
| 语音护理文书 | 2026 | Su et al., *Voice-Based Structured Nursing Documentation Using Automatic Speech Recognition and Large Language Models* | ASR—LLM—DART 结构化文书开发与评价，包含护士核验、准确性、幻觉和实际使用 | 10.2196/88567 |
| 临床决策 | 2025 | Saban & Dubovi, *A comparative vignette study* | 30 名急诊护士、38 名护生与 ChatGPT 比较；提示犹豫、过度检查及重评错误 | 10.1111/jan.16101 |
| 护理教育干预 | 2025 | Arkan et al., *The impact of ChatGPT training in the nursing process...* | 单盲随机对照研究；支持教育研究应采用客观能力结局，而不只调查态度 | 10.1016/j.nedt.2025.106765 |
| 用药安全 | 2025 | Orkaby et al., *Bridging generational gaps in medication safety* | 比较护士、护生与生成式 AI 模型，直接连接护理与用药安全 | 10.1186/s12912-025-03034-8 |
| 护理计划 | 2025 | Tanrıverdi & Söylemez, *Use of artificial intelligence in planning postoperative nursing care...* | 比较 ChatGPT 与学生的术后护理计划 | 10.1016/j.nepr.2025.104515 |
| 数字职业素养 | 2026 | Ali & Shaban, *Constructing digital professionalism in the generative AI era* | 护生与教师质性研究 | 10.1016/j.nedt.2026.107055 |
| 临床推理教育 | 2026 | Bulek et al., *Building foundations for independent clinical reasoning in an AI era* | 预注册护理教育中的独立临床推理任务体验 | 10.1016/j.teln.2025.08.034 |
| 护理文书安全 | 2026 | Alsararatee, *Effect of artificial intelligence on nursing documentation and patient safety* | 护理文书与患者安全的叙述性概览，不应计作临床效果试验 | 10.7748/ns.2026.e12724 |
| 临床实施 | 2026 | Scott et al., *Nurses’ Experiences Using AI in Clinical Practice* | 系统综述纳入 20 项实证研究；强调工作流匹配、培训、互操作性与护士共同设计 | 10.2196/91238 |
| 临床决策证据 | 2026 | Cant et al., *Artificial Intelligence Technologies in Nursing Clinical Decision-Making* | 伞状综述纳入 16 篇综述、覆盖 965 项初级研究；真实世界测试和严格比较仍少 | 10.1111/jan.70579 |

## 对方向判断的更新

1. **不优先：再做普通 AI 素养、态度或使用意愿横断面调查。** 2025–2026 年同类护生研究密集，除非具有独特人群、纵向设计或客观行为结局。
2. **较强方向：AI 辅助护理文书的真实工作流评价。** 已有直接完成论文支持，但仍可围绕特定科室、中文语音、结构化字段正确性、护士修订量、文书耗时与严重错误开展聚焦研究。
3. **较强方向：LLM 护理临床决策的错误边界与人工复核。** 已有模拟比较显示过度检查和重评错误；新研究应设置专家金标准、盲法评分、错误严重性和模型版本冻结。
4. **可行方向：AI 辅助护理计划或用药安全。** 不能只比较文本“看起来更好”；应评价遗漏、幻觉、禁忌建议、个体化程度和护士修正成本。
5. **实施研究的缺口仍明确。** 当前综述一致指出真实临床实施、比较研究、互操作性、组织准备度和护理相关客观结局不足。

## 当前边界

- 本轮为快速方向景观，不是系统综述。
- 64 条是候选记录数，不等于 64 篇均已完成全文核验。
- 表中 10 篇已通过 DOI MCP 二次核验题录；是否纳入最终方向支持计数，仍需按全文和研究设计逐篇审查。
- arXiv 未成功覆盖；中文数据库也不在本轮 MCP 来源内。

