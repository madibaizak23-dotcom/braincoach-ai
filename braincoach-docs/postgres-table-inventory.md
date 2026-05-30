# PostgreSQL Table Inventory — BrainCoach AI

Last Updated: 2026-05-30

**Sources searched:** `schemas/`, `src/`, `memory/`, `architecture/`, `workflows/`, `README.md`

**Database name (documented):** `braincoach`

**Workflow reference:** Only `workflows/qualification-engine.json` contains live Postgres nodes today. Stub workflows (`offer-engine.json`, `reactivation-engine.json`, `voice-intake.json`) have no Postgres nodes. Duplicate exports `qualification-engine-v4.json` / `qualification-engine-v6.json` mirror the same SQL.

---

## Summary

| Status | Count | Tables |
|--------|-------|--------|
| **Production (documented)** | 5 | `clients`, `messages`, `events`, `memory_facts`, `offers_and_outcomes` |
| **Planned (DDL in schema, not production)** | 4 | `offers_sent`, `conversation_state`, `memory_items`, `user_profiles` |
| **Used in n8n today** | 2 | `clients`, `events` |
| **Used in Node.js (`src/postgres/`)** | 2 | `memory_items`, `user_profiles` |

---

## Production tables

Per `schemas/postgres-schema.md` § Production vs Planned — these exist in production PostgreSQL and are the operational data layer.

### `clients`

| Attribute | Detail |
|-----------|--------|
| **Purpose** | Source of truth for user identity and funnel state: Telegram id, stage (`new_lead` → `booked`, etc.), keyword, qualification depth, emotional fields, message counters, timestamps. |
| **Definition** | `schemas/postgres-schema.md` (full `CREATE TABLE`) |
| **Also described in** | `README.md`, `architecture/infrastructure-source-of-truth.md`, `schemas/stage-map.md`, `schemas/events-taxonomy.md` |
| **Workflow nodes** (`qualification-engine.json`) | |
| | **Postgres - Find Client** — `SELECT * FROM clients WHERE telegram_user_id = …` |
| | **Postgres - Create Client** — `INSERT INTO clients` (`new_lead`, `total_messages = 0`) |
| | **Postgres - Update Client** — `UPDATE clients` (keyword, depth, emotional fields, stage, `total_messages`) |
| **Other references** | OpenAI / IF / Telegram nodes read client state via expressions (e.g. `$node["Postgres - Find Client"]`) but do not execute SQL |

---

### `messages`

| Attribute | Detail |
|-----------|--------|
| **Purpose** | Full conversation history: user/assistant turns, model used, intent, confidence, emotional signal, token counts. |
| **Definition** | `schemas/postgres-schema.md` (full `CREATE TABLE`) |
| **Also described in** | `README.md`, `architecture/conversational-memory-layer.md` (save after response) |
| **Workflow nodes** | **None** in committed workflows |
| **Planned usage (docs/prompts)** | `prompts/response/qualification_conversation.md`, `prompts/offer/offer_generator.md` — save assistant/user text; `voice-intake.json` (stub) implied |

---

### `events`

| Attribute | Detail |
|-----------|--------|
| **Purpose** | Audit trail and analytics: stage transitions, qualification milestones, offers, booking, reactivation. Flexible `metadata` JSONB. |
| **Definition** | `schemas/postgres-schema.md` (full `CREATE TABLE`) |
| **Also described in** | `schemas/events-taxonomy.md`, `README.md`, `architecture/infrastructure-source-of-truth.md` |
| **Workflow nodes** (`qualification-engine.json`) | |
| | **Postgres - Insert Event** — `INSERT INTO events` (`event_name = 'stage_entered'`, `event_category = 'qualification'`, old/new stage, keyword, model, metadata) |
| **Other references** | Funnel SQL examples in `schemas/events-taxonomy.md` (analytics queries, not n8n nodes) |

---

### `memory_facts`

| Attribute | Detail |
|-----------|--------|
| **Purpose** | Long-term behavioral personalization: `signal_type`, `meaning`, `severity`, `recommended_action` (aligned with Google Sheets `memory_signals` semantic layer). |
| **Definition** | Listed as production in `schemas/postgres-schema.md`; field list in `README.md` — **no `CREATE TABLE` in repository** |
| **Workflow nodes** | **None** |
| **Note** | Distinct from table `memory_items` (planned cognitive layer). Intake classifier JSON field `memory_items` in prompts is an LLM output shape, not this table. |

---

### `offers_and_outcomes`

| Attribute | Detail |
|-----------|--------|
| **Purpose** | Offer analytics: offers shown, user responses, outcomes, conversion signals. |
| **Definition** | Listed as production in `schemas/postgres-schema.md`; field list in `README.md` — **no `CREATE TABLE` in repository** |
| **Workflow nodes** | **None** (`offer-engine.json` is empty stub) |
| **Planned usage** | `braincoach-docs/workflow-inventory.md`, offer/booking architecture reviews |

