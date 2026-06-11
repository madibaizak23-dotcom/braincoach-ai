-- 002_seed_decisions.sql

INSERT INTO decisions (
    decision_code,
    title,
    status,
    approved_at
)
VALUES

(
    'DEC-008',
    'BGS Data Architecture',
    'approved',
    NOW()
),

(
    'DEC-009',
    'Human-AI Operating Model',
    'approved',
    NOW()
),

(
    'DEC-011',
    'Source Of Truth Model',
    'approved',
    NOW()
),

(
    'DEC-012',
    'BGS Foundation Bootstrap',
    'approved',
    NOW()
),

(
    'DEC-013',
    'Orchestration Runtime Strategy',
    'approved',
    NOW()
),

(
    'DEC-014',
    'BGS Core MVP v1',
    'approved',
    NOW()
);