# BrainCoach Intelligence Monitor MVP-1

## Goal

Send a compact read-only Telegram intelligence monitor report from current `bgs_core` data.

The workflow reads live data, formats an operator-facing report, and sends it to Telegram.

It does not write to the database.

It does not create SQL migrations.

It does not modify any existing production workflow.

## Trigger

- `TRG_ManualRun`: manual n8n execution.
- `TRG_ScheduledRun`: scheduled execution at `0 9,21 * * *`.

The default schedule runs twice daily, at 09:00 and 21:00.

Workflow settings set timezone to `Asia/Qyzylorda`. If the n8n instance ignores workflow-level timezone for Schedule Trigger nodes, the schedule follows the n8n instance timezone.

## Node Map

```text
TRG_ManualRun
        \
         -> DB_ReadIntelligenceSnapshot -> SYS_FormatTelegramReport -> TG_SendMonitorReport
        /
TRG_ScheduledRun
```

## Nodes

### TRG_ManualRun

- type: `n8n-nodes-base.manualTrigger`
- purpose: allow operator-triggered monitor run from n8n.

### TRG_ScheduledRun

- type: `n8n-nodes-base.scheduleTrigger`
- purpose: run the monitor regularly.
- default cron: `0 9,21 * * *`

### DB_ReadIntelligenceSnapshot

- type: `n8n-nodes-base.postgres`
- operation: `executeQuery`
- credential: `POSTGRES | BGS_CORE`
- mode: read-only
- SQL action: one `WITH ... SELECT` statement.

### SYS_FormatTelegramReport

- type: `n8n-nodes-base.code`
- purpose: format the SQL snapshot into a compact Telegram message.
- output fields:
  - `report_text`
  - `chat_id`
  - `run_at`
  - `read_only`

### TG_SendMonitorReport

- type: `n8n-nodes-base.telegram`
- credential: `BrainCoach GPS`
- purpose: send the formatted report to the operator Telegram chat.

Before first run, replace:

```text
REPLACE_WITH_TELEGRAM_CHAT_ID
```

inside `SYS_FormatTelegramReport`.

## Source Tables

The workflow reads:

- `tracker_entries`
- `observations`
- `research_signal_candidates`
- `parent_interviews`
- `interview_responses`
- `conversations`
- `conversation_events`

## SQL SELECT Queries

The workflow uses one read-only query composed from CTE sections:

- `params`: run timestamp, daily window, last 24h window, stuck-stage threshold.
- `data_intake`: counts tracker entries, observations, and signal candidates.
- `interview_funnel`: counts parent interview statuses.
- `stage_counts`: active conversations by `current_stage`.
- `top_today`: top `signal_name` today.
- `top_all`: top `signal_name` all time.
- `status_counts`: candidate lifecycle status counts.
- `signal_summary`: average confidence, low-confidence count, top signals, statuses.
- `bottlenecks`: observation/signal gaps, stuck conversations, interview gaps, errors today.
- `repeated_themes`: repeated `signal_name` values in the last 24h.
- final `SELECT`: returns JSON sections for Telegram formatting.

No `INSERT`, `UPDATE`, `DELETE`, `CREATE`, `ALTER`, `DROP`, migration, or schema operation is used.

## Report Sections

The Telegram report includes:

- Data Intake
- Interview Funnel
- Signals
- Bottlenecks
- Daily Intelligence Draft

## Manual Run

1. Import `BrainCoach Intelligence Monitor MVP-1.json` into n8n.
2. Open `SYS_FormatTelegramReport`.
3. Replace `REPLACE_WITH_TELEGRAM_CHAT_ID` with the operator Telegram chat id.
4. Open the workflow.
5. Click `Execute Workflow`.

## Schedule Changes

Open `TRG_ScheduledRun` and update the cron expression.

Default:

```text
0 9,21 * * *
```

Examples:

```text
0 9 * * *
0 9,18 * * *
*/30 * * * *
```

## Read-Only Boundary

This workflow is read-only.

It does not:

- create tables;
- run migrations;
- change schema;
- insert rows;
- update rows;
- delete rows;
- alter existing workflows;
- change Interview Bot;
- change Tracker workflow.
