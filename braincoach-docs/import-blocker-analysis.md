# Import Blocker Analysis — Qualification Engine vs Production Export

Last Updated: 2026-05-30

**Authoritative reference:** `workflows/reference-node-exports/my-test-workflow.json`  
(exported workflow name: `My test workflow`)

**Target workflow:** `workflows/qualification-engine.json`  
(internal name: `qualification-engine-v3`)

**Scope:** OpenAI, Google Sheets, IF, and Telegram nodes only.  
**Out of scope:** Postgres, Function nodes (not present in production export).

**Rules applied:** Documentation only. No workflow file modifications. No new workflow versions.

---

## Reference Mapping

| Production node (My test workflow) | Qualification nodes to align |
|-----------------------------------|------------------------------|
| Telegram Trigger | Telegram Trigger |
| IF - Not Empty? | IF - Client Exists?, IF - All Valid? |
| OpenAI - Chat | OpenAI - Intake Classifier, Emotional Reflection, Qualification Engine |
| Google Sheets - Add Row | GoogleSheets - keywords_master, qualification_flow, memory_signals |
| Telegram - Send Response | Telegram - Send Error, Telegram - Send Question |

**Production instance metadata (from export):**

- `settings.executionOrder`: `"v1"`
- Google Sheets `typeVersion`: **4** (not 4.6 as older docs stated)
- IF `typeVersion`: **1** (same as qualification — shape differs, not version)
- OpenAI `typeVersion`: **1.8** (matches qualification)

---

## Executive Summary

| # | Finding |
|---|---------|
| **Single most likely import blocker** | **OpenAI `messages` stored as a direct array** instead of `{ "values": [...] }` on all 3 LangChain nodes |
| **Second blocker** | **Google Sheets** — `typeVersion` 1 + legacy `sheetId`/`range` vs production `typeVersion` 4 + `documentId`/`sheetName` Resource Locators |
| **Third blocker** | **Telegram Trigger `updates`** — empty object `{}` vs production array `["message"]` |
| **Total mismatches (in-scope)** | **28** field-level issues across 11 qualification nodes |
| **Minimum node types to fix for import** | OpenAI (3), Google Sheets (3), Telegram Trigger (1) — **7 nodes** |

---

## 1. Field-by-Field Comparison

### 1.1 OpenAI — `@n8n/n8n-nodes-langchain.openAi` v1.8

**Production reference:** `OpenAI - Chat`  
**Qualification nodes:** OpenAI - Intake Classifier, OpenAI - Emotional Reflection, OpenAI - Qualification Engine (identical schema issues ×3)

| Field | Production (`my-test-workflow.json`) | Qualification (`qualification-engine.json`) | Match? |
|-------|--------------------------------------|---------------------------------------------|--------|
| `type` | `@n8n/n8n-nodes-langchain.openAi` | Same | Yes |
| `typeVersion` | `1.8` | `1.8` | Yes |
| `parameters.modelId` | Object with `__rl`, `value`, `mode`, `cachedResultName` | Plain string (`"gpt-5.4-nano"` / `"gpt-5.4-mini"`) | **No** |
| `parameters.messages` | Object: `{ "values": [ {...}, {...} ] }` | Direct array: `[ {...}, {...} ]` | **No** |
| `parameters.messages.values[].content` | Present | Present (inside array items) | Partial |
| `parameters.messages.values[].role` | Present on system message; user message may omit `role` | Both messages have `role` | Partial |
| `parameters.options` | `{}` | Absent | **No** |
| `parameters.temperature` | Absent | `0.2` | Extra in qual |
| `parameters.maxTokens` | Absent | `800` / `1000` | Extra in qual |
| `credentials.openAIApi` | Real credential id + name | Placeholder `=credentials.openai` | Expected at import |

**Production `modelId` shape:**

```json
"modelId": {
  "__rl": true,
  "value": "gpt-5.4-mini",
  "mode": "list",
  "cachedResultName": "GPT-5.4-MINI"
}
```

**Qualification `modelId` shape:**

