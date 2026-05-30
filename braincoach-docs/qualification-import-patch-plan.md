# Qualification Engine — Import Patch Plan

Last Updated: 2026-05-30

**Authoritative schema:** `workflows/reference-node-exports/my-test-workflow.json`  
**Target file:** `workflows/qualification-engine.json`  
**Goal:** Minimal safe patch sequence for successful n8n import.

**Rules:** Documentation only. Do not apply patches from this doc without a backup. Do not create new workflow files or versions (no v7).

---

## Patch Principles

1. Change **parameter shape only** — preserve node `name`, `position`, `connections`, and business expressions where possible.
2. Patch in **phases** — import-test after each phase if import still fails.
3. **Google Sheets tab gids** (`sheetName.value`) must be resolved in the n8n UI spreadsheet picker — placeholders below use `REPLACE_WITH_GID_FROM_N8N_UI`.
4. Production export shows Sheets **append** only; qualification needs **read**. Use UI to pick the read operation, then optionally re-export a read node for a follow-up doc update.
5. **Credentials** stay as placeholders until import; re-bind in n8n after workflow opens.

---

## Workflow-Level Patch (optional, after nodes import)

Add production execution order setting if missing:

```json
"settings": {
  "executionOrder": "v1"
}
```

**Current:** `"settings": {}`  
**Action:** Merge `executionOrder: "v1"` (from production export).

---

## 1. Exact OpenAI Node Changes

**Applies to:** 3 nodes — same structural patch, different `modelId.value` and message text.

| Node name | `modelId.value` | `cachedResultName` | Keep `maxTokens` after import? |
|-----------|-----------------|--------------------|--------------------------------|
| OpenAI - Intake Classifier | `gpt-5.4-nano` | `GPT-5.4-NANO` | 800 (re-add in UI) |
| OpenAI - Emotional Reflection | `gpt-5.4-nano` | `GPT-5.4-NANO` | 800 |
| OpenAI - Qualification Engine | `gpt-5.4-mini` | `GPT-5.4-MINI` | 1000 |

**Unchanged fields:** `type`, `typeVersion` (1.8), `position`, `credentials`, `connections`.

### 1.1 OpenAI - Intake Classifier

**REPLACE** entire `parameters` object.

**Before:**

```json
"parameters": {
  "modelId": "gpt-5.4-nano",
  "temperature": 0.2,
  "maxTokens": 800,
  "messages": [
    {
      "role": "system",
      "content": "You are BrainCoach Intake Classifier. Classify the user message using keywords_master. Return JSON only with: keyword, segment, consultation_type, intent, emotional_driver, emotional_state, emotional_intensity, interaction_type, qualification_readiness, memory_candidate, memory_items, confidence, next_route. Do not return stage fields."
    },
    {
      "role": "user",
      "content": "Message: {{$json[\"message\"][\"text\"]}}\nKeywords: {{$node[\"GoogleSheets - keywords_master\"].json}}\nClient: {{$node[\"Postgres - Find Client\"].json[0] || $node[\"Postgres - Create Client\"].json[0]}}"
    }
  ]
}
```

**After (production-shaped):**

```json
"parameters": {
  "modelId": {
    "__rl": true,
    "value": "gpt-5.4-nano",
    "mode": "list",
    "cachedResultName": "GPT-5.4-NANO"
  },
  "messages": {
    "values": [
      {
        "role": "system",
        "content": "You are BrainCoach Intake Classifier. Classify the user message using keywords_master. Return JSON only with: keyword, segment, consultation_type, intent, emotional_driver, emotional_state, emotional_intensity, interaction_type, qualification_readiness, memory_candidate, memory_items, confidence, next_route. Do not return stage fields."
      },
      {
        "content": "Message: {{$json[\"message\"][\"text\"]}}\nKeywords: {{$node[\"GoogleSheets - keywords_master\"].json}}\nClient: {{$node[\"Postgres - Find Client\"].json[0] || $node[\"Postgres - Create Client\"].json[0]}}"
      }
    ]
  },
  "options": {}
}
```

