CREATE TABLE decision_log (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    decision_id VARCHAR(50) NOT NULL UNIQUE,

    title VARCHAR(255) NOT NULL,

    decision_date DATE NOT NULL,

    decision_text TEXT NOT NULL,

    reason TEXT,

    status VARCHAR(50) NOT NULL DEFAULT 'accepted',

    related_documents JSONB DEFAULT '[]'::jsonb,

    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_decision_log_decision_id
ON decision_log(decision_id);

CREATE INDEX idx_decision_log_status
ON decision_log(status);

CREATE INDEX idx_decision_log_date
ON decision_log(decision_date);