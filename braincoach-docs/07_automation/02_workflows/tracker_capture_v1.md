# tracker_capture_v1

Status: Production MVP
Layer: Automation / Tracker Intake
Implementation: n8n (BrainCoach GPS OS V3)
Last Updated: 2026-06-09

## Purpose

`tracker_capture_v1` captures user observations from Telegram and converts them into structured BrainCoach objects.

Current scope:

```text
Raw Input
->
Observation
->
Signal Candidate
```

This workflow is not a journaling system.

Tracker is the intake layer of BrainCoach GPS and the signal detection engine.

## Strategic Role

BrainCoach GPS tracks trajectory earlier than visible results.

Tracker is the first operational layer that turns reality into persistent objects.

Future object evolution:

```text
Raw Input
->
Observation
->
Signal
->
Deviation
->
Phenomenon
->
Research Object
->
Model
->
Decision
```

Current implementation covers:

```text
Raw Input
->
Observation
->
Signal Candidate
```

## Current Workflow Flow

```text
TG_Trigger
->
VOI_CheckVoice
->
VOI_GetFile / text path
->
VOI_Transcribe
->
VOI_NormalizeTranscript
->
SYS_LoadContext
->
SYS_BuildInputContext
->
SYS_RouteInput
->
TRK_IsTrackerEvent
->
TRK_SaveRawEvent
->
TRK_ExtractEntry
->
TRK_ParseEntry
->
TRK_SaveEntry
->
OBS_CreateObservation
->
SIG_ExtractSignalCandidate
->
SIG_ParseCandidate
->
SIG_HasCandidate
->
DB_SaveSignalCandidate (if signal exists)
->
TRK_GetEntryCount
->
TRK_ReplySaved
```

Command/history branch:

```text
SYS_RouteInput
->
TRK_IsTrackerEvent
->
HIS_CheckRecent
->
HIS_LoadEntries
->
HIS_FormatReply
->
HIS_Reply
```

## Current Capabilities

Validated:

- voice capture from Telegram
- text capture from Telegram
- voice transcription
- basic input routing
- tracker entry classification
- persistence into `messages`
- persistence into `tracker_entries`
- observation creation in `observations`
- signal candidate extraction via `SIG_*` nodes
- signal candidate persistence in `research_signal_candidates`
- `/recent` command for recent tracker entries

Not yet implemented:

- deviation detection
- phenomenon creation
- deduplication across observations
- structured metadata persistence from extractor output (tags, summary)
- signal candidate promotion workflow
- object lifecycle states beyond `captured`

## Current Tables

| table | role |
| --- | --- |
| `clients` | user identity and current tracker state |
| `conversation_state` | working state for the current user |
| `messages` | raw user message persistence |
| `tracker_entries` | captured tracker notes and classified entry type |
| `observations` | first structured BrainCoach object created from tracker input |
| `research_signal_candidates` | staging table for signal candidates extracted from observations |

## Current Nodes

### `TG_Trigger`

Type: Telegram Trigger

Purpose: Receives Telegram `message` updates.

Input: Telegram text or voice message.

Output: Telegram message payload.

### `VOI_CheckVoice`

Type: IF

Purpose: Routes voice messages through transcription and text messages directly to context loading.

Condition:

```text
$json.message.voice?.file_id is not empty
```

### `VOI_GetFile`

Type: Telegram file

Purpose: Downloads the Telegram voice file for transcription.

### `VOI_Transcribe`

Type: Google Gemini audio

Purpose: Transcribes voice input into text.

Current model:

```text
models/gemini-3.5-flash
```

### `VOI_NormalizeTranscript`

Type: Code

Purpose: Normalizes Gemini transcript output into:

```json
{
  "text": "...",
  "route": "voice"
}
```

### `SYS_LoadContext`

Type: Postgres

Purpose:

- upserts `clients`
- ensures `conversation_state`
- sets current stage to `tracking`
- returns user state and qualification context

Tables:

- `clients`
- `conversation_state`

### `SYS_BuildInputContext`

Type: Code

Purpose: Selects normalized voice transcript or Telegram text and attaches current user context.

Output shape:

```json
{
  "text": "...",
  "current_stage": "...",
  "sub_stage": "...",
  "pattern_type": "...",
  "allow_reminders": true
}
```

### `SYS_RouteInput`

Type: Code

Purpose: Routes slash commands separately from tracker capture.

Routes:

- `command` when text starts with `/`
- `tracker` for normal captured input

### `TRK_IsTrackerEvent`

Type: IF

Purpose: Sends tracker events into persistence and commands into history handling.

### `TRK_SaveRawEvent`

Type: Postgres

Purpose: Saves raw user message into `messages`.

Current behavior:

- `role = user`
- `content = normalized text`
- `created_at = now()`

### `TRK_ExtractEntry`

Type: LangChain Agent

Purpose: Classifies tracker input.

Current expected JSON:

```json
{
  "entry_type": "note",
  "tags": [],
  "summary": ""
}
```

Allowed `entry_type` values:

- `note`
- `idea`
- `insight`
- `decision`
- `observation`
- `hypothesis`
- `task`

Current limitation:

The workflow currently saves only `entry_type`; `tags` and `summary` are not persisted into `tracker_entries.metadata`.

### `TRK_ParseEntry`

Type: Code

Purpose: Parses classifier JSON output.

Current risk:

The node calls `JSON.parse(raw)` directly. Invalid model output can fail the execution.

### `TRK_SaveEntry`

Type: Postgres

Purpose: Saves normalized input into `tracker_entries`.

Current inserted fields:

- `telegram_user_id`
- `content`
- `entry_type`

### `OBS_CreateObservation`

Type: Postgres

Purpose: Creates an `observations` row from the tracker entry.

Current inserted fields:

- `telegram_user_id`
- `observation_text`
- `source_entry_id`
- `current_state = captured`

### `SIG_ExtractSignalCandidate`

Type: LangChain Agent (Version 3.1)

Purpose: Analyzes the observation text to detect if it contains a development signal candidate.

Expected output JSON:
```json
{
  "has_signal": true,
  "signal_text": "",
  "signal_type": "",
  "confidence": 0.0,
  "evidence": "",
  "reason": ""
}
```

### `SIG_ParseCandidate`

Type: Code (Version 2)

Purpose: Parses the string output from the LangChain Agent into a structured JSON object.

### `SIG_HasCandidate`

Type: IF (Version 2.3)

Purpose: Checks if `has_signal` is true in the parsed object. If yes, routes to DB persistence; if no, bypasses and routes directly to the total entry count.

### `DB_SaveSignalCandidate`

Type: Postgres (Version 2.6)

Purpose: Saves the candidate signal to the `research_signal_candidates` staging table.

### `TRK_GetEntryCount`

Type: Postgres

Purpose: Counts tracker entries for the current user.

### `TRK_ReplySaved`

Type: Telegram

Purpose: Confirms that the entry was saved.

### `HIS_CheckRecent`

Type: IF

Purpose: Detects `/recent`.

### `HIS_LoadEntries`

Type: Postgres

Purpose: Loads latest 5 non-command tracker entries.

### `HIS_FormatReply`

Type: Code

Purpose: Formats recent entries for Telegram reply.

### `HIS_Reply`

Type: Telegram

Purpose: Sends `/recent` reply.

## Incremental Upgrade Rule

Do not redesign the whole workflow while the MVP is working.

Future changes should be incremental and should preserve:

- Telegram trigger
- voice/text capture
- `messages` raw persistence
- `tracker_entries` persistence
- `observations` creation
- `/recent` command branch

Every proposed upgrade must include:

1. Architecture rationale
2. n8n node config
3. SQL migration if needed
4. Documentation updates required
5. Knowledge OS placement

## Stage 3 Completion

Stage 3 completed 2026-06-09.

Signal candidate extraction is operational in BrainCoach GPS OS V3.

Former production export: `BrainCoach GPS OS — Stage 3 Complete.json`

Migration status: completed 2026-06-13.

Current production export: `BrainCoach GPS MVP-1 — bgs_core adapted.json`

Migration report: `BrainCoach GPS MVP-1 — bgs_core adapted.diff-report.md`

Notes:

- The Stage 3 workflow was not rebuilt from scratch.
- The Telegram trigger, voice transcription, routing, tracker extraction, signal candidate extraction, replies, `/start`, `/help`, and `/recent` paths were preserved.
- The PostgreSQL layer now uses live `bgs_core` tables: `persons`, `trajectories`, `tracker_entries`, `observations`, `research_signal_candidates`, `activity_events`, and `trajectory_entries`.
- The legacy Stage 3 export was removed from `03_n8n` after successful import and owner confirmation to prevent workflow duplication.

First validated signal categories: `self_initiation`, `dependence_external`

Known limitation: research notes and parent reflections can be misclassified as behavioral signals. Tracked for Signal Taxonomy v2.

## Recommended Next Increment (Stage 4)

Next upgrade should add analytics and intelligence over accumulated signal candidates.

Recommended evolution:

```text
research_signal_candidates
->
analytics views
->
signal aggregation
->
pattern detection
->
weekly reports
```

Deferred:

- signal candidate promotion (candidate → accepted → promoted)
- deviation detection
- phenomenon creation
- deduplication across observations

Reason:

The system now accumulates signal data. Stage 4 makes this data useful through aggregation, pattern detection, and reporting before promoting candidates to confirmed signals.

## Documentation Dependencies

When this workflow changes, update:

- `braincoach-docs/07_automation/02_workflows/tracker_capture_v1.md`
- `braincoach-docs/07_automation/03_n8n/{workflow_export}.json` when an export is saved
- `braincoach-docs/07_automation/04_postgres/postgres-schema.md` if tables change
- `braincoach-docs/07_automation/04_postgres/braincoach_owned_tables.md` if tables are added
- `braincoach-docs/03_knowledge/04_decisions/system_evolution_log.md` if the change is architectural
