# tracker_capture_v1

Status: Working MVP
Layer: Automation / Tracker Intake
Implementation: n8n
Last Updated: 2026-06-08

## Purpose

`tracker_capture_v1` captures user observations from Telegram and converts them into structured BrainCoach objects.

Current scope:

```text
Raw Input
->
Observation
```

This workflow is not a journaling system.

Tracker is the intake layer of BrainCoach GPS and the future signal detection engine.

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

Current implementation covers only:

```text
Raw Input
->
Observation
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
- voice transcription through Gemini
- basic input routing
- tracker entry classification
- persistence into `messages`
- persistence into `tracker_entries`
- observation creation in `observations`
- `/recent` command for recent tracker entries

Not optimized yet:

- signal extraction
- deviation detection
- phenomenon creation
- deduplication across observations
- structured metadata persistence from extractor output
- confidence scoring
- object lifecycle states beyond `captured`

## Current Tables

| table | role |
| --- | --- |
| `clients` | user identity and current tracker state |
| `conversation_state` | working state for the current user |
| `messages` | raw user message persistence |
| `tracker_entries` | captured tracker notes and classified entry type |
| `observations` | first structured BrainCoach object created from tracker input |

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

## Recommended Next Increment

Next upgrade should add signal candidate extraction without changing current observation creation.

Recommended object evolution:

```text
tracker_entries
->
observations
->
signal_candidates
```

Recommended new table:

```text
research_signal_candidates
```

Status:

```text
Database table created.
n8n insertion nodes not yet added.
```

Reason:

The system should not immediately promote every observation into a confirmed signal. A candidate layer allows review, confidence scoring, deduplication, and later promotion.

Recommended new nodes:

```text
OBS_CreateObservation
->
SIG_ExtractSignalCandidate
->
SIG_ParseCandidate
->
DB_SaveSignalCandidate
->
TRK_GetEntryCount
```

Recommended initial fields:

- `id`
- `telegram_user_id`
- `source_observation_id`
- `signal_text`
- `signal_type`
- `confidence`
- `evidence`
- `status`
- `metadata`
- `created_at`
- `updated_at`

Knowledge OS placement:

- `observations` belong to Research OS intake.
- `research_signal_candidates` belong to the Research Layer.
- confirmed signals should later connect to `signal_registry` and `signal_dictionary`.

## Documentation Dependencies

When this workflow changes, update:

- `braincoach-docs/07_automation/02_workflows/tracker_capture_v1.md`
- `braincoach-docs/07_automation/03_n8n/{workflow_export}.json` when an export is saved
- `braincoach-docs/07_automation/04_postgres/postgres-schema.md` if tables change
- `braincoach-docs/07_automation/04_postgres/braincoach_owned_tables.md` if tables are added
- `braincoach-docs/03_knowledge/04_decisions/system_evolution_log.md` if the change is architectural
