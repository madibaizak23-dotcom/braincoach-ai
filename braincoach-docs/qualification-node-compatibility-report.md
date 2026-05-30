# Qualification Engine — Node Compatibility Report

Last Updated: 2026-05-30

**File analyzed:** `workflows/qualification-engine.json`  
**Workflow name (internal):** `qualification-engine-v3`  
**Node count:** 18  
**Analysis scope:** Node compatibility only — no business-logic review.

**Reference standards:**

- `braincoach-docs/n8n-node-schema-source-of-truth.md`
- `braincoach-docs/n8n-compatibility-notes.md`
- `workflows/reference-node-exports/` — **empty** (production exports not available for diff)

Because production node exports are missing, this report compares workflow JSON against documented BrainCoach production requirements. Final confirmation requires exported nodes from the live n8n instance.

---

## Executive Summary

| Risk level | Count | Nodes |
|------------|-------|-------|
| **Critical** | 8 | 3× Google Sheets, 3× OpenAI, 2× IF |
| **High** | 5 | 3× Postgres (write), 2× Telegram (send) |
| **Medium** | 4 | Telegram Trigger, Postgres Find, Postgres Create, 3× Function (grouped as low-medium) |
| **Low** | 3 | Validate Function nodes |

**Overall import compatibility:** **Poor** — multiple node parameter shapes appear AI-generated against legacy/generic n8n schemas, not BrainCoach production schemas.

**Most likely import failure point for** `"propertyValues[itemName] is not iterable"`: **OpenAI LangChain nodes** (×3), followed by **IF nodes** (×2) and **Google Sheets nodes** (×3).

---

## Compatibility Risk Legend

| Level | Meaning |
|-------|---------|
| **Critical** | Documented production schema mismatch; strong correlation with import/UI iterable errors |
| **High** | Likely mismatch; may fail import or break in editor on current n8n |
| **Medium** | Unverified typeVersion; may work on older n8n but not confirmed for production |
| **Low** | Stable legacy node; low schema complexity |

---

## Full Node Inventory

| # | Node name | Node type | typeVersion | Compatibility risk |
|---|-----------|-----------|-------------|-------------------|
| 1 | Telegram Trigger | `n8n-nodes-base.telegramTrigger` | 1 | **Medium** |
| 2 | Postgres - Find Client | `n8n-nodes-base.postgres` | 1 | **Medium** |
| 3 | IF - Client Exists? | `n8n-nodes-base.if` | 1 | **Critical** |
| 4 | Postgres - Create Client | `n8n-nodes-base.postgres` | 1 | **Medium** |
| 5 | GoogleSheets - keywords_master | `n8n-nodes-base.googleSheets` | 1 | **Critical** |
| 6 | GoogleSheets - qualification_flow | `n8n-nodes-base.googleSheets` | 1 | **Critical** |
| 7 | GoogleSheets - memory_signals | `n8n-nodes-base.googleSheets` | 1 | **Critical** |
| 8 | OpenAI - Intake Classifier | `@n8n/n8n-nodes-langchain.openAi` | 1.8 | **Critical** |
| 9 | OpenAI - Emotional Reflection | `@n8n/n8n-nodes-langchain.openAi` | 1.8 | **Critical** |
| 10 | OpenAI - Qualification Engine | `@n8n/n8n-nodes-langchain.openAi` | 1.8 | **Critical** |
| 11 | Validate - Intake JSON | `n8n-nodes-base.function` | 1 | **Low** |
| 12 | Validate - Emotional JSON | `n8n-nodes-base.function` | 1 | **Low** |
| 13 | Validate - Qualification JSON | `n8n-nodes-base.function` | 1 | **Low** |
| 14 | IF - All Valid? | `n8n-nodes-base.if` | 1 | **Critical** |
| 15 | Telegram - Send Error | `n8n-nodes-base.telegram` | 1 | **High** |
| 16 | Postgres - Update Client | `n8n-nodes-base.postgres` | 1 | **High** |
| 17 | Postgres - Insert Event | `n8n-nodes-base.postgres` | 1 | **High** |
| 18 | Telegram - Send Question | `n8n-nodes-base.telegram` | 1 | **High** |

---

## Focused Analysis — Priority Node Types

### OpenAI nodes (×3) — **Critical**

**Nodes:** OpenAI - Intake Classifier, OpenAI - Emotional Reflection, OpenAI - Qualification Engine  
**Type:** `@n8n/n8n-nodes-langchain.openAi` · **typeVersion:** 1.8

