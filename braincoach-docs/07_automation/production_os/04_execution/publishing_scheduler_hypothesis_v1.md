# Publishing Scheduler Hypothesis v1

Status: Active Candidate

Date: 2026-06-18

Layer: Production OS / Execution Planning

## Purpose

Define how BrainCoach plans publishing windows across Instagram, Facebook, Threads, TikTok, YouTube Shorts, and Telegram while the system is still learning real audience behavior.

This is not a final "best time to post" rule.

It is a testable scheduling hypothesis that should be adapted from production outcomes.

## Principle

Publishing windows are candidates until BrainCoach has repeated account-specific evidence.

Generic Instagram advice may be used as external research input, but it must not override BrainCoach's own signal log, production outcomes, or audience behavior.

Weekly Content Plan is a weekly hypothesis test.

The purpose is not to guess the best time once.

The purpose is to build a repeatable audience-response model through planned publishing, measurement, correction, and reinforcement.

BrainCoach feed should behave like a research serial, not a set of disconnected posts.

Each week must preserve one main conversation and test how the audience responds to that conversation across formats, channels, hooks, CTAs, and publishing windows.

## Source Status

External posts about best publishing times should enter the system as:

```text
Object: Publishing Time Hypothesis
Source: external Instagram / creator / marketing advice
Status: Candidate
Use: test for 2 weeks
```

The system should preserve:

* source text or summary;
* date captured;
* channel;
* proposed time windows;
* assumptions;
* experiment window;
* metrics to review;
* decision after review.

## Baseline Daily Rhythm

The current BrainCoach Instagram rhythm is:

| Time window | Format | Production role |
| --- | --- | --- |
| 08:00-10:00 | Story 1 | Observation |
| 08:00-10:00 | Story 2 | Poll |
| 13:00-15:00 | Reel | Phenomenon of the day |
| 17:00-18:00 | Story 3 | Insight after reel |
| 20:00-21:30 | Story 4 | Question |
| 20:00-21:30 | Story 5 | CTA |

This rhythm remains the default until outcome data proves a better rhythm.

## Weekly Publishing Pattern

Default weekly pattern:

| Day | Primary role | Recommended format mix |
| --- | --- | --- |
| Monday | Open the weekly conversation | Reel, Stories, Threads, Facebook post |
| Tuesday | Capture recognition and objections | Reel, Stories, Threads |
| Wednesday | Explain the mechanism | Carousel or Reel, Stories, Telegram note |
| Thursday | Increase tension and show cost of inaction | Reel, Stories, Facebook post |
| Friday | Collect market data | Carousel or Reel, Stories, Facebook question |
| Saturday | Reframe ordinary solutions | Reel, Stories, Threads |
| Sunday | Review signals and prepare next week | Stories, Telegram recap, Facebook recap |

## Weekly Hypothesis Cycle

Each week is one test cycle:

```text
Weekly theme
->
content plan with publishing windows
->
publication
->
signal and metric capture
->
weekly review
->
next-week correction
```

The next week should be built as a correction of the previous hypothesis.

Week 1 produces data.

Week 2 tests the correction.

Week 3 reinforces windows, formats, hooks, and CTAs that show repeatable results.

The planning agent must not change everything at once.

Correction should change only one or two parameters per cycle:

* publishing time;
* hook;
* format;
* CTA;
* topic angle;
* visual frame.

If a Reel at 17:00 gives strong reach but weak saves, keep the time and change the hook or topic.

If morning Stories produce replies, keep the morning contact window and test the question, poll, or CTA.

This lets the system detect whether the effect came from timing, format, scene, hook, or audience tension.

## Weekly Plan Template

Each planned content unit should store:

| Field | Purpose |
| --- | --- |
| `date` | Calendar date |
| `weekday` | Weekly position |
| `platform` | Instagram, Facebook, Threads, TikTok, YouTube Shorts, Telegram |
| `format` | Reel, Story, Carousel, post, short, thread, Telegram note |
| `topic` | What the unit is about |
| `hypothesis` | What this unit is testing |
| `publishing_time` | Planned publishing time or window |
| `expected_signal` | What audience behavior should appear |
| `primary_kpi` | Main metric for success |
| `secondary_kpi` | Supporting metric |
| `cta` | Requested audience action |
| `result` | Actual outcome after publication |
| `decision_for_next_week` | keep, test again, modify, drop |

Minimum row example:

| Date | Platform | Format | Topic / hypothesis | Publishing time | Expected signal | Primary KPI | Secondary KPI | Result | Decision for next week |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 2026-06-22 | Instagram | Reel | Investment return anxiety | 13:00-15:00 | Parents recognize summer trajectory anxiety | Retention | DM / profile visits | pending | pending |

## Review Logic

The weekly review must compare:

* planned publishing time vs actual publish time;
* planned format vs actual format;
* expected signal vs observed signal;
* primary KPI vs result;
* secondary KPI vs result;
* qualitative comments, DM, replies, and objections;
* whether the same result repeated in comparable conditions.

If a result repeats for 2 weeks, it becomes a candidate working rule.

If it does not repeat, it remains a hypothesis.

If it fails twice under comparable conditions, reduce priority or replace it.

## Working Rule Promotion

A timing, format, or CTA pattern may be promoted from candidate to working rule only when:

1. it appears in 2 or more comparable content units;
2. the content quality was acceptable;
3. the metric matches the intended role of the format;
4. qualitative signals support the interpretation;
5. no obvious confounder explains the result better.

