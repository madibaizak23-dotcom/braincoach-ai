# BrainCoach Database Bootstrap

**Status:** ACTIVE  
**Last Updated:** 2026-05-31  
**Responsibility:** Canonical PostgreSQL bootstrap for BrainCoach application data only.

---

## Purpose

This document defines the canonical SQL required to create the BrainCoach application database schema.

It owns:

- database target rules
- migration safety guardrails
- table creation order
- all BrainCoach table definitions
- indexes
- foreign keys
- analytics views
- verification queries
- database smoke tests

---

## Source Of Truth Status

This file is the canonical bootstrap document for BrainCoach PostgreSQL application tables.

Schema sources used:

- `schemas/postgres-schema.md`
- `braincoach-docs/postgres-table-inventory.md`
- `src/postgres/initDatabase.js`
- `braincoach-docs/active/canonical-workflows.md`
- `braincoach-docs/active/memory-engine-v1-design.md`
- `braincoach-docs/active/n8n-v2-status.md`

If this file conflicts with `schemas/postgres-schema.md`, verify against repository code and active workflow requirements before running migrations.

---

## Database Architecture

BrainCoach application data uses two dedicated PostgreSQL databases:

| Environment | Database | Purpose |
|---|---|---|
| Development / n8n-v2 | `braincoach_dev` | Development, workflow validation, Memory Engine v1 work |
| Production | `braincoach_prod` | Production BrainCoach application data |

Development workflows must connect to `braincoach_dev`.

Production workflows must connect to `braincoach_prod`.

---

## Forbidden Targets

Never run BrainCoach application migrations against:

- `n8n`
- `n8n_db`

Those databases are not BrainCoach application databases.

If `current_database()` returns `n8n` or `n8n_db`, stop immediately.

---

## Required Tables

The canonical bootstrap creates 9 BrainCoach tables.

| Table | Status | Source | Current usage |
|---|---|---|---|
| `clients` | Required now | `schemas/postgres-schema.md` | Intake Engine client lookup/create/update |
| `messages` | Core production data | `schemas/postgres-schema.md` | Conversation history; not yet written by stable workflow |
| `events` | Required now | `schemas/postgres-schema.md` | Intake Engine event insert |
| `memory_facts` | Production documented | table inventory / repository docs | Personalization facts; no workflow node yet |
| `offers_and_outcomes` | Production documented | table inventory / repository docs | Offer analytics; no workflow node yet |
| `offers_sent` | Planned | `schemas/postgres-schema.md` | Offer Engine future table |
| `conversation_state` | Planned | `schemas/postgres-schema.md` | Qualification context future table |
| `memory_items` | Memory Engine v1 | `schemas/postgres-schema.md`, `src/postgres/initDatabase.js` | Memory repository |
| `user_profiles` | Memory Engine v1 | `schemas/postgres-schema.md`, `src/postgres/initDatabase.js` | Profile repository |

Minimum tables required by Intake Engine v1 Stable:

- `clients`
- `events`

Full bootstrap target:

- all 9 tables

---

## Workflow Dependencies

The canonical workflow is:

```text
workflows/reference-node-exports/intake-engine-v1-stable.json
```

PostgreSQL tables used by the stable workflow:

| Workflow node | SQL operation | Table |
|---|---|---|
| `Postgres - Find Client` | `SELECT` | `clients` |
| `Postgres - Create Client` | `INSERT` | `clients` |
| `Postgres - Update Client` | `UPDATE` | `clients` |
| `Postgres - Insert Event` | `INSERT` | `events` |

Memory Engine v1 repository code uses:

| Repository | Tables |
|---|---|
| `src/postgres/memoryRepository.js` | `memory_items` |
| `src/postgres/profileRepository.js` | `user_profiles` |
| `src/postgres/initDatabase.js` | creates only `memory_items` and `user_profiles` |

`src/postgres/initDatabase.js` is not a full BrainCoach bootstrap. It does not create `clients`, `messages`, `events`, `memory_facts`, `offers_and_outcomes`, `offers_sent`, or `conversation_state`.

---

