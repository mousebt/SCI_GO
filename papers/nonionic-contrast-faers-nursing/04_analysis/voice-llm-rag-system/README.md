# Contrast-AE Voice RAG

论文配套的最小可运行研究系统。系统将护士普通话口述转写为文本，检索经批准的本地知识库，调用真实 LLM 生成来源可追溯的结构化初稿，并要求人工确认。

## 研究边界

- 不自动诊断、判断因果关系、严重程度或法定可报告性。
- 不生成治疗建议。
- 不把 FAERS 信号写成患者事实。
- 未在口述中出现的内容保持为“未提供”。
- 未经护士确认，报告状态始终为 `pending_human_review`，且禁止自动提交。
- 默认示例均为合成病例；不得把带直接身份标识的真实音频发送到未经批准的外部模型。

## 启动

在仓库根目录运行：

```powershell
$py = 'C:\Users\XuJianhao\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe'
& $py papers/nonionic-contrast-faers-nursing/04_analysis/voice-llm-rag-system/app/server.py
```

打开 `http://127.0.0.1:8765`。

程序按顺序寻找以下兼容服务：

1. `GEMINI_API_KEY` + `GEMINI_MODEL`（原生 Gemini `generateContent`）
2. `DEEPSEEK_API_KEY` + `DEEPSEEK_BASE_URL`
3. `ZHIPU_API_KEY` + `ZHIPU_BASE_URL`
4. `OPENROUTER_KEY` + `OPENROUTER_BASE_URL`
5. `LOCAL_LLM_BASE_URL`

可使用 `CONTRAST_RAG_LLM_PROVIDER` 强制指定 `gemini`、`deepseek`、`zhipu`、`openrouter` 或 `local`。模型可分别通过 `GEMINI_MODEL`、`DEEPSEEK_MODEL`、`ZHIPU_MODEL`、`OPENROUTER_MODEL`、`LOCAL_LLM_MODEL` 固定。

## 语音

网页优先使用浏览器的 `SpeechRecognition/webkitSpeechRecognition` 完成中文口述转写，并允许人工校正。音频录制可下载留存。浏览器不支持语音识别时，可粘贴人工或机构批准的 ASR 转写文本；此时系统的 RAG 与 LLM 流程仍可完整运行。

浏览器语音服务的供应商和模型版本通常不可冻结，因此不能单独作为论文最终 ASR 性能结论。正式实验应接入机构批准且版本固定的 ASR，并在运行清单中记录模型。

## 测试与离线评价

```powershell
& $py -m unittest discover -s papers/nonionic-contrast-faers-nursing/04_analysis/voice-llm-rag-system/tests -v
& $py papers/nonionic-contrast-faers-nursing/04_analysis/voice-llm-rag-system/evaluation/run_evaluation.py
```

离线评价默认使用确定性安全基线，不调用外部API。使用 `--live-llm` 才会调用已配置的真实LLM，并只发送合成病例。

结构化事实除逐字来源校验外，还经过语义范围护栏；否定、冲突、未确认候选、模板示例、假设讨论、拟写/补全指令和明确缺失声明不得作为患者事实。命中护栏的内容保持为空或候选状态，并继续要求人工确认。

`evaluation/run_text_corpus.py` 默认单并发。对直接REST调用，只对HTTP 429、HTTP 5xx和瞬时网络错误重试；优先遵循服务器`Retry-After`或Gemini`retryDelay`，否则按1、2、4、8秒指数退避并封顶60秒。JSON、Schema和其他非瞬时错误不自动重试。每次重试写入运行记录的`retry_events`。

## 目录

- `app/`：Web服务、检索、LLM调用、安全校验和界面。
- `knowledge/`：冻结的可追溯知识条目。
- `evaluation/`：合成病例、参考答案、指标与运行输出。
- `tests/`：核心安全规则的自动测试。
- `runs/`：运行日志；不应提交真实患者材料。
