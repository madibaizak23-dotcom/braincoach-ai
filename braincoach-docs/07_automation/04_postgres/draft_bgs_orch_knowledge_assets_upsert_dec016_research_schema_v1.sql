-- draft_bgs_orch_knowledge_assets_upsert_dec016_research_schema_v1.sql
-- Target database: bgs_orch
-- Target table: knowledge_assets
-- Status: DRAFT ONLY.
-- Apply manually only after approval.
-- Purpose: register DEC-016 and Research Schema v1 as live Knowledge Assets.
-- Safety: upsert by the live registry unique key source_path.

INSERT INTO knowledge_assets (
    asset_name,
    asset_type,
    source_path,
    source_of_truth,
    status
)
VALUES
(
    'DEC-016 BGS Database Boundary: Core vs Orch',
    'decision',
    'braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-016-bgs-database-boundary-core-vs-orch.md',
    'github',
    'active'
),
(
    'Research Schema v1 for bgs_orch',
    'architecture',
    'braincoach-docs/07_automation/research_schema_v1_bgs_orch.md',
    'github',
    'active'
)
ON CONFLICT (source_path)
DO UPDATE SET
    asset_name = EXCLUDED.asset_name,
    asset_type = EXCLUDED.asset_type,
    source_of_truth = EXCLUDED.source_of_truth,
    status = EXCLUDED.status,
    updated_at = NOW();
