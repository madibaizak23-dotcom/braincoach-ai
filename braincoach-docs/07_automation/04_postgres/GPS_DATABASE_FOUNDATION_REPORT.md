# GPS Database Foundation Report

Date: 2026-06-12
Status: Draft migration report
Migration: `braincoach-docs/07_automation/04_postgres/draft_004_gps_tracker_foundation.sql`

## Summary

A draft PostgreSQL migration was prepared for the BrainCoach GPS Daily Tracker foundation in `bgs_core`.

The migration was not applied.

The design is additive only. It does not drop, alter, or replace existing Conversation Engine, tracker, observation, or event tables.

## Existing Tables Checked

The current BGS Core SQL and docs show these existing tables relevant to this task:

- `persons`
- `conversations`
- `messages`
- `parent_interviews`
- `interview_responses`
- `observations`
- `tracker_entries`
- `research_signal_candidates`
- `knowledge_assets`
- `decisions`
- `conversation_events`

Important compatibility points:

- `persons(person_id)` is the existing human identity source and is used by the draft migration.
- `conversation_events` has a constrained `event_type` list. The draft does not add new event types or alter the table.
- `observations`, `tracker_entries`, and `conversation_events` are preserved unchanged.

## Tables Proposed

### Reality Tracker Foundation

These tables support the first MVP layer: activities, confirmations, observations, feelings, notes, and insights.

| table | purpose |
| --- | --- |
| `trajectory_domains` | Lookup table for GPS trajectory domains such as sport, career, education, relationships, self_learning, health, and family. |
| `trajectories` | One development trajectory for a person, such as Hockey to NCAA or Java Developer to Data Architect. |
| `person_roles` | Person roles in a context, optionally linked to a trajectory. |
| `activity_types` | Lookup table for activity types such as ice, english, gym, nutrition, sleep, study. |
| `activity_events` | Actual completed or planned activity facts, including start/end/duration/source. |
| `activity_confirmations` | Confirmation, correction, or dispute records for activity events. |
| `trajectory_entries` | Free-form trajectory notes: observations, reflections, feelings, insights, nutrition notes, photo notes, coach notes, parent notes. |

### GPS Layer

These tables support the later GPS interpretation layer.

| table | purpose |
| --- | --- |
| `trajectory_matrix_snapshots` | Periodic internal/external reality matrix snapshot with resonance and dissonance notes. |
| `gps_reports` | Daily, weekly, and monthly reports with summaries, totals, observations, insights, resonance, dissonance points, and next step. |

## Tables Using `persons`

The draft migration uses existing `persons(person_id)` in:

- `trajectories.person_id`
- `person_roles.person_id`
- `activity_events.person_id`
- `activity_events.created_by_person_id`
- `activity_confirmations.confirmed_by_person_id`
- `trajectory_entries.person_id`
- `trajectory_entries.created_by_person_id`
- `trajectory_matrix_snapshots.person_id`
- `gps_reports.person_id`

No new user/person identity table is introduced.

## Tables Connected To Trajectory

The trajectory-centered tables are:

- `person_roles.trajectory_id`
- `activity_events.trajectory_id`
- `trajectory_entries.trajectory_id`
- `trajectory_matrix_snapshots.trajectory_id`
- `gps_reports.trajectory_id`

Lookup tables connected to trajectory usage:

- `trajectory_domains`
- `activity_types`

## Ready For Telegram MVP

The draft supports a Telegram MVP for daily GPS tracking through:

- `trajectories` for selecting the active trajectory.
- `activity_events` for saving concrete activity facts.
- `activity_confirmations` for athlete, parent, coach, or manual confirmation.
- `trajectory_entries` for free-form notes, observations, feelings, and insights.
- `person_roles` for distinguishing athlete, parent, coach, mentor, and other contexts.

The draft intentionally avoids modifying:

- `messages`
- `conversations`
- `conversation_events`
- `tracker_entries`
- `observations`

This keeps the existing Conversation Engine stable.

## Not Ready To Apply Without Review

Do not apply this migration until the following are checked:

- Confirm the live `bgs_core` schema matches the documented `persons(person_id)` shape.
- Confirm whether GPS tables should live in `public` or a dedicated schema later.
- Confirm whether `activity_events.duration_minutes` should be stored manually or generated from `started_at` and `ended_at`.
- Confirm score ranges for `trajectory_matrix_snapshots` and `gps_reports.resonance_score`; draft uses `0..100`.
- Confirm whether `trajectory_entries` should link back to existing `tracker_entries` or `observations` in a later migration.
- Confirm whether confirmation sources should be constrained to the current four values or remain open text for MVP.
- Confirm whether `ON DELETE CASCADE` on `activity_confirmations.activity_event_id` is acceptable.

## Critical Non-Actions

The migration was not applied.

No existing table is dropped.

No existing table is altered.

No existing data is changed.

No Conversation Engine event type is added.

## Recommended Review Query Before Applying

Run this against the target `bgs_core` database before applying:

```sql
SELECT
    table_name,
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name IN (
    'persons',
    'observations',
    'tracker_entries',
    'conversation_events'
  )
ORDER BY table_name, ordinal_position;
```

## Implementation Order

Reality Tracker first:

1. `trajectory_domains`
2. `trajectories`
3. `person_roles`
4. `activity_types`
5. `activity_events`
6. `activity_confirmations`
7. `trajectory_entries`

GPS layer later:

1. `trajectory_matrix_snapshots`
2. `gps_reports`
