CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- =====================================================
-- PERSONS
-- =====================================================

CREATE TABLE persons (
    person_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    external_id TEXT,
    source TEXT NOT NULL,

    role TEXT NOT NULL DEFAULT 'parent',

    first_name TEXT,
    last_name TEXT,

    status TEXT NOT NULL DEFAULT 'active',

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =====================================================
-- CONVERSATIONS
-- =====================================================

CREATE TABLE conversations (
    conversation_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    person_id UUID NOT NULL REFERENCES persons(person_id),

    channel TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'active',

    started_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    ended_at TIMESTAMPTZ
);

-- =====================================================
-- MESSAGES
-- =====================================================

CREATE TABLE messages (
    message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    conversation_id UUID NOT NULL
        REFERENCES conversations(conversation_id),

    role TEXT NOT NULL,
    content TEXT NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =====================================================
-- PARENT INTERVIEWS
-- =====================================================

CREATE TABLE parent_interviews (
    interview_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    person_id UUID NOT NULL REFERENCES persons(person_id),

    status TEXT NOT NULL DEFAULT 'started',

    started_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    completed_at TIMESTAMPTZ
);

-- =====================================================
-- INTERVIEW RESPONSES
-- =====================================================

CREATE TABLE interview_responses (
    response_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    interview_id UUID NOT NULL
        REFERENCES parent_interviews(interview_id),

    question_code TEXT NOT NULL,
    response_text TEXT NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =====================================================
-- OBSERVATIONS
-- =====================================================

CREATE TABLE observations (
    observation_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    person_id UUID NOT NULL REFERENCES persons(person_id),

    source_type TEXT NOT NULL,

    observation_text TEXT NOT NULL,

    confidence NUMERIC(5,2),

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =====================================================
-- TRACKER ENTRIES
-- =====================================================

CREATE TABLE tracker_entries (
    entry_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    person_id UUID REFERENCES persons(person_id),

    entry_type TEXT NOT NULL,

    content TEXT NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =====================================================
-- RESEARCH SIGNAL CANDIDATES
-- =====================================================

CREATE TABLE research_signal_candidates (
    candidate_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    observation_id UUID
        REFERENCES observations(observation_id),

    signal_name TEXT NOT NULL,

    confidence NUMERIC(5,2),

    status TEXT NOT NULL DEFAULT 'candidate',

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =====================================================
-- KNOWLEDGE ASSETS
-- =====================================================

CREATE TABLE knowledge_assets (
    asset_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    asset_type TEXT NOT NULL,

    title TEXT NOT NULL,

    content TEXT,

    status TEXT NOT NULL DEFAULT 'draft',

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =====================================================
-- DECISIONS
-- =====================================================

CREATE TABLE decisions (
    decision_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    decision_code TEXT UNIQUE NOT NULL,

    title TEXT NOT NULL,

    status TEXT NOT NULL,

    approved_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =====================================================
-- INDEXES
-- =====================================================

CREATE INDEX idx_persons_external_id
ON persons(external_id);

CREATE INDEX idx_conversations_person_id
ON conversations(person_id);

CREATE INDEX idx_messages_conversation_id
ON messages(conversation_id);

CREATE INDEX idx_parent_interviews_person_id
ON parent_interviews(person_id);

CREATE INDEX idx_interview_responses_interview_id
ON interview_responses(interview_id);

CREATE INDEX idx_observations_person_id
ON observations(person_id);

CREATE INDEX idx_tracker_entries_person_id
ON tracker_entries(person_id);

CREATE INDEX idx_signal_candidates_observation_id
ON research_signal_candidates(observation_id);

CREATE INDEX idx_knowledge_assets_type
ON knowledge_assets(asset_type);

CREATE INDEX idx_decisions_code
ON decisions(decision_code);