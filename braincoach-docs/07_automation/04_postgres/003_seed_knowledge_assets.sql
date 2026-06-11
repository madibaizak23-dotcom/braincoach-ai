-- 003_seed_knowledge_assets.sql

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