## Execution Order

Foreign keys require `clients` first.

```text
1. Create target database if needed
2. Connect to target database
3. Run guardrail query
4. CREATE EXTENSION pgcrypto
5. clients
6. messages
7. events
8. memory_facts
9. offers_and_outcomes
10. offers_sent
11. conversation_state
12. memory_items
13. user_profiles
14. indexes
15. analytics views
16. verification queries
17. smoke test
```

---

## Pre-flight Database Creation

Run only from a PostgreSQL admin connection.

### Development

```sql
CREATE DATABASE braincoach_dev
  ENCODING 'UTF8'
  LC_COLLATE 'en_US.UTF-8'
  LC_CTYPE 'en_US.UTF-8'
  TEMPLATE template0;
```

### Production

```sql
CREATE DATABASE braincoach_prod
  ENCODING 'UTF8'
  LC_COLLATE 'en_US.UTF-8'
  LC_CTYPE 'en_US.UTF-8'
  TEMPLATE template0;
```

---

## Connect To Target Database

### Development

```sql
\c braincoach_dev
```

### Production

```sql
\c braincoach_prod
```

---

## Safety Guardrails

Run before executing the bootstrap SQL.

```sql
SELECT current_database();
```

Allowed results:

- `braincoach_dev`
- `braincoach_prod`

Forbidden results:

- `n8n`
- `n8n_db`

Stop immediately if the connected database is not an allowed target.

For today's n8n-v2 development workflow, the expected target is:

```text
braincoach_dev
```

---

## Bootstrap SQL

Run this script only after connecting to `braincoach_dev` or `braincoach_prod`.