---

## Planned tables

Per `schemas/postgres-schema.md` § Planned — target architecture; may not exist in production DB yet.

### `offers_sent`

| Attribute | Detail |
|-----------|--------|
| **Purpose** | Per-offer send tracking: offer id, keyword, message text, status (`pending` / `accepted` / `rejected`), user response, timestamps. |
| **Definition** | `schemas/postgres-schema.md` (full `CREATE TABLE`) |
| **Workflow nodes** | **None** (planned for `offer-engine.json`) |
| **Documented triggers** | `schemas/stage-map.md`, `schemas/events-taxonomy.md`, data lifecycle in `postgres-schema.md` |

---

### `conversation_state`

| Attribute | Detail |
|-----------|--------|
| **Purpose** | Short-lived qualification session context: current question number, timeouts, qualification signals, pain points JSONB, tone. |
| **Definition** | `schemas/postgres-schema.md` (full `CREATE TABLE`) |
| **Workflow nodes** | **None** |
| **Architecture** | Complements `clients.current_stage` for in-flow state |

---

### `memory_items`

| Attribute | Detail |
|-----------|--------|
| **Purpose** | Long-term extracted memories (goals, challenges, preferences, etc.) with confidence, source, observation count, active flag. |
| **Definition** | `schemas/postgres-schema.md` (full `CREATE TABLE`); created by `src/postgres/initDatabase.js` |
| **Workflow nodes** | **None** |
| **Application code** | `src/postgres/memoryRepository.js` — `INSERT`, `SELECT`, `UPDATE` on `memory_items` |
| **Prompts** | `prompts/memory/memory_extractor.md`, `memory_updater.md`, `memory_retriever.md` |

---

### `user_profiles`

| Attribute | Detail |
|-----------|--------|
| **Purpose** | Aggregated cognitive profile per user: interests, goals, decision/learning style, motivation, strengths, challenges, response style preference. |
| **Definition** | `schemas/postgres-schema.md` (full `CREATE TABLE`); created by `src/postgres/initDatabase.js` |
| **Workflow nodes** | **None** |
| **Application code** | `src/postgres/profileRepository.js` — `SELECT`, `INSERT`, `UPDATE` on `user_profiles` |
| **Prompts** | `prompts/memory/profile_builder.md` |

---

## Workflow ↔ table matrix

| Workflow file | Postgres nodes | Tables touched |
|---------------|----------------|----------------|
| `qualification-engine.json` | Postgres - Find Client | `clients` (read) |
| | Postgres - Create Client | `clients` (insert) |
| | Postgres - Update Client | `clients` (update) |
| | Postgres - Insert Event | `events` (insert) |
| `offer-engine.json` | — | — (stub, 0 nodes) |
| `reactivation-engine.json` | — | — (stub) |
| `voice-intake.json` | — | — (stub) |
| `reference-node-exports/my-test-workflow.json` | — | — (no Postgres) |

---

## `memory/` directory

Placeholder files only (`clients.md`, `events.md`, `messages.md`, `memory_facts.md`) — **empty**, no DDL. Table purposes for those names are defined in `schemas/postgres-schema.md` and `README.md`.

---

## `architecture/` directory

| File | PostgreSQL mention |
|------|-------------------|
| `infrastructure-source-of-truth.md` | PostgreSQL owns user profiles, history, qualification, offers, events |
| `conversational-memory-layer.md` | Level 2 historical memory in PostgreSQL; load/save message history (no table names in DDL) |
| `system-context.md` | PostgreSQL as system component |
| `secure-console-policy.md` | Console access to logs and events |

No additional table names beyond the schema doc.

---

## Analytics views (not tables)

`schemas/postgres-schema.md` documents SQL **views** (not application tables):

- `v_users_by_stage` — reads `clients`
- `v_qualification_funnel` — reads `clients`

---

## Cognitive data lifecycle (cross-table)

From `schemas/postgres-schema.md`:

```text
messages → memory_items → user_profiles
         ↘ events
clients (state hub)
offers_sent / offers_and_outcomes (offer path)
```

---

## Gaps and inconsistencies

| Issue | Detail |
|-------|--------|
| `memory_facts` vs `memory_items` | Both documented; only `memory_items` has repo DDL + `src/` code |
| `offers_sent` vs `offers_and_outcomes` | Production list includes `offers_and_outcomes`; schema also defines `offers_sent` as planned |
| `messages` | Full DDL exists; no workflow or `src/` repository yet |
| `initDatabase.js` | Only creates `memory_items` and `user_profiles` — not `clients` / `messages` / `events` |

---

## Related documents

- `schemas/postgres-schema.md` — authoritative DDL and production/planned split
- `schemas/events-taxonomy.md` — event types written to `events`
- `schemas/stage-map.md` — stages stored on `clients`
- `braincoach-docs/workflow-inventory.md` — workflow readiness
