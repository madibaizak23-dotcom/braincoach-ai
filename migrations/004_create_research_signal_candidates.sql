CREATE TABLE IF NOT EXISTS research_signal_candidates (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    telegram_user_id BIGINT NOT NULL REFERENCES clients(telegram_user_id),
    source_observation_id UUID NOT NULL REFERENCES observations(id),
    source_entry_id UUID REFERENCES tracker_entries(id),
    signal_text TEXT NOT NULL,
    signal_type VARCHAR(80) NOT NULL DEFAULT 'unknown',
    confidence NUMERIC(4,3),
    evidence TEXT,
    status VARCHAR(40) NOT NULL DEFAULT 'candidate',
    metadata JSONB NOT NULL DEFAULT '{}'::jsonb,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT chk_research_signal_candidates_confidence
        CHECK (confidence IS NULL OR (confidence >= 0 AND confidence <= 1)),
    CONSTRAINT chk_research_signal_candidates_status
        CHECK (status IN ('candidate', 'accepted', 'rejected', 'merged', 'promoted'))
);

CREATE INDEX IF NOT EXISTS idx_research_signal_candidates_user
    ON research_signal_candidates(telegram_user_id);

CREATE INDEX IF NOT EXISTS idx_research_signal_candidates_observation
    ON research_signal_candidates(source_observation_id);

CREATE INDEX IF NOT EXISTS idx_research_signal_candidates_entry
    ON research_signal_candidates(source_entry_id);

CREATE INDEX IF NOT EXISTS idx_research_signal_candidates_status
    ON research_signal_candidates(status);

CREATE INDEX IF NOT EXISTS idx_research_signal_candidates_type
    ON research_signal_candidates(signal_type);

CREATE INDEX IF NOT EXISTS idx_research_signal_candidates_created
    ON research_signal_candidates(created_at DESC);
