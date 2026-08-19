# Antigravity & Agent 核心规则 (Project Guidelines)

## 1. 文献循证基准（硬性规定）

**所有回答、科研分析、机制解释与方案建议，必须 100% 基于真实已发表的同行评议学术论文与权威临床指南。**

- **时效性优先**：优先采用近 2~3 年（2024–2026）的顶刊（如 *The Lancet*、*Stroke*、*AACN*、*JCN* 等）、系统评价/Meta 分析及最新学会指南。
- **必须标注文献依据**：任何核心论点、临床干预措施（如 COMMIT 方案）、风险预测因子或统计设计，必须给出明确文献出处（期刊名、年份、第一作者或 PMID/DOI）。
- **零虚构原则**：严禁无文献支撑凭空发散，严禁虚构文献、数据、机制或统计量。

---

## 2. 论文与方向工作流规则

- 严格遵守 `config/writing-logic.md`、`config/start-modes.md` 和 `config/project-policy.md`。
- 课题探讨阶段保持孵化状态，未经用户批准不得擅自创建正文项目。
- 技能与环境维护参考 `docs/handoff-skills-environment.md`。

---

## 3. Git 与 GitHub 远程同步规范（Windows / Agent 环境硬性规定）

在当前 Windows 环境下执行 Git 同步（Pull / Push）时，**必须严格遵守以下规范，严禁尝试无头 GUI 弹窗或错误代理协议**：

1. **Git 可执行文件路径**：
   - 系统全局 `PATH` 未注册 `git`，统一调用便携版：`C:\Users\XuJianhao\.mingit\cmd\git.exe`。
2. **凭据读取（禁止 GUI 弹窗）**：
   - 严禁使用 `credential.helper=manager`（会在后台无头环境下因等待桌面弹窗而假死超时）。
   - 统一配置使用 Windows 本地凭据：`credential.helper=wincred`。
3. **代理配置标准**：
   - 本地 v2rayN 监听端口为 `10808`。
   - 所有 Git 远程命令必须统一携带：`-c http.proxy="http://127.0.0.1:10808"`。
   - 严禁设置超大 `http.postBuffer`（会导致大附件 POST 握手超时 408）。
4. **标准同步命令模板**：
   ```powershell
   # 拉取并变基同步
   & "C:\Users\XuJianhao\.mingit\cmd\git.exe" -c http.proxy="http://127.0.0.1:10808" pull --rebase origin main
   # 推送变更
   & "C:\Users\XuJianhao\.mingit\cmd\git.exe" -c http.proxy="http://127.0.0.1:10808" push origin main
   ```

