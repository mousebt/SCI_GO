# SCI_GO 双 Agent 技能环境交接与切换指南 (Codex ↔ Antigravity)

**更新日期**：2026-08-18  
**维护状态**：已验证 / Validated  
**适用 Agent**：OpenAI Codex、Google Antigravity、Claude Code 等  

---

## 1. 概述与核心原则

本项目（SCI_GO）已完成对 **Google Antigravity** 与 **OpenAI Codex** 的双平台兼容。

### 核心设计原则：
1. **单一数据源（Single Source of Truth）**：所有 Skill 的源文件均保留在原生的 `skills/`（项目级）和 `~/.codex/skills/`（全局级）中，严禁在不同平台间拷贝造成多份脱节副本。
2. **零文件改动**：Codex 端的全部配置、目录结构及技能实现均保持原貌不变，Codex 可直接按原有方式工作。
3. **无损无冗余联接**：Antigravity 依赖根目录 `.agents/` 结构，通过 Windows **NTFS Directory Junction（目录联接）** 挂载技能，修改任何一方即时双向生效，且不消耗额外存储。

---

## 2. 技能与服务映射拓扑

```text
[Codex 原生环境]                                       [Antigravity 运行环境]
E:\pythonProjects\SCI_GO\skills\                 ──(Junction)──>  E:\pythonProjects\SCI_GO\.agents\skills\
  ├── journal-library/                                              ├── journal-library/
  └── research-direction/                                          ├── research-direction/

C:\Users\<User>\.codex\skills\                   ──(Junction)──>
  ├── nature-writing/                                               ├── nature-writing/
  ├── nature-polishing/                                             ├── nature-polishing/
  ├── nature-academic-search/                                       ├── nature-academic-search/
  └── ... (19 个 Nature 技能)                                       └── ... (全部 19 个 Nature 技能)

.codex\config.toml (MCP: academic_search)         ──(JSON转换)──>  .agents\mcp_config.json (MCP 服务)
```

---

## 3. 已映射的全部 Skills 清单

### 3.1 项目内置 Skills（2个）
* `journal-library`：SCI 投稿目标期刊库维护、官方指南与 APC/IF 数据抽取。
* `research-direction`：论文前选题孵化、可行性评分与已发表文献支撑核验。

### 3.2 Nature 科研系列 Skills（19个）
* `nature-academic-search`：学术文献与 PubMed 深度检索。
* `nature-citation`：规范学术引用管理。
* `nature-data`：实验与临床数据集结构化管理。
* `nature-downloader`：文献与补充材料下载。
* `nature-experiment-log`：科研实验与计算运行记录。
* `nature-figure`：Nature 级科学图表规范与构图指引。
* `nature-literature-pipeline`：文献综述与批处理流水线。
* `nature-paper-card`：论文速读卡片生成。
* `nature-paper-to-patent`：论文成果转化专利方案。
* `nature-paper2ppt`：学术汇报幻灯片生成。
* `nature-polishing`：高水平学术语言润色。
* `nature-proposal-writer`：基金与课题申报书撰写。
* `nature-reader`：文献精读与关键证据提取。
* `nature-ref-verifier`：文献真实性与引用准确性核查。
* `nature-response`：审稿意见逐条回复（Response Letter）构建。
* `nature-reviewer`：模拟顶刊审稿人进行同行评议与审稿排雷。
* `nature-shared`：跨模块共享科研逻辑与组件。
* `nature-statistics`：统计学方法、样本量与检验规范。
* `nature-writing`：Nature 风格正文全流程写作与重构。

---

## 4. 自动化维护与一键刷新脚本

当 Codex 或研究人员**新增了新 Skill**、或移动了技能路径、或克隆项目到新环境时，只需运行以下 PowerShell 脚本即可一键刷新所有联接与 MCP 配置：

```powershell
powershell -ExecutionPolicy Bypass -File scripts/setup-antigravity-skills.ps1
```

### 脚本位置与职责：
* **脚本文件**：[`scripts/setup-antigravity-skills.ps1`](file:///e:/pythonProjects/SCI_GO/scripts/setup-antigravity-skills.ps1)
* **执行动作**：
  1. 检查并建立 `.agents/skills` 目录；
  2. 遍历 `skills/*` 建立项目技能 Junction；
  3. 遍历 `~/.codex/skills/nature-*` 建立全局 Nature 技能 Junction；
  4. 自动生成 `.agents/mcp_config.json` 挂载 PubMed 学术检索 MCP。

---

## 5. Codex 恢复工作 / 开发指引

### 当你在 Codex 中继续开发时：
1. **直接调用**：无需关注 `.agents/` 目录，直接在 Codex 终端/界面中按既定提示词使用 `skills/` 或 `nature-*`。
2. **编辑技能**：若需修改某个 Skill，直接编辑 `skills/<skill-name>/SKILL.md` 或 `~/.codex/skills/<skill-name>/`，修改会立即同步体现在 Antigravity 中。
3. **新增技能**：
   - 项目级技能：建在 `skills/<new-skill>/SKILL.md`；
   - 全局 Nature 技能：建在 `~/.codex/skills/<new-skill>/SKILL.md`；
   - 随后运行一次 `powershell -ExecutionPolicy Bypass -File scripts/setup-antigravity-skills.ps1`，即可让 Antigravity 也立即识别到新技能。

---

## 6. Git 与 GitHub 远程同步运维规范与避坑指南

### 6.1 环境基准与痛点排查
1. **Git 解释器路径**：
   - 宿主机系统全局 `PATH` 中未注册 `git`，真实可执行程序位于：`C:\Users\XuJianhao\.mingit\cmd\git.exe`。
2. **凭据阻塞（GUI 假死坑点）**：
   - MinGit 默认带有的 `credential.helper=manager` 会唤起桌面弹窗。在 AI / 后台无头（Headless）运行环境中无法交互，会导致无限等待假死。
   - **解决方案**：使用 `credential.helper=wincred` 直接从 Windows 凭据管理器静默读取。
3. **代理协议与端口**：
   - 本地 v2rayN 监听代理端口为 `127.0.0.1:10808`。
   - Git 远程操作必须显式带上代理参数：`-c http.proxy="http://127.0.0.1:10808"`。
   - **禁止配置** 超大 `http.postBuffer`（如 500MB），否则会导致分块上传退化为单包长连接，在代理链路上触发 `HTTP 408 Request Timeout`。

### 6.2 标准极速同步指令
```powershell
# 1. 查看状态
& "C:\Users\XuJianhao\.mingit\cmd\git.exe" status

# 2. 提交本地变更
& "C:\Users\XuJianhao\.mingit\cmd\git.exe" add .
& "C:\Users\XuJianhao\.mingit\cmd\git.exe" commit -m "<commit message>"

# 3. 远端拉取变基
& "C:\Users\XuJianhao\.mingit\cmd\git.exe" -c http.proxy="http://127.0.0.1:10808" pull --rebase origin main

# 4. 推送至 GitHub
& "C:\Users\XuJianhao\.mingit\cmd\git.exe" -c http.proxy="http://127.0.0.1:10808" push origin main
```

