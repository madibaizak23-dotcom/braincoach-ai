CREATE TABLE conversation_events (
    event_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    conversation_id UUID NOT NULL
        REFERENCES conversations(conversation_id),
    person_id UUID NOT NULL
        REFERENCES persons(person_id),
    event_type TEXT NOT NULL,
    event_payload JSONB DEFAULT '{}'::jsonb,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_conversation_events_conversation
ON conversation_events(conversation_id);

CREATE INDEX idx_conversation_events_person
ON conversation_events(person_id);

CREATE INDEX idx_conversation_events_type
ON conversation_events(event_type);

CREATE INDEX idx_conversation_events_created
ON conversation_events(created_at DESC);

ALTER TABLE conversation_events
ADD CONSTRAINT chk_event_type
CHECK (
    event_type IN (
        'message_received',
        'conversation_created',
        'interview_started',
        'question_sent',
        'response_saved',
        'stage_changed',
        'analysis_started',
        'analysis_completed',
        'observation_created',
        'conversation_completed',
        'error'
    )
);