**Removed for import (re-add in n8n UI if needed):** `temperature`, `maxTokens`.

**Note:** User message may omit `role` (production pattern) or keep `"role": "user"` — both are acceptable if import succeeds.

---

### 1.2 OpenAI - Emotional Reflection

**REPLACE** entire `parameters` object.

**After:**

```json
"parameters": {
  "modelId": {
    "__rl": true,
    "value": "gpt-5.4-nano",
    "mode": "list",
    "cachedResultName": "GPT-5.4-NANO"
  },
  "messages": {
    "values": [
      {
        "role": "system",
        "content": "You are BrainCoach Emotional Reflection Engine. Analyze the user text and return JSON only with emotional_state, emotional_intensity, behavioral_signal, tone_adjustment, pace_adjustment, state_change, confidence. Do not decide qualification stages or offers."
      },
      {
        "content": "Message: {{$json[\"message\"][\"text\"]}}\nMemory signals: {{$node[\"GoogleSheets - memory_signals\"].json}}\nClient: {{$node[\"Postgres - Find Client\"].json[0] || $node[\"Postgres - Create Client\"].json[0]}}"
      }
    ]
  },
  "options": {}
}
```

---

### 1.3 OpenAI - Qualification Engine

**REPLACE** entire `parameters` object.

**After:**

```json
"parameters": {
  "modelId": {
    "__rl": true,
    "value": "gpt-5.4-mini",
    "mode": "list",
    "cachedResultName": "GPT-5.4-MINI"
  },
  "messages": {
    "values": [
      {
        "role": "system",
        "content": "You are BrainCoach Qualification Engine. Use the intake classifier output, emotional reflection output, qualification_flow rows, and client state to generate the next qualification question. Return JSON only with qualification_depth, pain_detected, pain_summary, emotional_driver_confirmed, desired_outcome, consultation_readiness, offer_eligibility_signal, next_question, next_stage, memory_updates, confidence."
      },
      {
        "content": "Classifier: {{$node[\"OpenAI - Intake Classifier\"].json.choices[0].message.content}}\nEmotional: {{$node[\"OpenAI - Emotional Reflection\"].json.choices[0].message.content}}\nQualification flow: {{$node[\"GoogleSheets - qualification_flow\"].json}}\nClient: {{$node[\"Postgres - Find Client\"].json[0] || $node[\"Postgres - Create Client\"].json[0]}}"
      }
    ]
  },
  "options": {}
}
```

---

### 1.4 OpenAI patch summary

| Action | Field |
|--------|-------|
| Replace | `modelId` string → RL object |
| Wrap | `messages` array → `{ "values": [ ... ] }` |
| Add | `options: {}` |
| Remove (import-safe) | `temperature`, `maxTokens` |
| Keep | All `content` strings unchanged |

---

## 2. Exact Telegram Trigger Changes

**Node:** `Telegram Trigger`  
**Unchanged:** `type`, `typeVersion` (1), `position`, `credentials`.

**REPLACE** entire `parameters` object.

**Before:**

```json
"parameters": {
  "updates": {},
  "event": "message"
}
```

**After (from production):**

```json
"parameters": {
  "updates": [
    "message"
  ],
  "additionalFields": {}
}
```

| Action | Detail |
|--------|--------|
| Replace | `updates` from `{}` to `["message"]` |
| Add | `additionalFields: {}` |
| Delete | `event` key entirely |

---

## 3. Exact Google Sheets Changes

**Applies to:** 3 nodes — same structure, different `sheetName.cachedResultName` / gid.

| Node name | Tab name (`cachedResultName`) | Legacy `range` |
|-----------|------------------------------|----------------|
| GoogleSheets - keywords_master | `keywords_master` | `keywords_master` |
| GoogleSheets - qualification_flow | `qualification_flow` | `qualification_flow` |
| GoogleSheets - memory_signals | `memory_signals` | `memory_signals` |

**Per node:**