| Parameter | Workflow value | Production requirement | Risk |
|-----------|----------------|------------------------|------|
| `modelId` | Plain string `"gpt-5.4-nano"` / `"gpt-5.4-mini"` | Resource Locator object with `__rl`, `mode`, `value` | **Critical** |
| `messages` | Direct array `[{ role, content }, ...]` | Wrapped collection: `{ "values": [...] }` | **Critical** |
| `resource` | Absent | Typically required in LangChain node UI schema | **High** |
| `operation` | Absent | Typically required in LangChain node UI schema | **High** |
| Node type | Correct LangChain type | `@n8n/n8n-nodes-langchain.openAi` v1.8 | OK |
| Credentials key | `openAIApi` | Must match production export | **Medium** (unverified) |

**Current workflow fragment (all 3 nodes follow this pattern):**

```json
"modelId": "gpt-5.4-nano",
"messages": [
  { "role": "system", "content": "..." },
  { "role": "user", "content": "..." }
]
```

**Expected production shape (per `n8n-node-schema-source-of-truth.md`):**

```json
"modelId": {
  "__rl": true,
  "mode": "list",
  "value": "gpt-5.4-mini"
},
"messages": {
  "values": [
    { "role": "system", "content": "..." },
    { "role": "user", "content": "..." }
  ]
}
```

**Why this triggers iterable errors:** LangChain OpenAI v1.8 defines `messages` as a `fixedCollection` / multi-value field. During import or editor hydration, n8n calls internal helpers that iterate `propertyValues[itemName]`. If `messages` is a plain array (or `modelId` is a string when an object schema is expected), the helper receives a non-iterable shape and throws.

**Iterable-error likelihood:** **Highest in entire workflow**

---

### IF nodes (×2) — **Critical**

**Nodes:** IF - Client Exists?, IF - All Valid?  
**Type:** `n8n-nodes-base.if` · **typeVersion:** 1

| Parameter | Workflow value | Production requirement | Risk |
|-----------|----------------|------------------------|------|
| `typeVersion` | 1 | 2.2 (documented production) | **Critical** |
| `conditions` | Legacy `{ "boolean": [{ value1, operation }] }` | Modern conditions schema with combinator/options | **Critical** |
| `conditions.options` | Absent | Expected in v2.x | **High** |
| `value1` operation | `"equal"` without `value2` | Incomplete boolean condition (may fail validation) | **High** |

**IF - Client Exists? fragment:**

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

**Issues:**

1. Production docs explicitly forbid legacy `conditions.boolean` structures.
2. typeVersion 1 schema differs from typeVersion 2.2 — n8n loads the v2.2 parameter definition but receives v1 JSON, causing collection parsing failures.
3. Boolean condition uses `operation: "equal"` with no `value2` — malformed even within legacy schema.