```json
"modelId": "gpt-5.4-nano"
```

**Production `messages` shape:**

```json
"messages": {
  "values": [
    { "content": "...", "role": "system" },
    { "content": "={{ ... }}" }
  ]
}
```

**Qualification `messages` shape:**

```json
"messages": [
  { "role": "system", "content": "..." },
  { "role": "user", "content": "..." }
]
```

**Runtime note (not import):** Production Telegram reply uses `$node["OpenAI - Chat"].json["message"]["content"]`. Qualification validators use `.json.choices[0].message.content` — response path may differ after import; fix separately.

---

### 1.2 Google Sheets — `n8n-nodes-base.googleSheets`

**Production reference:** `Google Sheets - Add Row` (`operation: append`)  
**Qualification nodes:** GoogleSheets - keywords_master, qualification_flow, memory_signals (identical schema issues ×3)

| Field | Production | Qualification | Match? |
|-------|------------|---------------|--------|
| `typeVersion` | `4` | `1` | **No** |
| `parameters.operation` | `"append"` | Absent | **No** |
| `parameters.documentId` | RL object (`__rl`, `value`, `mode`, `cachedResultName`, `cachedResultUrl`) | Absent | **No** |
| `parameters.sheetName` | RL object (numeric `value` = sheet gid) | Absent | **No** |
| `parameters.sheetId` | Absent | Plain spreadsheet id string | **No** (legacy) |
| `parameters.range` | Absent | Tab name string (`keywords_master`, etc.) | **No** (legacy) |
| `parameters.columns` | Full mapping object (`mappingMode`, `schema`, etc.) | Absent | **No** (operation-dependent) |
| `parameters.options` | `{}` | `{}` | Yes (shape) |

**Production spreadsheet reference:**

- `documentId.value`: `1H4EJw-Boe-xsM0J2rfOmaSHbzOSSzU_Hci62c44ByU8`
- `sheetName.cachedResultName`: `logs`

**Qualification spreadsheet reference:**

- `sheetId`: `1r7n5E1eU5IKK6RPkK4HHsLxorFpgs66GZQwYhI0fL_I`
- `range`: `keywords_master` / `qualification_flow` / `memory_signals`

**Important:** Production export only demonstrates **append**. Qualification needs **read** semantics. For import, the minimum fix is v4 parameter *shape* (`documentId`, `sheetName`, `operation`); the correct read operation must be selected in the n8n UI and re-exported if import still fails on operation-specific fields.

---

### 1.3 IF — `n8n-nodes-base.if` v1

**Production reference:** `IF - Not Empty?`  
**Qualification nodes:** IF - Client Exists?, IF - All Valid?

| Field | Production | Qualification (Client Exists?) | Qualification (All Valid?) | Match? |
|-------|------------|----------------------------------|----------------------------|--------|
| `typeVersion` | `1` | `1` | `1` | Yes |
| `conditions` key | `string` | `boolean` | `boolean` | **No** |
| Condition `value1` | Expression on `$json["message"]["text"]` | Expression on Postgres result | Compound `valid && valid && valid` | Different |
| Condition `operation` | `"isNotEmpty"` | `"equal"` | `"equal"` | **No** |
| Condition `value2` | Absent (valid for isNotEmpty) | Absent | Absent | **Malformed for equal** |

**Production conditions shape:**

```json
"conditions": {
  "string": [
    {
      "value1": "={{$json[\"message\"][\"text\"]}}",
      "operation": "isNotEmpty"
    }
  ]
}
```

**Qualification conditions shape:**

```json
"conditions": {
  "boolean": [
    {
      "value1": "={{$node[\"Postgres - Find Client\"].json[0] !== undefined}}",
      "operation": "equal"
    }
  ]
}
```

**Analysis:** Production and qualification share **typeVersion 1**, so the older doc requirement for IF **2.2** does not match this instance. The mismatch is **condition collection type** (`string` vs `boolean`) and **invalid `equal` without `value2`**, not typeVersion alone.

