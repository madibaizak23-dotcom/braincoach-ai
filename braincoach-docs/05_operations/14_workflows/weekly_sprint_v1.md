# BrainCoach Weekly Sprint v1

Status: Working Specification

Date: 2026-06-18

Layer: 05_operations / Workflows

Related:

* `braincoach-docs/05_operations/14_workflows/practice_loop_v1.md`
* `braincoach-docs/07_automation/02_workflows/tracker_capture_v1.md`
* `braincoach-docs/01_foundation/braincoach_thinking_os_practice_v1.md`

---

## Purpose

Weekly Sprint is the planning layer that turns tracker ideas, obligations, habits, content work, family learning blocks, client work, and events into a visible weekly control loop.

It is not only a calendar.

It is a control mechanism:

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

## Core Principle: Time Luck

Weekly Sprint treats time as an active control layer.

The founder principle:

```text
Время везёт меня, когда я использую время и действую по плану.
```

Luck is not treated as randomness.

In this workflow, "luck" improves when action lands in the right time window.

The tracker should therefore measure:

* whether the plan existed before the moment arrived;
* whether the user remembered the plan under real conditions;
* whether the action happened inside its intended time window;
* whether stress caused loss of time sense;
* how large the deviation was when timing was missed;
* which repeated conditions break timing.

Operational definition:

```text
Better timing adherence -> stronger practical luck.
```

The weekly sprint is also a practice for time sense.

The goal is not only to complete tasks.

The goal is to train the ability to remember the plan and feel what time has come, even under stress.

## Scope

Weekly Sprint may include:

* founder personal practice;
* breathing exercises;
* health routines;
* son's learning blocks;
* English, physics, and other study blocks;
* content production;
* reels and stories preparation;
* delayed publishing;
* story and reel publishing windows;
* personal learning plans;
* client calls;
* masterclass preparation;
* weekly offer discovery tasks;
* recovery and open windows.

## Example Categories

Personal routine:

```text
09:00 Wim Hof breathing
19:00 Wim Hof breathing second round
```

Breathing practice capture:

```text
Вим Хофф 4 цикла, задержки после выдоха 45, 60, 75, 90 сек, всего 11 мин
```

The tracker should normalize these aliases as the same practice:

* Wim Hof
* Вим Хофф
* Вимхов
* дыхание Вим Хоффа

For Wim Hof breathing, the most valuable structured metric is the retention after exhale.

The tracker should extract:

* practice type: `wim_hof_breathing`;
* cycle count;
* exhale retention seconds per cycle;
* total session duration;
* raw wording;
* subjective state before / after if provided.

Example parsed result:

```json
{
  "practice_type": "wim_hof_breathing",
  "cycles": 4,
  "exhale_retention_seconds": [45, 60, 75, 90],
  "max_exhale_retention_seconds": 90,
  "total_duration_minutes": 11
}
```

Son's learning:

```text
10:00-11:00 English
14:00-15:00 Physics
```

Content:

```text
Evening: prepare tomorrow's reel
Morning: prepare five story scripts
Scheduled slots: publish each story at its planned time
```

Event:

```text
Wednesday 19:00 masterclass
Preparation blocks required before event
```

## Weekly Sprint Intake

The founder may send the tracker:

```text
Weekly sprint: next week I need ...
```

or:

```text
Add to weekly sprint: ...
```

or:

```text
Tomorrow: ...
```

The agent should extract:

* task or habit;
* person: founder, son, client, audience, team;
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

## Calendar Distribution

When the user gives a weekly plan, the tracker should:

1. preserve the raw plan;
2. detect fixed events;
3. detect recurring routines;
4. detect flexible tasks;
5. estimate required preparation time;
6. place fixed events first;
7. place preparation before deadlines;
8. place recurring routines at stable times;
9. check load by day;
10. identify free windows;
11. suggest conflicts or overload;
12. ask one clarification only if required.

## Load Check

The weekly plan must show:

* fixed commitments;
* preparation blocks;
* execution blocks;
* recovery windows;
* open windows;
* overload risks;
* tasks without time;
* deadlines without preparation.

Agent question:

```text
What will fail if this day goes exactly as planned?
```

This question is used to detect hidden overload.

## Reminder Behavior

Future tracker behavior should support reminders.

Reminder types:

* start reminder;
* preparation reminder;
* check-in reminder;
* completion reminder;
* missed-action recovery prompt;
* evening planning prompt;
* morning execution prompt.

Reminder examples:

```text
09:00 - Wim Hof breathing
19:00 - Wim Hof breathing second round
```

