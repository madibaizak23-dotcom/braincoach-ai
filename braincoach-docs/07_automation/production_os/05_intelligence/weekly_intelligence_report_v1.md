# Weekly Intelligence Report v1

Status: Draft
Date: 2026-06-14
Layer: Architecture / Production OS / Intelligence Reporting

## Purpose

Define the weekly reporting artifact that turns accumulated signal candidates, aggregations, outcomes, and review queues into actionable research intelligence.

This document does not define SQL.

It does not design tables.

It does not create an automated workflow.

## Definition

Weekly Intelligence Report is a periodic internal research artifact.

It summarizes what BrainCoach learned or should inspect from recent production and research activity.

It answers:

```text
What should the research operator pay attention to this week?
```

## Inputs

The report may use:

- new tracker entries;
- observations;
- structured practice entries;
- research signal candidates;
- Production Executions;
- Production Outcomes;
- Signal Captures;
- Signal Aggregation clusters;
- open validation tasks;
- interview candidates;
- prior report open questions.

## Core Sections

Recommended report sections:

- reporting period;
- signal volume;
- top signal types;
- top repeated phrases;
- strongest cases;
- emerging clusters;
- possible patterns;
- offer-signal candidates;
- interview candidates;
- contradictions or dissonance;
- data quality warnings;
- recommended research actions;
- recommended content/research follow-up;
- open questions for Season Review.

When structured practice entries exist, especially founder routines tracked through Weekly Sprint, the report should include a `practice tracks` subsection.

For Wim Hof breathing, the report should show:

- number of sessions;
- total practice time;
- cycle counts;
- exhale retention seconds per session;
- best retention after exhale;
- progression across the reporting period;
- planned windows and confirmation deadlines;
- on-time / late / missed / rescheduled counts;
- repeated timing deviations;
- state before / after practice if captured.

Example:

```text
Practice Track: Wim Hof
- sessions: 2
- total time: 22 min
- planned windows: 08:00 by 08:15, 18:00 by 18:15
- timing: 1 on time, 1 late, 0 missed
- exhale retentions: 45/60/75/90 sec; 40/60/80/95 sec
- best retention after exhale: 95 sec
- note: retention after exhale is the primary metric, not just total duration
```

## Output

Weekly Intelligence Report may produce:

- research attention priorities;
- candidate promotion review queue;
- interview follow-up list;
- next content prompts;
- next research questions;
- data quality warnings.

It does not create validated knowledge automatically.

## Relationship To Season Review

Weekly Intelligence Report is periodic.

Season Review is seasonal.

Weekly reports feed Season Review but do not replace it.

## Relationship To Knowledge Update

Weekly reports may recommend attention or review.

Knowledge Update applies or records approved changes after review.

## Non-Goals

Weekly Intelligence Report is not:

- a dashboard;
- a migration;
- a table;
- a final Season Review;
- a Knowledge Update;
- an offer approval;
- automatic promotion.
