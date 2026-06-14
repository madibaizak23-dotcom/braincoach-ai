# Candidate Promotion Governance v1

Status: Draft
Date: 2026-06-14
Layer: Architecture / Production OS / Governance

## Purpose

Define how BrainCoach governs movement from signal candidates and knowledge candidates toward accepted knowledge or validated reality.

This document closes the gap between Signal Candidate and Knowledge Asset.

It does not define SQL.

It does not design tables.

It does not approve automatic promotion.

## Promotion Principle

Candidates do not become knowledge automatically.

Candidates move through review, consolidation, validation, and owner approval.

## Candidate Inputs

Promotion governance may receive candidates from:

- `bgs_core.research_signal_candidates`;
- Signal Capture candidates;
- Signal Aggregation clusters;
- Season Review consolidated candidates;
- Weekly Intelligence Report recommendations;
- manual research review.

## Candidate Types

Candidate types include:

- signal candidate;
- repeated phrase candidate;
- pattern candidate;
- phenomenon candidate;
- offer signal candidate;
- strong case;
- interview candidate;
- research question candidate;
- knowledge update recommendation.

## Promotion States

Recommended conceptual states:

```text
captured
↓
aggregated
↓
reviewed
↓
accepted_candidate
↓
validation_required
↓
validated
↓
promoted
```

Rejection path:

```text
captured
↓
reviewed
↓
rejected
```

These are conceptual states only.

They are not table definitions.

## Promotion Criteria

A candidate becomes stronger when it has:

- repeated evidence across time;
- evidence from more than one outcome;
- evidence from more than one person or context;
- interview confirmation;
- clear source traceability;
- alignment with a Research Season question;
- low contradiction from competing evidence;
- owner review.

## Validation Required

Validation is required before:

- creating validated signals;
- updating Phenomenon Registry;
- promoting a candidate to `bgs_core`;
- making person-linked claims;
- creating product or offer claims;
- treating a pattern as canonical.

## Never Automatic

The following must never be automatic:

- writing to `bgs_core`;
- validating a phenomenon;
- approving an offer;
- changing Phenomenon Registry status to validated or canonical;
- creating person-linked observations;
- applying migrations;
- updating live registry rows.

## Promotion Outputs

Possible outputs:

- accepted research signal candidate;
- candidate pattern;
- candidate phenomenon;
- candidate offer signal;
- validation task;
- research question update;
- Knowledge Update recommendation;
- rejected candidate note.

## Boundary

`bgs_orch` stores process memory and candidate review.

`bgs_core` stores validated human reality data.

Promotion across this boundary requires explicit approval.

## Non-Goals

This governance does not:

- define a database schema;
- define final statuses for implementation;
- approve SQL;
- replace Season Review;
- replace Knowledge Update;
- automate validation.