**Iterable-error likelihood:** **Very high** — IF/Switch nodes are repeatedly cited in n8n GitHub issues (#14775, #28998) as sources of this error when condition type keys (`boolean`, `number`, `string`) do not match the active typeVersion.

---

### Google Sheets nodes (×3) — **Critical**

**Nodes:** GoogleSheets - keywords_master, GoogleSheets - qualification_flow, GoogleSheets - memory_signals  
**Type:** `n8n-nodes-base.googleSheets` · **typeVersion:** 1

| Parameter | Workflow value | Production requirement | Risk |
|-----------|----------------|------------------------|------|
| `typeVersion` | 1 | 4.6 (documented production) | **Critical** |
| Spreadsheet ref | `sheetId` (plain string) | `documentId` (Resource Locator) | **Critical** |
| Tab ref | `range` (tab name string) | `sheetName` (Resource Locator) | **Critical** |
| `operation` | Absent | Required in v4.x node | **High** |
| `options` | `{}` empty object | Empty fixedCollection objects often break import | **High** |

**Current workflow fragment (all 3 nodes):**

```json
"sheetId": "1r7n5E1eU5IKK6RPkK4HHsLxorFpgs66GZQwYhI0fL_I",
"range": "keywords_master",
"options": {}
```

**Production docs explicitly say:** do not use `sheetId` / `range` unless confirmed by exported schema. Production expects `documentId` + `sheetName`.

**Why this triggers iterable errors:** Google Sheets v4.6 reorganized parameters into resource locators and collection types. Importing v1 parameter names into a v4.6 node definition causes n8n to look up collection keys that do not exist or have wrong types. Empty `options: {}` is a known LLM-generated anti-pattern — n8n expects either omitted `options` or a properly keyed fixedCollection.

**Iterable-error likelihood:** **Very high**

---

### PostgreSQL nodes (×4) — **Medium to High**

**Nodes:** Postgres - Find Client, Postgres - Create Client, Postgres - Update Client, Postgres - Insert Event  
**Type:** `n8n-nodes-base.postgres` · **typeVersion:** 1

| Parameter | Find / Create | Update / Insert | Production note | Risk |
|-----------|---------------|-----------------|-----------------|------|
| `typeVersion` | 1 | 1 | Not documented; export missing | **Medium** |
| `operation` | Absent | Absent | Modern postgres nodes use `executeQuery` operation wrapper | **High** |
| `query` | Inline SQL string | Inline SQL string | May need to live under `operation` + `query` in v2+ | **High** |
| `values` | Absent | Array of 6–7 expression strings | Parameter binding collection — shape depends on typeVersion | **High** (write nodes) |

**Read nodes (Find, Create):** Medium risk — simple query string may still hydrate on older postgres v1, but unverified against production.

**Write nodes (Update, Insert):** High risk — `values` is typically a `fixedCollection` (e.g. `valuesUi` / `values` with nested structure). A plain string array may not match the collection iterator n8n expects:

```json
"values": [
  "={{$node[\"Validate - Intake JSON\"].json[0].parsed.keyword}}",
  "..."
]
```

**Iterable-error likelihood:** **Moderate** — less common than OpenAI/IF/Sheets, but Update/Insert nodes are suspects if import fails after fixing higher-priority nodes.

---

### Telegram nodes (×3) — **Medium to High**

#### Telegram Trigger

**Node:** Telegram Trigger · **Type:** `n8n-nodes-base.telegramTrigger` · **typeVersion:** 1 · **Risk:** **Medium**

| Parameter | Workflow value | Issue |
|-----------|----------------|-------|
| `updates` | `{}` empty object | May need proper fixedCollection structure for update types |
| `event` | `"message"` | Legacy flat param; newer triggers may use different schema |

#### Telegram - Send Error / Telegram - Send Question

**Type:** `n8n-nodes-base.telegram` · **typeVersion:** 1 · **Risk:** **High**

| Parameter | Workflow value | Issue |
|-----------|----------------|-------|
| `resource` | Absent | Modern telegram node uses resource/operation pattern |
| `operation` | Absent | Expected: `sendMessage` or similar under v1.2+ |
| `chatId`, `text` | Flat parameters | May need relocation under `additionalFields` or operation block |

**Current fragment:**

```json
"chatId": "={{$json[\"message\"][\"chat\"][\"id\"]}}",
"text": "={{$node[\"Validate - Qualification JSON\"].json[0].parsed.next_question}}"
```

**Iterable-error likelihood:** **Moderate** — Telegram nodes appear in multiple import-failure reports; rank after OpenAI, IF, and Google Sheets.

---

### Function nodes (×3) — **Low**

**Nodes:** Validate - Intake JSON, Validate - Emotional JSON, Validate - Qualification JSON  
**Type:** `n8n-nodes-base.function` · **typeVersion:** 1 · **Risk:** **Low**

Only parameter is `functionCode` (string). No fixedCollection fields. Unlikely to cause `"propertyValues[itemName] is not iterable"`.

> **Note:** `n8n-nodes-base.function` is deprecated in newer n8n in favor of Code node — separate migration concern, not an iterable-error cause.

---

## Suspect Ranking for `"propertyValues[itemName] is not iterable"`

This error occurs when n8n's parameter hydration (`NodeHelpers.getNodeParameters`) expects an **iterable collection** (array or fixedCollection values) but receives an **object, string, or wrong legacy shape** for the active `typeVersion`.

Documented in [n8n-io/n8n#14775](https://github.com/n8n-io/n8n/issues/14775), [n8n-io/n8n#17580](https://github.com/n8n-io/n8n/pull/17580), and n8n community reports on AI-generated workflows.

### Ranked suspects in `qualification-engine.json`

| Rank | Node(s) | Likely malformed parameter | Mechanism |
|------|---------|---------------------------|-----------|
| **1** | OpenAI ×3 | `messages` as direct array; `modelId` as string | fixedCollection expects `{ values: [...] }` and RL object — iterator receives wrong type |
| **2** | IF ×2 | `conditions.boolean` on typeVersion 1 | typeVersion 2.2 node definition iterates condition collections with different keys |
| **3** | Google Sheets ×3 | `sheetId` + `range` + `options: {}` on typeVersion 1 vs production 4.6 | Parameter name/shape mismatch; empty `options` object breaks fixedCollection parsing |
| **4** | Postgres Update / Insert | `values` as flat string array | Binding values may need nested collection schema in current postgres node |
| **5** | Telegram Send ×2 | Flat `chatId`/`text` without resource/operation | Newer telegram schema may fail hydration |
| **6** | Telegram Trigger | `updates: {}` | Empty fixedCollection object |

### Secondary contributing factors

| Factor | Impact |
|--------|--------|
| Entire workflow AI-generated without production exports | Multiple nodes fail simultaneously — error message does not identify which node |
| `workflows/reference-node-exports/` empty | Cannot validate exact shapes BrainCoach production n8n expects |
| Mixed legacy typeVersions (1) with modern node types (OpenAI 1.8) | Editor loads newest schema for type, applies oldest parameter JSON |

---

## Error Diagnosis — What the message means

```
propertyValues[itemName] is not iterable
```

**Plain language:** n8n is trying to loop over a node parameter sub-field (a `fixedCollection` or multi-value property) and the stored JSON is the wrong data type or structure for that node's `typeVersion`.

**Typical causes in AI-generated workflows:**

1. Array where n8n expects `{ values: [...] }` (or the reverse — depends on node + version)
2. Legacy condition keys (`boolean`, `conditions`) on modern IF node versions
3. Deprecated parameter names (`sheetId`, `range`) on current Google Sheets node
4. Empty `{}` objects on fixedCollection fields (`options`, `updates`)
5. Missing `resource` / `operation` wrappers required by current node definitions

**Why n8n does not show which node failed:** The error is thrown during bulk workflow import/hydration before the editor pinpoints a single node ([community report](https://community.n8n.io/t/error-importing-workflow-created-by-claude-code-and-chatgpt/252985)).

---

## Isolation Strategy (diagnostic, no file changes)

To identify the exact failing node on import:

1. Import an empty workflow, then paste nodes one at a time in this order (highest risk first):
   - OpenAI - Intake Classifier
   - IF - Client Exists?
   - GoogleSheets - keywords_master
   - OpenAI - Emotional Reflection
   - OpenAI - Qualification Engine
   - IF - All Valid?
   - Remaining nodes

2. Export a working node of each type from production n8n into `workflows/reference-node-exports/` and diff parameter shapes.

3. Download production node definitions from `{N8N_URL}/types/nodes.json` and validate each `type` + `typeVersion` pair.

4. Use [n8n-workflow-validator](https://github.com/yigitkonur/n8n-workflow-validator/) locally against installed `n8n-nodes-base` to get node-level error codes.

---

## Parameter Shape Checklist — Workflow vs Production Docs

| Node type | Workflow typeVersion | Doc typeVersion | Parameter mismatch | Iterable risk |
|-----------|---------------------|-----------------|-------------------|---------------|
| LangChain OpenAI | 1.8 | 1.8 | `modelId`, `messages` shape | **Critical** |
| Google Sheets | 1 | 4.6 | `sheetId`/`range` vs `documentId`/`sheetName`; `options: {}` | **Critical** |
| IF | 1 | 2.2 | `conditions.boolean` legacy | **Critical** |
| Postgres | 1 | unknown | No `operation`; flat `values` array on writes | **High** |
| Telegram | 1 | unknown | No `resource`/`operation` | **High** |
| Telegram Trigger | 1 | unknown | `updates: {}` | **Medium** |
| Function | 1 | 1 | None detected | **Low** |

---

## Recommended Fix Order (documentation guidance only)

When reconciling against production exports — **do not guess shapes**:

1. **Export** one working instance of each node type from BrainCoach production n8n
2. **Fix OpenAI nodes first** — `modelId` RL object + `messages.values` wrapper
3. **Fix Google Sheets nodes** — upgrade to typeVersion 4.6 with `documentId` / `sheetName`
4. **Fix IF nodes** — upgrade to typeVersion 2.2 with modern conditions schema
5. **Fix Postgres nodes** — align `operation`, `query`, and `values` with exported postgres node
6. **Fix Telegram nodes** — align with exported telegram / telegramTrigger nodes
7. **Re-import and test** — confirm error cleared before committing

---

## Cross-References

- `braincoach-docs/n8n-node-schema-source-of-truth.md` — production node shape requirements
- `braincoach-docs/n8n-compatibility-notes.md` — OpenAI type and model mapping
- `braincoach-docs/workflow-inventory.md` — workflow readiness and canonical file decision
- `workflows/qualification-engine-v4.md` — validation layer notes (separate from schema compatibility)

---

## Limitations

- No production node exports exist in `workflows/reference-node-exports/` — this report is based on documented requirements, not a byte-level diff against live n8n.
- Exact iterable-error behavior can vary by n8n server version (fixes landed in PR #17580 for some cases).
- BrainCoach production n8n version number was not available during this analysis — confirm against live instance.
