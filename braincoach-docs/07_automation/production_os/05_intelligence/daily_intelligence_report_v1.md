# BrainCoach Daily Intelligence Report v1

Status: Draft
Date: 2026-06-14
Layer: Architecture / Production OS / Intelligence Reporting

## Purpose

Define the daily intelligence artifact that turns recent observations, signal candidates, operational state, and emerging friction into next-day research and product attention.

Daily Intelligence Report is an internal operational intelligence object.

It is not content.

It is not a marketing report.

It is not a dashboard.

It answers:

```text
What did BrainCoach learn today, what is changing, and what should receive attention tomorrow?
```

This document does not define SQL.

It does not design tables.

It does not create an automated workflow.

It does not modify production workflow.

## Definition

BrainCoach Daily Intelligence Report is a daily draft/spec artifact that captures the state of the Production OS intelligence loop.

It converts accumulated daily evidence into:

- active signals;
- emerging patterns;
- product insight;
- bottleneck visibility;
- research direction;
- knowledge update candidates;
- next-day priorities.

It does not validate knowledge automatically.

It does not promote candidates.

It does not write to `bgs_core`.

## Inputs

The report may use existing documentation and process memory only.

Allowed inputs include:

- current research season context;
- active research briefs;
- Production Executions;
- Production Outcomes;
- Signal Captures;
- research signal candidates;
- observations from tracker or manual review;
- Signal Aggregation clusters;
- prior Daily Intelligence Reports;
- prior Weekly Intelligence Reports;
- open validation tasks;
- known data quality warnings;
- operator notes from the day.

The report must not require:

- new SQL schemas;
- new tables;
- migrations;
- direct production workflow changes;
- automatic writes into `bgs_core`;
- unapproved candidate promotion.

## Report Structure

Recommended sections:

- report date;
- reporting window;
- system state;
- active research context;
- active signals;
- new signal candidates;
- emerging patterns;
- product insights;
- knowledge update candidates;
- bottlenecks;
- contradictions or weak evidence;
- data quality warnings;
- decisions needed;
- next-day priorities;
- carry-forward items;
- weekly rollup notes.

## Section Guidance

### System State

Summarizes whether the Production OS is operating normally, partially blocked, noisy, or missing key inputs.

This section should focus on operational intelligence, not infrastructure monitoring.

### Active Signals

Lists signals that were visible during the reporting window and are relevant to current research direction.

Signals remain candidates unless validated through the accepted governance path.

### Emerging Patterns

Captures repeated structure across observations, outcomes, phrases, user behavior, or operator review.

Emerging patterns may be weak.

The report should distinguish between:

- isolated observation;
- repeated signal;
- possible pattern;
- validated pattern.

### Product Insights

Records product-facing implications from the day.

Examples:

- feature friction;
- unclear value proposition;
- onboarding gap;
- unexpected user language;
- offer or positioning clue;
- evidence that a workflow is too heavy or too shallow.

Product insights are not implementation decisions.

They are inputs for product review.

### Bottlenecks

Identifies constraints that slowed the intelligence loop.

Examples:

- missing observations;
- low-quality signal candidates;
- unclear research question;
- weak linkage between outcome and signal capture;
- unresolved governance question;
- manual review backlog.

### Next-Day Priorities

Defines a short operational queue for the next day.

Priorities should be specific enough to guide action without becoming a task management system.

## Daily Generation Logic

Daily generation is a documentation process, not a live automation requirement.

Recommended logic:

1. Select the reporting window.
2. Review new Production Outcomes and Signal Captures.
3. Review new or changed signal candidates.
4. Compare daily evidence against the active Research Season and Research Brief.
5. Identify repeated phrases, recurring behaviors, contradictions, and bottlenecks.
6. Translate evidence into research attention, product insight, and knowledge update candidates.
7. Mark unresolved items for carry-forward or weekly rollup.
8. Produce next-day priorities.

The report should preserve uncertainty.

It should use language such as:

- observed;
- possible;
- emerging;
- candidate;
- needs validation;
- ready for review.

It should avoid language such as:

- proven;
- validated;
- approved;
- promoted;
- source of truth.

## Relationship To Weekly Intelligence Reports

Daily Intelligence Reports are daily operational snapshots.

Weekly Intelligence Reports are synthesis artifacts.

Daily reports feed weekly reports by providing:

- recurring signal evidence;
- repeated bottlenecks;
- unresolved questions;
- candidate patterns;
- product insight trail;
- data quality warnings;
- carry-forward research priorities.

Weekly reports may consolidate, compare, and prioritize daily intelligence across a longer window.

Weekly reports do not replace daily reports.

Daily reports do not replace weekly reports.

## Relationship To Season Review

Daily reports may surface early indicators for Season Review.

They do not close a season.

They do not approve knowledge changes.

They provide traceable daily context that Season Review can inspect later.

## Relationship To Knowledge Update

Daily reports may identify knowledge update candidates.

Knowledge Update remains the artifact that records accepted changes after review.

Daily reports must not directly alter canonical knowledge.

## Governance Rules

Daily Intelligence Report must follow these rules:

- remain a draft/spec artifact until explicitly approved for implementation;
- use existing Production OS and Knowledge OS documentation boundaries;
- preserve distinction between observation, signal candidate, pattern candidate, and validated knowledge;
- avoid automatic promotion;
- avoid automatic writes into `bgs_core`;
- avoid creating new SQL schemas, tables, or migrations;
- avoid changing production workflow;
- document uncertainty explicitly;
- keep marketing/content interpretation separate from intelligence interpretation;
- carry unresolved questions forward instead of forcing premature conclusions.

## Future Automation Notes

Future automation may generate a draft Daily Intelligence Report from existing process memory.

Allowed future automation direction:

- collect existing observations and signal candidates;
- summarize daily state;
- cluster repeated items;
- draft bottleneck and data quality warnings;
- suggest next-day priorities;
- flag items for Weekly Intelligence Report synthesis.

Future automation must remain draft-first unless separately approved.

Future automation must not:

- create SQL schemas;
- create tables;
- run migrations;
- modify production workflow;
- validate knowledge automatically;
- promote candidates automatically;
- write to `bgs_core` automatically;
- replace human review.

## Non-Goals

Daily Intelligence Report is not:

- public content;
- marketing reporting;
- an analytics dashboard;
- a production workflow;
- a database schema;
- a migration plan;
- a final research conclusion;
- a Season Review;
- a Knowledge Update;
- a candidate promotion mechanism.
