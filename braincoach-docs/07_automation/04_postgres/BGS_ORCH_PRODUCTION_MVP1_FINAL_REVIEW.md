# BGS Orch Production MVP-1 Final Review

Status: Applied Manually By Owner

Date: 2026-06-18

Database: `bgs_orch`

Schema: `production`

Migrations:

* `007_bgs_orch_instagram_analytics_mvp1.sql`
* `008_bgs_orch_weekly_content_automation_mvp1.sql`

Operational seeds:

* `009_seed_weekly_content_plan_2026_06_22.sql`

## Purpose

Record the live installation and verification of the first `bgs_orch.production` tables for BrainCoach marketing, content automation, Instagram telemetry, market signals, and tracker monitoring.

Codex prepared SQL and documentation.

Owner installed the migrations manually in Cloud SQL.

## Installation Confirmation

Owner confirmed active database and user:

```text
current_database = bgs_orch
current_user     = bgs_admin
```

`007_bgs_orch_instagram_analytics_mvp1.sql` installed successfully.

`008_bgs_orch_weekly_content_automation_mvp1.sql` installed successfully.

Expected `pgcrypto` and `production` existing notices were observed during `008`:

```text
extension "pgcrypto" already exists, skipping
schema "production" already exists, skipping
```

## Tables Confirmed

Owner verified 11 live tables in `production`:

| table | role |
| --- | --- |
| `content_outcomes` | channel-specific outcome records linked to content units / executions |
| `content_units` | planned content units by channel, format, date, KPI, CTA |
| `generated_content_assets` | generated copy/scripts/assets for content units |
| `instagram_comment_inbox_items` | classified Instagram comment inbox items |
| `instagram_comment_snapshots` | read-only Instagram comment snapshots |
| `instagram_media_snapshots` | read-only Instagram media metric snapshots |
| `market_signals` | classified marketing / offer / sales response signals |
| `outcomes` | generic Instagram production outcome summaries |
| `publishing_executions` | actual publishing execution records |
| `tracker_monitoring_items` | monitoring records for Tracker / daily control loop |
| `weekly_content_plans` | weekly content plan root object |

## Constraints Confirmed

Owner verified:

```text
37 constraints
9 foreign keys
```

Confirmed FK chain:

```text
weekly_content_plans
->
content_units
->
generated_content_assets

content_units
->
publishing_executions
->
content_outcomes

content_units / content_outcomes
->
market_signals

weekly_content_plans / content_units
->
tracker_monitoring_items
```

## Smoke Test

Owner inserted:

* one `weekly_content_plans` row;
* one linked `content_units` row.

Confirmed counts:

```text
weekly_plans  = 1
content_units = 1
```

Confirmed join:

```text
CPLAN-2026-06-22-W01
->
CUNIT-2026-06-22-IG-REEL-01
```

Theme:

```text
Мы столько вложили. Что останется к осени?
```

## First Weekly Plan Seed

Owner applied:

```text
\i 009_seed_weekly_content_plan_2026_06_22.sql
```

Result:

```text
INSERT 0 1
INSERT 0 68
```

Confirmed weekly plan:

```text
CPLAN-2026-06-22-W01
2026-06-22 -> 2026-06-28
status = draft
```

Content units confirmed:

| platform | format | units |
| --- | --- | ---: |
| Facebook | Post | 5 |
| Instagram | Carousel | 2 |
| Instagram | Reel | 4 |
| Instagram | Story | 35 |
| Telegram | Note | 7 |
| Threads | Post | 4 |
| Threads | Thread | 3 |
| TikTok | Short | 4 |
| YouTube Shorts | Short | 4 |

Total:

```text
68 content units
```

The `publishing_scheduler_hypothesis` metadata was confirmed in the weekly plan. It stores the first candidate baseline for Stories, Reels/Shorts/TikTok, Carousel, Facebook, Telegram, and Threads publication windows. This baseline is a weekly test hypothesis, not a permanent rule.

Attachment review note:

The owner-provided `planned_date / platform / format / topic / publishing_time_label` output confirmed all 68 rows. The pasted text displayed Cyrillic as mojibake during copy/export, but the row structure, platform distribution, and publishing windows matched the seed.

## Monday Generated Assets Seed

Owner applied:

```text
\i 010_seed_generated_assets_2026_06_22_monday_mvp.sql
```

Result:

```text
BEGIN
DELETE 0
INSERT 0 11
COMMIT
```

Confirmed:

```text
monday_generated_assets = 11
voice_check_status = pending
approval_status = pending
assets = 11
```

This confirms the first live transition:

```text
content_units
->
generated_content_assets
```

No generated asset was approved, scheduled, or published.

## Monday Public-Language Correction Seed

Owner applied:

```text
\i 011_update_monday_generated_assets_public_language_v1.sql
```

Confirmed:

```text
corrected_assets = 4
voice_check_status = pending
approval_status = pending
assets = 11
```

Purpose:

Reduce public overuse of internal BrainCoach wording before Telegram Review.

Corrected assets:

* `CUNIT-2026-06-22-IG-REEL-01`
* `CUNIT-2026-06-22-IG-STORY-05`
* `CUNIT-2026-06-22-THREADS-01`
* `CUNIT-2026-06-22-TG-01`

No `content_units` were changed.

No generated asset was approved, scheduled, or published.

## Safety

No `bgs_core` changes were made.

No n8n platform/runtime tables were modified.

No public Instagram action was created.

No automatic publishing, comment reply, or Direct message action was enabled.

## Source Of Truth

Installed migration files:

* `braincoach-docs/07_automation/04_postgres/007_bgs_orch_instagram_analytics_mvp1.sql`
* `braincoach-docs/07_automation/04_postgres/008_bgs_orch_weekly_content_automation_mvp1.sql`

Installed operational seed:

* `braincoach-docs/07_automation/04_postgres/009_seed_weekly_content_plan_2026_06_22.sql`
* `braincoach-docs/07_automation/04_postgres/010_seed_generated_assets_2026_06_22_monday_mvp.sql`
* `braincoach-docs/07_automation/04_postgres/011_update_monday_generated_assets_public_language_v1.sql`

Architecture / build references:

* `braincoach-docs/07_automation/03_n8n/weekly_content_automation_mvp1_build_plan.md`
* `braincoach-docs/07_automation/03_n8n/marketing_sales_automation_mvp1.md`
* `braincoach-docs/07_automation/production_os/03_content/weekly_content_generation_mvp1.md`

## Result

`bgs_orch.production` is now live as the first BrainCoach production-process memory layer for marketing and content automation MVP work.

Next implementation step:

```text
Generate first approved day package into generated_content_assets, then build n8n Weekly Package Generator MVP-1 against bgs_orch.production.
```