Examples:

* Stories morning window may become a working rule if it repeatedly produces replies or poll votes.
* Reel afternoon window may become a working rule if it repeatedly produces reach and retention.
* Carousel mid-day may become a working rule if it repeatedly produces saves or shares.

## Channel Role Matrix

| Channel | Role | Scheduler logic |
| --- | --- | --- |
| Instagram Stories | Contact and signal capture | multiple daily windows |
| Instagram Reels | Reach and daily phenomenon | one main daily window |
| Instagram Carousel | Structure and saves | 1-2 times weekly |
| Threads | Thought lab and wording tests | short posts across the day |
| Facebook | Trust and parent discussion | 3-4 adapted posts weekly |
| TikTok | Fast hook and reach | adapted short video, more direct opening |
| YouTube Shorts | Searchable expert short | adapted short video, clearer educational framing |
| Telegram | Depth and community room | evening recap, voice note, poll, or breakdown |

## Initial Candidate Windows

Use these windows as starting candidates, not permanent rules:

| Channel / format | Candidate windows | Review metric |
| --- | --- | --- |
| Instagram Stories morning | 08:00-10:00 | views, poll votes, replies |
| Instagram Reel | 13:00-15:00 or 17:00 | reach, retention, shares, profile visits |
| Instagram Stories follow-up | 17:00-18:00 | replies, taps forward, DM |
| Instagram Stories evening | 20:00-21:30 | replies, CTA clicks, DM |
| Instagram Carousel | 10:00-14:00 | saves, shares, completion |
| Threads | 09:00, 14:00, 21:00 | replies, reposts, phrase resonance |
| Facebook | 19:00-21:00 | comments, shares, profile actions |
| Telegram | 20:00-22:00 | views, reactions, replies, link clicks |
| TikTok | 13:00-15:00 or 19:00-21:00 | views, retention, comments |
| YouTube Shorts | 12:00-15:00 or 18:00-21:00 | viewed vs swiped away, retention |

## Adaptation Rule

Every 7 days, compare planned windows with actual outcomes.

Every 14 days, update the scheduler hypothesis only if a pattern repeats.

Do not change the whole schedule because of one strong post.

Decision rule:

```text
Keep window:
  repeated above-baseline outcome in 2+ comparable posts

Test again:
  mixed results or weak sample

Reduce priority:
  repeated below-baseline outcome in 2+ comparable posts

Do not conclude:
  content topic, hook, asset quality, or CTA was materially different
```

## Metrics To Track

Minimum:

* planned channel;
* planned format;
* planned window;
* actual publish time;
* timing status: `on_time`, `late`, `missed`, `rescheduled`;
* reach or views;
* retention where available;
* saves;
* shares;
* comments;
* replies;
* DM;
* profile visits;
* link clicks;
* CTA result;
* qualitative signals.

## Planner Requirements

The planning agent must output:

* weekly theme;
* channel matrix;
* daily content units;
* planned publishing window;
* prep deadline;
* asset owner;
* approval status;
* fallback if asset is not ready;
* metrics to review;
* signal capture question.

The planner must distinguish:

```text
planned window
actual publish time
best known window
candidate test window
```

## Automation Requirements

Future automation should not start with blind autoposting.

Recommended staged automation:

```text
1. Create schedule drafts from approved weekly content plan.
2. Send daily publishing cards to Telegram.
3. Remind operator before each window.
4. Capture actual publish time and status.
5. Pull analytics after publication.
6. Compare performance by window and format.
7. Recommend next scheduler adjustment.
8. Publish only after explicit human approval.
```

## n8n Workflow Direction

Future n8n scheduler flow:

```text
TRG_DailyPublishingPlan
->
DB_ReadApprovedContentPlan
->
SYS_SelectCandidateWindows
->
SYS_BuildPublishingCards
->
TG_SendApprovalAndReminderCards
->
TG_WaitForApproveRescheduleSkip
->
IG_FB_TT_YT_TG_PublishOrRecordManualExecution
->
DB_RecordProductionExecution
->
DB_RecordTimingDeviation
->
TRG_AnalyticsFollowup
->
DB_RecordProductionOutcome
->
AI_RecommendSchedulerAdjustment
```

Early versions may record manual execution instead of publishing directly.

## Human Approval Gate

Human approval is required before:

* publishing any content automatically;
* changing the default weekly publishing rhythm;
* promoting a candidate window into a preferred window;
* enabling automatic cross-posting;
* sending Direct messages or public replies.

## Failure Modes

The scheduler is unreliable if:

* it copies external advice without testing;
* it ignores actual BrainCoach outcomes;
* it changes timing after one viral or weak post;
* it treats all formats as comparable;
* it reposts the same artifact everywhere without channel adaptation;
* it publishes without approved content, asset, CTA, or voice check;
* it cannot compare planned time with actual time.

## Related

* `braincoach-docs/05_operations/14_workflows/weekly_sprint_v1.md`
* `braincoach-docs/07_automation/03_n8n/instagram_analytics_mvp1.md`
* `braincoach-docs/07_automation/03_n8n/instagram_social_automation_mvp2_plan.md`
* `braincoach-docs/07_automation/production_os/04_execution/production_execution.md`
* `braincoach-docs/07_automation/production_os/04_execution/production_outcome.md`
* `braincoach-docs/07_automation/production_os/06_governance/marketing_agent_sync_protocol_v1.md`
