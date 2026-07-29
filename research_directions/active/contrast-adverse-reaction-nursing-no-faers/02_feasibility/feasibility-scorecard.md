# Feasibility scorecard

Direction ID: `contrast-adverse-reaction-nursing-no-faers`

Title: 造影剂临床不良反应与护理研究（不使用FAERS）

Scoring: 1 = weak/blocking, 5 = strong/low risk.

| Dimension | Score | Current evidence | Missing evidence | Action |
|---|---:|---|---|---|
| Data availability | 2 | 已有44例简短登记和约5年服务量背景 | 检查级台账、完整护理记录、处置、转归、再次暴露和精确时间尚未确认 | 先做数据盘点和20例完整记录可得性试查 |
| Data quality | 2 | 现有登记能证明记录结构不足 | 现有文本中位长度仅2个中文字符，缺少多数关键字段 | 将“低质量”作为研究对象，不能直接作为模型金标准 |
| Sample size plausibility | 2 | 44例可用于初步记录审计 | 只有约7例外渗，无法建立可靠风险模型；其他亚组亦可能过小 | 获取全部检查级数据并估算各事件类型数量 |
| Method feasibility | 4 | 记录质量审计、专家字段集和前后对照实施研究方法成熟 | 需要冻结字段定义、评分手册和重复标注流程 | 优先选择记录质量/实施研究，不做发生率预测 |
| Ethics/governance | 3 | 可进行去标识化回顾性审计 | 本院数据和护士参与仍需伦理/治理判断 | 先咨询伦理和信息部门 |
| Literature saturation | 3 | 标准化记录和护理实施仍有空间 | 外渗风险、一般ADR知识态度和机器学习预测较拥挤 | 聚焦造影剂特异记录质量与实施效果 |
| Nursing/clinical relevance | 5 | 护士直接承担观察、升级、记录和患者告知 | 需把护理动作与可测量终点绑定 | 主要终点固定为来源支持的核心字段完整度 |
| Journal fit | 4 | 适合影像护理、护理信息学和患者安全读者 | 单纯44例描述研究可能较弱 | 采用审计＋标准开发或前瞻性实施设计 |
| Speed to manuscript | 3 | 已有44例、字段原型和100条开发文本 | 真实记录和专家标注尚未完成 | 先做20例可行性试查，2周内决定 |
| Overall publication feasibility | 3 | 方向临床相关、证据链较FAERS整合更清楚 | 数据完整性和样本量仍是主要阻断点 | 当前建议为“revise”，数据试查通过后再转入论文 |

## Red flags

- 把约9,500次服务量直接当作发生率分母。
- 用44例简短登记建立风险预测模型。
- 仅凭记录变完整就声称患者安全或临床结局改善。
- 将100条已用于开发的合成文本作为独立最终测试集。
- 在没有专家裁决时报告LLM临床准确率。

## Fastest uncertainty-reducing step

- 随机抽取20例能够关联到完整护理记录的真实事件，检查是否可获得具体造影剂、发生时间、生命体征、处置、转归和患者告知；同时确认检查级分母能否从信息系统稳定导出。
