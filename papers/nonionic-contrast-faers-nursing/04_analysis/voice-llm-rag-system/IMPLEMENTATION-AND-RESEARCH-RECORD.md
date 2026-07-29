# Contrast-AE Voice RAG：实现与研究记录

日期：2026-07-29  
系统版本：1.0.0  
状态：可运行研究原型；完成合成病例工程验证；未完成临床或护士参与评价

## 1. 系统在论文中的位置

系统不是独立的计算机算法研究，而是针对本院手工登记结构不足而建立的护理记录辅助工具。证据链为：

`本院44例登记的结构缺口 → 正式字段骨架与FAERS造影剂特异提示 → 本地RAG检索 → LLM来源约束抽取与组织 → 确定性安全校验 → 护士审核确认`

更新后的一句话论证：

> 在造影剂相关事件护理记录中，本研究通过本院44例手工登记审计识别出症状标签与可复核事件叙述之间的结构缺口，以FAERS事件和时间模式补充采集提示，并实现了一个将普通话口述转换为来源可追溯结构化初稿的LLM+RAG原型；该系统已通过合成病例工程验证，但其对真实报告质量和护理负担的影响仍需前瞻性评价。

## 2. 已实现组件

1. 浏览器端普通话连续语音识别；
2. 浏览器端音频录制和本地下载；
3. 可人工校正的原始转写文本；
4. 基于中文二元字符向量和余弦相似度的本地RAG检索；
5. 带来源、用途、版本和审核状态的知识条目；
6. OpenAI兼容的真实LLM调用层；
7. 固定JSON输出模板；
8. 事件、处置、结局和人口学字段的混合抽取；
9. 每个非空字段的逐字来源验证；
10. 缺失字段检测与中性追问；
11. 因果、严重程度、治疗建议和自动上报的禁止规则；
12. 护士人工确认与JSON导出；
13. 合成病例评价脚本和逐例运行记录；
14. Web API健康检查和自动测试。

## 3. 实现方法

### 3.1 语音输入

网页使用浏览器 `SpeechRecognition/webkitSpeechRecognition` 接口进行普通话实时转写，并使用 `MediaRecorder` 保存音频。浏览器不支持实时转写时，允许粘贴经机构批准ASR生成的转写文本。

浏览器ASR供应商和底层模型版本通常不能由研究者冻结。因此，当前工程验证不报告字错误率，也不将浏览器转写视为最终可重复的ASR模型。正式语音评价应更换为机构批准、版本固定的ASR。

### 3.2 RAG

知识库当前包含12条经原型批准的条目：

- 核心字段和来源状态；
- 本院44例去标识化症状词汇；
- FAERS优先事件词汇；
- FAERS早期发生时间提示；
- 胃肠道、皮肤过敏样和外渗术语候选；
- 中性补充问题；
- 三组安全边界。

检索使用中文二元字符向量、余弦相似度和关键词命中加权。默认返回6条最相关内容，并确保至少包含字段定义和安全规则。检索内容明确标注为结构、候选术语或追问依据，不得作为患者事实。

知识库SHA-256：

`8F2E8F8C742EC7149F3EAC3A118E357E9BC388B3EA8359DAE0EE3EF6D3CAC40A`

运行记录使用其前12位作为知识库版本：`8f2e8f8c742e`。

### 3.3 LLM与混合抽取

真实LLM通过兼容的 `/chat/completions` 接口调用，温度固定为0。系统可配置DeepSeek、智谱、OpenRouter或本地兼容模型。

最终实现采用混合抽取：

- 确定性规则抽取原文中明确出现的年龄、性别、产品、剂量、检查、时间词和常见症状；
- LLM结合RAG内容组织事件、处置、结局、关系和叙述；
- 当LLM漏掉确定性规则已找到的逐字事实时，规则允许回填；
- 回填内容必须是原始转写中的连续片段。

该设计用于降低简单字段遗漏，同时不让规则或知识库创造患者事实。

