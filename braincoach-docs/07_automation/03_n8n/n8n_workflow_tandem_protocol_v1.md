# n8n Workflow Tandem Protocol v1

## Purpose

This file defines how we build BrainCoach n8n workflows together.

The working mode:
- user tests workflows in n8n and sends screenshots, errors, exports, or logs;
- Codex proposes next node changes, console commands, SQL, and deployment steps;
- every meaningful workflow, table, command, and decision is documented in this repository.

## Documentation Map

Use these folders for the automation layer:

- `braincoach-docs/07_automation/03_n8n/`
  n8n workflows, node maps, import/export JSON files, error notes.

- `braincoach-docs/07_automation/04_postgres/`
  Postgres schemas, table contracts, SQL migrations, data model notes.

- `braincoach-docs/05_operations/naming_conventions/`
  naming rules for workflows, nodes, tables, and operational commands.

- `migrations/`
  executable SQL migration files when database changes must be applied.

## Workflow File Pattern

For each n8n workflow, keep two files:

- `{workflow_name}_v{n}.md`
  Human-readable workflow description.

- `{workflow_name}_v{n}.json`
  n8n export/import file.

Example:

- `gps_capture_layer_v1.md`
- `gps_capture_layer_v1.json`

## Workflow Markdown Template

Use this structure when documenting a workflow:

```md
# workflow_name_v1

## Goal

What this workflow does in one paragraph.

## Trigger

- node: TG_Trigger
- source: Telegram / Webhook / Manual / Schedule
- input shape:

## Node Map

TG_Trigger
↓
SYS_LoadContext
↓
SYS_RouteInput
↓
DB_SaveEvent

## Nodes

### TG_Trigger

- type:
- purpose:
- required credentials:
- important settings:
- output:

### DB_SaveEvent

- type:
- purpose:
- table:
- input:
- output:

## Postgres Dependencies

- table:
- columns:
- indexes:
- constraints:

## Console Commands

```powershell
# command goes here
```

## Test Log

- date:
- test:
- result:
- issue:
- next action:
```

## Node Naming

Use the existing prefix style:

- `TG_` Telegram or trigger nodes
- `SYS_` system/context/routing nodes
- `VOI_` voice processing nodes
- `TRK_` tracker/event capture nodes
- `MEM_` memory nodes
- `AI_` model/extraction/response nodes
- `DB_` database utility nodes
- `CMD_` command parser nodes
- `SEM_` semantic search nodes
- `TRAJ_` trajectory engine nodes

Format:

```text
PREFIX_ActionObject
```

Examples:

- `TG_Trigger`
- `SYS_LoadContext`
- `TRK_SaveEntry`
- `DB_InsertObservation`
- `AI_ExtractSignals`

## Console Command Protocol

When a command is needed, document:

- where to run it;
- what it does;
- expected output;
- rollback or cleanup if relevant.

Command block format:

```powershell
# Location: project root
# Purpose: import an n8n workflow JSON
npx n8n import:workflow --input braincoach-docs/07_automation/03_n8n/workflow.json
```

## Postgres Table Protocol

For every new table, create or update a markdown contract in `07_automation/04_postgres/`.

Minimum table contract:

```md
# table_name

## Purpose

## Columns

| column | type | required | description |
| --- | --- | --- | --- |

## Indexes

## Relations

## Example Rows

## n8n Usage

## Migration
```

If executable SQL is needed, add it to `migrations/` with a numbered filename.

## Debug Loop

Use this loop for every n8n test:

1. User runs the workflow.
2. User sends screenshot, execution error, node output, or exported JSON.
3. Codex identifies the failing node and likely cause.
4. Codex gives exact node edits or console/SQL commands.
5. Codex updates docs or workflow JSON if needed.
6. User tests again.

## First Working Target

Recommended first workflow:

```text
gps_capture_layer_v1
```

Minimal node chain:

```text
TG_Trigger
↓
SYS_NormalizeInput
↓
SYS_RouteInput
↓
TRK_SaveRawEvent
↓
AI_ExtractObservation
↓
DB_SaveObservation
↓
TG_SendAck
```

