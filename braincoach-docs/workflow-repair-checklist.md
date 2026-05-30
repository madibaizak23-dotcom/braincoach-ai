# Workflow Repair Checklist — `BrainCoach_qualification_engine.json`

**File:** `workflows/BrainCoach_qualification_engine.json`  
**n8n:** 1.93 · **Scope:** PostgreSQL nodes, IF nodes tied to Postgres path, SQL/expressions only  
**Reference (intended SQL):** `workflows/qualification-engine.json` (repo baseline)

---

## Root cause (execution stops early)

Import/UI migration left Postgres nodes **without executable SQL**. `Postgres - Find Client` declares `operation: executeQuery` but **`query` is empty**, so the run fails at step 2. Downstream nodes only have `table` names with no `operation`, column maps, or `query`/`values` — they cannot write state or events.

---

## 1. PostgreSQL nodes (4)

### Postgres - Find Client

| | |
|--|--|
| **Current** | `operation: "executeQuery"`, `additionalFields: {}` — **no `query`** |
| **Missing** | SQL `query`; optional `values` if using parameterized form |
| **Intended** | Load `clients` row by `telegram_user_id` from Telegram trigger |
| **Import damage** | Yes — operation preserved, query stripped |

### Postgres - Create Client

| | |
|--|--|
| **Current** | `table: "clients"`, `additionalFields: {}` only |
| **Missing** | `operation` (or `query`), all column values (`telegram_user_id`, `current_stage`, timestamps, `total_messages`) |
| **Intended** | Insert new client `current_stage = 'new_lead'` when IF false branch runs |
| **Import damage** | Yes — reduced to table picker shell |

### Postgres - Update Client

| | |
|--|--|
| **Current** | `table: "clients"`, `additionalFields: {}` only |
| **Missing** | `UPDATE` SQL, `values` array (7 expressions from validators) |
| **Intended** | Persist classifier + emotional + qualification parsed fields; bump `total_messages` |
| **Import damage** | Yes |

### Postgres - Insert Event

| | |
|--|--|
| **Current** | `table: "events"`, `additionalFields: {}` only |
| **Missing** | `INSERT` SQL, `values` array (6 expressions) |
| **Intended** | Log `stage_entered` / `qualification` with metadata JSONB |
| **Import damage** | Yes |

---

## 2. IF nodes (Postgres path)

### IF - Client Exists? (after Find Client)

| | |
|--|--|
| **Current** | `boolean[0].value1` = `={{$node["Postgres - Find Client"].json[0] !== undefined}}`, `value2: true` — **no `operation`** |
| **Missing** | `"operation": "equal"` (required on n8n IF v1 boolean rows) |
| **Intended** | True → existing client → Sheets path; False → Create Client |
| **Risk** | Without `operation`, branch routing may be undefined; expression OK **if** Find Client returns row array |

### IF - All Valid? (gates Update / Insert)

| | |
|--|--|
| **Current** | Compound `value1` on three validators, `value2: true` — **no `operation`** |
| **Missing** | `"operation": "equal"` |
| **Intended** | True → Update Client → Insert Event; False → Telegram Send Error |
| **Note** | Not wired to Postgres until true branch; still blocks completion when validators never reach IF |

---

## 3. Broken / missing expressions (Postgres-related)

| Location | Issue |
|----------|--------|
| Find Client | No query — cannot resolve `$node["Postgres - Find Client"].json[0]` reliably |
| OpenAI prompts (downstream) | `Client: {{$node["Postgres - Find Client"].json[0] \|\| $node["Postgres - Create Client"].json[0]}}` — **broken until Find/Create return rows** |
| Update / Insert | All `values` expressions absent (nodes empty) |

---

## 4. Connection note (blocks Postgres path indirectly)

`OpenAI - Intake Classifier` and `OpenAI - Emotional Reflection` have **no** edges to `Validate - Intake JSON` / `Validate - Emotional JSON` (only Qualification → Validate - Qualification JSON). `IF - All Valid?` may never see `valid: true` even after Postgres fix. **Out of strict Postgres scope** but required for end-to-end success.

