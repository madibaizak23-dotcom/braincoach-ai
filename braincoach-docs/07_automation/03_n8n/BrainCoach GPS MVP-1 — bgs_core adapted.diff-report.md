# BrainCoach GPS MVP-1 — bgs_core adapted diff-report

## Source

- `BrainCoach GPS OS — Stage 3 Complete.json`

## Deliverable

- `BrainCoach GPS MVP-1 — bgs_core adapted.json`
- Workflow is copied and adapted.
- Workflow `active` is set to `false`.
- Workflow was not imported, activated, or executed.

## Nodes Preserved

- `TG_Trigger`
- `VOI_CheckVoice`
- `VOI_GetFile`
- `VOI_Transcribe`
- `VOI_NormalizeTranscript`
- `SYS_LoadContext`
- `SYS_BuildInputContext`
- `SYS_RouteInput`
- `TRK_IsTrackerEvent`
- `TRK_SaveRawEvent`
- `TRK_ExtractEntry`
- `TRK_ParseEntry`
- `TRK_SaveEntry`
- `OBS_CreateObservation`
- `SIG_ExtractSignalCandidate`
- `SIG_ParseCandidate`
- `SIG_HasCandidate`
- `DB_SaveSignalCandidate`
- `TRK_GetEntryCount`
- `TRK_ReplySaved`
- `HIS_CheckRecent`
- `HIS_LoadEntries`
- `HIS_FormatReply`
- `HIS_Reply`
- `HIS_CheckStart`
- `HIS_ReplyStart`
- `HIS_UnknownCommand`
- `OpenAI Chat Model`

## SQL Nodes Changed

- `SYS_LoadContext`
  - Replaced `clients` and `conversation_state`.
  - Uses `persons` by `external_id = Telegram user id`, `source = 'telegram'`, default `role = 'athlete'`.
  - Ensures an active `conversations` row for the preserved Conversation Engine.
  - Ensures an active `trajectories` row for GPS MVP-1 writes.

- `TRK_SaveRawEvent`
  - Replaced old `messages.telegram_user_id` insert.
  - Writes to live `messages(conversation_id, role, content, created_at)`.

- `TRK_SaveEntry`
  - Replaced `tracker_entries.telegram_user_id` with `tracker_entries.person_id`.
  - Replaced `tracker_entries.id` return usage with `tracker_entries.entry_id`.
  - Adds `activity_events` insert for short activity facts such as `английский 60`, `лед 60`, `дриблинг 30`.
  - Adds `trajectory_entries` insert for non-activity notes with `source = 'telegram_bot'`.

- `OBS_CreateObservation`
  - Replaced `observations.telegram_user_id` with `observations.person_id`.
  - Removed `observations.source_entry_id`.
  - Uses live `observations(observation_id, person_id, source_type, observation_text, confidence, created_at)`.

- `DB_SaveSignalCandidate`
  - Replaced old candidate shape with live `research_signal_candidates(candidate_id, observation_id, signal_name, confidence, status, created_at)`.

- `TRK_GetEntryCount`
  - Counts by `person_id`.

- `HIS_LoadEntries`
  - Loads recent rows by `person_id`.
  - Selects `entry_id` and keeps `id` alias only for node compatibility.

## Non-SQL Logic Changed

- `SYS_BuildInputContext`
  - Carries `person_id`, `conversation_id`, and `trajectory_id`.

- `SYS_RouteInput`
  - Keeps `/start` and `/recent`.
  - Adds `/help` as an alias to `/start`.

- `TRK_ParseEntry`
  - Adds deterministic parsing for short activity facts:
    - `английский 60` -> `activity_type_code = 'english'`, `duration_minutes = 60`
    - `лед 60` -> `activity_type_code = 'ice'`, `duration_minutes = 60`
    - `дриблинг 30` -> `activity_type_code = 'dribbling'`, `duration_minutes = 30`
  - Maps note-like entries to `trajectory_entries.entry_type = 'general_note'`.
  - Maps `observation`, `insight`, `feeling` directly to GPS MVP-1 trajectory entry types.

- `TRK_ExtractEntry`
  - Prompt updated to allow `feeling` and clarify that activity facts are parsed deterministically later.

- `HIS_ReplyStart`
  - Start/help copy updated for MVP-1:
    - plan
    - fact
    - observation
    - thought
    - insight
  - Commands minimized to `/start`, `/help`, `/recent`.

## Old Fields Removed

- `clients`
- `conversation_state`
- `telegram_user_id`
- `tracker_entries.id`
- `observations.source_entry_id`
- old `research_signal_candidates.source_observation_id`
- old `research_signal_candidates.source_entry_id`
- old `research_signal_candidates.signal_text`
- old `research_signal_candidates.signal_type`
- old `research_signal_candidates.evidence`
- old `research_signal_candidates.metadata`

## Live Tables Used

- `persons`
- `trajectories`
- `tracker_entries`
- `observations`
- `research_signal_candidates`
- `activity_events`
- `trajectory_entries`
- `conversations`
- `messages`

`conversations` and `messages` are used only to preserve the existing Conversation Engine behavior.
