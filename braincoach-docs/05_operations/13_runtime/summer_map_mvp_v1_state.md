# Summer Map MVP v1 Implementation State

Status: MVP Ready

Date: 2026-06-12

Last Updated: 2026-06-16

Strategic Update: 2026-06-18

Current Version:

Summer Map v1.1 - Interview to GPS Conversion Optimization

Strategic Direction:

Summer Map should evolve from a separate summer questionnaire into the universal BrainCoach Discovery Engine.

The engine should support multiple research templates, Russian / Kazakh language selection, PostgreSQL-loaded questions, and signal classification across market, offer, and phenomenon layers.

## Workflow Export

Authoritative export:

`braincoach-docs/07_automation/03_n8n/BrainCoach Summer Map v1 MVP.json`

Workflow name:

`BrainCoach Summer Map v1.1 MVP`

Node count:

21

Primary processing node:

`SYS_ProcessSummerMap`

## Repository Placement

Current placement follows the existing repository architecture:

| Artifact | Location | Reason |
| --- | --- | --- |
| n8n workflow export | `braincoach-docs/07_automation/03_n8n/` | Existing location for importable n8n workflows. |
| Release note | `braincoach-docs/03_knowledge/03_registries/releases.md` | Existing release registry. |
| Test report | `braincoach-docs/05_operations/12_reviews/summer_map_mvp_v1_test_report.md` | Existing operational review/report section. |
| Implementation state | `braincoach-docs/05_operations/13_runtime/summer_map_mvp_v1_state.md` | Existing runtime state and deployment log section. |

No new top-level directories or new repository sections were created.

## Telegram Scenarios

| Scenario | Input | Behavior |
| --- | --- | --- |
| Open map | `/start` or start intent | Shows Summer Map intro and `Начать` button. |
| Start interview | `sm:start` | Creates/refreshes active Summer Map interview and shows Q1. |
| Answer Q1 | `sm:q1:1..4` | Saves answer and moves to Q2. |
| Answer Q2 | `sm:q2:1..4` | Saves answer and moves to Q3. |
| Answer Q3 | `sm:q3:1..4` | Saves answer and moves to Q4. |
| Answer Q4 | `sm:q4:1..4` | Saves behavioural day-initiation answer and moves to Q5. |
| Answer Q5 | `sm:q5:1..4` | Saves future-projection answer, completes interview, shows GPS CTA. |
| GPS CTA | `sm:gps` | Logs `gps_cta_clicked` and returns the BrainCoach GPS URL button. |
| Text during question | Any text while waiting for Q1-Q5 | Logs invalid input and repeats current question. |
| Voice input | Telegram voice message | Transcribes voice and joins the same normalized text path. |

## Callback Data

Supported callbacks:

* `sm:start`
* `sm:q1:1`
* `sm:q1:2`
* `sm:q1:3`
* `sm:q1:4`
* `sm:q2:1`
* `sm:q2:2`
* `sm:q2:3`
* `sm:q2:4`
* `sm:q3:1`
* `sm:q3:2`
* `sm:q3:3`
* `sm:q3:4`
* `sm:q4:1`
* `sm:q4:2`
* `sm:q4:3`
* `sm:q4:4`
* `sm:q5:1`
* `sm:q5:2`
* `sm:q5:3`
* `sm:q5:4`
* `sm:gps`

The code also recognizes `sm:restart`; no visible restart button is part of MVP v1.1.

## Stage Machine

Conversation stages:

* `new`
* `waiting_q1`
* `waiting_q2`
* `waiting_q3`
* `waiting_q4`
* `waiting_q5`
* `completed`

Q4 transitions to `waiting_q5`; Q5 transitions to `completed`.

Database constraint:

`conversations.chk_conversation_stage` must include `waiting_q5`.

Applied in BGS Core:

```bash
gcloud sql connect n8n-db-instance \
  --user=bgs_admin \
  --database=bgs_core
```

Migration file:

`braincoach-docs/07_automation/04_postgres/005_summer_map_v1_1_conversation_stage.sql`

Verified constraint:

```text
CHECK ((current_stage = ANY (ARRAY[
  'new',
  'waiting_q1',
  'waiting_q2',
  'waiting_q3',
  'waiting_q4',
  'waiting_q5',
  'analysis',
  'completed'
])))
```

## Screen Routing

`CODE_FormatReplyMarkup` derives `screen` from the first callback in the generated inline keyboard:

| First callback / route | Screen |
| --- | --- |
| `sm:start` | `intro` |
| `sm:q1:*` | `q1` |
| `sm:q2:*` | `q2` |
| `sm:q3:*` | `q3` |
| `sm:q4:*` | `q4` |
| `sm:q5:*` | `q5` |
| `sm:gps` after completion | `gps` |
| `current_stage = completed` or `route = result` | `result` |
| `route = gps` | `gps` |
| otherwise | `fallback` |

Telegram send nodes:

* `TG_Intro`
* `TG_Q1`
* `TG_Q2`
* `TG_Q3`
* `TG_Q4`
* `TG_Q5`
* `TG_Result`
* `TG_GPS`

## PostgreSQL Dependencies

Existing BGS Core tables used by MVP v1:

* `persons`
* `conversations`
* `parent_interviews`
* `interview_responses`
* `conversation_events`
* `messages`

Schema dependency for v1.1:

* `conversations.current_stage` check constraint must allow `waiting_q5`.

Tables intentionally not required in the MVP path:

* `observations`
* `research_signal_candidates`

## Universal Discovery Engine Direction

The current Summer Map MVP remains a valid runtime baseline.

The next design direction should not create a separate questionnaire for every topic.

Target architecture:

```text
one engine
different research templates
one database
one signal logic
```

Required future capabilities:

* language selection: Russian / Kazakh;
* survey template selection by scenario;
* question loading from PostgreSQL instead of hardcoded question flow;
* scenario support for summer, sport, study, NIS, tutors, potential, and independence;
* answer persistence as market, offer, and phenomenon signals;
* GPS transition only after the user has received a clear value frame.

The key design change is that the bot should capture what parents have already done and bought, not only what they think about a diagnostic topic.

Primary offer-discovery questions:

1. What have you already invested in for your child's development?
2. What produced a result?
3. What did not produce a result?
4. Where did the most money go?
5. What became the last straw?
6. Was there a moment: "We invested so much, why is there no result?"
7. What would you want to see earlier, before the final failure?

## Event Model

Events are persisted in `conversation_events` with `event_payload.source = 'summer_map'`.

Key event names:

* `summer_map_opened`
* `summer_map_started`
* `question_1_answered`
* `question_2_answered`
* `question_3_answered`
* `question_4_answered`
* `question_5_answered`
* `summer_result_generated`
* `summer_result_shown`
* `gps_cta_shown`
* `gps_cta_clicked`
* `summer_map_invalid_input`
* `summer_map_duplicate_click`
* `summer_map_unexpected_callback`

Future GPS-side funnel events required for full reporting:

* `gps_started`
* `first_tracker_entry`
* `day_3_active`
* `day_7_active`

## BrainCoach GPS Transition

The MVP v1.1 uses a measured GPS handoff:

* Completion screen shows one visible CTA: `🚀 Перейти в BrainCoach GPS`.
* CTA uses callback `sm:gps` so Summer Map can log `gps_cta_clicked`.
* After the click, the bot returns one URL button to `https://t.me/BrainCoach_GPS_bot?start=summer_map`.

For GPS onboarding, the receiving bot should treat `start=summer_map` as the source attribution for the Summer Map pilot.

Strategic correction:

GPS should not be framed primarily as a tracker.

It should be framed as early visibility into whether a child's trajectory investment is converting into real progress.

Working transition:

```text
Interview
↓
GPS
↓
14-day trajectory review
```

Working parent-facing question:

```text
How can you understand whether your investment in a child is turning into real progress?
```

## Recommended Next Steps for GPS Onboarding

1. Confirm the receiving `BrainCoach_GPS_bot` start parameter contract for `start=summer_map`.
2. Log `gps_started` when GPS bot receives `/start summer_map`.
3. Log `first_tracker_entry` when the first observation is saved.
4. Add Day 3 and Day 7 activity events for retention reporting.
5. Preserve the Summer Map `telegram_user_id` mapping through `persons.external_id`.
6. Run an end-to-end test: Summer Map result -> GPS CTA -> GPS URL -> GPS onboarding first screen -> first observation captured.

## Commit Summary

Suggested commit message:

`feat: optimize Summer Map GPS conversion funnel`

Suggested commit body:

* Add behavioural Q4 and future-projection Q5.
* Replace diagnostic completion output with GPS activation message.
* Use one visible GPS CTA.
* Log `gps_cta_shown` and `gps_cta_clicked`.
* Update runtime documentation for Summer Map v1.1.