```sql
-- ============================================================
-- BrainCoach AI bootstrap migration
-- Target database: braincoach_dev or braincoach_prod
-- Forbidden targets: n8n, n8n_db
-- ============================================================

CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- ------------------------------------------------------------
-- 1. clients
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS clients (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  telegram_user_id BIGINT UNIQUE NOT NULL,
  first_name VARCHAR(100),
  username VARCHAR(100),
  current_stage VARCHAR(50),
  current_keyword VARCHAR(100),
  qualification_depth INTEGER DEFAULT 0,
  consultation_interest BOOLEAN DEFAULT FALSE,
  emotional_state VARCHAR(50),
  emotional_intensity INTEGER DEFAULT 0,
  interaction_type VARCHAR(50),
  total_messages INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  last_message_at TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_clients_telegram_id ON clients(telegram_user_id);
CREATE INDEX IF NOT EXISTS idx_clients_current_stage ON clients(current_stage);
CREATE INDEX IF NOT EXISTS idx_clients_keyword ON clients(current_keyword);
CREATE INDEX IF NOT EXISTS idx_clients_stage_keyword ON clients(current_stage, current_keyword);
CREATE INDEX IF NOT EXISTS idx_clients_last_message ON clients(last_message_at)
  WHERE current_stage IN ('sleeping', 'inactive');

-- ------------------------------------------------------------
-- 2. messages
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  telegram_user_id BIGINT NOT NULL REFERENCES clients(telegram_user_id),
  role VARCHAR(20) NOT NULL,
  content TEXT NOT NULL,
  model_used VARCHAR(100),
  intent VARCHAR(100),
  confidence NUMERIC(3,2),
  emotional_signal VARCHAR(50),
  message_tokens INTEGER,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_messages_user_id ON messages(telegram_user_id);
CREATE INDEX IF NOT EXISTS idx_messages_created_at ON messages(created_at);
CREATE INDEX IF NOT EXISTS idx_messages_user_recent ON messages(telegram_user_id, created_at DESC);

-- ------------------------------------------------------------
-- 3. events
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  telegram_user_id BIGINT NOT NULL REFERENCES clients(telegram_user_id),
  event_name VARCHAR(100) NOT NULL,
  event_category VARCHAR(50),
  old_stage VARCHAR(50),
  new_stage VARCHAR(50),
  keyword VARCHAR(100),
  model_used VARCHAR(100),
  metadata JSONB,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_events_user_id ON events(telegram_user_id);
CREATE INDEX IF NOT EXISTS idx_events_event_name ON events(event_name);
CREATE INDEX IF NOT EXISTS idx_events_created_at ON events(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_events_category_created ON events(event_category, created_at DESC);

-- ------------------------------------------------------------
-- 4. memory_facts
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS memory_facts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  telegram_user_id BIGINT NOT NULL REFERENCES clients(telegram_user_id),
  signal_type VARCHAR(100) NOT NULL,
  meaning TEXT,
  severity VARCHAR(50),
  recommended_action TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_memory_facts_user ON memory_facts(telegram_user_id);
CREATE INDEX IF NOT EXISTS idx_memory_facts_signal ON memory_facts(signal_type);

-- ------------------------------------------------------------
-- 5. offers_and_outcomes
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS offers_and_outcomes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  telegram_user_id BIGINT NOT NULL REFERENCES clients(telegram_user_id),
  offers TEXT,
  responses TEXT,
  outcomes TEXT,
  conversion_signals TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_offers_outcomes_user ON offers_and_outcomes(telegram_user_id);

-- ------------------------------------------------------------
-- 6. offers_sent
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS offers_sent (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  telegram_user_id BIGINT NOT NULL REFERENCES clients(telegram_user_id),
  offer_id VARCHAR(100) NOT NULL,
  keyword VARCHAR(100),
  offer_message TEXT,
  status VARCHAR(50) DEFAULT 'pending',
  response_at TIMESTAMP,
  user_response TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(telegram_user_id, offer_id)
);

CREATE INDEX IF NOT EXISTS idx_offers_sent_user_id ON offers_sent(telegram_user_id);
CREATE INDEX IF NOT EXISTS idx_offers_sent_status ON offers_sent(status);

-- ------------------------------------------------------------
-- 7. conversation_state
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS conversation_state (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  telegram_user_id BIGINT NOT NULL REFERENCES clients(telegram_user_id) UNIQUE,
  current_q_number INTEGER,
  question_asked_at TIMESTAMP,
  expected_response_by TIMESTAMP,
  qualification_signals JSONB,
  pain_points JSONB,
  conversation_tone VARCHAR(50),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_conv_state_user_id ON conversation_state(telegram_user_id);

-- ------------------------------------------------------------
-- 8. memory_items
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS memory_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  telegram_user_id BIGINT NOT NULL REFERENCES clients(telegram_user_id),
  memory_type VARCHAR(50) NOT NULL,
  memory_category VARCHAR(50),
  memory_content TEXT NOT NULL,
  confidence NUMERIC(3,2),
  source VARCHAR(50),
  first_observed_at TIMESTAMP DEFAULT NOW(),
  last_confirmed_at TIMESTAMP DEFAULT NOW(),
  observation_count INTEGER DEFAULT 1,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_memory_user ON memory_items(telegram_user_id);
CREATE INDEX IF NOT EXISTS idx_memory_type ON memory_items(memory_type);
CREATE INDEX IF NOT EXISTS idx_memory_active ON memory_items(is_active);
CREATE UNIQUE INDEX IF NOT EXISTS idx_memory_unique ON memory_items(
  telegram_user_id,
  memory_type,
  memory_content
);

-- ------------------------------------------------------------
-- 9. user_profiles
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS user_profiles (
  telegram_user_id BIGINT PRIMARY KEY REFERENCES clients(telegram_user_id),
  profile_version INTEGER DEFAULT 1,
  primary_interests JSONB,
  long_term_goals JSONB,
  decision_style VARCHAR(50),
  learning_style VARCHAR(50),
  motivation_drivers JSONB,
  strengths JSONB,
  recurring_challenges JSONB,
  preferred_response_style VARCHAR(50),
  profile_confidence NUMERIC(3,2),
  last_profile_update TIMESTAMP DEFAULT NOW(),
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_profile_decision_style ON user_profiles(decision_style);
CREATE INDEX IF NOT EXISTS idx_profile_learning_style ON user_profiles(learning_style);
CREATE INDEX IF NOT EXISTS idx_profile_updated ON user_profiles(last_profile_update DESC);
```