---

### 1.4 Telegram Trigger — `n8n-nodes-base.telegramTrigger` v1

**Production reference:** `Telegram Trigger`  
**Qualification node:** Telegram Trigger

| Field | Production | Qualification | Match? |
|-------|------------|---------------|--------|
| `typeVersion` | `1` | `1` | Yes |
| `parameters.updates` | Array: `["message"]` | Object: `{}` | **No** |
| `parameters.additionalFields` | `{}` | Absent | **No** |
| `parameters.event` | Absent | `"message"` | **No** (extra legacy field) |

**Why `updates: {}` matters:** Production stores `updates` as an **array** (iterable collection). Qualification stores an **empty object**. n8n hydration iterates collection parameters — object where array is expected is a direct cause of `propertyValues[itemName] is not iterable`.

---

### 1.5 Telegram Send — `n8n-nodes-base.telegram` v1

**Production reference:** `Telegram - Send Response`  
**Qualification nodes:** Telegram - Send Error, Telegram - Send Question

| Field | Production | Qualification | Match? |
|-------|------------|---------------|--------|
| `typeVersion` | `1` | `1` | Yes |
| `parameters.chatId` | Expression | Expression | Yes |
| `parameters.text` | Expression | Expression / static (error msg) | Yes |
| `parameters.additionalFields` | `{}` | Absent | **No** |
| `parameters.resource` | Absent | Absent | Yes |
| `parameters.operation` | Absent | Absent | Yes |

**Analysis:** Flat `chatId` + `text` **matches production** — no resource/operation wrapper required on this instance. Missing `additionalFields` is a minor schema gap, unlikely to be the primary import blocker.

---

## 2. Complete Mismatch List

| ID | Node(s) | Field | Qualification value | Production value | Iterable risk |
|----|---------|-------|---------------------|------------------|---------------|
| M01 | OpenAI ×3 | `messages` | Direct array | `{ values: [...] }` | **Critical** |
| M02 | OpenAI ×3 | `modelId` | Plain string | RL object | **Critical** |
| M03 | OpenAI ×3 | `options` | Missing | `{}` | Medium |
| M04 | Google Sheets ×3 | `typeVersion` | `1` | `4` | **Critical** |
| M05 | Google Sheets ×3 | `documentId` | Missing | RL object | **Critical** |
| M06 | Google Sheets ×3 | `sheetName` | Missing | RL object | **Critical** |
| M07 | Google Sheets ×3 | `operation` | Missing | `"append"` (read TBD) | **Critical** |
| M08 | Google Sheets ×3 | `sheetId` | Present (legacy) | Must not exist | **Critical** |
| M09 | Google Sheets ×3 | `range` | Present (legacy) | Must not exist | **Critical** |
| M10 | Google Sheets ×3 | `columns` | Missing | Present (for append) | High (operation-dependent) |
| M11 | Telegram Trigger | `updates` | `{}` object | `["message"]` array | **Critical** |
| M12 | Telegram Trigger | `event` | `"message"` | Absent | High |
| M13 | Telegram Trigger | `additionalFields` | Missing | `{}` | Medium |
| M14 | IF - Client Exists? | `conditions` key | `boolean` | `string` (in prod example) | High |
| M15 | IF - Client Exists? | `operation` | `equal` without `value2` | `isNotEmpty` | High |
| M16 | IF - All Valid? | `conditions` key | `boolean` | `string` (in prod example) | High |
| M17 | IF - All Valid? | `operation` | `equal` without `value2` | `isNotEmpty` | High |
| M18 | Telegram Send ×2 | `additionalFields` | Missing | `{}` | Low |

**Corrections vs earlier analysis:**

- IF typeVersion **2.2 is not required** on this production instance — both use v1.
- Google Sheets typeVersion is **4**, not 4.6.
- Telegram Send does **not** need `resource`/`operation` — production uses flat parameters.

---

## 3. Mismatch Ranking — `propertyValues[itemName] is not iterable`

Ranked by likelihood of causing import/editor failure on this specific n8n instance:

