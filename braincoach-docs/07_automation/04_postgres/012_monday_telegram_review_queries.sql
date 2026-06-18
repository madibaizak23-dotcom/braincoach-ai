-- =====================================================
-- BrainCoach SQL 012
-- Monday Telegram Review MVP-1 queries
-- Date: 2026-06-18
-- Target database: bgs_orch
-- Target schema: production
--
-- Purpose:
--   Provide read and update queries for Telegram human review of
--   Monday generated_content_assets.
--
-- Safety:
--   - Does not alter schema.
--   - Does not update content_units.
--   - Does not schedule or publish anything.
--   - Updates generated_content_assets only when a specific
--     content_unit_code and exact Monday generator metadata match.
--
-- IMPORTANT:
--   This file is not meant to be executed top-to-bottom with \i.
--   Copy the specific query needed by the n8n node or psql test.
-- =====================================================

-- =====================================================
-- QUERY 01
-- Read Monday review package for Telegram cards
-- =====================================================

SELECT
    g.asset_id,
    g.content_unit_code,
    u.platform,
    u.format,
    u.topic,
    u.publishing_time_label,
    g.asset_type,
    g.voice_check_status,
    g.approval_status,
    g.asset_text,
    g.asset_payload,
    g.metadata,
    g.updated_at
FROM production.generated_content_assets g
JOIN production.content_units u
    ON u.content_unit_code = g.content_unit_code
WHERE g.metadata->>'generator' = 'monday_generator_mvp1'
  AND g.metadata->>'content_plan_code' = 'CPLAN-2026-06-22-W01'
  AND g.metadata->>'planned_date' = '2026-06-22'
ORDER BY
    CASE u.platform
        WHEN 'Instagram' THEN 1
        WHEN 'Threads' THEN 2
        WHEN 'Facebook' THEN 3
        WHEN 'Telegram' THEN 4
        WHEN 'TikTok' THEN 5
        WHEN 'YouTube Shorts' THEN 6
        ELSE 99
    END,
    CASE u.format
        WHEN 'Reel' THEN 1
        WHEN 'Story' THEN 2
        WHEN 'Thread' THEN 3
        WHEN 'Post' THEN 4
        WHEN 'Note' THEN 5
        WHEN 'Short' THEN 6
        ELSE 99
    END,
    g.content_unit_code;

-- =====================================================
-- QUERY 02
-- Monday review status summary
-- =====================================================

SELECT
    approval_status,
    voice_check_status,
    count(*) AS assets
FROM production.generated_content_assets
WHERE metadata->>'generator' = 'monday_generator_mvp1'
  AND metadata->>'content_plan_code' = 'CPLAN-2026-06-22-W01'
  AND metadata->>'planned_date' = '2026-06-22'
GROUP BY approval_status, voice_check_status
ORDER BY approval_status, voice_check_status;

-- =====================================================
-- QUERY 03
-- Approve one asset by content_unit_code
--
-- n8n parameter:
--   $1 = content_unit_code
--
-- psql example:
--   Replace __CONTENT_UNIT_CODE__ before running.
-- =====================================================

UPDATE production.generated_content_assets
SET
    approval_status = 'approved',
    voice_check_status = 'passed',
    approved_at = now(),
    metadata = metadata
        || jsonb_build_object(
            'review_status', 'approved',
            'reviewed_by', 'telegram_operator',
            'reviewed_at', now()::text,
            'review_channel', 'telegram_review_mvp1'
        ),
    updated_at = now()
WHERE content_unit_code = '__CONTENT_UNIT_CODE__'
  AND metadata->>'generator' = 'monday_generator_mvp1'
  AND metadata->>'content_plan_code' = 'CPLAN-2026-06-22-W01'
  AND metadata->>'planned_date' = '2026-06-22'
RETURNING
    content_unit_code,
    approval_status,
    voice_check_status,
    approved_at;

-- =====================================================
-- QUERY 04
-- Mark one asset as needs_edit by content_unit_code
--
-- n8n parameters:
--   $1 = content_unit_code
--   $2 = review_note
--
-- psql example:
--   Replace __CONTENT_UNIT_CODE__ and __REVIEW_NOTE__ before running.
-- =====================================================

UPDATE production.generated_content_assets
SET
    approval_status = 'needs_edit',
    voice_check_status = 'needs_edit',
    approved_at = NULL,
    metadata = metadata
        || jsonb_build_object(
            'review_status', 'needs_edit',
            'review_note', '__REVIEW_NOTE__',
            'reviewed_by', 'telegram_operator',
            'reviewed_at', now()::text,
            'review_channel', 'telegram_review_mvp1'
        ),
    updated_at = now()
WHERE content_unit_code = '__CONTENT_UNIT_CODE__'
  AND metadata->>'generator' = 'monday_generator_mvp1'
  AND metadata->>'content_plan_code' = 'CPLAN-2026-06-22-W01'
  AND metadata->>'planned_date' = '2026-06-22'
RETURNING
    content_unit_code,
    approval_status,
    voice_check_status,
    metadata->>'review_note' AS review_note;

-- =====================================================
-- QUERY 05
-- Reject one asset by content_unit_code
--
-- n8n parameters:
--   $1 = content_unit_code
--   $2 = review_note
--
-- psql example:
--   Replace __CONTENT_UNIT_CODE__ and __REVIEW_NOTE__ before running.
-- =====================================================

UPDATE production.generated_content_assets
SET
    approval_status = 'rejected',
    voice_check_status = 'failed',
    approved_at = NULL,
    metadata = metadata
        || jsonb_build_object(
            'review_status', 'rejected',
            'review_note', '__REVIEW_NOTE__',
            'reviewed_by', 'telegram_operator',
            'reviewed_at', now()::text,
            'review_channel', 'telegram_review_mvp1'
        ),
    updated_at = now()
