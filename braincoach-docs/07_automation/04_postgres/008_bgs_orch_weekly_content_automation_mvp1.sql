-- =====================================================
-- BrainCoach Migration 008
-- Weekly Content Automation MVP-1
-- Database: bgs_orch
-- Schema: production
-- Date: 2026-06-18
--
-- Manual install only.
-- Do not run against bgs_core.
--
-- Purpose:
-- Store weekly content plans, generated assets, publishing executions,
-- outcomes, market signals, and tracker monitoring items.
-- =====================================================

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE SCHEMA IF NOT EXISTS production;

-- =====================================================
-- WEEKLY CONTENT PLANS
-- =====================================================

CREATE TABLE IF NOT EXISTS production.weekly_content_plans (
    plan_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    content_plan_code text NOT NULL UNIQUE,
    week_start_date date NOT NULL,
    week_end_date date NOT NULL,
    weekly_theme text NOT NULL,
    main_conversation text NOT NULL,
    main_tension text NOT NULL,
    main_question text NOT NULL,
    weekly_hypothesis text NOT NULL,
    visual_master_world text NOT NULL DEFAULT 'Navigation Universe',
    weekly_visual_world text,
    status text NOT NULL DEFAULT 'draft',
    source_paths jsonb NOT NULL DEFAULT '[]'::jsonb,
    metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT chk_weekly_content_plans_status
        CHECK (status IN ('draft', 'approved', 'in_production', 'completed', 'reviewed', 'cancelled'))
);

CREATE INDEX IF NOT EXISTS weekly_content_plans_week_idx
    ON production.weekly_content_plans (week_start_date DESC);

-- =====================================================
-- CONTENT UNITS
-- =====================================================

CREATE TABLE IF NOT EXISTS production.content_units (
    content_unit_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    content_unit_code text NOT NULL UNIQUE,
    content_plan_code text NOT NULL
        REFERENCES production.weekly_content_plans(content_plan_code)
        ON DELETE CASCADE,
    planned_date date NOT NULL,
    weekday text,
    platform text NOT NULL,
    format text NOT NULL,
    topic text NOT NULL,
    hypothesis text,
    publishing_window tstzrange,
    publishing_time_label text,
    expected_signal text,
    primary_kpi text,
    secondary_kpi text,
    cta text,
    source_meaning text,
    status text NOT NULL DEFAULT 'draft',
    metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT chk_content_units_status
        CHECK (status IN ('draft', 'approved', 'scheduled', 'published', 'missed', 'skipped', 'reviewed', 'cancelled'))
);

CREATE INDEX IF NOT EXISTS content_units_plan_date_idx
    ON production.content_units (content_plan_code, planned_date);

CREATE INDEX IF NOT EXISTS content_units_platform_status_idx
    ON production.content_units (platform, status, planned_date);

-- =====================================================
-- GENERATED CONTENT ASSETS
-- =====================================================

CREATE TABLE IF NOT EXISTS production.generated_content_assets (
    asset_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    content_unit_code text NOT NULL
        REFERENCES production.content_units(content_unit_code)
        ON DELETE CASCADE,
    asset_type text NOT NULL,
    asset_text text NOT NULL,
    asset_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    voice_check_status text NOT NULL DEFAULT 'pending',
    approval_status text NOT NULL DEFAULT 'pending',
    approved_at timestamptz,
    metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT chk_generated_content_assets_voice
        CHECK (voice_check_status IN ('pending', 'passed', 'failed', 'needs_edit')),
    CONSTRAINT chk_generated_content_assets_approval
        CHECK (approval_status IN ('pending', 'approved', 'rejected', 'needs_edit'))
);

CREATE INDEX IF NOT EXISTS generated_assets_unit_idx
    ON production.generated_content_assets (content_unit_code);

-- =====================================================
-- PUBLISHING EXECUTIONS
-- =====================================================

CREATE TABLE IF NOT EXISTS production.publishing_executions (
    execution_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    execution_code text NOT NULL UNIQUE,
    content_unit_code text
        REFERENCES production.content_units(content_unit_code)
        ON DELETE SET NULL,
    channel text NOT NULL,
    format text NOT NULL,
    planned_window tstzrange,
    executed_at timestamptz,
    timing_status text NOT NULL DEFAULT 'planned',
    execution_status text NOT NULL DEFAULT 'planned',
    operator text,
    artifact_reference text,
    notes text,
    metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT chk_publishing_executions_timing_status
        CHECK (timing_status IN ('planned', 'on_time', 'late', 'missed', 'rescheduled', 'unknown')),
    CONSTRAINT chk_publishing_executions_status
        CHECK (execution_status IN ('planned', 'scheduled', 'completed', 'skipped', 'failed', 'cancelled', 'revised'))
);

