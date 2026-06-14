# Daily Intelligence Report Generator v1

Status: Draft
Date: 2026-06-14
Layer: Architecture / Production OS / Intelligence Reporting

## Purpose

Define the future generator design for producing BrainCoach Daily Intelligence Report drafts from live operational and research data.

Daily Intelligence Report Generator turns live data sources into a daily intelligence artifact.

It is an intelligence architecture specification.

It is not an implementation.

It is not an n8n workflow.

It is not a SQL schema.

It is not a migration.

It is not production automation.

It answers:

```text
How should BrainCoach convert daily data into actionable intelligence without promoting knowledge automatically?
```

## Scope

This document is documentation/spec only.

It defines:

- source data contract;
- daily read model;
- aggregation logic;
- signal-of-the-day logic;
- emerging-pattern detection logic;
- bottleneck detection;
- research direction derivation;
- output schema;
- governance rules;
- future automation boundary.

It does not define:

- SQL;
- migrations;
- new tables;
- n8n nodes;
- workflow JSON;
- production deployment;
- automatic candidate promotion;
- canonical knowledge updates.

## Placement Decision

This document belongs in:

`braincoach-docs/07_automation/production_os/05_intelligence/`

Reason:

Daily Intelligence Report Generator v1 is currently an intelligence architecture specification, not a workflow implementation.

It defines how daily evidence should be transformed into intelligence.

It does not define execution mechanics, n8n nodes, schedules, credentials, workflow JSON, or runtime deployment.

Therefore it should remain close to the Daily Intelligence Report artifact specification.

It may later produce a separate workflow design under:

`braincoach-docs/07_automation/02_workflows/`

Only after implementation is explicitly approved.

## Relationship To Daily Intelligence Report

`daily_intelligence_report_v1.md` defines the output artifact.

This document defines the generator design that may later produce that output as a draft.

The relationship is:

```text
Live data sources
↓
Daily Intelligence Report Generator v1
↓
Daily Intelligence Report v1 draft
↓
Human review
↓
Weekly Intelligence Report input
```

The generator must not bypass human review.

## Source Data Contract

The generator may read from existing live sources when implementation is separately approved.

Expected source families:

- `tracker_entries`;
- `observations`;
- `research_signal_candidates`;
- `parent_interviews`;
- `interview_responses`;
- `conversation_events`.

Source records should be treated as evidence.

Source records do not become validated knowledge because they were included in a generated report.

## Daily Read Model

For each daily window, the generator should read:

- new tracker entries;
- new observations;
- new research signal candidates;
- new interview responses;
- completed interviews;
- abandoned interviews;
- conversation events;
- errors;
- bottlenecks;
- unresolved analysis items from the prior daily window.

The daily window should be explicit in the output report.

The generator should preserve source references when possible so that human reviewers can trace conclusions back to evidence.

## Aggregation Logic

Daily evidence should be grouped before interpretation.

Recommended grouping dimensions:

- signal type;
- phenomenon candidate;
- person or conversation;
- source type;
- confidence;
- recurrence;
- time window;
- relation to active research season;
- relation to Self Learning Capability;
- relation to active phenomena.

Aggregation output remains candidate-level intelligence.

It should not be named as validated signal, validated pattern, or canonical knowledge.

## Signal-Of-The-Day Logic

Signal of the day is the strongest daily signal candidate for operator attention.

Selection should consider:

- recurrence across multiple records;
- confidence level;
- strategic relevance;
- relation to Self Learning Capability;
- relation to active phenomena;
- novelty against prior reports;
- evidence diversity across source types;
- contradiction or dissonance value.

The generator should produce a rationale, not only a label.

Recommended output fields:

- signal name;
- short description;
- source evidence count;
- source types;
- confidence;
- novelty;
- strategic relevance;
- why it matters today;
- required human review.

If evidence is weak, the report should explicitly say that no reliable signal of the day was detected.

## Emerging Pattern Detection Logic

Emerging pattern detection identifies repeated structure without validating it.

Inputs may include:

- repeated signal candidates;
- similar observation language;
- repeated parent concerns;
- repeated tracker themes;
- signal combinations;
- repeated stage transitions;
- recurring abandonment or completion patterns.