---

## 5. Repair table

| Node | Problem | Exact fix |
|------|---------|-----------|
| **Postgres - Find Client** | `executeQuery` with empty `query` | Set `parameters.query` to: `SELECT * FROM clients WHERE telegram_user_id = {{$json["message"]["from"]["id"]}} LIMIT 1;` (remove stray `operation` if using legacy single-field mode, or keep `executeQuery` + `query` per n8n 1.93 UI) |
| **Postgres - Create Client** | Only `table: clients` | Set `parameters.query` to: `INSERT INTO clients (telegram_user_id, current_stage, created_at, updated_at, total_messages) VALUES ({{$json["message"]["from"]["id"]}}, 'new_lead', NOW(), NOW(), 0) RETURNING *;` |
| **IF - Client Exists?** | Missing `operation` on boolean condition | Add `"operation": "equal"` to `conditions.boolean[0]` |
| **Postgres - Update Client** | No SQL / values | Set `query` to: `UPDATE clients SET current_keyword = $1, qualification_depth = $2, emotional_state = $3, emotional_intensity = $4, interaction_type = $5, current_stage = COALESCE(NULLIF($7, ''), current_stage), total_messages = total_messages + 1, updated_at = NOW() WHERE telegram_user_id = $6 RETURNING *;` and `values` array with 7 expressions (see `qualification-engine.json` lines 319–327) |
| **Postgres - Insert Event** | No SQL / values | Set `query` to: `INSERT INTO events (telegram_user_id, event_name, event_category, old_stage, new_stage, keyword, model_used, metadata) VALUES ($1, 'stage_entered', 'qualification', $2, $3, $4, $5, $6::jsonb);` and `values` with 6 expressions (see `qualification-engine.json` lines 343–350) |
| **IF - All Valid?** | Missing `operation` | Add `"operation": "equal"` to `conditions.boolean[0]` |

---

## 6. `values` expressions (copy from baseline)

**Update Client (`values` order $1–$7):**

1. `={{$node["Validate - Intake JSON"].json[0].parsed.keyword}}`
2. `={{$node["Validate - Qualification JSON"].json[0].parsed.qualification_depth}}`
3. `={{$node["Validate - Emotional JSON"].json[0].parsed.emotional_state}}`
4. `={{$node["Validate - Emotional JSON"].json[0].parsed.emotional_intensity}}`
5. `={{$node["Validate - Intake JSON"].json[0].parsed.interaction_type}}`
6. `={{$json["message"]["from"]["id"]}}`
7. `={{$node["Validate - Qualification JSON"].json[0].parsed.next_stage}}`

**Insert Event (`values` order $1–$6):**

1. `={{$json["message"]["from"]["id"]}}`
2. `={{$node["Postgres - Find Client"].json[0] && $node["Postgres - Find Client"].json[0].current_stage \|\| null}}`
3. `={{$node["Postgres - Update Client"].json[0] && $node["Postgres - Update Client"].json[0].current_stage \|\| null}}`
4. `={{$node["Validate - Intake JSON"].json[0].parsed.keyword}}`
5. `=OpenAI:qualification`
6. `={{JSON.stringify({classifier: $node["Validate - Intake JSON"].json[0].parsed, emotional: $node["Validate - Emotional JSON"].json[0].parsed, qualification: $node["Validate - Qualification JSON"].json[0].parsed})}}`

---

## 7. Verification order

1. Fix **Find Client** query → manual run → row or empty array  
2. Fix **IF - Client Exists?** `operation` → test true/false branches  
3. Fix **Create Client** query → new user path  
4. Fix validator wiring (if needed) → **IF - All Valid?**  
5. Fix **Update Client** + **Insert Event** → full happy path  

---

## 8. Status

| Check | Result |
|-------|--------|
| Postgres SQL present | **No** (4/4 broken or empty) |
| IF `operation` present | **No** (2/2) |
| Import damage pattern | Table-only stubs replacing `query`/`values` |
| Recommended approach | Restore raw `query` + `values` from `qualification-engine.json` in n8n UI or JSON edit |
