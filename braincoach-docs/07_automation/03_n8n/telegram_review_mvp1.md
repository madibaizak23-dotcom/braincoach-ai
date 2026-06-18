# Telegram Review MVP-1

Status: Draft Build Spec

Date: 2026-06-18

Layer: Production OS / Review

Storage target: `bgs_orch.production.generated_content_assets`

Workflow target: n8n + Telegram Bot

Importable workflow:

`braincoach-docs/07_automation/03_n8n/telegram_review_command_only_mvp1.json`

This is the single Telegram Review MVP-1 workflow. The earlier manual-send draft was removed after the stable command-only Telegram path was verified.

Telegram credential:

```text
BrainCoach Content Manager
```

Bot username:

```text
content_manager_assist_bot
```

## Purpose

Create the first operator review loop for generated content assets.

This MVP turns:

```text
generated_content_assets
->
Telegram Review
->
human decision
->
approval_status update
```

It does not publish content.

It does not change the weekly plan, Channel Matrix, Scheduler, or `content_units`.

## Current Use Case

Review Monday package for:

```text
CPLAN-2026-06-22-W01
planned_date = 2026-06-22
generator = monday_generator_mvp1
```

Current package:

* 11 generated assets;
* 4 public-language corrections already applied;
* all assets remain `voice_check_status = pending`;
* all assets remain `approval_status = pending`.

## MVP Boundary

Allowed:

* read pending generated assets;
* send review cards to Telegram;
* receive approve / needs_edit / reject commands;
* update `approval_status`;
* update `voice_check_status`;
* append review notes into `metadata`;
* keep assets pending until explicit human command.

Not allowed:

* autopublishing;
* scheduling;
* editing `content_units`;
* editing weekly strategy;
* generating Tuesday before Monday review decisions are captured.

## Workflow 1: Send Monday Review Package

Status:

Deprecated for MVP-1 runtime. Use `/review_card monday` from the command handler instead.

Name:

```text
BGS TG Content Review MVP-1 Send Monday Package
```

Trigger:

Manual n8n execution.

Flow:

```text
TRG_ManualSendMondayReview
->
DB_ReadMondayGeneratedAssets
->
SYS_BuildReviewCards
->
TG_SendReviewHeader
->
TG_SendReviewCards
->
TG_SendCommandHelp
```

DB query:

Use:

`braincoach-docs/07_automation/04_postgres/012_monday_telegram_review_queries.sql`

Main read query:

```text
QUERY 01: Read Monday review package
```

Telegram header:

```text
BrainCoach Monday Review
CPLAN-2026-06-22-W01
2026-06-22

Status:
11 assets pending review.
No asset is approved.
No publishing is enabled.
```

Review card format:

```text
[1/11] Instagram / Reel
CUNIT-2026-06-22-IG-REEL-01
asset_type: reel_script
status: pending / pending

<asset_text preview or full text>

Commands:
/approve CUNIT-2026-06-22-IG-REEL-01
/needs_edit CUNIT-2026-06-22-IG-REEL-01 reason
/reject CUNIT-2026-06-22-IG-REEL-01 reason
```

MVP sending rule:

First run must be smoke-test mode:

```text
sendLimit = 1
```

Send header, first asset card, and command help.

Do not send all 11 cards on the first execution.

After smoke-test passes, increase sending by small batches.

Send one Telegram message per asset. Do not put all 11 assets into one very long message.

If a text is too long for Telegram:

* send first message with metadata and command help;
* send asset text as a second message;
* keep `content_unit_code` visible in both messages.

## Workflow 2: Receive Review Commands

Name:

```text
BGS TG Content Review MVP-1 Command Handler
```

Trigger:

Telegram Trigger.

Accepted commands:

```text
/approve <content_unit_code>
/needs_edit <content_unit_code> <reason>
/reject <content_unit_code> <reason>
/review_status monday
```

Command rules:

* `/approve` requires only `content_unit_code`.
* `/needs_edit` requires `content_unit_code` and reason.
* `/reject` requires `content_unit_code` and reason.
* Unknown content units must return a safe error.
* Commands only affect assets with:

```text
metadata.generator = monday_generator_mvp1
metadata.content_plan_code = CPLAN-2026-06-22-W01
metadata.planned_date = 2026-06-22
```

## Status Updates

Approve:

```text
approval_status = approved
voice_check_status = passed
approved_at = now()
metadata.review_status = approved
metadata.reviewed_by = telegram_operator
metadata.reviewed_at = now()
```

Needs edit:

```text
approval_status = needs_edit
voice_check_status = needs_edit
approved_at = null
metadata.review_status = needs_edit
metadata.review_note = <reason>
metadata.reviewed_by = telegram_operator
metadata.reviewed_at = now()
```

Reject:

```text
approval_status = rejected
voice_check_status = failed
approved_at = null
metadata.review_status = rejected
metadata.review_note = <reason>
metadata.reviewed_by = telegram_operator
metadata.reviewed_at = now()
```

## Telegram Replies

Approve reply:

```text
Approved:
CUNIT-2026-06-22-IG-REEL-01

Status:
approval_status = approved
voice_check_status = passed
```

Needs edit reply:

```text
Needs edit:
CUNIT-2026-06-22-IG-REEL-01

Reason saved:
<reason>
```

Reject reply:

```text
Rejected:
CUNIT-2026-06-22-IG-REEL-01

Reason saved:
<reason>
```

Status reply:

```text
Monday Review Status

pending: N
approved: N
needs_edit: N
rejected: N
```

## Data Safety

The command handler must never update by loose text search.

It must always restrict updates by:

* `content_unit_code`;
* `metadata.generator`;
* `metadata.content_plan_code`;
* `metadata.planned_date`.

The workflow must not touch:

* `weekly_content_plans`;
* `content_units`;
* `publishing_executions`;
* `content_outcomes`;
* `market_signals`;
* Tracker tables.

## Operator Policy

Monday review is the gate before Tuesday Generator.

Tuesday Generator may start only when one of these is true:

1. all 11 Monday assets are `approved`;
2. some assets are `needs_edit`, but explicit human decision says Tuesday can proceed;
3. rejected assets have been intentionally removed from Monday publishing scope.

Default:

```text
Do not start Tuesday Generator while Monday assets are still pending.
```

## First MVP Build Order

1. Add Telegram bot token to n8n credentials as `BrainCoach Content Manager`.
2. Add Postgres credential for `bgs_orch`.
3. Import `telegram_review_command_only_mvp1.json`.
4. Replace placeholder credentials with real n8n credentials.
5. Test `/review_status monday`.
6. Test `/review_card monday`.
7. Test `/needs_edit` on one non-critical asset.
8. Reset status if needed.
9. Continue review card by card through Telegram commands.

## Related

* `braincoach-docs/07_automation/04_postgres/012_monday_telegram_review_queries.sql`
* `braincoach-docs/07_automation/04_postgres/010_seed_generated_assets_2026_06_22_monday_mvp.sql`
* `braincoach-docs/07_automation/04_postgres/011_update_monday_generated_assets_public_language_v1.sql`
* `braincoach-docs/07_automation/03_n8n/weekly_content_automation_mvp1_build_plan.md`
* `braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-035-weekly-production-cycle-freeze.md`