---

## Analytics Views

Run after all tables exist.

```sql
CREATE OR REPLACE VIEW v_users_by_stage AS
SELECT
  current_stage,
  COUNT(*) AS user_count,
  AVG(qualification_depth) AS avg_depth,
  COUNT(CASE WHEN updated_at > NOW() - INTERVAL '24 hours' THEN 1 END) AS active_24h
FROM clients
GROUP BY current_stage;

CREATE OR REPLACE VIEW v_qualification_funnel AS
SELECT
  COUNT(CASE WHEN current_stage = 'new_lead' THEN 1 END) AS new_leads,
  COUNT(CASE WHEN current_stage IN ('q1', 'q2', 'q3') THEN 1 END) AS in_qualification,
  COUNT(CASE WHEN current_stage IN ('offer', 'offer_transition') THEN 1 END) AS offer_shown,
  COUNT(CASE WHEN current_stage = 'booked' THEN 1 END) AS booked,
  ROUND(100.0 * COUNT(CASE WHEN current_stage = 'booked' THEN 1 END) /
    NULLIF(COUNT(CASE WHEN current_stage = 'new_lead' THEN 1 END), 0), 2) AS conversion_rate
FROM clients;
```

---

## Verification Queries

Run all verification queries on the target database after bootstrap.

### Confirm Target Database

```sql
SELECT current_database();
```

Expected:

- `braincoach_dev`
- `braincoach_prod`

Forbidden:

- `n8n`
- `n8n_db`

### Confirm Extension

```sql
SELECT extname
FROM pg_extension
WHERE extname = 'pgcrypto';
```

Expected:

```text
pgcrypto
```

### Confirm Tables

```sql
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_type = 'BASE TABLE'
  AND table_name IN (
    'clients',
    'messages',
    'events',
    'memory_facts',
    'offers_and_outcomes',
    'offers_sent',
    'conversation_state',
    'memory_items',
    'user_profiles'
  )
ORDER BY table_name;
```

Expected: 9 rows.

Expected table names:

```text
clients
conversation_state
events
memory_facts
memory_items
messages
offers_and_outcomes
offers_sent
user_profiles
```

### Confirm Indexes

```sql
SELECT indexname
FROM pg_indexes
WHERE schemaname = 'public'
  AND indexname IN (
    'idx_clients_telegram_id',
    'idx_clients_current_stage',
    'idx_clients_keyword',
    'idx_clients_stage_keyword',
    'idx_clients_last_message',
    'idx_messages_user_id',
    'idx_messages_created_at',
    'idx_messages_user_recent',
    'idx_events_user_id',
    'idx_events_event_name',
    'idx_events_created_at',
    'idx_events_category_created',
    'idx_memory_facts_user',
    'idx_memory_facts_signal',
    'idx_offers_outcomes_user',
    'idx_offers_sent_user_id',
    'idx_offers_sent_status',
    'idx_conv_state_user_id',
    'idx_memory_user',
    'idx_memory_type',
    'idx_memory_active',
    'idx_memory_unique',
    'idx_profile_decision_style',
    'idx_profile_learning_style',
    'idx_profile_updated'
  )
ORDER BY indexname;
```

Expected: 25 rows.

### Confirm Foreign Keys

```sql
SELECT
  tc.table_name,
  kcu.column_name,
  ccu.table_name AS foreign_table_name,
  ccu.column_name AS foreign_column_name
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
  ON tc.constraint_name = kcu.constraint_name
 AND tc.table_schema = kcu.table_schema
JOIN information_schema.constraint_column_usage AS ccu
  ON ccu.constraint_name = tc.constraint_name
 AND ccu.table_schema = tc.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY'
  AND tc.table_schema = 'public'
ORDER BY tc.table_name, kcu.column_name;
```

Expected foreign-key child tables:

```text
conversation_state
events
memory_facts
memory_items
messages
offers_and_outcomes
offers_sent
user_profiles
```

All foreign keys should reference:

```text
clients.telegram_user_id
```

### Confirm Views

