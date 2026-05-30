# Qualification Engine — Patch Summary

Last Updated: 2026-05-30 (full patch plan applied)

**Patched file:** `workflows/qualification-engine.json`  
**Patch source:** `braincoach-docs/qualification-import-patch-plan.md`  
**Production schema reference:** `workflows/reference-node-exports/my-test-workflow.json`

**Status:** All required and optional schema patches from the import patch plan are applied.

**Scope applied:**

| Phase | Nodes / settings | Status |
|-------|------------------|--------|
| §1 OpenAI | Intake Classifier, Emotional Reflection, Qualification Engine | Applied |
| §2 Telegram Trigger | Telegram Trigger | Applied |
| §3 Google Sheets | keywords_master, qualification_flow, memory_signals | Applied |
| §4 IF | Client Exists?, All Valid? | Applied |
| §5 Telegram Send (optional) | Send Error, Send Question | Applied |
| Workflow settings (optional) | `executionOrder: "v1"` | Applied |

**Unchanged (by design):** Postgres (×4), Function (×3), connections, node names, positions, credential placeholders, all prompt `content` and SQL/query expressions.

---

## 1. Telegram Trigger

| Field | Before (pre-patch) | After |
|-------|-------------------|-------|
| `parameters.updates` | `{}` (empty object) | `["message"]` (array) |
| `parameters.event` | `"message"` | **removed** |
| `parameters.additionalFields` | absent | `{}` |

---

## 2. OpenAI - Intake Classifier

| Field | Before (pre-patch) | After |
|-------|-------------------|-------|
| `parameters.modelId` | `"gpt-5.4-nano"` (string) | RL object: `__rl`, `value`, `mode`, `cachedResultName` |
| `parameters.modelId.__rl` | — | `true` |
| `parameters.modelId.value` | — | `"gpt-5.4-nano"` |
| `parameters.modelId.mode` | — | `"list"` |
| `parameters.modelId.cachedResultName` | — | `"GPT-5.4-NANO"` |
| `parameters.messages` | Direct array | Object with `values` array |
| `parameters.messages.values[0]` | `{ role, content }` (system) | Unchanged content; wrapped under `values` |
| `parameters.messages.values[1].role` | `"user"` | **removed** (matches production) |
| `parameters.messages.values[1].content` | User prompt expression | **preserved** |
| `parameters.options` | absent | `{}` |
| `parameters.temperature` | `0.2` | **removed** (re-add in n8n UI if needed) |
| `parameters.maxTokens` | `800` | **removed** (re-add in n8n UI if needed) |

---

## 3. OpenAI - Emotional Reflection

| Field | Before (pre-patch) | After |
|-------|-------------------|-------|
| `parameters.modelId` | `"gpt-5.4-nano"` (string) | RL object (`GPT-5.4-NANO`) |
| `parameters.messages` | Direct array | `{ "values": [ ... ] }` |
| `parameters.messages.values[1].role` | `"user"` | **removed** |
| `parameters.options` | absent | `{}` |
| `parameters.temperature` | `0.2` | **removed** |
| `parameters.maxTokens` | `800` | **removed** |

**Preserved:** System and user `content` strings.

---

## 4. OpenAI - Qualification Engine

| Field | Before (pre-patch) | After |
|-------|-------------------|-------|
| `parameters.modelId` | `"gpt-5.4-mini"` (string) | RL object (`GPT-5.4-MINI`) |
| `parameters.messages` | Direct array | `{ "values": [ ... ] }` |
| `parameters.messages.values[1].role` | `"user"` | **removed** |
| `parameters.options` | absent | `{}` |
| `parameters.temperature` | `0.2` | **removed** |
| `parameters.maxTokens` | `1000` | **removed** |

**Preserved:** Classifier/emotional/flow/client expressions in user `content`.

---

## 5. GoogleSheets - keywords_master

| Field | Before (pre-patch) | After |
|-------|-------------------|-------|
| `typeVersion` | `1` | `4` |
| `parameters.sheetId` | `"1r7n5E1eU5IKK6RPkK4HHsLxorFpgs66GZQwYhI0fL_I"` | **removed** |
| `parameters.range` | `"keywords_master"` | **removed** |
| `parameters.operation` | absent | `"read"` |
| `parameters.documentId` | absent | RL object |
| `parameters.documentId.value` | — | `"1r7n5E1eU5IKK6RPkK4HHsLxorFpgs66GZQwYhI0fL_I"` |
| `parameters.documentId.mode` | — | `"list"` |
| `parameters.documentId.cachedResultName` | — | `"BrainCoach Semantic Control"` |
| `parameters.documentId.cachedResultUrl` | — | Google Sheets edit URL |
| `parameters.sheetName` | absent | RL object |
| `parameters.sheetName.cachedResultName` | — | `"keywords_master"` |
| `parameters.sheetName.value` | — | `"REPLACE_WITH_GID_keywords_master"` (set in n8n UI) |
| `parameters.options` | `{}` | `{}` |

