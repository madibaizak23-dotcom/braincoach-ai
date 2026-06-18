-- 006_add_wim_hof_breathing_activity_type.sql
-- Purpose: add Wim Hof breathing as a structured activity type for tracker practice capture.
-- Boundary: additive lookup seed only; does not alter existing tables or workflow behavior.

INSERT INTO activity_types (
    activity_type_code,
    title,
    description,
    is_active
)
VALUES (
    'wim_hof_breathing',
    'Wim Hof Breathing',
    'Structured breathing practice. Primary captured metric: retention after exhale per cycle.',
    TRUE
)
ON CONFLICT (activity_type_code) DO UPDATE
SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    is_active = EXCLUDED.is_active;
