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

