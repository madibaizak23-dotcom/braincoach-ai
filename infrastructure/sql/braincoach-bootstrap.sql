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