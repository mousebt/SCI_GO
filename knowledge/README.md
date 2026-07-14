# 共享知识库

`validated/techniques.csv` 是写作任务可直接读取的稳定知识；`inbox/manual-techniques.csv` 用于人工录入候选技巧。每篇论文也可在自己的 `90_learning/lessons.csv` 中产生候选经验。

同步规则：

- `status=validated`
- `reusable=yes`
- `approved=yes`
- 必须填写适用范围和验证证据
- `id` 全局唯一；重复 ID 不会覆盖已有条目

运行 `scripts/sync-knowledge.ps1` 可预览；加 `-Apply` 才写入稳定知识库。底层写作逻辑不会被自动改写；需要全局规则升级时走人工评审并更新变更日志。
