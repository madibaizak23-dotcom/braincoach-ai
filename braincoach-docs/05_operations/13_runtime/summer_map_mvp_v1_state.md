# Summer Map MVP v1 Implementation State

Status: MVP Ready

Date: 2026-06-12

## Workflow Export

Authoritative export:

`braincoach-docs/07_automation/03_n8n/BrainCoach Summer Map v1 MVP.json`

Workflow name:

`BrainCoach Summer Map v1 MVP`

Node count:

19

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
| Answer Q4 | `sm:q4:1..4` | Saves answer, completes interview, calculates result, shows GPS offer. |
| GPS interest | `sm:gps` | Logs tracker click and keeps conversation completed. |
| Share | `sm:share` | Logs referral click and returns share link. |
| Text during question | Any text while waiting for Q1-Q4 | Logs invalid input and repeats current question. |
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
* `sm:gps`
* `sm:share`

The code also recognizes `sm:restart`; no visible restart button is part of MVP v1.

## Stage Machine

Conversation stages:

* `new`
* `waiting_q1`
* `waiting_q2`
* `waiting_q3`
* `waiting_q4`
* `completed`

Q4 transitions directly to `completed`.

## Screen Routing

`CODE_FormatReplyMarkup` derives `screen` from the first callback in the generated inline keyboard:

| First callback / route | Screen |
| --- | --- |
| `sm:start` | `intro` |
| `sm:q1:*` | `q1` |
| `sm:q2:*` | `q2` |
| `sm:q3:*` | `q3` |
| `sm:q4:*` | `q4` |
| `sm:gps` | `offer` |
| `sm:share` | `share` |
| `current_stage = completed` or `route = result` | `result` |
| `route = gps` | `gps` |
| otherwise | `fallback` |

Telegram send nodes:

* `TG_Intro`
* `TG_Q1`
* `TG_Q2`
* `TG_Q3`
* `TG_Q4`
* `TG_Result`

## PostgreSQL Dependencies

Existing BGS Core tables used by MVP v1:

* `persons`
* `conversations`
* `parent_interviews`
* `interview_responses`
* `conversation_events`
* `messages`

Tables intentionally not required in the MVP path:

* `observations`
* `research_signal_candidates`

## Event Model

Events are persisted in `conversation_events` with `event_payload.source = 'summer_map'`.

Key event names:

* `summer_map_opened`
* `summer_map_started`
* `question_1_answered`
* `question_2_answered`
* `question_3_answered`
* `question_4_answered`
* `summer_result_generated`
* `summer_result_shown`
* `tracker_offer_shown`
* `tracker_button_clicked`
* `referral_clicked`
* `summer_map_invalid_input`
* `summer_map_duplicate_click`
* `summer_map_unexpected_callback`

## BrainCoach GPS Transition

The MVP uses two GPS-related paths:

* In-workflow callback: `sm:gps`, logged as `tracker_button_clicked`.
* Telegram URL handoff from result screen: `https://t.me/BrainCoach_GPS_bot?start=summer_map`.

For GPS onboarding, the receiving bot should treat `start=summer_map` as the source attribution for the Summer Map pilot.

## Recommended Next Steps for GPS Onboarding

1. Confirm the receiving `BrainCoach_GPS_bot` start parameter contract for `start=summer_map`.
2. Add source attribution in GPS onboarding persistence: `source = summer_map`, `campaign = summer_2026_pilot`.
3. Preserve the Summer Map `telegram_user_id` mapping through `persons.external_id`.
4. Define conversion events in `conversation_events` or the GPS workflow equivalent before launch.
5. Run an end-to-end test: Summer Map result -> GPS URL -> GPS onboarding first screen -> application captured.

## Commit Summary

Suggested commit message:

`docs: capture Summer Map MVP v1 release state`

Suggested commit body:

* Save current Summer Map MVP n8n export.
* Add Summer Map MVP release note to the release registry.
* Add operational test report for the MVP pilot.
* Add runtime implementation state with Telegram callbacks, screen routing, PostgreSQL dependencies, and GPS handoff.
