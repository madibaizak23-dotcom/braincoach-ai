# Tracker Practice Loop n8n Note v1

Status: Implementation Note

Date: 2026-06-18

Layer: 07_automation / 03_n8n

Related:

* `braincoach-docs/07_automation/02_workflows/tracker_capture_v1.md`
* `braincoach-docs/05_operations/14_workflows/practice_loop_v1.md`
* `braincoach-docs/05_operations/14_workflows/weekly_sprint_v1.md`
* `braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-025-practice-loop.md`
* `braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-026-weekly-sprint.md`

---

## Purpose

This note marks the next n8n direction for the BrainCoach tracker.

Current production workflow captures:

```text
Raw Input
->
Observation
->
Signal Candidate
```

Future tracker behavior should also support:

```text
Practice Loop
Council Mode
Weekly Sprint
```

No production workflow JSON is changed by this note.

No SQL is executed by this note.

## Required Future Behavior

The tracker should be able to route incoming Telegram messages into these modes:

* normal tracker observation;
* Practice Loop reflection;
* Council Mode support;
* Weekly Sprint planning;
* reminder request;
* content planning request;
* event preparation request;
* review request.

## Routing Candidates

Future routing may detect phrases such as:

```text
weekly sprint
спринт
на неделю
завтра
напомни
поставь
контент план
сторис
рилс
мастер класс
подготовка
```

The router should preserve the raw message before interpretation.

## Structured Practice Capture

Future n8n parsing should support structured practice facts, not only broad tracker notes.

Wim Hof breathing must be recognized across common aliases:

```text
Wim Hof
Вим Хофф
Вимхов
дыхание Вим Хоффа
```

Example input:

```text
сделал дыхание Вимхофф 4 цикла задержки в сек, 45. 60, 75 и 90, итого заняло 11 мин
```

Expected extraction:

```json
{
  "is_activity_event": true,
  "activity_type_code": "wim_hof_breathing",
  "duration_minutes": 11,
  "practice_type": "wim_hof_breathing",
  "cycles": 4,
  "exhale_retention_seconds": [45, 60, 75, 90],
  "max_exhale_retention_seconds": 90
}
```

Important:

The core metric is retention after exhale. Total duration is secondary.

Until `activity_types` contains `wim_hof_breathing`, the workflow should keep this as a tracker note / trajectory entry and not attempt an `activity_events` insert with an unknown activity type code.

## Practice Loop Mode

When the user sends an idea, observation, contradiction, decision candidate, client signal, or market pain, n8n should support passing it to an AI step that returns:

1. raw thought preserved;
2. system / object;
3. likely constraint;
4. contradiction;
5. logical status: validated, contradicted, or indeterminate;
6. adaptation / radical hypothesis if useful;
7. next action or experiment;
8. feedback signal to watch.

## Council Mode

Council Mode should help the founder use previously studied source systems as external working memory.

The AI step should apply methods, not imitate authors.

Internal lenses:

* DOTU: control, goal, feedback, correction;
* Goldratt / TOC: constraint, conflict, assumption, choice;
* Altshuller / TRIZ: contradiction, resource, stronger solution;
* Lobanov / Russian Logic: terms, quantifiers, premises, conclusion, indeterminate state;
* DOTU / Sociology: behavior, psyche, culture, environment, social layer;
* adaptation patterns / radicals: support strategy without identity labeling.

## Weekly Sprint Mode

Weekly Sprint should transform tracker notes into a weekly control loop:

```text
Goal
->
Week structure
->
Time blocks
->
Load check
->
Reminders
->
Execution feedback
->
Correction
```

The AI step should extract:

* task or habit;
* person;
* date or weekday;
* time or flexible window;
* duration;
* recurrence;
* priority;
* dependency;
* preparation required;
* reminder requirement;
* expected output;
* feedback signal.

Example recurring timed practice:

```text
Хочу делать Вим Хофф утром в 8 и вечером в 18. Если не записал до 08:15 или 18:15, трекер должен спросить и отметить отклонение.
```

Expected reminder candidate structure:

```json
{
  "practice_type": "wim_hof_breathing",
  "recurrence": "daily",
  "planned_times": ["08:00", "18:00"],
  "confirmation_deadlines": ["08:15", "18:15"],
  "missed_action_prompt": "Сделал, перенести, сократить или пропустить?",
  "weekly_review_tracking": true
}
```

## Reminder Direction

Future n8n implementation may need a reminder layer.

Reminder types:

* start reminder;
* preparation reminder;
* check-in reminder;
* completion reminder;
* missed-action recovery prompt;
* evening planning prompt;
* morning execution prompt.

Missed-action recovery language:

```text
Reschedule, reduce, or drop?
```

For timed practices, reminder automation should compare planned windows against captured tracker entries:

```text
planned practice
->
confirmation deadline
->
matching tracker entry found?
->
on_time / late / missed / rescheduled
->
weekly deviation summary
```

If no matching Wim Hof entry is captured by `08:15` or `18:15`, the tracker should send:

```text
Вим Хофф не закрыт. Сделал, перенести, сократить или пропустить?
```

If the user logs the practice after the deadline, the tracker should keep the practice facts and mark the timing status as `late`, including deviation minutes.

No reminder automation is implemented yet.

## Content Planning Direction

The tracker should later support a weekly content plan and daily publishing slots.

Example daily slots:

```text
08:00-10:00 Story 1 - observation
08:00-10:00 Story 2 - poll
13:00-15:00 Reel - phenomenon of the day
17:00-18:00 Story 3 - insight after reel
20:00-21:30 Story 4 - question
20:00-21:30 Story 5 - CTA
```

The tracker should help prepare tomorrow's reel the evening before and story scripts in the morning.

## Event Preparation Direction

For a fixed event, such as:

```text
Wednesday 19:00 masterclass
```

the tracker should ask:

1. What is the event goal?
2. What must be ready before it starts?
3. What preparation blocks are required?
4. What can be delegated, reduced, or postponed?
5. What feedback should be captured after the event?

For the current strategy, masterclass defaults to:

```text
Offer Discovery
->
payment stories
->
interview candidates
->
GPS / trajectory review transition
```

## Future Node Direction

Possible future node groups:

```text
SPR_RouteWeeklySprint
SPR_ExtractTimeBlocks
SPR_CheckLoad
SPR_SaveSprintCandidate
SPR_FormatSprintReply

REM_ExtractReminder
REM_SaveReminderCandidate
REM_SendReminder
REM_HandleMissedAction

PLC_RunPracticeLoop
PLC_FormatPracticeReply

CNS_RunCouncilMode
CNS_FormatCouncilReply
```

These node names are candidates, not approved production nodes.

## Implementation Boundary

This note does not approve:

* new database tables;
* workflow JSON edits;
* live reminder automation;
* calendar integration;
* external posting automation.

Those require separate design, test, and approval.
