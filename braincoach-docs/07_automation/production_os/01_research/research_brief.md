# Research Brief Specification v1

Status: Draft
Date: 2026-06-14
Depends on:

- DEC-016 BGS Database Boundary: Core vs Orch
- DEC-017 BGS Orch Schema Segregation
- Research Schema v1 for bgs_orch
- Research Season Specification v1

Layer: Architecture / Production OS / Research Process

## Purpose Of This Document

Define the canonical concept of a Research Brief for BrainCoach.

This document specifies the object.

It does not define SQL.

It does not approve migration.

It does not create `research.briefs`.

## Definition

A Research Brief is the object that translates a Research Season question into a concrete research program.

It sits between the season-level question and downstream marketing or production work.

Research Season asks:

> What do we want to understand?

Research Brief answers:

> How exactly will we investigate it?

## Purpose

A Research Brief exists to make a season operational without turning it into a content plan.

It solves these tasks:

- clarifies the season research question;
- states the primary hypothesis to investigate;
- identifies phenomenon focus;
- defines signal categories to watch;
- narrows the investigation scope;
- gives strategists, marketers, writers, analysts, and agents a shared research frame;
- prepares the input for a future Marketing Brief.

It does not solve these tasks:

- it does not define marketing copy;
- it does not plan channels or posting cadence;
- it does not store production telemetry;
- it does not validate observations;
- it does not close the season.

## Position In Production OS

The Research Brief is the second object in the early Production OS chain:

```text
Research Season
↓
Research Brief
↓
Marketing Brief
```

The Research Season defines the root question and boundary.

The Research Brief converts that question into an investigation plan.

The Marketing Brief later converts the research frame into market-facing communication strategy.

## Core Attributes

These are logical attributes only.

They are not SQL columns.

### brief_code

Stable human-readable identifier for the brief.

Example:

`BRIEF-2026-SUMMER-01-R01`

Purpose:

Allows humans, agents, and documents to reference the same brief.

### season_code

The season this brief belongs to.

Example:

`SEASON-2026-SUMMER-01`

Purpose:

Keeps the brief connected to the root Research Season.

### research_question

The question being investigated by this brief.

Purpose:

Makes the brief accountable to a specific research question rather than a vague topic.

### primary_hypothesis

The main hypothesis the brief is designed to test, refine, or disprove.

Purpose:

Provides direction for signal capture and analysis.

### phenomenon_focus

The phenomenon, behavior pattern, contradiction, or mechanism the brief focuses on.

Purpose:

Connects the brief to BrainCoach research objects and prevents broad thematic drift.

### signal_categories

The categories of signals the brief expects to observe.

Examples:

- self-initiation
- dependence on external operator
- avoidance
- resistance
- independent planning
- emotional reaction

Purpose:

Defines what evidence the system should watch for during execution and review.

### investigation_scope

The boundaries of the investigation.

Purpose:

Defines what belongs inside the brief and what should be ignored for this cycle.

### success_criteria

The conditions that would make the brief useful.

Examples:

- repeated phrases appear across audience responses;
- at least one strong case is captured;
- a hypothesis becomes sharper;
- a phenomenon candidate becomes clearer;
- a future interview question becomes obvious.

Purpose:

Prevents the brief from being judged only by content performance.

## Relationships

These are logical relationships only.

They are not table definitions.

They are not foreign keys.

### research.seasons

A Research Brief belongs to one Research Season.

The season gives the brief its root question and time boundary.

### marketing.briefs

A Research Brief may produce one or more Marketing Briefs.

The Marketing Brief translates research focus into audience, channel, message, and signal-capture strategy.

### research.reviews

A Research Review may evaluate whether a brief generated useful signals, cases, hypotheses, or candidate phenomena.

Briefs are reviewed as part of the season learning process.

### agent.runs

Agent runs may create, refine, or evaluate a Research Brief.

Examples:

- strategist creates a research frame;
- analyst reviews signal categories;
- marketer checks whether the brief can become market-facing;
- editor checks clarity and platform fit before marketing work begins.

## Example

### season_code

`SEASON-2026-SUMMER-01`

### season_name

Лето как тест самостоятельности

### brief_code

`BRIEF-2026-SUMMER-01-R01`

### research_question

Что происходит с ребёнком, когда исчезает внешний оператор?

### primary_hypothesis

Внешняя система маскирует отсутствие внутренней системы.

### phenomenon_focus

Dependence on external operator during unstructured time.

### signal_categories

- self-initiation
- dependence on external operator
- planning failure
- avoidance
- responsibility transfer
- independent recovery

### investigation_scope

Summer situations where school structure, coach control, tutor schedules, or parent reminders are reduced.

### success_criteria

- repeated parent phrases are captured;
- at least one strong case appears;
- the external-operator hypothesis becomes clearer;
- a future interview question is generated;
- a candidate phenomenon becomes easier to name.

## Non-Goals

A Research Brief is not:

- a content plan;
- a marketing plan;
- an offer;
- a season review;
- a CRM object;
- a database table;
- a migration;
- a replacement for a Marketing Brief.

## Related Concepts

### Research Season Specification v1

Existing document:

`braincoach-docs/07_automation/production_os/01_research/research_season.md`

Relationship:

The Research Season is the root object. The Research Brief operationalizes one season question into an investigation plan.

### Research Schema v1 for bgs_orch

Existing document:

`braincoach-docs/07_automation/research_schema_v1_bgs_orch.md`

Relationship:

Research Schema v1 proposes `research.briefs` as a future `bgs_orch` object.

This specification defines that object conceptually before any schema migration or DDL is drafted.

### Offer Discovery

Existing decision:

`braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-007-offer-discovery-layer.md`

Relationship:

Offer Discovery is a knowledge activity before it is a marketing activity.

A Research Brief may support Offer Discovery by defining what signals, objections, language, and strong cases should be watched.

It is not itself an offer.

### Seasonal Phenomena

Existing concept:

Phenomenon Registry states that phenomena may evolve across seasons.

Relationship:

A Research Brief may focus investigation on a candidate seasonal phenomenon, but it does not validate the phenomenon by itself.

Validation requires evidence and later knowledge update.

### Marketing Brief

Existing document:

`braincoach-docs/07_automation/production_os/02_marketing/marketing_brief.md`

Relationship:

The Marketing Brief should consume a Research Brief and translate it into market-facing strategy.

Research Brief stays on the research side of the boundary.

Marketing Brief starts the communication strategy layer.

### Agent Runs

Existing future object in Research Schema v1:

`agent.runs`

Relationship:

Agent runs may produce, critique, or refine Research Briefs.

The brief records the research frame; the agent run records the process that produced or changed it.

## Future Work

After this specification is reviewed and accepted, future work may discuss:

- `research.briefs` object in `bgs_orch`;
- Research Brief template v1;
- Season Review Specification v1;
- agent workflow for generating Research Briefs;
- draft migration for `research.briefs` after schema approval.

These are not approved by this document.

Any future SQL must remain draft-only until explicit approval.
