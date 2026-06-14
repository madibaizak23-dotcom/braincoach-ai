-- draft_bgs_orch_knowledge_assets_upsert_production_os_specs_2026_06_14.sql
-- Target database: bgs_orch
-- Target table: knowledge_assets
-- Status: DRAFT ONLY.
-- Apply manually only after approval.
-- Purpose: register DEC-017 and Production OS architecture/spec/governance documents as live Knowledge Assets.
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
    'DEC-017 BGS Orch Schema Segregation',
    'decision',
    'braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-017-bgs-orch-schema-segregation.md',
    'github',
    'active'
),
(
    'Research Schema v1 for bgs_orch',
    'architecture',
    'braincoach-docs/07_automation/research_schema_v1_bgs_orch.md',
    'github',
    'active'
),
(
    'Research Season Specification v1',
    'architecture',
    'braincoach-docs/07_automation/production_os/01_research/research_season.md',
    'github',
    'active'
),
(
    'Research Brief Specification v1',
    'architecture',
    'braincoach-docs/07_automation/production_os/01_research/research_brief.md',
    'github',
    'active'
),
(
    'Marketing Brief Specification v1',
    'architecture',
    'braincoach-docs/07_automation/production_os/02_marketing/marketing_brief.md',
    'github',
    'active'
),
(
    'Content Plan Specification v1',
    'architecture',
    'braincoach-docs/07_automation/production_os/03_content/content_plan.md',
    'github',
    'active'
),
(
    'Production Execution Specification v1',
    'architecture',
    'braincoach-docs/07_automation/production_os/04_execution/production_execution.md',
    'github',
    'active'
),
(
    'Production Outcome Specification v1',
    'architecture',
    'braincoach-docs/07_automation/production_os/04_execution/production_outcome.md',
    'github',
    'active'
),
(
    'Signal Capture Specification v1',
    'architecture',
    'braincoach-docs/07_automation/production_os/05_intelligence/signal_capture.md',
    'github',
    'active'
),
(
    'Season Review Specification v1',
    'architecture',
    'braincoach-docs/07_automation/production_os/05_intelligence/season_review.md',
    'github',
    'active'
),
(
    'Knowledge Update Specification v1',
    'architecture',
    'braincoach-docs/07_automation/production_os/05_intelligence/knowledge_update.md',
    'github',
    'active'
),
(
    'Production OS Canon v1',
    'architecture',
    'braincoach-docs/07_automation/production_os/00_production_os_canon_v1.md',
    'github',
    'active'
),
(
    'Production OS Index',
    'architecture',
    'braincoach-docs/07_automation/production_os/README.md',
    'github',
    'active'
),
(
    'Production OS Structure Normalization v1',
    'architecture',
    'braincoach-docs/07_automation/production_os/06_governance/production_os_structure_normalization_v1.md',
    'github',
    'active'
),
(
    'Migration Governance Rule v1',
    'governance',
    'braincoach-docs/07_automation/04_postgres/migration_governance_rule_v1.md',
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
