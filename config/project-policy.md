# 项目治理规则

## 生命周期

`idea → planning → drafting → internal-review → submission → revision → accepted/closed`

当前状态写入每篇论文的 `paper.yaml`。关闭论文不等于删除；临时目录可清理，证据、正文、审稿记录和最终投稿包应保留。

## 隔离

- 一篇论文一个 `papers/<slug>/`。
- 跨论文可复用的只有 `config/`、`templates/` 和 `knowledge/validated/`。
- 原始数据建议保存在专业数据仓库或受控存储中；仓库只记录路径、版本、校验值和访问条件。

## 临时文件

- 一次性脚本、OCR 中间件、转换缓存和试验性导出放入论文 `tmp/`。
- `scripts/cleanup.ps1` 默认只预览，`-Apply` 才删除。
- 默认删除超过 14 天的临时文件；规则见 `config/cleanup-policy.json`。
- 建议用 `powershell -ExecutionPolicy Bypass -File scripts/install-cleanup-task.ps1` 注册每周清理任务。

## 版本控制

- 正文、配置、表格和日志使用 Git。
- 原始大数据不进 Git；大型必要二进制文件使用 Git LFS 或外部存储。
- 每个提交只处理一个清晰问题，提交信息使用 `paper/<slug>: 动作`。
- 投稿里程碑使用标签，例如 `paper-my-study-v1.0-submitted`。
- 不用复制出 `final_final_v3.docx` 的方式代替版本控制。

## 决策审计

任何会改变论文结论、边界、统计解释、主要图或投稿策略的修改，都写入 `06_review/change-log.md`，记录理由、证据和批准人。
