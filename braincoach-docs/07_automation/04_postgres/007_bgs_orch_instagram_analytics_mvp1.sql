-- =====================================================
-- BrainCoach Migration 007
-- Instagram Analytics MVP-1
-- Database: bgs_orch
-- Schema: production
-- Date: 2026-06-18
--
-- Manual install only.
-- Do not run against bgs_core.
--
-- Purpose:
-- Store read-only Instagram media snapshots, comment snapshots,
-- classified comment inbox items, and production outcome summaries.
-- =====================================================

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE SCHEMA IF NOT EXISTS production;

-- =====================================================
-- INSTAGRAM MEDIA SNAPSHOTS
-- =====================================================

CREATE TABLE IF NOT EXISTS production.instagram_media_snapshots (
    snapshot_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    instagram_media_id text NOT NULL,
    media_type text,
    media_product_type text,
    caption text,
    permalink text,
    published_at timestamptz,
    reach integer,
    views integer,
    likes integer,
    comments integer,
    saves integer,
    shares integer,
    raw_metrics jsonb NOT NULL DEFAULT '{}'::jsonb,
    raw_media jsonb NOT NULL DEFAULT '{}'::jsonb,
    collected_at timestamptz NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX IF NOT EXISTS instagram_media_snapshots_media_collected_uidx
    ON production.instagram_media_snapshots (instagram_media_id, collected_at);

CREATE INDEX IF NOT EXISTS instagram_media_snapshots_media_id_collected_at_idx
    ON production.instagram_media_snapshots (instagram_media_id, collected_at DESC);

CREATE INDEX IF NOT EXISTS instagram_media_snapshots_published_at_idx
    ON production.instagram_media_snapshots (published_at DESC);

-- =====================================================
-- INSTAGRAM COMMENT SNAPSHOTS
-- =====================================================

CREATE TABLE IF NOT EXISTS production.instagram_comment_snapshots (
    snapshot_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    instagram_comment_id text NOT NULL,
    instagram_media_id text NOT NULL,
    comment_text text,
    author_username text,
    commented_at timestamptz,
    like_count integer,
    raw_comment jsonb NOT NULL DEFAULT '{}'::jsonb,
    collected_at timestamptz NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX IF NOT EXISTS instagram_comment_snapshots_comment_collected_uidx
    ON production.instagram_comment_snapshots (instagram_comment_id, collected_at);

CREATE INDEX IF NOT EXISTS instagram_comment_snapshots_media_id_collected_at_idx
    ON production.instagram_comment_snapshots (instagram_media_id, collected_at DESC);

CREATE INDEX IF NOT EXISTS instagram_comment_snapshots_comment_id_idx
    ON production.instagram_comment_snapshots (instagram_comment_id);

-- =====================================================
-- INSTAGRAM COMMENT INBOX ITEMS
-- =====================================================

CREATE TABLE IF NOT EXISTS production.instagram_comment_inbox_items (
    inbox_item_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    instagram_comment_id text NOT NULL,
    instagram_media_id text NOT NULL,
    classification text NOT NULL,
    secondary_labels jsonb NOT NULL DEFAULT '[]'::jsonb,
    priority text NOT NULL DEFAULT 'normal',
    why_it_matters text,
    recommended_next_action text,
    telegram_sent_at timestamptz,
    status text NOT NULL DEFAULT 'new',
    raw_classification jsonb NOT NULL DEFAULT '{}'::jsonb,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT instagram_comment_inbox_items_classification_chk
        CHECK (classification IN (
            'signal',
            'question',
            'interview_candidate',
            'spam',
            'risk',
            'market_signal',
            'payment_trigger',
            'offer_question',
            'consultation_candidate',
            'content_gap',
            'objection',
            'noise'
        )),
    CONSTRAINT instagram_comment_inbox_items_priority_chk
        CHECK (priority IN ('low', 'normal', 'high', 'urgent')),
    CONSTRAINT instagram_comment_inbox_items_status_chk
        CHECK (status IN ('new', 'seen', 'handled', 'ignored', 'escalated', 'promoted'))
);

CREATE UNIQUE INDEX IF NOT EXISTS instagram_comment_inbox_items_comment_uidx
    ON production.instagram_comment_inbox_items (instagram_comment_id);

CREATE INDEX IF NOT EXISTS instagram_comment_inbox_items_classification_idx
    ON production.instagram_comment_inbox_items (classification, priority, created_at DESC);

CREATE INDEX IF NOT EXISTS instagram_comment_inbox_items_media_id_idx
    ON production.instagram_comment_inbox_items (instagram_media_id, created_at DESC);

-- =====================================================
-- PRODUCTION OUTCOMES
-- =====================================================

CREATE TABLE IF NOT EXISTS production.outcomes (
    outcome_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    outcome_code text,
    channel text NOT NULL,
    source_type text NOT NULL,
    source_id text NOT NULL,
    source_reference text,
    response_window text,
    raw_metrics jsonb NOT NULL DEFAULT '{}'::jsonb,
    raw_responses jsonb NOT NULL DEFAULT '{}'::jsonb,
    repeated_phrase_candidates jsonb NOT NULL DEFAULT '[]'::jsonb,
    response_summary text,
    captured_at timestamptz NOT NULL DEFAULT now(),
    created_at timestamptz NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX IF NOT EXISTS outcomes_channel_source_captured_uidx
    ON production.outcomes (channel, source_type, source_id, captured_at);

CREATE INDEX IF NOT EXISTS outcomes_channel_source_idx
    ON production.outcomes (channel, source_type, source_id);

CREATE INDEX IF NOT EXISTS outcomes_captured_at_idx
    ON production.outcomes (captured_at DESC);

-- =====================================================
-- VERIFICATION QUERIES
-- Run manually after install if needed:
--
-- SELECT table_schema, table_name
-- FROM information_schema.tables
-- WHERE table_schema = 'production'
--   AND table_name IN (
--     'instagram_media_snapshots',
--     'instagram_comment_snapshots',
--     'instagram_comment_inbox_items',
--     'outcomes'
--   )
-- ORDER BY table_name;
-- =====================================================