Timed practice windows:

```text
08:00 Wim Hof breathing, confirmation expected by 08:15
18:00 Wim Hof breathing, confirmation expected by 18:15
```

For timed practices, the tracker should store both:

* planned time;
* confirmation deadline;
* actual captured time;
* timing status: `on_time`, `late`, `missed`, or `rescheduled`;
* deviation in minutes if late.

If no matching tracker entry arrives by the confirmation deadline, the tracker should send a check-in:

```text
Вим Хофф 08:00 не закрыт. Сделал, перенести, сократить или пропустить?
```

If the user completes it after the deadline, the entry should still be saved, but the weekly review should show it as late rather than missed.

```text
Tonight - prepare tomorrow's reel and schedule it
```

```text
Morning - prepare five story scripts and attach them to the day's slots
```

```text
Wednesday 19:00 - masterclass
Before Wednesday - preparation blocks required
```

If a reminder is missed, the tracker should not shame the user.

It should ask:

```text
Reschedule, reduce, or drop?
```

## Content Planning Inside Weekly Sprint

Content plan is one possible sprint stream.

The tracker should support:

* weekly theme;
* daily topic;
* reel topic;
* story sequence;
* CTA;
* KPI;
* what to look for in responses;
* publishing slot;
* delayed posting status;
* response capture after publishing.

For stories, reels, and production blocks, the tracker should treat each publishing or production window as a time-sense practice, not only as a task.

It should capture:

* planned publishing window;
* actual publishing time;
* preparation block timing;
* production block timing;
* whether the artifact was ready before the window;
* whether posting happened on time, late, missed, or rescheduled;
* whether stress, overload, unclear asset, or weak preparation caused the timing deviation.

Daily content rhythm can be represented as:

```text
08:00-10:00 Story 1 - observation
08:00-10:00 Story 2 - poll
13:00-15:00 Reel - phenomenon of the day
17:00-18:00 Story 3 - insight after reel
20:00-21:30 Story 4 - question
20:00-21:30 Story 5 - CTA
```

The tracker should help prepare tomorrow's assets the evening before and morning story scripts on the same day.

## Learning Plan Tracking

The same timing rule applies to founder learning and self-development.

Examples:

```text
07:30-08:00 reading / theory
12:30-13:00 implementation note
21:00-21:20 review and next question
```

The tracker should show whether learning happened in the planned window, whether it was displaced by urgent work, and whether the week still protected enough learning time.

## Masterclass Planning

When a fixed event exists, such as:

```text
Wednesday 19:00 masterclass
```

the tracker should ask:

1. What is the goal of the event?
2. What must be ready before it starts?
3. What preparation blocks are needed?
4. What can be delegated, reduced, or postponed?
5. What feedback should be captured after the event?

For the current BrainCoach strategy, a masterclass should be treated as:

```text
Offer Discovery
->
payment stories
->
interview candidates
->
GPS / trajectory review transition
```

unless the user explicitly sets another goal.

## Weekly Review

At the end of the week, the tracker should produce:

1. completed blocks;
2. missed blocks;
3. repeated overload points;
4. most valuable actions;
5. weak commitments;
6. useful free windows;
7. constraints;
8. contradictions;
9. signals from content or clients;
10. corrections for next week.

The weekly review must include a timing effectiveness section:

* planned windows;
* on-time actions;
* late actions;
* missed actions;
* rescheduled actions;
* average deviation in minutes;
* strongest timing failures;
* best timing wins;
* stress points where the plan was forgotten;
* next week's timing correction.

The key review question:

```text
Где я потерял чувство времени, а где время повезло меня по плану?
```

If Wim Hof breathing or other structured practice entries exist, the weekly review must include a dedicated practice track summary:

* number of sessions;
* total practice time;
* cycle counts;
* exhale retention sequence for each session;
* best retention after exhale;
* retention progression across the week;
* timing adherence: planned, on-time, late, missed, rescheduled;
* repeated timing deviations;
* notes on state before / after practice if captured.

Example weekly line:

```text
Wim Hof: 2 sessions, 22 min total. Timing: morning on time, evening late +12 min. Exhale retentions: 45/60/75/90 sec; 40/60/80/95 sec. Best: 95 sec.
```

The weekly review must feed Practice Loop:

```text
Observed week
->
constraint
->
contradiction
->
decision
->
next sprint
```

## Agent Rule

Agents must not treat Weekly Sprint as a simple task list.

They must treat it as a control loop over time, energy, attention, obligations, preparation, feedback, and correction.