| Action | Detail |
|--------|--------|
| Set | `typeVersion`: `1` → `4` |
| Delete | `sheetId`, `range` |
| Add | `operation`, `documentId`, `sheetName` |
| Keep | `options: {}` |
| Omit (read) | `columns` block from append example — not used for read |

**Spreadsheet id:** Keep qualification spreadsheet  
`1r7n5E1eU5IKK6RPkK4HHsLxorFpgs66GZQwYhI0fL_I`  
(do not use production test spreadsheet `1H4EJw-Boe-xsM0J2rfOmaSHbzOSSzU_Hci62c44ByU8` unless that is the real BrainCoach control sheet).

### 3.1 Template — GoogleSheets - keywords_master

**Before:**

```json
"parameters": {
  "sheetId": "1r7n5E1eU5IKK6RPkK4HHsLxorFpgs66GZQwYhI0fL_I",
  "range": "keywords_master",
  "options": {}
},
"typeVersion": 1
```

**After:**

```json
"parameters": {
  "operation": "read",
  "documentId": {
    "__rl": true,
    "value": "1r7n5E1eU5IKK6RPkK4HHsLxorFpgs66GZQwYhI0fL_I",
    "mode": "list",
    "cachedResultName": "BrainCoach Semantic Control",
    "cachedResultUrl": "https://docs.google.com/spreadsheets/d/1r7n5E1eU5IKK6RPkK4HHsLxorFpgs66GZQwYhI0fL_I/edit"
  },
  "sheetName": {
    "__rl": true,
    "value": "REPLACE_WITH_GID_keywords_master",
    "mode": "list",
    "cachedResultName": "keywords_master",
    "cachedResultUrl": "https://docs.google.com/spreadsheets/d/1r7n5E1eU5IKK6RPkK4HHsLxorFpgs66GZQwYhI0fL_I/edit#gid=REPLACE_WITH_GID_keywords_master"
  },
  "options": {}
},
"typeVersion": 4
```

### 3.2 Template — GoogleSheets - qualification_flow

Same as §3.1, replace tab tokens:

- `cachedResultName`: `qualification_flow`
- `REPLACE_WITH_GID_qualification_flow` in `value` and URL

### 3.3 Template — GoogleSheets - memory_signals

Same as §3.1, replace tab tokens:

- `cachedResultName`: `memory_signals`
- `REPLACE_WITH_GID_memory_signals` in `value` and URL

### 3.4 Resolving `sheetName.value` (required UI step)

Production pattern uses **numeric gid** in `sheetName.value` (example: `1929630387` for tab `logs`).

**In n8n UI (per Sheets node):**

1. Set operation to **Read** (or equivalent: Get rows / Read sheet — match label on your instance).
2. Pick document `1r7n5E1eU5IKK6RPkK4HHsLxorFpgs66GZQwYhI0fL_I`.
3. Pick tab `keywords_master` (then repeat for other tabs).
4. Save node → export workflow or copy `sheetName` block from node JSON.

**If `operation: "read"` fails import:** Create a temporary read node in production n8n, export, and replace `operation` + any extra read-only fields from that export.

### 3.5 Google Sheets patch summary

| Field | Production reference | Qualification patch |
|-------|---------------------|---------------------|
| `typeVersion` | `4` | `4` |
| `operation` | `append` in export | `read` for qualification (UI-confirmed) |
| `documentId` | RL object | RL with qualification spreadsheet id |
| `sheetName` | RL object with numeric gid | RL per tab (gid from UI) |
| `columns` | Present for append | **Do not copy** for read |
| `sheetId` / `range` | Absent | **Remove** |

---

## 4. Exact IF Node Changes

**Production reference:** `IF - Not Empty?` uses `conditions.string` + `isNotEmpty`.  
**Qualification logic:** Boolean existence / validation checks — keep `conditions.boolean` but **fix malformed rows** (add `value2`).

**Unchanged:** `type`, `typeVersion` (1), `position`, `connections`.

### 4.1 IF - Client Exists?

**Before:**

