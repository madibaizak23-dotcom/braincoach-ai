# instagram_analytics_mvp1

Status: Draft
Date: 2026-06-15
Execution layer: n8n
Database target: `bgs_orch`
Schema target: `production`

## Goal

Daily collect read-only Instagram content performance and comments from a Meta Instagram Graph API Professional account, store production telemetry in `bgs_orch.production`, and send a Telegram intelligence report.

This workflow does not autopost.
It does not publish replies.
It does not write to `bgs_core`.
It does not create SQL migrations.

## Trigger

- node: `TRG_ManualRun`
- source: manual n8n execution

- node: `TRG_ScheduledRun`
- source: schedule
- default cron: `0 9 * * *`
- timezone: `Asia/Qyzylorda`

## Required Configuration

Set these n8n environment variables or replace the placeholders in the nodes:

| variable | purpose |
| --- | --- |
| `BRAINCOACH_IG_USER_ID` | Instagram Professional account id. |
| `META_IG_ACCESS_TOKEN` | Meta access token with Instagram Graph API read permissions. |
| `BRAINCOACH_TELEGRAM_CHAT_ID` | Operator Telegram chat id for reports. |

Credentials:

- HTTP Request nodes use query-string `access_token` placeholder.
- Postgres nodes must use the `bgs_orch` credential, not `bgs_core`.
- Telegram node uses the BrainCoach operator bot credential.

## Node Map

```text
TRG_ManualRun
        \
         -> IG_ListRecentMedia -> SYS_SplitMediaItems -> IG_ReadMediaInsights -> IG_ReadMediaComments
        /                                                                                  |
TRG_ScheduledRun                                                                            v
                                                                             SYS_NormalizeMediaOutcome
                                                                                  |
                                                                                  v
                                                                             DB_SaveMediaSnapshot
                                                                                  |
                                                                                  v
                                                                             DB_SaveCommentSnapshots
                                                                                  |
                                                                                  v
                                                                             DB_SaveOutcome
                                                                                  |
                                                                                  v
                                                                             DB_ReadReportWindow
                                                                                  |
                                                                                  v
                                                                             SYS_FormatTelegramReport
                                                                                  |
                                                                                  v
                                                                             TG_SendInstagramReport
```

## Nodes

### TRG_ManualRun

- type: `n8n-nodes-base.manualTrigger`
- purpose: allow operator test runs.

### TRG_ScheduledRun

- type: `n8n-nodes-base.scheduleTrigger`
- purpose: run once daily.
- default cron: `0 9 * * *`

### IG_ListRecentMedia

- type: `n8n-nodes-base.httpRequest`
- method: `GET`
- endpoint:

```text
https://graph.facebook.com/v21.0/{{ $env.BRAINCOACH_IG_USER_ID }}/media
```

- fields:

```text
id,caption,media_type,media_product_type,permalink,timestamp,like_count,comments_count
```

### SYS_SplitMediaItems

- type: `n8n-nodes-base.code`
- purpose: convert Meta media list response into one n8n item per media object.
- default filter: keep media published yesterday or today.

### IG_ReadMediaInsights

- type: `n8n-nodes-base.httpRequest`
- method: `GET`
- endpoint:

```text
https://graph.facebook.com/v21.0/{{ $json.instagram_media_id }}/insights
```

- requested metrics:

```text
reach,views,saved,likes,comments,shares,total_interactions
```

The workflow stores whatever metrics Meta returns. Some metrics may be unavailable depending on media type, permissions, or API version.

### IG_ReadMediaComments

- type: `n8n-nodes-base.httpRequest`
- method: `GET`
- endpoint:

```text
https://graph.facebook.com/v21.0/{{ $json.instagram_media_id }}/comments
```

- fields:

```text
id,text,username,timestamp,like_count
```

### SYS_NormalizeMediaOutcome

- type: `n8n-nodes-base.code`
- purpose:
  - normalize media payload;
  - normalize metric map;
  - normalize comments;
  - compute repeated comment themes;
  - create a factual outcome summary.

### DB_SaveMediaSnapshot

- type: `n8n-nodes-base.postgres`
- operation: `executeQuery`
- credential: `POSTGRES | BGS_ORCH`
- table: `production.instagram_media_snapshots`
- status: draft, requires approved schema migration before successful execution.

### DB_SaveCommentSnapshots

- type: `n8n-nodes-base.postgres`
- operation: `executeQuery`
- credential: `POSTGRES | BGS_ORCH`
- table: `production.instagram_comment_snapshots`
- status: draft, requires approved schema migration before successful execution.

### DB_SaveOutcome

- type: `n8n-nodes-base.postgres`
- operation: `executeQuery`
- credential: `POSTGRES | BGS_ORCH`
- table: `production.outcomes`
- status: draft, requires approved schema migration before successful execution.

### DB_ReadReportWindow

- type: `n8n-nodes-base.postgres`
- operation: `executeQuery`
- purpose: read yesterday/today media, comments, and outcomes for Telegram reporting.

### SYS_FormatTelegramReport

- type: `n8n-nodes-base.code`
- purpose: build a compact operator-facing Telegram report.

Report sections:

- yesterday/today top content;
- what performed best;
- what underperformed;
- repeated comment themes;
- possible market signals;
- recommended next content action.

### TG_SendInstagramReport

- type: `n8n-nodes-base.telegram`
- purpose: send report to operator Telegram chat.

## Postgres Dependencies

Draft proposal:

`braincoach-docs/07_automation/04_postgres/instagram_analytics_mvp1_schema_proposal.md`

Required tables after approval:

- `production.outcomes`
- `production.instagram_media_snapshots`
- `production.instagram_comment_snapshots`

## Meta API Notes

The Meta Instagram Graph API media reference states that IG Media reads support fields such as `id`, `caption`, `comments_count`, `like_count`, `media_type`, `permalink`, `timestamp`, and the `comments` and `insights` edges for Instagram Professional-account media.

References:

- `https://developers.facebook.com/docs/instagram-platform/reference/instagram-media`

## Manual Run

1. Review and approve the draft schema proposal.
2. Create and apply a separate approved SQL migration for `bgs_orch.production`.
3. Import `instagram_analytics_mvp1.json` into n8n.
4. Replace credential placeholders with the live `bgs_orch`, Meta, and Telegram credentials.
5. Execute `TRG_ManualRun`.
6. Confirm rows were written to `bgs_orch.production.*`.
7. Confirm the Telegram report is delivered.

## Read-Only Boundary

This workflow only reads from Instagram and writes internal telemetry to `bgs_orch`.

It does not:

- create Instagram media;
- update Instagram media;
- enable or disable comments;
- publish comments;
- reply to comments;
- delete comments;
- write to `bgs_core`;
- create or apply SQL migrations.
