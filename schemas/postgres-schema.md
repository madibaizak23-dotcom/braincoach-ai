# PostgreSQL Schema

Version: 1.1
Last Updated: 2026-05-29

**Database**: braincoach  
**Purpose**: Source of truth for all user state and conversation history

---

## Table: `clients`

User profiles and their current state in the system.

```sql
CREATE TABLE clients (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  telegram_user_id BIGINT UNIQUE NOT NULL,
  first_name VARCHAR(100),
  username VARCHAR(100),
  current_stage VARCHAR(50),           -- new_lead, q1, q2, q3, offer_transition, offer, booking_intent, booked, followup, sleeping, reactivated
  current_keyword VARCHAR(100), -- память, фокус, интеллект, состояние, система, архитектура, НИШ, ЕНТ
qualification_depth INTEGER DEFAULT 0,    -- qualification progression step

consultation_interest BOOLEAN DEFAULT FALSE, -- user expressed interest in consultation

emotional_state VARCHAR(50), -- calm, excited, frustrated, uncertain, resistant, hopeful, overwhelmed

emotional_intensity INTEGER DEFAULT 0, -- emotional engagement score (0-10)

interaction_type VARCHAR(50), -- text, voice, mixed

total_messages INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  last_message_at TIMESTAMP
);

CREATE INDEX idx_clients_telegram_id ON clients(telegram_user_id);
CREATE INDEX idx_clients_current_stage ON clients(current_stage);
CREATE INDEX idx_clients_keyword ON clients(current_keyword);
```

---

## Table: `messages`

Full conversation history.

```sql
CREATE TABLE messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  telegram_user_id BIGINT NOT NULL REFERENCES clients(telegram_user_id),
  role VARCHAR(20) NOT NULL,           -- 'user' or 'assistant'
  content TEXT NOT NULL,
  model_used VARCHAR(100),             -- Gemini Flash, GPT Nano, GPT-5.5, etc
  intent VARCHAR(100),                 -- classified intent (from intake_classifier)
  confidence NUMERIC(3,2),             -- 0.00-1.00 (confidence in intent classification)
  emotional_signal VARCHAR(50),        -- calm, excited, frustrated, etc (detected in message)
  message_tokens INTEGER,              -- for cost tracking
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_messages_user_id ON messages(telegram_user_id);
CREATE INDEX idx_messages_created_at ON messages(created_at);
CREATE INDEX idx_messages_user_recent ON messages(telegram_user_id, created_at DESC);
```

---

## Table: `events`

Audit trail of all system events.

```sql
CREATE TABLE events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  telegram_user_id BIGINT NOT NULL REFERENCES clients(telegram_user_id),
  event_name VARCHAR(100) NOT NULL,    -- stage_transition, offer_sent, offer_accepted, message_sent, etc
  event_category VARCHAR(50),          -- classification, qualification, offer, engagement, reactivation
  old_stage VARCHAR(50),               -- previous stage (if transition)
  new_stage VARCHAR(50),               -- new stage (if transition)
  keyword VARCHAR(100),                -- context keyword
  model_used VARCHAR(100),             -- which LLM was involved
  metadata JSONB,                      -- flexible event data
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_events_user_id ON events(telegram_user_id);
CREATE INDEX idx_events_event_name ON events(event_name);
CREATE INDEX idx_events_created_at ON events(created_at DESC);
```
---

# Production vs Planned Architecture

## Production Tables

The following tables currently exist in the production PostgreSQL database and are actively used by BrainCoach AI:

```text
clients
messages
events
memory_facts
offers_and_outcomes
```

These tables are considered production-ready and form the current operational data layer.

---

## Planned Tables

The following tables are part of the target BrainCoach architecture and may not yet exist in the production database.

They are documented here to define the future system design and implementation roadmap.

```text
offers_sent
conversation_state
memory_items
user_profiles
```

These tables represent planned capabilities including:

* advanced memory systems
* cognitive profiling
* offer analytics
* conversational context management
* personalization engines


---


## Table: `offers_sent`

Track all offers sent to users.

```sql
CREATE TABLE offers_sent (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  telegram_user_id BIGINT NOT NULL REFERENCES clients(telegram_user_id),
  offer_id VARCHAR(100) NOT NULL,     -- references offers_master sheet
  keyword VARCHAR(100),
  offer_message TEXT,
  status VARCHAR(50) DEFAULT 'pending', -- pending, accepted, rejected, expired
  response_at TIMESTAMP,
  user_response TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(telegram_user_id, offer_id)
);

CREATE INDEX idx_offers_sent_user_id ON offers_sent(telegram_user_id);
CREATE INDEX idx_offers_sent_status ON offers_sent(status);
```

---

## Table: `conversation_state`

Temporary conversation context (lives during active qualification flow).

```sql
CREATE TABLE conversation_state (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  telegram_user_id BIGINT NOT NULL REFERENCES clients(telegram_user_id) UNIQUE,
  current_q_number INTEGER,            -- which question in qualification (1, 2, 3)
  question_asked_at TIMESTAMP,
  expected_response_by TIMESTAMP,      -- timeout for response
  qualification_signals JSONB,         -- extracted signals from responses
  pain_points JSONB,                   -- array of identified pain points
  conversation_tone VARCHAR(50),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_conv_state_user_id ON conversation_state(telegram_user_id);
```

---

# BrainCoach Cognitive Layer

