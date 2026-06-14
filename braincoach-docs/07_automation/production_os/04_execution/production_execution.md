# Production Execution Specification v1

Status: Draft
Date: 2026-06-14
Depends on:

- DEC-016 BGS Database Boundary: Core vs Orch
- DEC-017 BGS Orch Schema Segregation
- Research Schema v1 for bgs_orch
- Research Season Specification v1
- Research Brief Specification v1
- Marketing Brief Specification v1
- Content Plan Specification v1

Layer: Architecture / Production OS / Execution Telemetry

## Purpose Of This Document

Define the canonical concept of Production Execution for BrainCoach.

This document specifies the object.

It does not define SQL.

It does not approve migration.

It does not create `production.executions`.

## Definition

Production Execution is the object that records what actually happened in production.

It is the factual execution record for a planned or unplanned production action.

Examples:

- post published;
- Telegram message sent;
- story sequence released;
- poll launched;
- interview invitation sent;
- GPS prompt sent;
- parent chat message posted;
- reel published;
- manual outreach completed.

Production Execution is not the plan.

It is the evidence that a production action occurred.

## Purpose

Production Execution exists to separate intended production from actual production.

It solves these tasks:

- records that a specific production action happened;
- links execution back to the Content Plan when one exists;
- preserves channel, timing, format, status, and artifact reference;
- creates the anchor for later outcomes and signal capture;
- lets Season Review compare planned work with actual work;
- allows agents and humans to evaluate production reliability.

It does not solve these tasks:

- it does not define what should be produced;
- it does not replace the Content Plan;
- it does not evaluate audience response by itself;
- it does not validate signals;
- it does not store all analytics;
- it does not become CRM or offer management.

## Position In Production OS

Production Execution is the fifth object in the Season Intelligence Loop:

```text
Research Season
↓
Research Brief
↓
Marketing Brief
↓
Content Plan
↓
Production Execution
↓
Signal Capture
↓
Season Review
```

Content Plan defines what BrainCoach intends to publish, send, launch, or run.

Production Execution records what BrainCoach actually published, sent, launched, or ran.

Signal Capture later records what the audience or reality produced in response.

## Core Attributes

These are logical attributes only.

They are not SQL columns.

### execution_code

Stable human-readable identifier for the execution.

Example:

`EXEC-2026-SUMMER-01-004`

Purpose:

Allows humans, agents, outcomes, and reviews to reference the same production event.

### season_code

The Research Season this execution belongs to.

Example:

`SEASON-2026-SUMMER-01`

Purpose:

Keeps execution tied to the root season question.

### content_plan_code

The Content Plan that intended or guided this execution.

Example:

`CPLAN-2026-SUMMER-01-W01`

Purpose:

Allows comparison between planned artifact sequence and actual execution.

This may be empty for unplanned production actions.

### content_unit_code

Identifier for the planned content unit when the execution comes from a Content Plan.

Example:

`CUNIT-2026-SUMMER-01-W01-THU`

Purpose:

Links the execution to a specific planned artifact.

### execution_type

The type of production action.

Examples:

- post;
- story;
- poll;
- Telegram message;
- DM outreach;
- interview invitation;
- GPS prompt;
- reel;
- parent chat message.

Purpose:

Makes execution comparable across channels and formats.

### channel

The channel where the action occurred.

Examples:

- Instagram;
- Telegram;
- direct message;
- email;
- parent chat;
- offline interview.

Purpose:

Preserves the surface where audience response may appear.

### format

The format of the executed artifact.

Examples:

- definition post;
- case prompt;
- poll;
- story sequence;
- short video;
- invitation message;
- checklist;
- reflection prompt.

Purpose:

Connects the execution to how the research question was expressed.

### artifact_reference

Reference to the executed artifact.

Examples:

- post URL;
- Telegram message link;
- internal draft path;
- n8n execution id;
- screenshot path;
- manual note reference.

Purpose:

Allows humans and agents to inspect the executed artifact later.

### executed_at

When the production action actually happened.

Purpose:

Supports sequencing, review, and later outcome attribution.

### execution_status

The state of the execution.

Candidate statuses:

- planned;
- scheduled;
- completed;
- skipped;
- failed;
- cancelled;
- revised.

Purpose:

Allows Season Review to distinguish completed actions from planned but unexecuted work.

### operator

Who or what performed the execution.

Examples:

- Malik;
- writer agent;
- n8n workflow;
- social media scheduler;
- manual operator.

Purpose:

Preserves accountability and helps evaluate production process reliability.

### notes

Short execution notes.

Purpose:

Captures execution-specific context that is not a signal, metric, or review finding.

## Relationships

These are logical relationships only.

They are not table definitions.

They are not foreign keys.

### content.plans

Production Execution may be derived from a Content Plan.

The Content Plan defines intended artifact sequence and signal-capture points.

Note:

`content.plans` is a logical reference, not an approved physical schema or table.

### production.outcomes

Production Outcomes may be observed after an execution.

Examples:

- reach;
- comments;
- DMs;
- poll answers;
- saves;
- replies;
- interview opt-ins.

Outcome records should not be confused with the execution record itself.

### signal.capture

Signal Capture interprets responses and extracts useful research material.

Production Execution creates the surface where signal capture may happen.

### research.reviews

Research Reviews use execution records to evaluate what actually happened during the season.

They may compare Content Plan, Production Execution, Outcomes, and captured signals.

### agent.runs

Agent runs may generate, schedule, inspect, critique, or summarize production executions.

The execution record stores what happened; the agent run stores the process that produced or evaluated it.

## Example

### season_code

`SEASON-2026-SUMMER-01`

### season_name

Лето как тест самостоятельности

### content_plan_code

`CPLAN-2026-SUMMER-01-W01`

### planned_content_unit

Thursday:

`День без напоминаний`

### execution_code

`EXEC-2026-SUMMER-01-004`

### execution_type

`Telegram message`

### channel

`Telegram`

### format

`case prompt`

### artifact_reference

`telegram://message/reference-placeholder`

### executed_at

`2026-06-18 09:00`

### execution_status

`completed`

### operator

`manual operator`

### notes

Published the planned Thursday prompt asking parents what happens on a day without reminders.

Signal capture should inspect replies, DMs, repeated phrases, and interview candidates separately.

## Non-Goals

Production Execution is not:

- a Content Plan;
- a Marketing Brief;
- Signal Capture;
- Production Outcome;
- analytics dashboard;
- CRM object;
- offer object;
- migration;
- table.

## Related Concepts

### Research Season

Existing document:

`braincoach-docs/07_automation/production_os/01_research/research_season.md`

Relationship:

The Research Season gives execution its season boundary and research context.

### Content Plan

Existing document:

`braincoach-docs/07_automation/production_os/03_content/content_plan.md`

Relationship:

Content Plan defines what was intended.

Production Execution records what actually happened.

### Production Outcomes

Existing document:

`braincoach-docs/07_automation/production_os/04_execution/production_outcome.md`

Relationship:

Production Outcomes record what the environment returned after execution.

They store raw response facts before Signal Capture interpretation.

### Signal Capture

Existing concept:

Signal Capture is the process of extracting useful signals from responses.

Relationship:

Execution creates the surface. Signal Capture interprets what came back.

Production Outcome is the raw response layer between Execution and Signal Capture.

### Season Review

Existing concept:

Season Review is the closing intelligence artifact for a Research Season.

Relationship:

Season Review uses execution records to evaluate production reliability, coverage, and learning quality.

### Agent Runs

Existing future object in Research Schema v1:

`agent.runs`

Relationship:

Agent runs may produce, schedule, monitor, or evaluate execution records.

## Future Work

After this specification is reviewed and accepted, future work may discuss:

- Signal Capture Specification v1;
- Season Review Specification v1;
- future object `production.executions`;
- execution status model;
- artifact reference conventions;
- agent workflow for execution monitoring;
- draft migration only after explicit approval.

Important:

DEC-017 already identifies `production.*` as an approved proposed schema family for production process memory.

Research Schema v1 already proposes `production.executions` as a future object.

This document does not create `production.executions`.

It does not approve DDL.

Any future SQL must remain draft-only until explicit approval.
