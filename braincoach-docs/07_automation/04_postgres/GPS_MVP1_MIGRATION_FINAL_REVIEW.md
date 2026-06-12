# GPS MVP-1 Migration Final Review

Date: 2026-06-12
Status: Applied manually in Cloud SQL
Migration: `braincoach-docs/07_automation/04_postgres/004_gps_reality_tracker_mvp1.sql`

## Summary

Live schema review was completed by the owner. The MVP-1 Reality Tracker migration was approved with two minor adjustments, both applied to the final SQL file.

The migration was not applied by Codex. It was applied manually in Cloud SQL by the owner.

## Live Apply Confirmation

The owner confirmed that the following MVP-1 tables now exist in live `bgs_core`:

- `activity_confirmations`
- `activity_events`
- `activity_types`
- `person_roles`
- `trajectories`
- `trajectory_domains`
- `trajectory_entries`

The owner also confirmed lookup seed rows:

- `trajectory_domains`: 7 rows
- `activity_types`: 11 rows

## Changes Applied

### Change 1 - `activity_confirmations.confirmation_source`

The `chk_activity_confirmations_source` constraint was expanded.

Final allowed values:

- `telegram_bot`
- `google_sheet`
- `athlete_telegram`
- `coach_google_sheet`
- `parent_telegram`
- `manual`
- `web`
- `api`

Reason:

MVP-1 may receive confirmations from Telegram Bot, Google Sheets, Web Forms, and future API integrations.

### Change 2 - `trajectory_entries.entry_type`

The `chk_trajectory_entries_type` constraint now includes:

- `general_note`

Final allowed values:

- `general_note`
- `observation`
- `reflection`
- `feeling`
- `insight`
- `nutrition`
- `photo_note`
- `coach_note`
- `parent_note`

Reason:

Early tracker records may be plain notes before precise classification is available.

## Tables To Be Created

The migration creates only the MVP-1 Reality Tracker foundation:

- `trajectory_domains`
- `trajectories`
- `person_roles`
- `activity_types`
- `activity_events`
- `activity_confirmations`
- `trajectory_entries`

The migration does not create:

- `trajectory_matrix_snapshots`
- `gps_reports`

## Existing Tables Referenced

The migration references existing live schema tables:

- `persons(person_id)`
- `tracker_entries(entry_id)`
- `observations(observation_id)`

## Tables Touched

New tables:

- `trajectory_domains`
- `trajectories`
- `person_roles`
- `activity_types`
- `activity_events`
- `activity_confirmations`
- `trajectory_entries`

Existing tables:

- Referenced only through foreign keys.
- Not altered.
- Not dropped.
- Not updated.

## Safety Confirmation

Existing tables are not changed.

Existing data is not deleted.

No `DROP`, `ALTER`, `UPDATE`, `DELETE`, or `TRUNCATE` is included.

Conversation Engine is not touched:

- `conversations` is not changed.
- `messages` is not changed.
- `conversation_events` is not changed.
- No Conversation Engine event type is added.

## Manual Run Requirement

This SQL was executed manually in Cloud SQL by the owner.

Codex did not apply the migration.
