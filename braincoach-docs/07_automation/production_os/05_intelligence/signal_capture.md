# Signal Capture Specification v1

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
- Production Outcome Specification v1

Layer: Architecture / Production OS / Knowledge Candidate Extraction

## Purpose Of This Document

Define the canonical concept of Signal Capture for BrainCoach.

This document specifies the object.

It does not define SQL.

It does not approve migration.

It does not create a table or schema.

## Definition

Signal Capture is the object and process that turns Production Outcomes into structured knowledge candidates.

It begins interpretation.

It does not finalize truth.

It answers:

```text
What knowledge candidates can be extracted from what the world returned?
```

Signal Capture sits between raw response telemetry and validated knowledge.

## Purpose

Signal Capture exists to prevent BrainCoach from jumping directly from raw outcomes to conclusions.

It solves these tasks:

- interprets raw outcomes into candidate signals;
- separates repeated language from validated signal meaning;
- identifies strong cases and interview candidates;
- captures early offer-signal material without turning it into an offer;
- creates reviewable evidence for Season Review;
- prepares possible promotion into `bgs_core` only after validation.

It does not solve these tasks:

- it does not store raw comments, DMs, poll answers, or metrics;
- it does not replace Production Outcome;
- it does not complete Season Review;
- it does not validate phenomena;
- it does not write validated reality into `bgs_core`;
- it does not create a product offer.

## Position In Production OS