```sql
SELECT table_name
FROM information_schema.views
WHERE table_schema = 'public'
  AND table_name IN (
    'v_users_by_stage',
    'v_qualification_funnel'
  )
ORDER BY table_name;
```

Expected: 2 rows.

Expected view names:

```text
v_qualification_funnel
v_users_by_stage
```

---

## Smoke Tests

Run smoke tests in `braincoach_dev` first.

Do not run production smoke tests against `braincoach_prod` unless explicitly approved.

### Smoke Test 1: Client Insert

```sql
INSERT INTO clients (
  telegram_user_id,
  first_name,
  username,
  current_stage,
  current_keyword,
  total_messages
)
VALUES (
  999999001,
  'bootstrap_test',
  'bootstrap_test_user',
  'new_lead',
  'test',
  0
)
ON CONFLICT (telegram_user_id) DO NOTHING;

SELECT *
FROM clients
WHERE telegram_user_id = 999999001;
```

Expected:

- 1 row returned from `clients`
- `current_stage = 'new_lead'`

### Smoke Test 2: Event Insert

```sql
INSERT INTO events (
  telegram_user_id,
  event_name,
  event_category,
  old_stage,
  new_stage,
  keyword,
  model_used,
  metadata
)
VALUES (
  999999001,
  'bootstrap_smoke_test',
  'database',
  NULL,
  'new_lead',
  'test',
  'manual',
  '{"source":"bootstrap"}'::jsonb
)
RETURNING *;
```

Expected:

- 1 row returned from `events`
- `telegram_user_id = 999999001`

### Smoke Test 3: Memory Insert

```sql
INSERT INTO memory_items (
  telegram_user_id,
  memory_type,
  memory_category,
  memory_content,
  confidence,
  source
)
VALUES (
  999999001,
  'goal',
  'test',
  'Bootstrap smoke test memory',
  0.80,
  'bootstrap'
)
ON CONFLICT (telegram_user_id, memory_type, memory_content) DO NOTHING
RETURNING *;
```

Expected:

- 0 or 1 row returned depending on whether the smoke test was already run
- no uncontrolled duplicate rows

### Smoke Test 4: Profile Insert

```sql
INSERT INTO user_profiles (
  telegram_user_id,
  primary_interests,
  long_term_goals,
  profile_confidence
)
VALUES (
  999999001,
  '["bootstrap"]'::jsonb,
  '["verify database"]'::jsonb,
  0.50
)
ON CONFLICT (telegram_user_id) DO NOTHING
RETURNING *;
```

Expected:

- 0 or 1 row returned depending on whether the smoke test was already run
- no primary-key conflict error

### Smoke Test 5: Analytics Views

```sql
SELECT *
FROM v_users_by_stage
WHERE current_stage = 'new_lead';

SELECT *
FROM v_qualification_funnel;
```

Expected:

- both queries execute without error

### Smoke Test Cleanup

Run only after smoke tests complete.

```sql
DELETE FROM user_profiles
WHERE telegram_user_id = 999999001;

DELETE FROM memory_items
WHERE telegram_user_id = 999999001;

DELETE FROM events
WHERE telegram_user_id = 999999001;

DELETE FROM clients
WHERE telegram_user_id = 999999001;
```

Expected:

- smoke-test records removed
- no production user data affected

---

## Production Safety Notes

For development implementation sessions:

- use `braincoach_dev`
- do not modify `braincoach_prod`
- do not modify `n8n`
- do not modify `n8n_db`

For production bootstrap or migration:

- require explicit production approval
- verify current database before every migration
- run verification queries before enabling workflows
- run smoke tests only with an approved production test user

---

## Completion Criteria

Database bootstrap is complete when:

1. `current_database()` returns the intended target.
2. `pgcrypto` exists.
3. All 9 BrainCoach tables exist.
4. All expected indexes exist.
5. All child tables have foreign keys to `clients.telegram_user_id`.
6. Both analytics views exist.
7. Smoke test inserts, reads, view queries, and cleanup pass.
8. The canonical workflow can access `clients` and `events`.
