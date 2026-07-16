# SCI_GO：可复用的 SCI 论文工作区

本仓库把“写作规则”“每篇论文的材料”“跨项目知识”和“自动化工具”分开管理。目录名称面向研究人员，而不是只面向 AI。

## 快速开始

1. 把已有材料放进 `START_HERE/`，然后告诉我“材料已放好，请启动论文”。
2. 在 `START_HERE/PROJECT_INFO.md` 选择“已有中文稿改造”“从材料零起草”或保留 `auto`。
3. 我会先生成文件清单、识别是否包含多篇论文，再建立独立论文工作区并校验迁移材料。
4. 你确认一句话论证、关键证据和边界后，我开始按所选模式处理。
5. 正文只在对应论文的 `03_manuscript/` 中维护；重要节点用 Git 提交和标签固定。
6. 预览临时文件清理：`powershell -ExecutionPolicy Bypass -File scripts/cleanup.ps1`；确认后加 `-Apply`。
7. 项目结束时填写 `90_learning/lessons.csv`，再运行 `powershell -ExecutionPolicy Bypass -File scripts/sync-knowledge.ps1 -Apply`。

如果没有现成材料，也可以直接运行 `scripts/new-paper.ps1` 创建空白论文工作区。

## 顶层目录

| 目录 | 用途 | 是否长期保存 |
|---|---|---|
| `config/` | 所有论文共享的底层写作逻辑与治理规则 | 是 |
| `templates/` | 新论文的统一模板 | 是 |
| `papers/` | 各论文独立工作区，一篇论文一个目录 | 是 |
| `research_directions/` | 论文前的研究方向探讨与可行性孵化区 | 是 |
| `knowledge/` | 经验证的跨项目经验与人工技巧 | 是 |
| `scripts/` | 稳定的管理工具，不放一次性分析代码 | 是 |
| `docs/` | 架构、工作流和版本管理说明 | 是 |
| `START_HERE/` | 新论文原始材料投递区；校验迁移成功后自动清空 | 临时 |
| `logs/` | 需要用户批准的计划、当时对话与最终决定 | 是 |

## 三条硬规则

- 不把不同论文的材料混放；引用、图、正文、审稿记录都留在各自论文目录。
- 不在正文目录运行一次性脚本；临时产物只能进入该论文的 `tmp/`，并接受定期清理。
- 不把未经验证的经验写入共享规则；必须有来源、适用范围、证据和批准人。

详细说明见 [架构](docs/architecture.md)、[写作流程](docs/workflow.md) 与 [版本控制](docs/version-control.md)。

## 研究方向探讨

当一个想法还没有成熟到可以直接创建论文时，使用研究方向探讨流程：

```text
方向探讨：你的研究想法
```

系统会在 `research_directions/active/` 中建立方向工作区，先评估问题边界、数据可得性、方法可行性、伦理风险、文献拥挤度、期刊匹配和最快下一步。只有用户确认“转入论文项目”后，才创建 `papers/<slug>/`。

详细流程见 [research direction workflow](docs/research-direction-workflow.md)。