WHERE content_unit_code = '__CONTENT_UNIT_CODE__'
  AND metadata->>'generator' = 'monday_generator_mvp1'
  AND metadata->>'content_plan_code' = 'CPLAN-2026-06-22-W01'
  AND metadata->>'planned_date' = '2026-06-22'
RETURNING
    content_unit_code,
    approval_status,
    voice_check_status,
    metadata->>'review_note' AS review_note;

-- =====================================================
-- QUERY 06
-- Reset one asset to pending after command testing
--
-- Use only for operator testing before real review starts.
-- Replace __CONTENT_UNIT_CODE__ before running.
-- =====================================================

UPDATE production.generated_content_assets
SET
    approval_status = 'pending',
    voice_check_status = 'pending',
    approved_at = NULL,
    metadata = metadata
        - 'review_status'
        - 'review_note'
        - 'reviewed_by'
        - 'reviewed_at'
        - 'review_channel',
    updated_at = now()
WHERE content_unit_code = '__CONTENT_UNIT_CODE__'
  AND metadata->>'generator' = 'monday_generator_mvp1'
  AND metadata->>'content_plan_code' = 'CPLAN-2026-06-22-W01'
  AND metadata->>'planned_date' = '2026-06-22'
RETURNING
    content_unit_code,
    approval_status,
    voice_check_status,
    approved_at;

-- =====================================================
-- QUERY 07
-- Read only assets that still need human action
-- =====================================================

SELECT
    g.content_unit_code,
    u.platform,
    u.format,
    g.asset_type,
    g.approval_status,
    g.voice_check_status,
    left(g.asset_text, 300) AS preview
FROM production.generated_content_assets g
JOIN production.content_units u
    ON u.content_unit_code = g.content_unit_code
WHERE g.metadata->>'generator' = 'monday_generator_mvp1'
  AND g.metadata->>'content_plan_code' = 'CPLAN-2026-06-22-W01'
  AND g.metadata->>'planned_date' = '2026-06-22'
  AND g.approval_status IN ('pending', 'needs_edit')
ORDER BY u.platform, u.format, g.content_unit_code;

-- =====================================================
-- QUERY 08
-- Approval gate: can Tuesday Generator start?
--
-- If pending_assets = 0 and needs_edit_assets = 0,
-- Tuesday can proceed from review-status perspective.
-- =====================================================

SELECT
    count(*) FILTER (WHERE approval_status = 'pending') AS pending_assets,
    count(*) FILTER (WHERE approval_status = 'needs_edit') AS needs_edit_assets,
    count(*) FILTER (WHERE approval_status = 'rejected') AS rejected_assets,
    count(*) FILTER (WHERE approval_status = 'approved') AS approved_assets,
    count(*) AS total_assets
FROM production.generated_content_assets
WHERE metadata->>'generator' = 'monday_generator_mvp1'
  AND metadata->>'content_plan_code' = 'CPLAN-2026-06-22-W01'
  AND metadata->>'planned_date' = '2026-06-22';

-- =====================================================
-- QUERY 09
-- Optional n8n parameterized versions
-- Use in Postgres node if parameter binding is configured.
-- =====================================================

-- Approve:
-- UPDATE production.generated_content_assets
-- SET
--     approval_status = 'approved',
--     voice_check_status = 'passed',
--     approved_at = now(),
--     metadata = metadata || jsonb_build_object(
--         'review_status', 'approved',
--         'reviewed_by', 'telegram_operator',
--         'reviewed_at', now()::text,
--         'review_channel', 'telegram_review_mvp1'
--     ),
--     updated_at = now()
-- WHERE content_unit_code = $1
--   AND metadata->>'generator' = 'monday_generator_mvp1'
--   AND metadata->>'content_plan_code' = 'CPLAN-2026-06-22-W01'
--   AND metadata->>'planned_date' = '2026-06-22'
-- RETURNING content_unit_code, approval_status, voice_check_status, approved_at;

-- Needs edit:
-- UPDATE production.generated_content_assets
-- SET
--     approval_status = 'needs_edit',
--     voice_check_status = 'needs_edit',
--     approved_at = NULL,
--     metadata = metadata || jsonb_build_object(
--         'review_status', 'needs_edit',
--         'review_note', $2,
--         'reviewed_by', 'telegram_operator',
--         'reviewed_at', now()::text,
--         'review_channel', 'telegram_review_mvp1'
--     ),
--     updated_at = now()
-- WHERE content_unit_code = $1
--   AND metadata->>'generator' = 'monday_generator_mvp1'
--   AND metadata->>'content_plan_code' = 'CPLAN-2026-06-22-W01'
--   AND metadata->>'planned_date' = '2026-06-22'
-- RETURNING content_unit_code, approval_status, voice_check_status, metadata->>'review_note' AS review_note;

-- Reject:
-- UPDATE production.generated_content_assets
-- SET
--     approval_status = 'rejected',
--     voice_check_status = 'failed',
--     approved_at = NULL,
--     metadata = metadata || jsonb_build_object(
--         'review_status', 'rejected',
--         'review_note', $2,
--         'reviewed_by', 'telegram_operator',
--         'reviewed_at', now()::text,
--         'review_channel', 'telegram_review_mvp1'
--     ),
--     updated_at = now()
-- WHERE content_unit_code = $1
--   AND metadata->>'generator' = 'monday_generator_mvp1'
--   AND metadata->>'content_plan_code' = 'CPLAN-2026-06-22-W01'
--   AND metadata->>'planned_date' = '2026-06-22'
-- RETURNING content_unit_code, approval_status, voice_check_status, metadata->>'review_note' AS review_note;
