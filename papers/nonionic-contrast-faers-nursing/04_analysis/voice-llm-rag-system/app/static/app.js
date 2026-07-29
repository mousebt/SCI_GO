let recognition = null;
let recorder = null;
let chunks = [];
let audioBlob = null;
let timerHandle = null;
let seconds = 0;
let currentReport = null;

const $ = (id) => document.getElementById(id);
const setMessage = (text, error = false) => {
  $("message").textContent = text;
  $("message").style.color = error ? "#9b382f" : "#126b57";
};

function startTimer() {
  seconds = 0;
  $("timer").textContent = "00:00";
  timerHandle = setInterval(() => {
    seconds += 1;
    $("timer").textContent = `${String(Math.floor(seconds / 60)).padStart(2, "0")}:${String(seconds % 60).padStart(2, "0")}`;
  }, 1000);
}

$("record").onclick = async () => {
  try {
    const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
    chunks = [];
    recorder = new MediaRecorder(stream);
    recorder.ondataavailable = (event) => chunks.push(event.data);
    recorder.onstop = () => {
      audioBlob = new Blob(chunks, { type: recorder.mimeType });
      $("download").disabled = false;
      stream.getTracks().forEach((track) => track.stop());
    };
    recorder.start();

    const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
    if (SpeechRecognition) {
      recognition = new SpeechRecognition();
      recognition.lang = "zh-CN";
      recognition.continuous = true;
      recognition.interimResults = true;
      let finalText = $("transcript").value.trim();
      recognition.onresult = (event) => {
        let interim = "";
        for (let i = event.resultIndex; i < event.results.length; i += 1) {
          if (event.results[i].isFinal) finalText += `${event.results[i][0].transcript} `;
          else interim += event.results[i][0].transcript;
        }
        $("transcript").value = `${finalText}${interim}`.trim();
      };
      recognition.onerror = () => setMessage("浏览器转写不可用，但录音仍在进行；停止后可人工粘贴转写。", true);
      recognition.start();
    } else {
      setMessage("当前浏览器不支持实时语音转写；录音会保留，请人工粘贴转写。", true);
    }
    $("record").disabled = true;
    $("stop").disabled = false;
    startTimer();
  } catch (error) {
    setMessage(`无法使用麦克风：${error.message}`, true);
  }
};

$("stop").onclick = () => {
  if (recognition) recognition.stop();
  if (recorder && recorder.state !== "inactive") recorder.stop();
  clearInterval(timerHandle);
  $("record").disabled = false;
  $("stop").disabled = true;
};

$("download").onclick = () => {
  if (!audioBlob) return;
  const link = document.createElement("a");
  link.href = URL.createObjectURL(audioBlob);
  link.download = `contrast-ae-audio-${Date.now()}.webm`;
  link.click();
  URL.revokeObjectURL(link.href);
};

function field(label, item) {
  const value = item?.value ?? "未提供";
  const source = item?.source_text ? `来源：“${item.source_text}”` : "无口述来源";
  return `<div class="field"><small>${label} · ${item?.status ?? "missing"}</small><strong>${value}</strong><div class="source">${source}</div></div>`;
}

function render(report) {
  currentReport = report;
  $("resultCard").classList.remove("hidden");
  $("reviewCard").classList.remove("hidden");
  $("modelBadge").textContent = `${report.run_metadata?.provider ?? "unknown"} / ${report.run_metadata?.model ?? "unknown"}`;
  $("missing").innerHTML = report.missing_required_fields.length
    ? `<p class="missing">仍缺少：${report.missing_required_fields.join("、")}</p>` : "<p>核心字段均已有来源。</p>";
  const items = [
    ["年龄", report.patient.age], ["性别", report.patient.sex], ["相关史", report.patient.history],
    ["造影剂", report.contrast.product], ["剂量", report.contrast.dose], ["途径", report.contrast.route],
    ["给药部位", report.contrast.site], ["检查", report.contrast.examination],
    ["给药时间", report.contrast.administration_time], ["事件时间", report.onset],
  ];
  $("fields").innerHTML = items.map(([label, item]) => field(label, item)).join("")
    + report.events.map((item, index) => `<div class="field"><small>事件 ${index + 1} · ${item.status}</small><strong>${item.original_wording ?? "未提供"}</strong><div class="source">候选术语：${item.normalized_candidate ?? "无"}；来源：“${item.source_text ?? "无"}”</div></div>`).join("");
  $("narrative").value = report.chronological_narrative || "";
  $("questions").innerHTML = report.neutral_follow_up_questions.map((q) => `<li>${q}</li>`).join("");
  const retrieved = report.retrieval.map((r) => `<li>${r.id} · ${r.title} · ${r.source} · score=${r.score}</li>`).join("");
  const flags = report.safety_flags.map((f) => `<li class="flag">${f.rule}: ${f.message}</li>`).join("");
  $("evidence").innerHTML = `<h4>检索条目</h4><ul>${retrieved}</ul><h4>安全规则</h4><ul>${flags || "<li>未触发自动修正</li>"}</ul>`;
}

$("generate").onclick = async () => {
  const transcript = $("transcript").value.trim();
  if (!transcript) return setMessage("请先录音或输入转写文本。", true);
  $("generate").disabled = true;
  setMessage("正在检索知识并生成来源约束初稿……");
  try {
    const response = await fetch("/api/generate", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ transcript, use_llm: $("useLlm").checked }),
    });
    const data = await response.json();
    if (!response.ok) throw new Error(data.error || "生成失败");
    render(data.report);
    setMessage("初稿已生成，必须由护士逐项审核。");
  } catch (error) {
    setMessage(error.message, true);
  } finally {
    $("generate").disabled = false;
  }
};

$("confirm").onclick = async () => {
  if (!currentReport) return;
  currentReport.chronological_narrative = $("narrative").value;
  try {
    const response = await fetch("/api/confirm", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ report: currentReport, nurse_name: $("nurseName").value }),
    });
    const data = await response.json();
    if (!response.ok) throw new Error(data.error || "确认失败");
    currentReport = data.report;
    $("reviewMessage").textContent = "已记录护士确认。系统仍不会自动提交报告。";
  } catch (error) {
    $("reviewMessage").textContent = error.message;
  }
};

$("export").onclick = () => {
  if (!currentReport) return;
  const blob = new Blob([JSON.stringify(currentReport, null, 2)], { type: "application/json" });
  const link = document.createElement("a");
  link.href = URL.createObjectURL(blob);
  link.download = `contrast-ae-report-${Date.now()}.json`;
  link.click();
  URL.revokeObjectURL(link.href);
};

