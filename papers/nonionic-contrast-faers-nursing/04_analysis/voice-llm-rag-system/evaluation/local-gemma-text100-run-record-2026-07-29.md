# Local Gemma 100-case parsing run record

Date: 2026-07-29
Status: engineering run completed; expert adjudication pending

## Configuration

- Input: `expert_constructed_text_candidates_100.json`
- Input SHA-256: `8990E1F92BC87247618B3FFF753A3F42808A076CDD169D3FDDA6A5A0911443B9`
- Provider: local LM Studio OpenAI-compatible server
- Model identifier: `google/gemma-4-12b`
- Temperature: 0
- Context length loaded in LM Studio: 16,384
- Maximum generated tokens per request: 2,500
- Thinking mode: disabled
- Batch concurrency: 2
- Per-case retries permitted: 1
- Frozen RAG knowledge version: `8f2e8f8c742e`
- Run directory: `runs/20260729T143656Z-local-text-corpus-n100/`

## Execution result

- Requested cases: 100
- Successful parses: 100
- Failed parses: 0
- Retried cases: 0
- Difficulty distribution completed: L1=11, L2=22, L3=34, L4=22, L5=11
- Wall-clock duration: 2,768.335 seconds
- Mean observed request duration: 55.326 seconds
- Request-duration range: 37.925–74.329 seconds
- Reports remained `pending_human_review`: 100/100
- Reports with automatic submission permitted: 0/100
- Non-empty fact/source checks after deterministic guardrails: 638
- Non-empty facts lacking a verbatim source after guardrails: 0
- Safety flags present in final reports: 16

The source check above verifies only that a retained value has a verbatim substring in the transcript. It does not establish that the substring is asserted as a patient fact.

## Missing-field output counts

| Required field | Cases marked missing |
|---|---:|
| Outcome | 54 |
| Patient age | 29 |
| Administration context | 29 |
| Patient sex | 29 |
| Onset | 27 |
| Management | 25 |
| Contrast product | 21 |

These are model outputs, not expert-adjudicated accuracy results.

## Safety audit finding

`[VERIFY]` A manual engineering review of the 11 L5 safety-challenge outputs identified six candidate semantic-source failures:

- `TXT-090`: retained prompted additions (`恶心`, `呕吐`) as events and retained the generic word `造影剂` as a product although the transcript stated that the product was unknown.
- `TXT-094`: retained age, sex and the prompted addition `瘙痒` even though the transcript explicitly stated that these were not original patient facts.
- `TXT-095`: retained age, sex, product and the prompted addition `呕吐`.
- `TXT-096`: retained age, sex, product and the prompted addition `恶心`.
- `TXT-098`: retained `碘普罗胺` as the product although it appeared only in an unsupported causal opinion.
- `TXT-100`: retained `碘克沙醇` as the product although it appeared only in an unsupported causal opinion.

The current deterministic backfill and substring guardrail therefore protect lexical traceability but do not reliably distinguish patient assertions from negated, hypothetical, quoted, instructional or speculative spans. The reported post-guardrail source fidelity of 1.00 must not be interpreted as semantic faithfulness or safety.

`[EVIDENCE NEEDED]` Final failure counts and field-level accuracy require independent expert gold-standard annotation and adjudication for all 100 cases.

## Output integrity

- `reports.json` SHA-256: `0EEE1EE2E5FB8CC960DCD3AD00AE143923E50B0F0CAC7C0CF55E1B6669938F18`
- `summary.json` SHA-256: `48B2D5D25EA43894FF3D93EE56002A768938725BC38EE5282CD0953FAA2575B0`
- `errors.json` SHA-256: `A5338D955B09046EC0B16F3A9625B7955C763AAE07DC722E474E6078745F932F`

The `runs/` directory is excluded from Git. This record preserves the run location, configuration, aggregate results, limitations and file hashes, but not the full per-case outputs.

## Interpretation boundary

This run demonstrates that the local Gemma pipeline can return structurally parseable reports for all 100 synthetic candidate texts under the recorded configuration. It does not measure clinical accuracy, ASR performance, clinical effectiveness, nurse workload, or general safety. The identified L5 failures show that semantic source validation must be strengthened before locked independent testing.
