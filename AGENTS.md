# SCI_GO 工作约定

任何人或 AI 在处理论文任务前，按以下顺序读取：

1. `config/writing-logic.md`
2. `config/start-modes.md`
3. `config/project-policy.md`
4. `knowledge/validated/techniques.csv`
5. 当前论文的 `paper.yaml`、`01_planning/research-brief.md`、术语表和主张—证据表

默认使用已安装的 nature skills，并按任务选择最小必要 skill。不得虚构数据、引用、方法、统计量、机制或创新性。
所有回答与科研建议必须基于真实已发表的权威学术论文（优先近2-3年核心期刊、指南与Meta分析），并明确标注文献来源（期刊、年份、作者或PMID/DOI），严禁无文献支持的主观臆测。
跨 Agent 运行环境（Codex / Antigravity）与技能同步参考 `docs/handoff-skills-environment.md`，同步脚本见 `scripts/setup-antigravity-skills.ps1`。

正文修改规则：

- 先确认一句话论证，再写章节。
- 结果和证据优先；引言不得先于核心结果定型。
- 术语表是唯一命名来源。
- 修改只触及用户指出的段落或主张；结构性重排必须先说明。
- AI 生成的待确认内容必须标记 `[VERIFY]`，缺失证据标记 `[EVIDENCE NEEDED]`。
- 一次性脚本和中间文件进入当前论文的 `tmp/`；不得散落在仓库根目录。
- 每次实质修改后更新 `06_review/change-log.md`。

共享知识规则：只有 `approved=yes` 且状态为 `validated` 的经验可以通过 `scripts/sync-knowledge.ps1` 进入全局知识库。不得让模型直接改写底层规则后悄悄生效。

## 需要用户批准的方案日志

凡助手提出需要用户批准后才能继续的实质性计划，必须遵守 `logs/README.md`：

1. 发出批准问题前，先运行 `scripts/new-approval-log.ps1` 创建 `pending` 日志。
2. 保存相关用户原话、当时事实、假设、不确定性、选项、权衡、拟执行计划、影响范围和准备发出的原样问题。
3. 向用户请求批准时明确给出日志 ID。
4. 收到回复后运行 `scripts/resolve-approval-log.ps1`，追加用户原始回复与处理结果；不得覆盖原始方案。
5. 方案发生实质变化时保留旧记录并新建日志，不得在旧记录上静默改写。
6. 论文级方案使用 `scope=paper` 和正确的 `paper_id`；全局规则与架构方案使用 `scope=global`。

## START_HERE 材料接收协议

发现 `START_HERE/` 中有用户材料时：

1. 先只读盘点文件名、类型、大小和 SHA-256，识别可能属于几篇论文；盘点完成前不得改名或删除原件。
2. 若明显混有多篇论文，先按研究主题提出分组并让用户确认论文边界。
3. 读取 `START_HERE/PROJECT_INFO.md` 的启动模式。若为 `auto`，按 `config/start-modes.md` 判断并把最终模式写入 `paper.yaml`；判断不可靠时再询问用户。
4. 创建论文工作区，把材料复制到对应目录，并填写 `00_admin/intake-manifest.csv`。
5. 校验复制件哈希与原件一致后，把迁移状态标记为 `verified`，随后删除 `START_HERE/` 中对应原件。
6. 按最终启动模式执行结构审计或从零论证构建，先向用户提交启动确认块；确认后才写完整正文。
7. 用户已明确选择不保留原件。完成分类、哈希校验和清单记录后，应自动清理 `START_HERE/`；校验失败的文件不得删除。

## 研究方向探讨协议

当用户说“方向探讨”“启动研究方向探讨”“这个方向能不能做”“帮我找一个可发表方向”等请求时，进入全局研究方向探讨流程，而不是直接创建论文或撰写正文。

处理顺序：

1. 使用并读取 `skills/research-direction/SKILL.md`。
2. 读取 `config/research-direction-policy.md`。
3. 若是新方向，使用 `scripts/new-research-direction.ps1` 在 `research_directions/active/<direction_id>/` 创建方向工作区。
4. 先形成一句话方向、候选研究问题、数据需求、方法可行性、伦理风险、期刊匹配和最快下一步。
5. 方向探讨阶段不得虚构数据、样本量、统计结果、引用、创新性或投稿概率。
6. 不得在方向探讨阶段直接写完整论文正文；只有用户确认“转入论文项目”后，才按 `START_HERE` 或 `scripts/new-paper.ps1` 创建 `papers/<slug>/`。
7. 方向成熟后，在 `04_decisions/direction-decision.md` 记录 proceed / revise / park / reject 决策。
8. 可复用经验仍需满足 `approved=yes` 且 `status=validated`，才能进入全局知识库。
