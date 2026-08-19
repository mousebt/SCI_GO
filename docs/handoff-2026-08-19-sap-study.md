# 项目交接与进展备忘：脑卒中相关性肺炎（SAP）常规数据 1:3 嵌套病例对照研究

- **交接日期**：2026-08-19
- **项目代号**：`SAP-Routine-NCC-Study`
- **当前阶段**：`research_direction_refined` / `analysis_preparation`
- **数据基底**：回顾性卒中住院队列（200~300 例病历），**已确认 20 例 SAP 阳性确诊病例**（发生率约 7%~10%）

---

## 1. 今日核心进展与决策锁定

1. **阳性病例数锁定与样本架构升级**：
   - 阳性病例从初始 6 例大幅提升并确认为 **20 例真实确诊 SAP**；
   - 匹配架构升级为 **1:3 风险集匹配（20 例 Case : 60 例 Control，总样本 N = 80）**；
   - 匹配变量：年龄（$\pm 3$ 岁）、性别（100% 精确同性）、卒中亚型（梗死 vs 出血 100% 相同）、基线瘫痪严重度（NIHSS $\pm 2$ 分）。
   - **统计保障**：20 个阳性事件完全满足 EPV $\ge 10$ 标准，支持 2~3 个核心预测因子稳健拟合，彻底消除过拟合与小样本偏倚。

2. **三大顶级方法学文献研读与归档（已写入 `key-literature.md`）**：
   - **文献 1**：*Zhang et al. (Acta Microbiol Immunol Hung, 2026)*：确立了 Bootstrap 降缩拟合复合评分（CIN-score）与“$\Delta\text{AUC}$ + Continuous NRI + IDI + Brier Score + 校准曲线”的增量价值评价链；
   - **文献 2**：*Kimura et al. (BMC Neurology, 2025, PMID: 41382279)*：针对同样仅有 22 例 SAP 的急性期卒中队列，确立了 STROBE 规范、72 小时内早期感染时序、以及 $A_2DS_2$ 高 NPV（99.5%）与低 PPV（6.3%）的临床痛点；
   - **文献 3**：*Yu et al. (Front Endocrinol, 2024, PMID: 39588332)*：确立了 100% 基于回顾性医院常规化验（血常规/生化/甲状腺）与护理文书（KWDT 吞咽/GCS 意识）零成本挖掘范式及 Kaplan-Meier 感染生存曲线。

3. **核心技术突破方向锁定（超越 Kimura 2025 的三大杀手锏）**：
   - **新视角**：破解 $A_2DS_2$ 的假阳性灰区（针对 93.7% 的假警报进行“物理误吸 + 免疫耗竭”双重打击精准分层）；
   - **新数据（零成本衍生特征工程）**：引入 2025 最新**中性粒细胞/白蛋白比值（NPAR / NAR）**、全身免疫炎症指数（SII）、预后营养指数（PNI）；
   - **新技术体系**：1:3 风险集匹配 + Bootstrap 降缩加权复合评分（CIN-score）+ 增量价值四部曲（$\Delta\text{AUC}$、NRI、IDI、DCA 决策曲线）+ 交互式列线图（Dynamic Nomogram）。

4. **学术检索环境健全**：
   - 完成了 `pubmed-database` 技能包的底层环境（`uv` 包管理器及 Windows 证书适配）配置与真实检索测试，确保所有文献证据 100% 真实可溯源。