Detection should look for:

- repeated wording;
- repeated emotional concerns;
- repeated parent-child dynamic descriptions;
- repeated friction in GPS stages;
- co-occurrence between signal types;
- recurrence across different people or conversations;
- recurrence across source types.

Pattern output must remain a pattern candidate until reviewed.

The generator should preserve contradictions and weak evidence instead of smoothing them away.

## Bottleneck Detection

Bottleneck detection identifies constraints in the intelligence loop.

Potential bottlenecks:

- incomplete interviews;
- abandoned interviews;
- stage transition failures;
- low-confidence signal noise;
- repeated errors;
- missing analysis;
- classification ambiguity;
- insufficient source diversity;
- unresolved prior-day items;
- signal candidates without related observations;
- observations without downstream signal candidates.

Bottlenecks should be separated from product insights.

A bottleneck describes system limitation.

A product insight describes what the limitation may imply for the BrainCoach product or GPS design.

## Research Direction Derivation

Daily intelligence should help the system move from evidence to research direction.

Recommended reasoning chain:

```text
Signal Cluster
↓
Pattern
↓
Question
↓
Hypothesis
↓
Suggested Research Direction
```

Each suggested research direction should include:

- source signal cluster;
- possible pattern;
- research question;
- working hypothesis;
- evidence strength;
- relation to active research season;
- relation to Self Learning Capability;
- suggested next inspection step;
- unresolved contradictions.

Research direction is not a decision.

It is a candidate for human review and weekly synthesis.

## Output Schema

The generator should produce a draft Daily Intelligence Report with the following sections:

- executive summary;
- system health;
- data intake summary;
- signal summary;
- signal of the day;
- emerging patterns;
- active phenomena;
- bottlenecks;
- research directions;
- product intelligence;
- next actions;
- human review notes.

### Executive Summary

Short synthesis of what the system learned during the daily window.

### System Health

Operational state of the intelligence loop.

Examples:

- normal;
- noisy;
- sparse data;
- blocked;
- ambiguous;
- review needed.

### Data Intake Summary

Counts and qualitative notes for source families read during the daily window.

### Signal Summary

Grouped view of daily signal candidates by type, confidence, recurrence, and source type.

### Signal Of The Day

Primary daily signal candidate and rationale.

### Emerging Patterns

Repeated structures that may become pattern candidates after review.

### Active Phenomena

Phenomena that appear connected to the daily evidence.

This section must distinguish active phenomena from newly detected phenomenon candidates.

### Bottlenecks

Detected constraints in intake, classification, analysis, interview flow, or signal quality.

### Research Directions

Candidate directions derived from signal clusters and possible patterns.

### Product Intelligence

Product-facing implications from the daily evidence.

This section must not issue parent-facing recommendations.

### Next Actions

Suggested operator actions for review, investigation, or weekly rollup.

### Human Review Notes

Items that require explicit human judgment before promotion, action, or knowledge update.

## Governance Rules

The generated report is draft until reviewed.

Rules:

- no automatic phenomenon promotion;
- no automatic canonical knowledge update;
- no intervention recommendation without human review;
- low-confidence signals must remain candidates;
- contradictions must be preserved;
- source uncertainty must be visible;
- signal and pattern labels must not imply validation;
- parent-facing recommendations require separate human approval;
- strategic decisions must not be made by the generator.

## Future Automation Boundary

Future automation may include:

- daily data pull;
- aggregation;
- draft generation;
- anomaly detection;
- report storage;
- source reference linking;
- weekly rollup preparation.

Future automation must not include:

- canonical signal approval;
- phenomenon validation;
- strategic decisions;
- parent-facing recommendations;
- automatic writes to canonical knowledge;
- automatic promotion from candidate to validated reality.

## Non-Goals

Daily Intelligence Report Generator v1 is not:

- the Daily Intelligence Report output itself;
- an n8n workflow;
- a production workflow;
- an SQL design;
- a migration plan;
- a database schema;
- a validated intelligence engine;
- a parent-facing recommendation system;
- a replacement for Weekly Intelligence Report;
- a replacement for human research review.
