-- 003_seed_knowledge_assets.sql
-- Bootstrap seed for the old/dev knowledge_assets shape.
-- Not a live bgs_orch registry update.
-- For live bgs_orch.knowledge_assets(asset_name, asset_type, source_path, source_of_truth, status),
-- use a separate reviewed draft/upsert file and apply manually only after approval.
-- Do not add new spec documents here.

INSERT INTO knowledge_assets (
    asset_type,
    title,
    content,
    status
)
VALUES

(
    'registry',
    'DEC Registry',
    'Approved architectural decisions of Brain Growth System',
    'approved'
),

(
    'registry',
    'Repository Registry',
    'Authoritative registry of repositories and knowledge assets',
    'approved'
),

(
    'registry',
    'Ontology Registry',
    'Authoritative ontology definitions and entity taxonomy',
    'approved'
),

(
    'system',
    'System Snapshot',
    'Current approved snapshot of BrainCoach Knowledge OS',
    'approved'
),

(
    'methodology',
    'Parent Interview Script v1',
    'Initial parent interview methodology and questionnaire',
    'approved'
)

ON CONFLICT DO NOTHING;