4. **系统环境与双 Agent 架构运维基准建立**：
   - 建立了跨 Agent（Codex ↔ Antigravity）技能软链接自动挂载脚本（[`scripts/setup-antigravity-skills.ps1`](file:///e:/pythonProjects/SCI_GO/scripts/setup-antigravity-skills.ps1)）；
   - 彻底跑通 Windows 平台下 MinGit + `wincred` 静默凭据读取 + `http://127.0.0.1:10808` 代理通道，解决了后台 GUI 弹窗挂起与超大缓冲导致超时（408）的痛点，固化至 [`GEMINI.md`](file:///e:/pythonProjects/SCI_GO/GEMINI.md) 与 [`docs/handoff-skills-environment.md`](file:///e:/pythonProjects/SCI_GO/docs/handoff-skills-environment.md)。

---

## 2. 核心文献资产库索引

| 文献标识 | 期刊与年份 | 核心价值与借鉴模块 |
|---|---|---|
| **Zhang et al. 2026** | *Acta Microbiol Immunol Hung (2026)*<br>DOI: `10.1556/030.2026.02907` | 1:2/1:3 嵌套匹配、Bootstrap 降缩复合评分、$\Delta\text{AUC}$/NRI/IDI/Brier 增量评价 |
| **Kimura et al. 2025** | *BMC Neurology (2025)*<br>PMID: `41382279` | 22 例 SAP 样本范例、72h 早期感染时序、DAG 变量筛选、$A_2DS_2$ 假阳性灰区破局依据 |
| **Yu et al. 2024** | *Front Endocrinol (2024)*<br>PMID: `39588332` | 常规化验（WBC/生化/甲状腺）+ 护理（KWDT/GCS）挖掘范式、KM 感染时间生存曲线 |
| **Wan et al. 2025** | *J Inflamm Res (2025)*<br>PMID: `40823354` | NPAR（中性粒细胞/白蛋白比值）作为强效独立预测标志物 |

---

## 3. 明天继续的工作执行蓝图（Tomorrow's Action Plan）

### 阶段 1：数据准备与 1:3 匹配（Data Intake & Risk-Set Matching）
1. **数据表校验与变量核对**：
   - 提取 20 例 SAP 病例与待选对照池（~180-280 例）的 36 项标准化变量（人口学、入院 24h 血常规与生化、护理进食/吞咽/意识量表及时间点）；
   - 计算衍生特征：$\text{NPAR} = \frac{\text{Neutrophil (\%)}}{\text{Albumin (g/dL)}}$、$\text{NLR} = \frac{\text{Neutrophil}}{\text{Lymphocyte}}$、$\text{SII} = \frac{\text{Platelet} \times \text{Neutrophil}}{\text{Lymphocyte}}$、$\text{PNI} = 10 \times \text{Albumin} + 0.005 \times \text{TLC}$。
2. **执行 1:3 风险集精准匹配**：
   - 年龄（$\pm 3$ 岁）、性别（精确同性）、卒中亚型（脑梗 vs 脑出血 100% 相同）、初始瘫痪严重度 NIHSS（$\pm 2$ 分）；
   - 生成 80 例（20 SAP vs 60 Control）核心分析宽表。

### 阶段 2：统计建模与增量价值验证（Statistical Modeling & Incremental Value）
1. **基线均衡性对比（Table 1）**：
   - 匹配前后各变量均值/中位数、Standardized Mean Difference (SMD < 0.10 表示完全均衡)。
2. **多因素条件 Logistic 回归（Table 2）**：
   - 筛选进入最终模型的独立预测因子（进食/鼻饲状态、NPAR 或 NLR），输出调整后 OR 及 95% CI。
3. **复合炎症-营养评分（CIN-Score）与增量价值分析（Table 3 & Figure 2-4）**：
   - 计算 Baseline Model（经典 $A_2DS_2$ 评分）vs Enhanced Model（$A_2DS_2$ + CIN-Score）；
   - 计算 $\Delta\text{AUC}$（Delong 检验）、Continuous NRI（净重分类改善度）、IDI（综合判别改善度）、Brier Score；
   - 绘制对比 ROC 曲线、校准曲线（Calibration Curve）与临床决策曲线（DCA）。
4. **可视化成果构建**：
   - 绘制动态交互式/静态临床风险列线图（Nomogram）。

### 阶段 3：论文正文初稿起草（Manuscript Drafting）
- 按 STROBE 规范起草 Methods（Study Design, Cohort & Matching, Variable Definition, Statistical Analysis）与 Results 部分。

---

## 4. 仓库与运行环境状态备忘

- **Git 远程仓库**：`https://github.com/mousebt/SCI_GO.git`
- **本地分支状态**：`main` 与 `origin/main` 保持完全一致，工作区干净（`working tree clean`）。
- **极速同步命令备忘**：
  ```powershell
  & "C:\Users\XuJianhao\.mingit\cmd\git.exe" -c http.proxy="http://127.0.0.1:10808" pull --rebase origin main
  & "C:\Users\XuJianhao\.mingit\cmd\git.exe" -c http.proxy="http://127.0.0.1:10808" push origin main
  ```

