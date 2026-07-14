# SCI_GO 工作约定

任何人或 AI 在处理论文任务前，按以下顺序读取：

1. `config/writing-logic.md`
2. `config/project-policy.md`
3. `knowledge/validated/techniques.csv`
4. 当前论文的 `paper.yaml`、`01_planning/research-brief.md`、术语表和主张—证据表

默认使用已安装的 nature skills，并按任务选择最小必要 skill。不得虚构数据、引用、方法、统计量、机制或创新性。

正文修改规则：

- 先确认一句话论证，再写章节。
- 结果和证据优先；引言不得先于核心结果定型。
- 术语表是唯一命名来源。
- 修改只触及用户指出的段落或主张；结构性重排必须先说明。
- AI 生成的待确认内容必须标记 `[VERIFY]`，缺失证据标记 `[EVIDENCE NEEDED]`。
- 一次性脚本和中间文件进入当前论文的 `tmp/`；不得散落在仓库根目录。
- 每次实质修改后更新 `06_review/change-log.md`。

共享知识规则：只有 `approved=yes` 且状态为 `validated` 的经验可以通过 `scripts/sync-knowledge.ps1` 进入全局知识库。不得让模型直接改写底层规则后悄悄生效。
