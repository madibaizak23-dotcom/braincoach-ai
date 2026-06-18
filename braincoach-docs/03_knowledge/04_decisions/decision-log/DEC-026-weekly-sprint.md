# DEC-026 Weekly Sprint

Date: 2026-06-18

Status: Accepted

## Context

BrainCoach tracker is becoming the founder's external working memory, practice support, and execution companion.

The system needs a weekly planning object that can handle more than content:

* personal routines;
* breathing exercises;
* son's learning blocks;
* English, physics, and other study periods;
* content production;
* delayed posting;
* client work;
* masterclass preparation;
* recovery windows;
* reminders;
* weekly review.

## Decision

BrainCoach adopts Weekly Sprint as a working specification for time, attention, preparation, reminders, execution, and correction.

Weekly Sprint is not a task list.

It is a control loop:

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

## Rules

Agents should be able to transform tracker input into:

* fixed events;
* recurring habits;
* flexible tasks;
* preparation blocks;
* reminders;
* daily execution prompts;
* open windows;
* overload warnings;
* weekly review.

If the user gives a content plan, agents should distribute it across the week and daily publishing slots.

If the user gives a life or learning plan, agents should distribute it across fixed and flexible time windows.

If a major event exists, such as a masterclass, agents must ask what preparation blocks are required before it.

## Related

* `braincoach-docs/05_operations/14_workflows/weekly_sprint_v1.md`
* `braincoach-docs/05_operations/14_workflows/practice_loop_v1.md`
* `braincoach-docs/07_automation/02_workflows/tracker_capture_v1.md`