CREATE INDEX IF NOT EXISTS publishing_executions_unit_idx
    ON production.publishing_executions (content_unit_code);

CREATE INDEX IF NOT EXISTS publishing_executions_executed_at_idx
    ON production.publishing_executions (executed_at DESC);

-- =====================================================
-- CONTENT OUTCOMES
-- =====================================================

CREATE TABLE IF NOT EXISTS production.content_outcomes (
    outcome_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    execution_code text
        REFERENCES production.publishing_executions(execution_code)
        ON DELETE SET NULL,
    content_unit_code text
        REFERENCES production.content_units(content_unit_code)
        ON DELETE SET NULL,
    channel text NOT NULL,
    source_reference text,
    response_window text,
    raw_metrics jsonb NOT NULL DEFAULT '{}'::jsonb,
    raw_responses jsonb NOT NULL DEFAULT '{}'::jsonb,
    response_summary text,
    captured_at timestamptz NOT NULL DEFAULT now(),
    created_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS content_outcomes_unit_idx
    ON production.content_outcomes (content_unit_code, captured_at DESC);

-- =====================================================
-- MARKET SIGNALS
-- =====================================================

CREATE TABLE IF NOT EXISTS production.market_signals (
    signal_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    content_unit_code text
        REFERENCES production.content_units(content_unit_code)
        ON DELETE SET NULL,
    outcome_id uuid
        REFERENCES production.content_outcomes(outcome_id)
        ON DELETE SET NULL,
    source_channel text NOT NULL,
    source_type text NOT NULL,
    source_reference text,
    raw_text text NOT NULL,
    classification text NOT NULL,
    secondary_labels jsonb NOT NULL DEFAULT '[]'::jsonb,
    priority text NOT NULL DEFAULT 'normal',
    why_it_matters text,
    recommended_action text,
    status text NOT NULL DEFAULT 'new',
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT chk_market_signals_classification
        CHECK (classification IN (
            'market_signal',
            'payment_trigger',
            'offer_question',
            'interview_candidate',
            'consultation_candidate',
            'content_gap',
            'objection',
            'noise',
            'risk'
        )),
    CONSTRAINT chk_market_signals_priority
        CHECK (priority IN ('low', 'normal', 'high', 'urgent')),
    CONSTRAINT chk_market_signals_status
        CHECK (status IN ('new', 'seen', 'handled', 'ignored', 'escalated', 'promoted'))
);

CREATE INDEX IF NOT EXISTS market_signals_classification_idx
    ON production.market_signals (classification, priority, created_at DESC);

CREATE INDEX IF NOT EXISTS market_signals_content_unit_idx
    ON production.market_signals (content_unit_code, created_at DESC);

-- =====================================================
-- TRACKER MONITORING ITEMS
-- =====================================================

CREATE TABLE IF NOT EXISTS production.tracker_monitoring_items (
    monitoring_item_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    content_plan_code text
        REFERENCES production.weekly_content_plans(content_plan_code)
        ON DELETE SET NULL,
    content_unit_code text
        REFERENCES production.content_units(content_unit_code)
        ON DELETE SET NULL,
    monitoring_type text NOT NULL,
    monitoring_text text NOT NULL,
    planned_for timestamptz,
    status text NOT NULL DEFAULT 'open',
    tracker_entry_reference text,
    metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT chk_tracker_monitoring_items_type
        CHECK (monitoring_type IN (
            'daily_plan',
            'publishing_reminder',
            'missed_window',
            'daily_summary',
            'weekly_review',
            'correction',
            'bottleneck'
        )),
    CONSTRAINT chk_tracker_monitoring_items_status
        CHECK (status IN ('open', 'sent_to_tracker', 'done', 'missed', 'cancelled'))
);

CREATE INDEX IF NOT EXISTS tracker_monitoring_items_plan_idx
    ON production.tracker_monitoring_items (content_plan_code, status, planned_for);

CREATE INDEX IF NOT EXISTS tracker_monitoring_items_unit_idx
    ON production.tracker_monitoring_items (content_unit_code, status, planned_for);

-- =====================================================
-- VERIFICATION QUERIES
-- Run manually after install if needed:
--
-- SELECT table_schema, table_name
-- FROM information_schema.tables
-- WHERE table_schema = 'production'
--   AND table_name IN (
--     'weekly_content_plans',
--     'content_units',
--     'generated_content_assets',
--     'publishing_executions',
--     'content_outcomes',
--     'market_signals',
--     'tracker_monitoring_items'
--   )
-- ORDER BY table_name;
-- =====================================================
