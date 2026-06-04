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
  current_stage VARCHAR(50),          -- new_lead, q1, q2, q3, offer_transition, offer, booking_intent, booking_requested, booked, followup, sleeping, reactivated
  current_keyword VARCHAR(100),       -- память, фокус, интеллект, состояние, система, архитектура, НИШ, ЕНТ
  qualification_depth INTEGER DEFAULT 0,    -- qualification progression step
  consultation_interest BOOLEAN DEFAULT FALSE, -- user expressed interest in consultation
  emotional_state VARCHAR(50), -- calm, excited, frustrated, uncertain, resistant, hopeful, overwhelmed
  emotional_intensity INTEGER DEFAULT 0, -- emotional engagement score (0-10)
  interaction_type VARCHAR(50), -- text, voice, mixed
  total_messages INTEGER DEFAULT 0,
  allow_reminders BOOLEAN DEFAULT FALSE, -- user consented to receiving followups/reminders
  last_nudge_sent_at TIMESTAMP,        -- when the last automatic re-engagement message was sent
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  last_message_at TIMESTAMP
);

CREATE INDEX idx_clients_telegram_id ON clients(telegram_user_id);
CREATE INDEX idx_clients_current_stage ON clients(current_stage);
CREATE INDEX idx_clients_keyword ON clients(current_keyword);

Table: messages
Full conversation history.

CREATE TABLE messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  telegram_user_id BIGINT NOT NULL REFERENCES clients(telegram_user_id),
  role VARCHAR(20) NOT NULL,           -- 'user' or 'assistant'
  content TEXT NOT NULL,
  model_used VARCHAR(100),            -- Gemini Flash, GPT Nano, GPT-5.5, etc
  intent VARCHAR(100),                -- classified intent (from intake_classifier)
  confidence NUMERIC(3,2),            -- 0.00-1.00 (confidence in intent classification)
  emotional_signal VARCHAR(50),        -- calm, excited, frustrated, etc (detected in message)
  message_tokens INTEGER,              -- for cost tracking
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_messages_user_id ON messages(telegram_user_id);
CREATE INDEX idx_messages_created_at ON messages(created_at);
CREATE INDEX idx_messages_user_recent ON messages(telegram_user_id, created_at DESC);


Table: events
Audit trail of all system events.

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

Production vs Planned Architecture
Production Tables
The following tables currently exist in the production PostgreSQL database and are actively used by BrainCoach AI:

clients
messages
events
conversation_state
memory_facts
offers_and_outcomes

Planned Tables
The following tables are part of the target BrainCoach architecture and may not yet exist in the production database.

These tables represent future capabilities including:

advanced memory systems

cognitive profiling

offer analytics

personalization engines

Table: offers_sent
Track all offers sent to users.

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

Table: conversation_state
Active qualification and Scout memory layer.
CREATE TABLE conversation_state (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  telegram_user_id BIGINT NOT NULL REFERENCES clients(telegram_user_id) UNIQUE,
  current_q_number INTEGER,
  question_asked_at TIMESTAMP,
  expected_response_by TIMESTAMP,
  qualification_signals JSONB,
  pain_points JSONB,
  conversation_tone VARCHAR(50),
  sub_stage VARCHAR(50),
  pattern_type VARCHAR(50),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_conv_state_user_id ON conversation_state(telegram_user_id);

qualification_signals
Stores structured information discovered by Scout. qualification_signals is the primary working memory of Scout.

Example structure:

{
  "trigger_event": "",
  "visible_problem": "",
  "goal": "",
  "stakes": "",
  "emotional_driver": "",
  "cost_of_inaction": "",
  "past_attempts": "",
  "investment_history": "",
  "desired_state": "",
  "readiness": ""
}

sub_stage
Current Scout micro-stage:

q_surface
q_problem
q_emotion
q_stakes
q_readiness

pattern_type
Detected conversation pattern:
Possible values:
cognitive
emotional
strategic
academic
mixed

Scout Memory Layer
Current status:

Implemented and validated in Scout Memory Milestone v1.

Components:

- Scout Context Builder
- Scout Agent
- Scout Extractor
- Parse Extractor JSON
- Merge Qualification Signals
- PostgreSQL Persistence

Scout continuously:

asks questions

extracts signals

updates qualification_signals

calculates depth

selects next objective

determines readiness for Architect handoff

BrainCoach Cognitive Layer
Table: memory_items
Long-term memory extracted from conversations.
CREATE TABLE memory_items (
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

Table: user_profiles
Aggregated cognitive profile generated from memory.

CREATE TABLE user_profiles (
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

Qualification Depth

Current:

clients.qualification_depth

Future depth calculation will be based on:

- number of completed qualification_signals
- signal quality
- emotional engagement
- readiness indicators

Future:

qualification_depth should be calculated automatically from qualification_signals completeness rather than manual stage progression.

Status:

Planned for Scout Intelligence Layer.


Key Indexes & Performance
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

Views for Analytics
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

Scout Intelligence Layer (Planned)

Components:

- Depth Calculator
- Next Objective Selector
- Scout Complete Detector
- Architect Ready Transition

Purpose:

Transform Scout from memory collection into qualification intelligence.

Source of Truth Rule
PostgreSQL owns:

user state

conversation memory

stage progression

events

Google Sheets owns:

qualification logic

offers

prompts

followups

n8n owns:

orchestration

AI models own:

generation only

Business logic must never be stored inside prompts.


Теперь у вас есть полный текст документа. Сохраните его как `.md` файл — и можно приступать к работе! Есть ли еще что-то, что нужно подготовить для реализации этого плана в базе данных?


## Knowledge OS Governance Tables

Added in Knowledge OS v1.0 operationalization.

### knowledge_objects

Purpose:

Operational catalog of BrainCoach Knowledge Objects.

Source of Truth:

Knowledge Objects Registry (GitHub)

Database Role:

Operational mirror used for synchronization, governance queries, and future retrieval systems.

Implemented via:

- migrations/001_create_knowledge_objects.sql
- migrations/003_add_unique_constraint_knowledge_objects.sql

---

### decision_log

Purpose:

Operational mirror of BrainCoach Decision Log.

Source of Truth:

braincoach-docs/05_decisions/decision-log/

Database Role:

Governance persistence and future synchronization target.

Implemented via:

- migrations/002_create_decision_log.sql

---

Migration History

- 001_create_knowledge_objects.sql
- 002_create_decision_log.sql
- 003_add_unique_constraint_knowledge_objects.sql