```json
"parameters": {
  "conditions": {
    "boolean": [
      {
        "value1": "={{$node[\"Postgres - Find Client\"].json[0] !== undefined}}",
        "operation": "equal"
      }
    ]
  }
}
```

**After (minimal valid boolean):**

```json
"parameters": {
  "conditions": {
    "boolean": [
      {
        "value1": "={{$node[\"Postgres - Find Client\"].json[0] !== undefined}}",
        "value2": true,
        "operation": "equal"
      }
    ]
  }
}
```

**Change:** Add `"value2": true` only.

**Alternative (production-style, if boolean still fails import):** Rebuild in UI using IF template from `my-test-workflow.json`, expression adapted to client lookup.

---

### 4.2 IF - All Valid?

**Before:**

```json
"parameters": {
  "conditions": {
    "boolean": [
      {
        "value1": "={{$node[\"Validate - Intake JSON\"].json[0].valid && $node[\"Validate - Emotional JSON\"].json[0].valid && $node[\"Validate - Qualification JSON\"].json[0].valid}}",
        "operation": "equal"
      }
    ]
  }
}
```

**After:**

```json
"parameters": {
  "conditions": {
    "boolean": [
      {
        "value1": "={{$node[\"Validate - Intake JSON\"].json[0].valid && $node[\"Validate - Emotional JSON\"].json[0].valid && $node[\"Validate - Qualification JSON\"].json[0].valid}}",
        "value2": true,
        "operation": "equal"
      }
    ]
  }
}
```

**Change:** Add `"value2": true` only.

---

### 4.3 IF patch summary

| Node | Action |
|------|--------|
| IF - Client Exists? | Add `value2: true` to boolean condition |
| IF - All Valid? | Add `value2: true` to boolean condition |
| Do not change | `typeVersion` (stays 1, matches production) |

---

## 5. Optional Telegram Send Patches (low priority)

Not required for primary import blocker fix; align with production when workflow already opens.

**Nodes:** `Telegram - Send Error`, `Telegram - Send Question`

**Add to each `parameters`:**

```json
"additionalFields": {}
```

**Example — Telegram - Send Question after patch:**

```json
"parameters": {
  "chatId": "={{$json[\"message\"][\"chat\"][\"id\"]}}",
  "text": "={{$node[\"Validate - Qualification JSON\"].json[0].parsed.next_question}}",
  "additionalFields": {}
}
```

---

## 6. Ordered Execution Plan

### Phase 0 — Prepare

| Step | Action |
|------|--------|
| 0.1 | Copy `workflows/qualification-engine.json` → `qualification-engine.json.pre-patch-backup` (local backup, do not commit backup unless desired) |
| 0.2 | Confirm `my-test-workflow.json` is the latest production export |

---

### Phase 1 — Telegram Trigger only (highest-confidence quick win)

| Step | Action | Verify |
|------|--------|--------|
| 1.1 | Apply §2 patch to `Telegram Trigger` | — |
| 1.2 | Import workflow OR import workflow with only Trigger + one dummy node | Import succeeds or error changes |

**Rollback:** Restore Trigger `parameters` from backup.

---

### Phase 2 — OpenAI (single node probe)

| Step | Action | Verify |
|------|--------|--------|
| 2.1 | Apply §1.1 patch to **OpenAI - Intake Classifier** only | — |
| 2.2 | Import workflow | If error was iterable-related, error may clear or move to next node |
| 2.3 | Apply §1.2 and §1.3 to remaining OpenAI nodes | Full OpenAI chain imports |

**Rollback:** Restore three OpenAI `parameters` from backup.

---

### Phase 3 — Google Sheets (UI-assisted)

| Step | Action | Verify |
|------|--------|--------|
| 3.1 | In **production n8n**, create temporary Google Sheets node: operation **Read**, document `1r7n5E1eU5IKK6RPkK4HHsLxorFpgs66GZQwYhI0fL_I`, tab `keywords_master` | Export node JSON or note exact `operation` string |
| 3.2 | Apply §3.1 template to `GoogleSheets - keywords_master` with real gid from step 3.1 | — |
| 3.3 | Repeat 3.1–3.2 for `qualification_flow` and `memory_signals` | All three nodes typeVersion 4 |
| 3.4 | Import workflow | Sheets nodes open in editor without iterable error |

