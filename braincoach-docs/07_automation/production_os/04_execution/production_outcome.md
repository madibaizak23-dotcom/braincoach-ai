# Production Outcome Specification v1

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
- Production Execution Specification v1

Layer: Architecture / Production OS / Response Telemetry

## Purpose Of This Document

Define the canonical concept of Production Outcome for BrainCoach.

This document specifies the object.

It does not define SQL.

It does not approve migration.

It does not create `production.outcomes`.

## Definition

Production Outcome is the object that records what the environment returned after a Production Execution.

It stores raw response facts.

It does not interpret those facts as signals.

Examples:

- comments count;
- DM count;
- poll answers;
- replies;
- saves;
- shares;
- clicks;
- interview candidate count;
- visible objections;
- raw repeated phrases;
- channel-level response.

Production Outcome answers:

```text
What came back after execution?
```

Signal Capture later answers:

```text
What does it mean?
```

## Purpose

Production Outcome exists to separate raw environment response from interpretation.

It solves these tasks:

- records measurable or observable response after execution;
- preserves raw counts, references, and response summaries;
- creates the input layer for Signal Capture;
- lets Season Review evaluate what the market actually returned;
- separates production telemetry from knowledge interpretation;
- allows comparison across channels, formats, and CTAs.

It does not solve these tasks:

- it does not define the production action;
- it does not replace Production Execution;
- it does not classify validated signals;
- it does not validate phenomena;
- it does not decide offer meaning;
- it does not become a CRM or analytics dashboard.

## Position In Production OS