Signal Capture is the interpretation layer after Production Outcome:

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
↓
Knowledge Update
```

Production Outcome records what came back.

Signal Capture extracts candidate meaning.

Season Review evaluates whether those candidates are strong enough to influence knowledge, future research, or possible promotion to validated reality.

## Core Attributes

These are logical attributes only.

They are not SQL columns.

### capture_code

Stable human-readable identifier for the signal capture record.

Example:

`CAP-2026-SUMMER-01-004-A`

Purpose:

Allows humans, agents, reviews, and future knowledge candidates to reference the same capture.

### season_code

The Research Season this capture belongs to.

Example:

`SEASON-2026-SUMMER-01`

Purpose:

Keeps captured candidates tied to the season question.

### outcome_code

The Production Outcome used as source material.

Example:

`OUT-2026-SUMMER-01-004`

Purpose:

Preserves traceability from interpretation back to raw response.

### execution_code

The Production Execution that produced the outcome.

Example:

`EXEC-2026-SUMMER-01-004`

Purpose:

Allows later review of which production action created the response surface.

### capture_type

The type of candidate extracted.

Candidate types:

- `repeated_phrase`;
- `objection_signal`;
- `fear_signal`;
- `offer_signal`;
- `strong_case`;
- `interview_candidate`;
- `resonance_signal`;
- `dissonance_signal`;
- `phenomenon_candidate`.

Purpose:

Keeps captured material structured without treating it as validated knowledge.

### candidate_label

Short human-readable label for the candidate.

Examples:

- `Dependency on External Operator`;
- `Fear of Future Independence Failure`;
- `Summer Structure Collapse`;
- `Reminder Dependency Case`;
- `Early Diagnostic Demand`.

Purpose:

Gives the candidate a usable name for review and future comparison.

### source_evidence

The evidence summary that supports the capture.

Examples:

- repeated phrase appeared 11 times;
- 7 DMs described the same failure mode;
- 2 parents asked for an interview;
- one objection repeated across comments and DMs.

Purpose:

Prevents capture from becoming unsupported interpretation.

### source_excerpt_refs

References to raw response excerpts in the Production Outcome.

Purpose:

Allows later inspection without duplicating raw comments, DMs, or poll answers inside Signal Capture.

### confidence_level

Initial confidence in the candidate.

Candidate values:

- low;
- medium;
- high.

Purpose:

Marks interpretation strength before Season Review.

### review_status

Status of the captured candidate.

Candidate values:

- captured;
- needs_review;
- reviewed;
- rejected;
- promoted_candidate.

Purpose:

Separates captured material from reviewed or promoted knowledge.

### interpretation_note

Short explanation of why this candidate was captured.

Purpose:

Documents the reasoning without turning the capture into final analysis.

### captured_by

Who or what captured the signal candidate.

Examples:

- Malik;
- analyst agent;
- marketer agent;
- manual review;
- n8n workflow.

Purpose:

Preserves accountability and makes agent performance review possible.

### captured_at

When the candidate was captured.

Purpose:

Keeps interpretation auditable.

## Candidate Types

### repeated_phrase

A phrase or language pattern repeated across raw responses.

Example:

`Без меня ничего не делает`

This is not yet a validated signal.

### objection_signal

A candidate objection expressed by the audience.

Example:

`We already tried schedules and they do not work.`

### fear_signal

A candidate fear or anxiety pattern.

Example:

`Не справится в вузе`

### offer_signal

A candidate indication of demand, willingness to solve, or language for a future offer.

Example:

`Как понять это заранее?`

### strong_case

A concrete case with enough detail to support deeper research.

Example:

A parent describes a child who performs well under coach structure but cannot restart independently during summer.

### interview_candidate

A person or case that may be suitable for deeper interview.

Example:

A parent gives a detailed case and agrees to discuss it further.

### resonance_signal

Evidence that a frame, phrase, or angle strongly matches audience experience.

Example:

Multiple parents respond to `parent as operating system` with concrete examples.

### dissonance_signal

Evidence that a frame creates resistance, confusion, or mismatch.

Example:

Parents reject a phrase because it feels blaming or inaccurate.

### phenomenon_candidate

A possible phenomenon suggested by repeated outcomes and captured signals.

Example:

`Summer exposes hidden dependence on external operators.`

## Relationships

These are logical relationships only.

They are not table definitions.

They are not foreign keys.

### production.outcomes

Signal Capture consumes Production Outcomes.

Production Outcome stores raw response facts.

Signal Capture extracts structured candidates from those facts.

### research.reviews

Season Review evaluates captured candidates across the season.

It may reject, merge, strengthen, or promote candidates.

### bgs_core

Signal Capture does not directly create validated reality in `bgs_core`.

Promotion to `bgs_core` requires separate validation and approved promotion rules.

### research_signal_candidates

Existing `bgs_core.research_signal_candidates` may store validated or promoted reality-facing signal candidates when the boundary rule is satisfied.

Signal Capture in `bgs_orch` remains process memory until promotion is explicitly approved.

### agent.runs

Agent runs may extract, classify, critique, or summarize signal captures.

The capture records the candidate; the agent run records the process that produced or evaluated it.

## Example

### season_code

`SEASON-2026-SUMMER-01`

### season_name

Лето как тест самостоятельности

### outcome_code

`OUT-2026-SUMMER-01-004`

### capture_code

`CAP-2026-SUMMER-01-004-A`

### capture_type

`repeated_phrase`

### candidate_label

`Dependency on External Operator`

### source_evidence

The phrase `Без меня ничего не делает` appeared 11 times in comments and DMs after the Thursday prompt.

Several cases described a child who can follow external structure but does not initiate action independently.

### interpretation_note

The repeated phrase may indicate a dependency pattern where the parent, coach, or school acts as the operating system.

This remains a candidate until Season Review compares it with other outcomes and cases.

### confidence_level

`medium`

### review_status

`captured`

## Non-Goals

Signal Capture is not:

- Production Outcome;
- raw comment storage;
- DM storage;
- poll storage;
- metrics storage;
- Season Review;
- validated signal;
- validated phenomenon;
- offer;
- CRM record;
- migration;
- table.

## Related Concepts

### Production Outcome

Existing document:

`braincoach-docs/07_automation/production_os/04_execution/production_outcome.md`

Relationship:

Production Outcome stores what came back.

Signal Capture extracts candidates from what came back.

### Season Review

Existing document:

`braincoach-docs/07_automation/production_os/05_intelligence/season_review.md`

Relationship:

Season Review evaluates captured candidates across the season and decides what should influence knowledge update.

### Offer Discovery

Existing decision:

`braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-007-offer-discovery-layer.md`

Relationship:

Signal Capture may identify offer-signal candidates.

It does not create or validate an offer.

### Research Schema v1 for bgs_orch

Existing document:

`braincoach-docs/07_automation/research_schema_v1_bgs_orch.md`

Relationship:

Research Schema v1 defines `bgs_orch` as the place for research process and production telemetry.

Signal Capture belongs to that process memory layer until a candidate is explicitly promoted.

### BGS Core Boundary

Existing decision:

`DEC-016 BGS Database Boundary: Core vs Orch`

Relationship:

`bgs_core` stores validated reality.

Signal Capture stores process-level candidates in `bgs_orch` unless and until promotion is approved.

## Future Work

After this specification is reviewed and accepted, future work may discuss:

- Knowledge Update Specification v1;
- candidate promotion rules from `bgs_orch` to `bgs_core`;
- future object placement under `research.*` or `knowledge.*`;
- agent workflow for signal extraction;
- draft migration only after explicit approval.

Important:

DEC-017 currently approved `knowledge.*`, `research.*`, `production.*`, and `agent.*` as proposed schemas.

Physical placement of a future Signal Capture object requires a later decision.

Signal Capture may belong under `research.*` or `knowledge.*`, but this document does not approve either placement.

This document does not create a table or schema.

It does not approve DDL.

Any future SQL must remain draft-only until explicit approval.