**Rollback:** Restore three Sheets nodes from backup.

---

### Phase 4 — IF nodes

| Step | Action | Verify |
|------|--------|--------|
| 4.1 | Apply §4.1 and §4.2 (`value2: true`) | — |
| 4.2 | Import workflow | IF nodes render in editor |

**If import still fails on IF:** Delete IF nodes from JSON, import, re-add IF nodes manually in UI using production IF as template.

---

### Phase 5 — Optional Telegram Send + workflow settings

| Step | Action | Verify |
|------|--------|--------|
| 5.1 | Add `additionalFields: {}` to both Telegram Send nodes (§5) | — |
| 5.2 | Add `settings.executionOrder: "v1"` | — |
| 5.3 | Import workflow | Complete graph opens |

---

### Phase 6 — Post-import (not JSON patch)

| Step | Action |
|------|--------|
| 6.1 | Re-bind credentials: Telegram, Postgres, Google Sheets, OpenAI |
| 6.2 | Re-add OpenAI `temperature` / `maxTokens` in UI if needed |
| 6.3 | Run manual execution with test Telegram message |
| 6.4 | Confirm OpenAI response path — production uses `.json["message"]["content"]`; validators still use `.choices[0].message.content` — update Function nodes if execution returns different shape |
| 6.5 | Confirm Postgres nodes import (out of scope for this plan — may need separate postgres export) |

---

## 7. Minimal Patch Sequence (single pass)

If you prefer **one edit session** before import (no phased testing):

| Order | Section | Nodes touched |
|-------|---------|---------------|
| 1 | §2 Telegram Trigger | 1 |
| 2 | §1 OpenAI (all three) | 3 |
| 3 | §3 Google Sheets (all three, after gid resolution) | 3 |
| 4 | §4 IF (both) | 2 |
| 5 | §5 Telegram Send (optional) | 2 |
| 6 | Workflow `settings` | 1 |

**Total in-scope node parameter patches:** 9 required + 2 optional = **11 nodes**.

**Do not patch in this plan:** Postgres (4), Function (3) — address only if import fails after phases 1–4.

---

## 8. Success Criteria

| Criterion | Status |
|-----------|--------|
| Workflow imports without `propertyValues[itemName] is not iterable` | Required |
| All 18 nodes visible in n8n editor | Required |
| Connections unchanged from pre-patch | Required |
| Google Sheets read returns rows for three tabs | Required (runtime) |
| OpenAI nodes execute | Required (runtime) |

---

## 9. Related Documents

| Document | Purpose |
|----------|---------|
| `braincoach-docs/import-blocker-analysis.md` | Mismatch ranking and root-cause analysis |
| `braincoach-docs/qualification-node-compatibility-report.md` | Pre-export compatibility review |
| `workflows/reference-node-exports/my-test-workflow.json` | Authoritative production shapes |

---

## 10. Patch Checklist (copy for execution)

```
[ ] Phase 0: Backup qualification-engine.json
[ ] Phase 1: Telegram Trigger parameters
[ ] Phase 2: OpenAI - Intake Classifier
[ ] Phase 2: OpenAI - Emotional Reflection
[ ] Phase 2: OpenAI - Qualification Engine
[ ] Phase 3: Resolve keywords_master gid in n8n UI
[ ] Phase 3: GoogleSheets - keywords_master
[ ] Phase 3: GoogleSheets - qualification_flow
[ ] Phase 3: GoogleSheets - memory_signals
[ ] Phase 4: IF - Client Exists? (value2: true)
[ ] Phase 4: IF - All Valid? (value2: true)
[ ] Phase 5: Telegram Send additionalFields (optional)
[ ] Phase 5: settings.executionOrder (optional)
[ ] Phase 6: Import test
[ ] Phase 6: Re-bind credentials + manual run
```
