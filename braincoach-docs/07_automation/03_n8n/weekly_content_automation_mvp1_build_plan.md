# Weekly Content Automation MVP-1 Build Plan

Status: Draft Build Plan

Date: 2026-06-18

Execution layer: n8n + Telegram operator loop + Tracker monitoring

Storage target: `bgs_orch.production`

## Purpose

Define how BrainCoach will automate weekly content package generation, daily publishing monitoring, Telegram reporting, and tracker follow-up.

This build connects:

```text
weekly content strategy
->
Postgres production tables
->
n8n generation workflow
->
Telegram weekly package report
->
daily Telegram publishing reminders
->
manual / approved publishing
->
execution and outcome capture
->
Tracker monitoring
->
weekly correction report
```

## Build Principle

Start with human-approved generation and monitoring.

Do not start with autopublishing.

After a weekly seed is installed, do not redesign the weekly brief, channel matrix, or scheduler until the week is complete.

The live week is a signal test under stable conditions.

Allowed changes before publishing are limited to:

* generated drafts;
* scripts;
* captions;
* story text;
* visual briefs;
* CTA wording;
* production notes.

The first automation advantage is:

* one weekly package instead of scattered manual work;
* one source of truth for planned content units;
* Telegram visibility before each publishing window;
* actual execution tracking;
* signal capture after publication;
* correction of the next weekly plan.

## MVP-1 Workflow Set

### 1. Weekly Package Generator

Goal:

Generate a full weekly content package from an approved weekly strategy.

MVP-1 implementation order:

```text
Monday Generator MVP
->
Review first day package
->
Generate remaining day packages
->
Weekly package review
```

Do not generate all 68 content units in one flat pass.

First target for `CPLAN-2026-06-22-W01`:

* Monday Instagram Reel;
* Monday 5 Stories;
* Monday Threads;
* Monday Facebook;
* Monday Telegram;
* Monday TikTok;
* Monday YouTube Shorts.

Before Tuesday Generator starts, the Monday package must pass pilot review or receive explicit human corrections.

Tuesday and later generators must apply:

```text
Main Conversation stays constant.
Daily language changes.
```

For this week:

* Monday language: investment / what remains.
* Tuesday language: first concern / when the parent started worrying.
* Wednesday language: same opportunities / different results.
* Thursday language: what can be lost this summer.
* Friday language: what parents already tried.
* Saturday language: why help does not always become movement.
* Sunday language: weekly signals and next correction.

Public-language rule:

Use `траектория` sparingly. Prefer `движение`, `прогресс`, `направление`, `результат`, and `что держится в ребенке`.

Flow:

```text
TRG_ManualWeeklyGeneration
->
DB_ReadApprovedWeeklyStrategy
->
AI_GenerateContentMatrix
->
AI_GenerateReelsScripts
->
AI_GenerateStorySequences
->
AI_GenerateChannelAdaptations
->
AI_GenerateSignalCapturePlan
->
DB_SaveContentPlan
->
DB_SaveContentUnits
->
DB_SaveGeneratedAssets
->
TG_SendWeeklyPackageReview
```

Telegram output:

* weekly theme;
* daily topics;
* reels count;
* stories count;
* Threads / Facebook / Telegram adaptations;
* missing assets;
* approval buttons / commands.

### 2. Daily Publishing Monitor

Goal:

Send daily publishing cards and track whether content was published on time.

Flow:

```text
TRG_DailyPublishingMonitor
->
DB_ReadTodayApprovedContentUnits
->
SYS_BuildPublishingCards
->
TG_SendPublishingReminders
->
TG_WaitForPublishedRescheduleSkip
->
DB_RecordProductionExecution
->
TRK_CreateMonitoringEntry
```

Telegram commands:

```text
/published <content_unit_code>
/reschedule <content_unit_code> <new_time>
/skip <content_unit_code> <reason>
/needs_edit <content_unit_code>
```

### 3. Daily Outcome Collector

Goal:

Collect what happened after publication and create a daily operational report.

Flow:

```text
TRG_DailyOutcomeCollector
->
IG_ReadAnalytics
->
MANUAL_ReadNonInstagramOutcomes
->
DB_SaveProductionOutcome
->
AI_ClassifySignals
->
DB_SaveMarketSignals
->
TG_SendDailyContentReport
->
TRK_SaveDailyMonitoringSummary
```

Daily Telegram report answers:

* what was planned today;
* what was published;
* what was missed / late;
* strongest response;
* possible market signals;
* what to watch tomorrow.

### 4. Weekly Correction Report

Goal:

Turn the week into next-week planning input.

Flow:

```text
TRG_WeeklyCorrectionReview
->
DB_ReadWeeklyPlanExecutionOutcomes
->
AI_CompareHypothesisVsOutcome
->
AI_FindWorkingWindows
->
AI_FindContentSignals
->
AI_RecommendNextWeekCorrection
->
TG_SendWeeklyCorrectionReport
->
TRK_SaveWeeklyReviewEntry
```

Weekly report answers:

* which theme / format / hook worked;
* which publishing windows worked;
* which channels produced replies, DM, saves, or profile visits;
* which payment triggers appeared;
* what to keep;
* what to modify;
* what to drop;
* what to test next week.

## Postgres Objects

MVP-1 needs production-process memory in `bgs_orch.production`.

Logical tables:

* `production.weekly_content_plans`
* `production.content_units`
* `production.generated_content_assets`
* `production.publishing_executions`
* `production.content_outcomes`
* `production.market_signals`
* `production.tracker_monitoring_items`

Draft SQL:

`braincoach-docs/07_automation/04_postgres/draft_weekly_content_automation_mvp1.sql`

This is draft only.

It must not be applied until reviewed and approved.

## Tracker Integration

Tracker should receive monitoring entries, not raw generated content.

Tracker entries should capture:

* today publishing plan;
* missed / late publishing windows;
* daily content execution summary;
* weekly correction summary;
* founder action reminders;
* bottleneck notes.

Example tracker entry:

```text
Content monitoring 2026-06-22:
planned 1 reel + 5 stories.
Published reel late by 18 min.
Morning stories on time.
Evening CTA missed.
Signal: parents replied to "what remains by autumn?"
Correction: prepare evening CTA before 18:00 tomorrow.
```

## Build Order

1. Approve draft table shape.
2. Apply `bgs_orch.production` schema migration only after approval.
3. Build Weekly Package Generator in n8n.
4. Generate first weekly package for:

```text
Мы столько вложили. Что останется к осени?
```

5. Send weekly package to Telegram for review.
6. Build Daily Publishing Monitor.
7. Build Daily Outcome Collector using existing Instagram Analytics MVP-1.
8. Add Tracker monitoring entries.
9. Build Weekly Correction Report.
10. Only later add approved publishing assistant.

## Non-Goals

MVP-1 does not:

* autopublish;
* send automatic public replies;
* send automatic DMs;
* write generated content into `bgs_core`;
* treat weak response as validated signal;
* replace human approval.

## Related

* `braincoach-docs/07_automation/production_os/03_content/weekly_content_generation_mvp1.md`
* `braincoach-docs/07_automation/production_os/04_execution/publishing_scheduler_hypothesis_v1.md`
* `braincoach-docs/07_automation/03_n8n/marketing_sales_automation_mvp1.md`
* `braincoach-docs/07_automation/03_n8n/instagram_analytics_mvp1.md`
* `braincoach-docs/07_automation/02_workflows/tracker_capture_v1.md`