---

## 6. GoogleSheets - qualification_flow

| Field | Before (pre-patch) | After |
|-------|-------------------|-------|
| `typeVersion` | `1` | `4` |
| `parameters.sheetId` | present | **removed** |
| `parameters.range` | `"qualification_flow"` | **removed** |
| `parameters.operation` | absent | `"read"` |
| `parameters.documentId` | absent | RL object (same spreadsheet id) |
| `parameters.sheetName.cachedResultName` | — | `"qualification_flow"` |
| `parameters.sheetName.value` | — | `"REPLACE_WITH_GID_qualification_flow"` |

---

## 7. GoogleSheets - memory_signals

| Field | Before (pre-patch) | After |
|-------|-------------------|-------|
| `typeVersion` | `1` | `4` |
| `parameters.sheetId` | present | **removed** |
| `parameters.range` | `"memory_signals"` | **removed** |
| `parameters.operation` | absent | `"read"` |
| `parameters.documentId` | absent | RL object (same spreadsheet id) |
| `parameters.sheetName.cachedResultName` | — | `"memory_signals"` |
| `parameters.sheetName.value` | — | `"REPLACE_WITH_GID_memory_signals"` |

---

## 8. IF - Client Exists?

| Field | Before (pre-patch) | After |
|-------|-------------------|-------|
| `parameters.conditions.boolean[0].value1` | Postgres exists expression | **unchanged** |
| `parameters.conditions.boolean[0].value2` | absent | `true` |
| `parameters.conditions.boolean[0].operation` | `"equal"` | **unchanged** |

---

## 9. IF - All Valid?

| Field | Before (pre-patch) | After |
|-------|-------------------|-------|
| `parameters.conditions.boolean[0].value1` | Compound valid expression | **unchanged** |
| `parameters.conditions.boolean[0].value2` | absent | `true` |
| `parameters.conditions.boolean[0].operation` | `"equal"` | **unchanged** |

---

## 10. Telegram - Send Error (Phase 5)

| Field | Before (pre-patch) | After |
|-------|-------------------|-------|
| `parameters.chatId` | Expression | **unchanged** |
| `parameters.text` | Static Russian error message | **unchanged** |
| `parameters.additionalFields` | absent | `{}` |

---

## 11. Telegram - Send Question (Phase 5)

| Field | Before (pre-patch) | After |
|-------|-------------------|-------|
| `parameters.chatId` | Expression | **unchanged** |
| `parameters.text` | `next_question` expression | **unchanged** |
| `parameters.additionalFields` | absent | `{}` |

---

## 12. Workflow settings (Phase 5)

| Field | Before (pre-patch) | After |
|-------|-------------------|-------|
| `settings` | `{}` | `{ "executionOrder": "v1" }` |

Matches production export `my-test-workflow.json`.

---

## 13. Change Count Summary

| Node / setting | Fields added | Fields removed | Fields restructured |
|----------------|--------------|----------------|---------------------|
| Telegram Trigger | 1 | 1 | 1 |
| OpenAI ×3 | 2 each | 2 each | 2 each |
| Google Sheets ×3 | 3+ each | 2 each | typeVersion |
| IF ×2 | 1 each | 0 | 0 |
| Telegram Send ×2 | 1 each | 0 | 0 |
| `settings` | 1 | 0 | 0 |

**Total nodes/settings patched:** 11 nodes + 1 workflow setting = **12 units**

---

## 14. Post-import manual steps

1. Replace `REPLACE_WITH_GID_*` in each Google Sheets `sheetName.value` via n8n spreadsheet picker (numeric gid, per production pattern).
2. Re-bind credentials: Telegram, Postgres, Google Sheets, OpenAI.
3. Re-add OpenAI `temperature` / `maxTokens` in UI if required for production behavior.
4. If `operation: "read"` fails import, export a read node from production n8n and align operation fields.
5. After first run, verify OpenAI response path (production: `.json["message"]["content"]` vs validators using `.choices[0].message.content`).

---

## 15. Verification

- [x] JSON parses successfully
- [x] Patch plan §1–§5 applied to `qualification-engine.json`
- [ ] Import into production n8n
- [ ] Resolve Google Sheets tab gids
- [ ] Manual test execution

---

## 16. Related Documents

- `braincoach-docs/qualification-import-patch-plan.md`
- `braincoach-docs/import-blocker-analysis.md`
- `workflows/reference-node-exports/my-test-workflow.json`
