# Signal Aggregation Layer v1

Status: Draft
Date: 2026-06-14
Layer: Architecture / Production OS / Intelligence

## Purpose

Define how BrainCoach groups isolated signal candidates into higher-level analytical clusters before pattern detection or promotion.

This document does not define SQL.

It does not design tables.

It does not promote candidates.

## Definition

Signal Aggregation is the analytical layer that groups related candidates across observations, outcomes, people, channels, and time windows.

It answers:

```text
What is repeating?
```

It does not answer:

```text
What is validated?
```

## Inputs

Signal Aggregation may consume:

- `bgs_core.research_signal_candidates`;
- Production Outcomes;
- Signal Captures;
- repeated phrase candidates;
- strong cases;
- interview candidate notes;
- manual review notes.

## Aggregation Dimensions

Candidates may be grouped by:

- signal type;
- phrase similarity;
- semantic similarity;
- person or trajectory;
- season;
- channel;
- content format;
- time window;
- confidence;
- source object;
- relationship to Self Learning Capability.

## Output Types

Signal Aggregation may produce:

- signal cluster;
- repeated phrase cluster;
- possible pattern;
- contradiction cluster;
- high-noise cluster;
- review queue;
- weak candidate group.

Outputs are analytical candidates.

They are not validated signals.

## Relationship To Pattern Detection

Signal Aggregation groups evidence.

Pattern Detection interprets recurring structure.

Example:

```text
Repeated phrases:
"Без меня ничего не делает"
"Сам не начинает"
"Нужен постоянный контроль"
↓
Signal cluster:
external management dependency language
↓
Pattern candidate:
Dependency on External Operator
```

## Relationship To Candidate Promotion

Aggregation may increase candidate strength, but does not promote by itself.

Promotion requires Candidate Promotion Governance.

## Quality Rules

Aggregation must account for:

- classification noise;
- duplicate observations;
- repeated wording introduced by BrainCoach;
- low-volume clusters;
- channel bias;
- ambiguity;
- contradictory evidence.

## Non-Goals

Signal Aggregation is not:

- Signal Capture;
- Pattern Detection finalization;
- Season Review;
- Knowledge Update;
- validated signal creation;
- SQL design;
- table design.