### 3.4 安全校验

生成后逐项执行确定性检查：

- 非空字段若无原文连续来源片段，则清空并标记；
- 事件术语没有口述支持时移除；
- 生成内容若包含确定因果、最终严重性、治疗建议或自动上报判断，则替换为原始口述；
- 缺失字段重新计算；
- 所有报告默认保持 `pending_human_review`；
- 即使护士确认，`automated_submission_permitted`仍为`false`。

## 4. 工程验证

### 4.1 测试集

使用5条完全合成的中文病例，覆盖：

- 恶心和呕吐；
- 外渗和局部肿胀；
- 打喷嚏和喉部不适；
- 时间表述冲突；
- 不在FAERS优先词汇中的其他事件。

测试集SHA-256：

`5934A507ADFF79FC3DDABC589C0DE28DAD7FC7353A3CECF2FA92F35320ED30FD`

### 4.2 冻结运行

- 提供商：Zhipu；
- 模型：`glm-4-flash`；
- 温度：0；
- 病例数：5；
- 知识库版本：`8f2e8f8c742e`；
- 运行目录：`runs/20260729T090247Z-live-llm/`。

DeepSeek接口鉴权和请求路径可达，但账户返回HTTP 402余额不足，因此未纳入冻结运行。

### 4.3 工程结果

| 指标 | 结果 |
|---|---:|
| 合成病例数 | 5 |
| 平均核心字段准确率 | 0.70 |
| 平均事件F1 | 1.00 |
| 平均来源忠实率 | 1.00 |
| 预设禁写事实总数 | 0 |
| 自动安全测试 | 7/7通过 |
| 本地Web/API烟雾测试 | 通过 |

核心字段准确率是脚本级初步指标。个别“不知道/记不清”信息被模型保存为待确认文本，而参考答案把相应患者事实设为缺失，这会被当前严格等值评分计为错误。正式论文评价前必须冻结更细的状态级评分规则，区分“正确保留不确定性”和“错误填值”。

### 4.4 结果边界

以上结果只证明：

- 真实LLM、RAG、安全校验和Web工作流可以端到端运行；
- 在5条合成病例中，事件抽取和来源验证按当前评分脚本运行；
- 未观察到预设禁写事实。

以上结果不能证明：

- 对真实患者或真实护士口述同样有效；
- 提高本院ADE报告质量；
- 减少记录时间或护理负担；
- 改善上报率；
- 优于无RAG或其他模型。

## 5. 论文可使用的准确表述

### Methods

> We implemented a web-based research prototype that combined Mandarin speech capture, local retrieval-augmented generation, source-constrained LLM extraction, deterministic safety checks and mandatory nurse confirmation. Retrieval used a versioned local knowledge base containing field definitions, local symptom vocabulary, FAERS-derived event and timing prompts, terminology candidates, neutral follow-up questions and guardrail rules. External knowledge was restricted to prompting and normalization and could not populate patient facts. Every non-null field was required to retain a verbatim source span from the transcript.

### Preliminary engineering result

> The end-to-end pipeline was executed on five synthetic Mandarin cases using GLM-4-Flash at temperature 0 and a frozen knowledge base. Under the prespecified engineering script, mean event-level F1 and source fidelity were both 1.00, no prespecified unsupported forbidden facts were detected, and all seven automated guardrail tests passed. Mean core-field accuracy was 0.70, indicating residual handling errors for missing and uncertain non-event fields. These results represent engineering verification on synthetic cases rather than clinical effectiveness.

## 6. 下一阶段

论文若要声称系统改善报告质量，仍需完成：

1. 专家冻结最终字段和评分规则；
2. 扩大并平衡合成病例测试集；
3. 固定可复现ASR模型并报告转写错误；
4. 比较无RAG与RAG；
5. 由独立评价者建立参考答案；
6. 进行护士参与的交叉评价；
7. 报告字段完整性、关系明确性、无来源事实、完成时间、修改量和工作负担。

