# Summer Map MVP v1 Test Report

Status: MVP Ready

Date: 2026-06-12

## Scope

Summer Map MVP v1 is a single n8n workflow for Telegram intake, four-question Summer Map completion, result generation, GPS offer display, share action, and GPS transition.

The release intentionally uses existing BGS Core tables only. No `clients`, `conversation_state`, `events`, or `offers_sent` tables are introduced.

## Validated Areas

| Area | Status | Notes |
| --- | --- | --- |
| Workflow JSON validity | Passed | Export parses as valid JSON. |
| Workflow location | Passed | Saved under `braincoach-docs/07_automation/03_n8n/`. |
| Telegram update intake | Passed | Workflow accepts `message` and `callback_query`. |
| Text and voice convergence | Passed | Voice path transcribes and joins normalized incoming update path. |
| BGS Core persistence model | Passed | Uses `persons`, `conversations`, `parent_interviews`, `interview_responses`, `conversation_events`, `messages`. |
| Summer Map stage machine | Passed | Uses `new`, `waiting_q1`, `waiting_q2`, `waiting_q3`, `waiting_q4`, `completed`. |
| Callback routing | Passed | Uses `sm:start`, `sm:q1:1..4`, `sm:q2:1..4`, `sm:q3:1..4`, `sm:q4:1..4`, `sm:gps`, `sm:share`. |
| UTF-8 text integrity | Passed | Export was synchronized from corrected `SYS_ProcessSummerMap`; mojibake markers were not found after update. |
| GPS transition | Passed | Result screen includes URL handoff to `https://t.me/BrainCoach_GPS_bot?start=summer_map`. |

## Manual Validation Evidence

Observed Telegram behavior:

* `/start` opens the Summer Map introduction.
* Intro screen displays the "Начать" action.
* Free text before starting is handled as invalid input and returns the start prompt.
* Raw user messages are persisted to `messages`.
* Analytics/state events are persisted to `conversation_events`.

## Not Included in MVP v1 Validation

* Load testing for 150 families.
* Production analytics dashboard.
* Automated regression suite for n8n import/export.
* Optional post-completion research extraction into `observations` or `research_signal_candidates`.

## Acceptance Criteria for Pilot

Track the following metrics during the first 150-family pilot:

* Completion Rate: users who reach `completed` after starting.
* Share Rate: users who activate the share action.
* GPS Click Rate: users who click the GPS transition.
* Application Conversion: users who continue into BrainCoach GPS onboarding.
