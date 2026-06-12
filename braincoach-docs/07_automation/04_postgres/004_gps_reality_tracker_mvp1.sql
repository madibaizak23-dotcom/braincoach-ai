-- 004_gps_reality_tracker_mvp1.sql
-- Status: FINAL SQL FOR REVIEW - DO NOT APPLY WITHOUT EXPLICIT APPROVAL.
-- Target database: bgs_core
-- Scope: BrainCoach GPS Daily Tracker MVP-1 Reality Tracker tables only.
--
-- Includes:
-- - trajectory_domains
-- - trajectories
-- - person_roles
-- - activity_types
-- - activity_events
-- - activity_confirmations
-- - trajectory_entries
--
-- Excludes:
-- - trajectory_matrix_snapshots
-- - gps_reports
--
-- Safety:
-- - Uses existing persons(person_id).
-- - References existing tracker_entries(entry_id) and observations(observation_id).
-- - Does not alter or drop existing tables.
-- - Does not touch conversation_events or Conversation Engine tables.

BEGIN;

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- =====================================================
-- LOOKUP: TRAJECTORY DOMAINS
-- =====================================================

CREATE TABLE IF NOT EXISTS trajectory_domains (
    domain_code TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

INSERT INTO trajectory_domains (domain_code, title)
VALUES
    ('sport', 'Sport'),
    ('career', 'Career'),
    ('education', 'Education'),
    ('relationships', 'Relationships'),
    ('self_learning', 'Self Learning'),
    ('health', 'Health'),
    ('family', 'Family')
ON CONFLICT (domain_code) DO NOTHING;

-- =====================================================
-- TRAJECTORIES
-- =====================================================

CREATE TABLE IF NOT EXISTS trajectories (
    trajectory_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    person_id UUID NOT NULL
        REFERENCES persons(person_id),

    domain_code TEXT NOT NULL
        REFERENCES trajectory_domains(domain_code),

    title TEXT NOT NULL,

    desired_state TEXT,
    current_state TEXT,

    status TEXT NOT NULL DEFAULT 'active',

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_trajectories_status
        CHECK (status IN ('draft', 'active', 'paused', 'completed', 'archived'))
);

CREATE INDEX IF NOT EXISTS idx_trajectories_person
ON trajectories(person_id);

CREATE INDEX IF NOT EXISTS idx_trajectories_domain
ON trajectories(domain_code);

CREATE INDEX IF NOT EXISTS idx_trajectories_status
ON trajectories(status);

-- =====================================================
-- PERSON ROLES
-- =====================================================

CREATE TABLE IF NOT EXISTS person_roles (
    role_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    person_id UUID NOT NULL
        REFERENCES persons(person_id),

    trajectory_id UUID
        REFERENCES trajectories(trajectory_id),

    role_type TEXT NOT NULL,
    context TEXT,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_person_roles_role_type
        CHECK (role_type IN (
            'athlete',
            'parent',
            'coach',
            'teacher',
            'student',
            'developer',
            'mentor'
        ))
);

CREATE INDEX IF NOT EXISTS idx_person_roles_person
ON person_roles(person_id);

CREATE INDEX IF NOT EXISTS idx_person_roles_trajectory
ON person_roles(trajectory_id);

CREATE INDEX IF NOT EXISTS idx_person_roles_type
ON person_roles(role_type);

-- =====================================================
-- LOOKUP: ACTIVITY TYPES
-- =====================================================

CREATE TABLE IF NOT EXISTS activity_types (
    activity_type_code TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

INSERT INTO activity_types (activity_type_code, title)
VALUES
    ('ice', 'Ice'),
    ('second_ice', 'Second Ice'),
    ('dribbling', 'Dribbling'),
    ('english', 'English'),
    ('physmath', 'Physics / Math'),
    ('gym', 'Gym'),
    ('recovery', 'Recovery'),
    ('nutrition', 'Nutrition'),
    ('sleep', 'Sleep'),
    ('study', 'Study'),
    ('other', 'Other')
ON CONFLICT (activity_type_code) DO NOTHING;

-- =====================================================
-- REALITY TRACKER: ACTIVITY EVENTS
-- =====================================================

CREATE TABLE IF NOT EXISTS activity_events (
    activity_event_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    trajectory_id UUID NOT NULL
        REFERENCES trajectories(trajectory_id),

    person_id UUID NOT NULL
        REFERENCES persons(person_id),

    activity_type_code TEXT NOT NULL
        REFERENCES activity_types(activity_type_code),

    started_at TIMESTAMPTZ,
    ended_at TIMESTAMPTZ,

    duration_minutes INTEGER,

    status TEXT NOT NULL DEFAULT 'completed',

    notes TEXT,
    source TEXT NOT NULL DEFAULT 'manual',

    created_by_person_id UUID
        REFERENCES persons(person_id),

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_activity_events_time_order
        CHECK (ended_at IS NULL OR started_at IS NULL OR ended_at >= started_at),

    CONSTRAINT chk_activity_events_duration
        CHECK (duration_minutes IS NULL OR duration_minutes >= 0),

    CONSTRAINT chk_activity_events_status
        CHECK (status IN ('planned', 'completed', 'missed', 'cancelled'))
);

CREATE INDEX IF NOT EXISTS idx_activity_events_trajectory
ON activity_events(trajectory_id);

CREATE INDEX IF NOT EXISTS idx_activity_events_person
ON activity_events(person_id);

CREATE INDEX IF NOT EXISTS idx_activity_events_type
ON activity_events(activity_type_code);

CREATE INDEX IF NOT EXISTS idx_activity_events_status
ON activity_events(status);

CREATE INDEX IF NOT EXISTS idx_activity_events_started
ON activity_events(started_at DESC);

CREATE INDEX IF NOT EXISTS idx_activity_events_created
ON activity_events(created_at DESC);

-- =====================================================
-- REALITY TRACKER: ACTIVITY CONFIRMATIONS
-- =====================================================

CREATE TABLE IF NOT EXISTS activity_confirmations (
    confirmation_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    activity_event_id UUID NOT NULL
        REFERENCES activity_events(activity_event_id)
        ON DELETE CASCADE,

    confirmed_by_person_id UUID
        REFERENCES persons(person_id),

    role_type TEXT NOT NULL,
    confirmation_source TEXT NOT NULL,

    status TEXT NOT NULL DEFAULT 'confirmed',

    notes TEXT,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_activity_confirmations_role_type
        CHECK (role_type IN (
            'athlete',
            'parent',
            'coach',
            'teacher',
            'student',
            'developer',
            'mentor'
        )),

    CONSTRAINT chk_activity_confirmations_source
        CHECK (confirmation_source IN (
            'telegram_bot',
            'google_sheet',
            'athlete_telegram',
            'coach_google_sheet',
            'parent_telegram',
            'manual',
            'web',
            'api'
        )),

    CONSTRAINT chk_activity_confirmations_status
        CHECK (status IN ('confirmed', 'corrected', 'disputed'))
);

CREATE INDEX IF NOT EXISTS idx_activity_confirmations_event
ON activity_confirmations(activity_event_id);

CREATE INDEX IF NOT EXISTS idx_activity_confirmations_person
ON activity_confirmations(confirmed_by_person_id);

CREATE INDEX IF NOT EXISTS idx_activity_confirmations_status
ON activity_confirmations(status);

-- =====================================================
-- REALITY TRACKER: TRAJECTORY ENTRIES
-- =====================================================

CREATE TABLE IF NOT EXISTS trajectory_entries (
    entry_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    trajectory_id UUID NOT NULL
        REFERENCES trajectories(trajectory_id),

    person_id UUID NOT NULL
        REFERENCES persons(person_id),

    tracker_entry_id UUID
        REFERENCES tracker_entries(entry_id),

    observation_id UUID
        REFERENCES observations(observation_id),

    entry_type TEXT NOT NULL,

    content TEXT NOT NULL,
    source TEXT NOT NULL DEFAULT 'manual',

    created_by_person_id UUID
        REFERENCES persons(person_id),

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_trajectory_entries_type
        CHECK (entry_type IN (
            'general_note',
            'observation',
            'reflection',
            'feeling',
            'insight',
            'nutrition',
            'photo_note',
            'coach_note',
            'parent_note'
        ))
);

CREATE INDEX IF NOT EXISTS idx_trajectory_entries_trajectory
ON trajectory_entries(trajectory_id);

CREATE INDEX IF NOT EXISTS idx_trajectory_entries_person
ON trajectory_entries(person_id);

CREATE INDEX IF NOT EXISTS idx_trajectory_entries_tracker_entry
ON trajectory_entries(tracker_entry_id);

CREATE INDEX IF NOT EXISTS idx_trajectory_entries_observation
ON trajectory_entries(observation_id);

CREATE INDEX IF NOT EXISTS idx_trajectory_entries_type
ON trajectory_entries(entry_type);

CREATE INDEX IF NOT EXISTS idx_trajectory_entries_created
ON trajectory_entries(created_at DESC);

COMMIT;