Production Outcome sits between Execution and Signal Capture:

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
Production Outcome
↓
Signal Capture
↓
Season Review
```

Production Execution records what BrainCoach did.

Production Outcome records what came back.

Signal Capture interprets the outcome and extracts meaningful signals.

## Core Attributes

These are logical attributes only.

They are not SQL columns.

### outcome_code

Stable human-readable identifier for the outcome.

Example:

`OUT-2026-SUMMER-01-004`

Purpose:

Allows humans, agents, and reviews to reference the same response record.

### execution_code

The Production Execution that produced this outcome.

Example:

`EXEC-2026-SUMMER-01-004`

Purpose:

Keeps raw response tied to the action that created it.

### season_code

The Research Season this outcome belongs to.

Example:

`SEASON-2026-SUMMER-01`

Purpose:

Keeps outcomes aligned with season-level learning.

### channel

The channel where the response appeared.

Examples:

- Instagram;
- Telegram;
- direct message;
- email;
- parent chat;
- interview call.

Purpose:

Allows outcomes to be compared by response surface.

### response_window

The time window used to observe the outcome.

Examples:

- first 24 hours;
- first 72 hours;
- one week;
- until season close.

Purpose:

Prevents response facts from being compared across inconsistent windows.

### raw_metrics

Quantitative response facts.

Examples:

- reach;
- views;
- comments;
- replies;
- DMs;
- saves;
- shares;
- clicks;
- poll votes;
- interview opt-ins.

Purpose:

Preserves the numeric response layer before interpretation.

### raw_responses

Qualitative raw response material.

Examples:

- selected comments;
- DM excerpts;
- poll free-text answers;
- parent replies;
- objection examples;
- case descriptions.

Purpose:

Provides material for Signal Capture without yet classifying it.

### repeated_phrase_candidates

Phrases that appear more than once but have not yet been interpreted as signals.

Examples:

- "Без меня ничего не делает";
- "Все лето только телефон";
- "Нужен постоянный контроль";
- "Сам не начинает".

Purpose:

Keeps repeated language visible while delaying interpretation until Signal Capture.

### interview_candidate_count

Number of potential interview candidates visible in the outcome.

Purpose:

Records raw interview opportunity before qualification.

### response_summary

Short factual summary of what came back.

Purpose:

Helps humans and agents inspect the outcome quickly without turning it into analysis.

### captured_at

When the outcome was recorded.

Purpose:

Keeps response telemetry auditable.

### source_reference

Reference to the raw response source.

Examples:

- post URL;
- Telegram message link;
- screenshot path;
- export file;
- manual note;
- n8n execution id.

Purpose:

Allows later inspection of raw response material.

## Relationships

These are logical relationships only.

They are not table definitions.

They are not foreign keys.

### production.executions

A Production Outcome belongs to one Production Execution.

The execution records what happened.

The outcome records what came back.

### signal.capture

Signal Capture consumes Production Outcomes.

It extracts repeated phrases, objections, resonance, dissonance, strong cases, fear signals, offer signals, and interview opportunities.

Production Outcome should not perform that interpretation.

### research.reviews

Research Reviews use Production Outcomes to evaluate season response volume, channel response, artifact performance, and signal potential.

### production.executions

Production Outcomes may be compared across executions to learn which formats, channels, CTAs, and artifacts returned useful raw response.

### agent.runs

Agent runs may summarize, normalize, or prepare outcome material for Signal Capture.

The outcome stores the raw response layer; the agent run stores the process that processed or summarized it.

## Example

### season_code

`SEASON-2026-SUMMER-01`

### season_name

Лето как тест самостоятельности

### execution_code

`EXEC-2026-SUMMER-01-004`

### outcome_code

`OUT-2026-SUMMER-01-004`

### production_action

Telegram case prompt:

`День без напоминаний`

### response_window

First 72 hours after publication.

### raw_metrics

- 34 comments;
- 7 DMs;
- 18 saves;
- 2 interview candidates;
- 1 parent asked for a deeper diagnostic.

### repeated_phrase_candidates

- "Без меня ничего не делает" — 11 appearances;
- "Сам не начинает" — 8 appearances;
- "Все лето телефон" — 6 appearances.

### raw_responses

- Parent described a child who trains well with coach structure but freezes during unstructured summer days.
- Parent asked how to tell whether reminders are helping or hiding the problem.
- Parent said the child can follow a plan but cannot restart after interruption.

### response_summary

The prompt produced strong parent examples around reminder dependency, difficulty starting independently, and summer structure collapse.

No final signal classification is made in this outcome.

## Non-Goals

Production Outcome is not:

- Production Execution;
- Signal Capture;
- Research Review;
- validated signal;
- validated phenomenon;
- offer;
- CRM record;
- analytics dashboard;
- migration;
- table.

## Related Concepts

### Production Execution

Existing document:

`braincoach-docs/07_automation/production_os/04_execution/production_execution.md`

Relationship:

Production Execution records what BrainCoach did.

Production Outcome records what came back.

### Signal Capture

Existing document:

`braincoach-docs/07_automation/production_os/05_intelligence/signal_capture.md`

Relationship:

Production Outcome provides raw material.

Signal Capture extracts meaning.

### Season Review

Existing concept:

Season Review is the closing intelligence artifact for a Research Season.

Relationship:

Season Review uses outcomes to evaluate response volume, channel usefulness, artifact usefulness, and whether enough raw material exists for signal extraction.

### Offer Discovery

Existing decision:

`braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-007-offer-discovery-layer.md`

Relationship:

Production Outcomes may contain raw offer-signal material, but they do not classify or validate offer signals.

### Research Schema v1 for bgs_orch

Existing document:

`braincoach-docs/07_automation/research_schema_v1_bgs_orch.md`

Relationship:

Research Schema v1 proposes `production.outcomes` as a future `bgs_orch` object.

This specification defines that object conceptually before any schema migration or DDL is drafted.

## Future Work

After this specification is reviewed and accepted, future work may discuss:

- Season Review Specification v1;
- future object `production.outcomes`;
- raw response normalization conventions;
- outcome status model;
- agent workflow for outcome summarization;
- draft migration only after explicit approval.

Important:

DEC-017 already identifies `production.*` as an approved proposed schema family for production process memory.

Research Schema v1 already proposes `production.outcomes` as a future object.

This document does not create `production.outcomes`.

It does not approve DDL.

Any future SQL must remain draft-only until explicit approval.