| Rank | Mismatch ID | Affected nodes | Mechanism |
|------|-------------|----------------|-----------|
| **1** | M01 | OpenAI ×3 | `messages` fixedCollection expects `{ values: [] }`; direct array is not iterable as collection |
| **2** | M11 | Telegram Trigger ×1 | `updates` expects array; `{}` is object — classic iterable failure |
| **3** | M04–M09 | Google Sheets ×3 | typeVersion 1 params on typeVersion 4 node definition — wrong property tree entirely |
| **4** | M02 | OpenAI ×3 | `modelId` RL field receives string — parameter hydration failure |
| **5** | M14–M17 | IF ×2 | Wrong/malformed `conditions` collection (`boolean` + incomplete `equal`) |
| **6** | M13, M18 | Telegram ×3 | Missing `additionalFields: {}` |
| **7** | M03 | OpenAI ×3 | Missing `options: {}` |
| **8** | M12 | Telegram Trigger | Extra `event` field (may be ignored or confuse migration) |

**Confidence note:** M01 and M11 are the patterns most directly described in [n8n-io/n8n#14775](https://github.com/n8n-io/n8n/issues/14775) (collection/array vs object for prompt and trigger fields).

---

## 4. Single Most Likely Import Blocker

### **OpenAI `parameters.messages` — direct array on 3 nodes**

**Evidence:**

1. Production export explicitly uses `messages: { "values": [ ... ] }`.
2. Qualification uses `messages: [ ... ]` on all three LangChain nodes.
3. n8n GitHub issue resolution: iterable errors on OpenAI nodes when `messages` structure does not match the fixedCollection schema.
4. Three nodes multiply failure probability — import fails if **any** node fails hydration.

**If only one node could be tested first:** `OpenAI - Intake Classifier`

---

## 5. Minimum Changes Required for Successful Import

Minimum set to align **in-scope node schemas** with production export. Apply to `qualification-engine.json` only after editing in n8n UI or careful JSON patch — this section is guidance, not an applied change.

### 5.1 OpenAI nodes (3) — **required**

For each of: Intake Classifier, Emotional Reflection, Qualification Engine:

| Change | From | To |
|--------|------|-----|
| `modelId` | `"gpt-5.4-nano"` string | RL object (copy structure from production; set `value` per model) |
| `messages` | `[...]` array | `{ "values": [ ... ] }` — move existing message objects inside `values` |
| `options` | absent | `{}` |
| `temperature`, `maxTokens` | present | Optional — re-add via n8n UI after import if needed |

**Template (from production, adapt content):**

```json
"modelId": {
  "__rl": true,
  "value": "gpt-5.4-nano",
  "mode": "list",
  "cachedResultName": "GPT-5.4-NANO"
},
"messages": {
  "values": [
    { "role": "system", "content": "..." },
    { "role": "user", "content": "..." }
  ]
},
"options": {}
```

### 5.2 Google Sheets nodes (3) — **required**

For each of: keywords_master, qualification_flow, memory_signals:

| Change | From | To |
|--------|------|-----|
| `typeVersion` | `1` | `4` |
| Remove | `sheetId`, `range` | — |
| Add | — | `documentId` RL (BrainCoach spreadsheet id) |
| Add | — | `sheetName` RL (per-tab; use n8n picker for gid) |
| Add | — | `operation` suitable for **read** (export a read node from n8n — production only shows `append`) |
| Keep | `options: {}` | `{}` |

**Spreadsheet id mapping:**

- Qualification `sheetId` `1r7n5E1eU5IKK6RPkK4HHsLxorFpgs66GZQwYhI0fL_I` → `documentId.value`
- Tab names `keywords_master`, `qualification_flow`, `memory_signals` → `sheetName` via n8n list picker (numeric gid in `value`, like production `logs`)

**Gap:** Production export does not include a **read/get rows** operation example. Minimum import fix is schema alignment; if import still fails, create a temporary read node in production n8n and re-export.

### 5.3 Telegram Trigger (1) — **required**

| Change | From | To |
|--------|------|-----|
| `updates` | `{}` | `["message"]` |
| `additionalFields` | absent | `{}` |
| `event` | `"message"` | **remove** |

### 5.4 IF nodes (2) — **recommended for import**

Production demonstrates `conditions.string` + `isNotEmpty`. Qualification logic needs different expressions but must use a **valid** condition row:

| Node | Minimum fix |
|------|-------------|
| IF - Client Exists? | Use a valid condition type for a boolean expression, e.g. `boolean` with `operation: "true"` / proper `value2`, OR refactor to `string`/`number` pattern that n8n v1 accepts; **remove invalid `equal` without `value2`** |
| IF - All Valid? | Same — express `all valid` as a condition n8n can parse (e.g. single boolean expression with `operation: "true"`) |

**Pragmatic approach:** Rebuild both IF nodes in the n8n UI after OpenAI/Sheets/Trigger import, using production IF node as a template.

### 5.5 Telegram Send (2) — **optional**

| Change | From | To |
|--------|------|-----|
| `additionalFields` | absent | `{}` |

Low priority — production shape otherwise matches.

---

## 6. Minimum Change Checklist (import order)

Execute in this order to isolate failures:

1. [ ] **Telegram Trigger** — fix `updates` array + remove `event`
2. [ ] **OpenAI ×3** — fix `modelId` + `messages.values` + `options`
3. [ ] **Google Sheets ×3** — upgrade to typeVersion 4 + `documentId`/`sheetName`/`operation`
4. [ ] **IF ×2** — fix condition schema in UI
5. [ ] **Telegram Send ×2** — add `additionalFields: {}`
6. [ ] Import test full workflow
7. [ ] Re-bind credentials (production uses real ids; qualification uses placeholders)

**Nodes requiring zero schema change for import (in scope):** Telegram Send — only optional `additionalFields`.

**Nodes with no production reference in export:** Postgres, Function — out of scope; may cause separate errors after in-scope fixes.

---

## 7. What Not to Change (based on production export)

| Earlier assumption | Production truth |
|--------------------|------------------|
| IF must be typeVersion 2.2 | Production IF is **typeVersion 1** |
| Google Sheets must be typeVersion 4.6 | Production is **typeVersion 4** |
| Telegram Send needs `resource`/`operation` | Production uses **flat `chatId` + `text`** |
| `messages` should be a direct array | Production requires **`{ values: [] }`** |

---

## 8. Files and Authority

| File | Role |
|------|------|
| `workflows/reference-node-exports/my-test-workflow.json` | **Highest priority** production schema source |
| `workflows/qualification-engine.json` | Target workflow to fix |
| `braincoach-docs/n8n-node-schema-source-of-truth.md` | Partially outdated on IF 2.2 and Sheets 4.6 — defer to this analysis when they conflict |
| `braincoach-docs/qualification-node-compatibility-report.md` | Pre-export analysis — superseded for in-scope nodes by this document |

---

## 9. Recommended Next Step

1. In production n8n, fix **one** OpenAI node using the UI (confirm `messages.values` + `modelId` RL).
2. Export that single node or patch `OpenAI - Intake Classifier` in qualification JSON to match.
3. Attempt import — if error clears, apply same pattern to remaining OpenAI nodes, then Telegram Trigger, then Google Sheets.
4. Export a **Google Sheets read** node from production (not append) for exact `operation` + `columns` shape.
5. Update `n8n-node-schema-source-of-truth.md` to reflect production export (typeVersion 4, IF v1 with `conditions.string`) — separate doc task.

---

## Appendix — Node Count Summary

| Type | Qualification count | Mismatched vs production |
|------|---------------------|--------------------------|
| OpenAI | 3 | 3 |
| Google Sheets | 3 | 3 |
| IF | 2 | 2 |
| Telegram Trigger | 1 | 1 |
| Telegram Send | 2 | 0–2 (minor) |
| **Total in scope** | **11** | **9–11** |