These tables support long-term memory, user profiling, and personalized responses.

---

## Table: `memory_items`

Long-term memory extracted from conversations.

```sql
CREATE TABLE memory_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  telegram_user_id BIGINT NOT NULL REFERENCES clients(telegram_user_id),

  memory_type VARCHAR(50) NOT NULL,
  memory_category VARCHAR(50),

  memory_content TEXT NOT NULL,

  confidence NUMERIC(3,2),

  source VARCHAR(50),                 -- intake, qualification, memory_extractor

  first_observed_at TIMESTAMP DEFAULT NOW(),
  last_confirmed_at TIMESTAMP DEFAULT NOW(),

  observation_count INTEGER DEFAULT 1,

  is_active BOOLEAN DEFAULT TRUE,

  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_memory_user
ON memory_items(telegram_user_id);

CREATE INDEX idx_memory_type
ON memory_items(memory_type);

CREATE INDEX idx_memory_active
ON memory_items(is_active);
CREATE UNIQUE INDEX idx_memory_unique
ON memory_items(
  telegram_user_id,
  memory_type,
  memory_content);
```

### Memory Types

Examples:

```text
goal
interest
challenge
strength
preference
project
habit
motivation
learning_pattern
decision_pattern
```

---

## Table: `user_profiles`

Aggregated cognitive profile generated from memory.

```sql
CREATE TABLE user_profiles (

  telegram_user_id BIGINT PRIMARY KEY
  REFERENCES clients(telegram_user_id),

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

CREATE INDEX idx_profile_decision_style
ON user_profiles(decision_style);

CREATE INDEX idx_profile_learning_style
ON user_profiles(learning_style);
CREATE INDEX idx_profile_updated
ON user_profiles(last_profile_update DESC);
```

---

## Cognitive Data Lifecycle

1. Conversation message received
2. Intake classifier analyzes context
3. Qualification engine identifies patterns
4. Memory extractor proposes memory candidates
5. Memory updater creates or updates memory_items
6. Profile builder updates user_profiles
7. Response generator uses user_profiles for personalization

---

## Example Memory Flow

User says:

```text
I want to build an AI business but keep postponing execution.
```

Memory Item:

```json
{
  "memory_type": "goal",
  "memory_content": "Build an AI business"
}
```

Memory Item:

```json
{
  "memory_type": "challenge",
  "memory_content": "Recurring procrastination during execution"
}
```

Profile Update:

```json
{
  "primary_interests": ["AI", "Business"],
  "long_term_goals": ["Build an AI business"],
  "recurring_challenges": ["procrastination"]
}
```


---

## Key Indexes & Performance

```sql
-- Fast stage transitions
CREATE INDEX idx_clients_stage_keyword ON clients(current_stage, current_keyword);

-- Fast user lookup
CREATE INDEX idx_clients_telegram_id ON clients(telegram_user_id);

-- Recent message retrieval
CREATE INDEX idx_messages_user_recent ON messages(telegram_user_id, created_at DESC);

-- Event analytics
CREATE INDEX idx_events_category_created ON events(event_category, created_at DESC);

-- Inactive user detection
CREATE INDEX idx_clients_last_message ON clients(last_message_at) 
WHERE current_stage IN ('sleeping', 'inactive');
```

---

## Views for Analytics

```sql
-- Active users in each stage
CREATE VIEW v_users_by_stage AS
SELECT 
  current_stage,
  COUNT(*) as user_count,
  AVG(qualification_depth) as avg_depth,
  COUNT(CASE WHEN updated_at > NOW() - INTERVAL '24 hours' THEN 1 END) as active_24h
FROM clients
GROUP BY current_stage;

-- Qualification funnel
CREATE VIEW v_qualification_funnel AS
SELECT 
  COUNT(CASE WHEN current_stage = 'new_lead' THEN 1 END) as new_leads,
  COUNT(CASE WHEN current_stage IN ('q1', 'q2', 'q3') THEN 1 END) as in_qualification,
  COUNT(CASE WHEN current_stage IN ('offer', 'offer_transition') THEN 1 END) as offer_shown,
  COUNT(CASE WHEN current_stage = 'booked' THEN 1 END) as booked,
  ROUND(100.0 * COUNT(CASE WHEN current_stage = 'booked' THEN 1 END) / 
    NULLIF(COUNT(CASE WHEN current_stage = 'new_lead' THEN 1 END), 0), 2) as conversion_rate
FROM clients;
```

---

## Data Lifecycle

1. **New user** → Create row in `clients`
2. **First message** → Add to `messages` + update `clients.updated_at`
3. **Stage transition** → Log in `events` + update `clients.current_stage`
4. **Offer sent** → Add to `offers_sent` + log event
5. **Inactive (30 days)** → Update `clients.current_stage = 'sleeping'`
6. **Reactivation** → Update `clients.current_stage = 'reactivated'`
7. **Booked** → Update `clients.current_stage = 'booked'` + archive conversation

---

## Backup Strategy

- **Daily snapshots**: Cloud SQL automated backups
- **Point-in-time recovery**: 35 days retention
- **Export to GCS**: Daily JSON export for audit

# Source of Truth Rule

PostgreSQL owns:

- user state
- conversation memory
- stage progression
- events

Google Sheets owns:

- qualification logic
- offers
- prompts
- followups

n8n owns:

- orchestration

AI models own:

- generation only

Business logic must never be stored inside prompts.