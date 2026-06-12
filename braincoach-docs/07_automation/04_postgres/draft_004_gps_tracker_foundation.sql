-- draft_004_gps_tracker_foundation.sql
-- Status: DRAFT ONLY - DO NOT APPLY WITHOUT REVIEW AND EXPLICIT APPROVAL.
-- Target database: bgs_core
-- Purpose: Foundation tables for BrainCoach GPS Daily Tracker.
--
-- Design rules:
-- - bgs_core remains the source of truth.
-- - Uses existing persons(person_id).
-- - Does not alter or drop existing observations, tracker_entries, or conversation_events.
-- - Reality Tracker first: activities, confirmations, entries.
-- - GPS layer later: matrix snapshots, resonance/dissonance, reports.

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

    notes TEXT,
    source TEXT NOT NULL DEFAULT 'manual',

    created_by_person_id UUID
        REFERENCES persons(person_id),

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_activity_events_time_order
        CHECK (ended_at IS NULL OR started_at IS NULL OR ended_at >= started_at),

    CONSTRAINT chk_activity_events_duration
        CHECK (duration_minutes IS NULL OR duration_minutes >= 0)
);

CREATE INDEX IF NOT EXISTS idx_activity_events_trajectory
ON activity_events(trajectory_id);

CREATE INDEX IF NOT EXISTS idx_activity_events_person
ON activity_events(person_id);

CREATE INDEX IF NOT EXISTS idx_activity_events_type
ON activity_events(activity_type_code);

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
            'athlete_telegram',
            'coach_google_sheet',
            'parent_telegram',
            'manual'
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

    entry_type TEXT NOT NULL,

    content TEXT NOT NULL,
    source TEXT NOT NULL DEFAULT 'manual',

    created_by_person_id UUID
        REFERENCES persons(person_id),

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_trajectory_entries_type
        CHECK (entry_type IN (
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

CREATE INDEX IF NOT EXISTS idx_trajectory_entries_type
ON trajectory_entries(entry_type);

CREATE INDEX IF NOT EXISTS idx_trajectory_entries_created
ON trajectory_entries(created_at DESC);

-- =====================================================
-- GPS: TRAJECTORY MATRIX SNAPSHOTS
-- =====================================================

CREATE TABLE IF NOT EXISTS trajectory_matrix_snapshots (
    snapshot_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    trajectory_id UUID NOT NULL
        REFERENCES trajectories(trajectory_id),

    person_id UUID NOT NULL
        REFERENCES persons(person_id),

    -- Internal reality
    awareness NUMERIC(5,2),
    observation NUMERIC(5,2),
    feelings NUMERIC(5,2),
    needs NUMERIC(5,2),
    desires NUMERIC(5,2),
    vision NUMERIC(5,2),
    personal_code NUMERIC(5,2),
    beingness NUMERIC(5,2),
    readiness NUMERIC(5,2),
    capability NUMERIC(5,2),
    confirmation NUMERIC(5,2),

    -- External reality
    presence NUMERIC(5,2),
    situation NUMERIC(5,2),
    behavior NUMERIC(5,2),
    goals NUMERIC(5,2),
    tasks NUMERIC(5,2),
    ideal_picture NUMERIC(5,2),
    guiding_rules NUMERIC(5,2),
    co_beingness NUMERIC(5,2),
    plan NUMERIC(5,2),
    action NUMERIC(5,2),
    valuable_product NUMERIC(5,2),

    resonance_score NUMERIC(5,2),
    dissonance_notes TEXT,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_trajectory_matrix_scores
        CHECK (
            (awareness IS NULL OR awareness BETWEEN 0 AND 100)
            AND (observation IS NULL OR observation BETWEEN 0 AND 100)
            AND (feelings IS NULL OR feelings BETWEEN 0 AND 100)
            AND (needs IS NULL OR needs BETWEEN 0 AND 100)
            AND (desires IS NULL OR desires BETWEEN 0 AND 100)
            AND (vision IS NULL OR vision BETWEEN 0 AND 100)
            AND (personal_code IS NULL OR personal_code BETWEEN 0 AND 100)
            AND (beingness IS NULL OR beingness BETWEEN 0 AND 100)
            AND (readiness IS NULL OR readiness BETWEEN 0 AND 100)
            AND (capability IS NULL OR capability BETWEEN 0 AND 100)
            AND (confirmation IS NULL OR confirmation BETWEEN 0 AND 100)
            AND (presence IS NULL OR presence BETWEEN 0 AND 100)
            AND (situation IS NULL OR situation BETWEEN 0 AND 100)
            AND (behavior IS NULL OR behavior BETWEEN 0 AND 100)
            AND (goals IS NULL OR goals BETWEEN 0 AND 100)
            AND (tasks IS NULL OR tasks BETWEEN 0 AND 100)
            AND (ideal_picture IS NULL OR ideal_picture BETWEEN 0 AND 100)
            AND (guiding_rules IS NULL OR guiding_rules BETWEEN 0 AND 100)
            AND (co_beingness IS NULL OR co_beingness BETWEEN 0 AND 100)
            AND (plan IS NULL OR plan BETWEEN 0 AND 100)
            AND (action IS NULL OR action BETWEEN 0 AND 100)
            AND (valuable_product IS NULL OR valuable_product BETWEEN 0 AND 100)
            AND (resonance_score IS NULL OR resonance_score BETWEEN 0 AND 100)
        )
);

CREATE INDEX IF NOT EXISTS idx_trajectory_matrix_snapshots_trajectory
ON trajectory_matrix_snapshots(trajectory_id);

CREATE INDEX IF NOT EXISTS idx_trajectory_matrix_snapshots_person
ON trajectory_matrix_snapshots(person_id);

CREATE INDEX IF NOT EXISTS idx_trajectory_matrix_snapshots_created
ON trajectory_matrix_snapshots(created_at DESC);

-- =====================================================
-- GPS: REPORTS
-- =====================================================

CREATE TABLE IF NOT EXISTS gps_reports (
    report_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    trajectory_id UUID NOT NULL
        REFERENCES trajectories(trajectory_id),

    person_id UUID NOT NULL
        REFERENCES persons(person_id),

    period_type TEXT NOT NULL,
    period_start DATE NOT NULL,
    period_end DATE NOT NULL,

    summary TEXT,

    activity_totals_json JSONB NOT NULL DEFAULT '{}'::jsonb,
    observations_json JSONB NOT NULL DEFAULT '[]'::jsonb,
    insights_json JSONB NOT NULL DEFAULT '[]'::jsonb,

    resonance_score NUMERIC(5,2),
    dissonance_points_json JSONB NOT NULL DEFAULT '[]'::jsonb,

    next_step TEXT,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_gps_reports_period_type
        CHECK (period_type IN ('day', 'week', 'month')),

    CONSTRAINT chk_gps_reports_period_order
        CHECK (period_end >= period_start),

    CONSTRAINT chk_gps_reports_resonance_score
        CHECK (resonance_score IS NULL OR resonance_score BETWEEN 0 AND 100)
);

CREATE INDEX IF NOT EXISTS idx_gps_reports_trajectory
ON gps_reports(trajectory_id);

CREATE INDEX IF NOT EXISTS idx_gps_reports_person
ON gps_reports(person_id);

CREATE INDEX IF NOT EXISTS idx_gps_reports_period
ON gps_reports(period_type, period_start, period_end);

CREATE INDEX IF NOT EXISTS idx_gps_reports_created
ON gps_reports(created_at DESC);
