# Research Season Specification v1

Status: Draft
Date: 2026-06-14
Depends on:

- DEC-016 BGS Database Boundary: Core vs Orch
- DEC-017 BGS Orch Schema Segregation
- Research Schema v1 for bgs_orch

Layer: Architecture / Production OS / Research Process

## Purpose Of This Document

Define the canonical concept of a Research Season for BrainCoach.

This document specifies the object.

It does not define SQL.

It does not approve migration.

It does not create `research.seasons`.

## Definition

A Research Season is a bounded research program organized around one major question about human development, behavior, learning, performance, or adaptation.

It is the root object of the Season Intelligence Loop.

## Purpose

A Research Season exists to create continuity in knowledge production.

It solves these tasks:

- focuses research around a single coherent question;
- groups signals, cases, hypotheses, executions, and reviews into one investigation;
- connects research work to production work without reducing research to content planning;
- gives agents and humans a shared unit of work;
- creates a reviewable cycle from question to knowledge update;
- prevents isolated observations from becoming disconnected content fragments.

It does not solve these tasks:

- it does not store human reality data directly;
- it does not replace `bgs_core` observations, signals, cases, or phenomena;
- it does not define final database tables;
- it does not replace the Season Registry;
- it does not act as a CRM object or campaign tracker.

## Position In Production OS

The Research Season is the root of the Production OS knowledge-production cycle:

```text
Research Season
↓
Research Brief
↓
Marketing Brief
↓
Content Plan
↓
Execution
↓
Signal Capture
↓
Season Review
↓
Knowledge Update
```

The season gives the loop a stable question and boundary.

Briefs translate the question into strategy.

Production creates public tests and signal-capture surfaces.

Signal capture gathers reality response.

Season review turns repeated patterns into learning.

Knowledge update promotes validated understanding into the appropriate knowledge layer.

## Lifecycle

### draft

The season is being formulated.

The research question, scope, and hypothesis are not yet stable.

No production or research execution should depend on it as an active season.

### active

The season is open and guiding work.

Briefs, executions, signal capture, agent runs, and reviews may link back to the season.

The season has a clear research question, primary hypothesis, and scope.

### completed

The season has been reviewed.

Its major learnings, repeated signals, cases, and knowledge updates have been summarized.

Completed does not mean the topic is permanently finished; it means this bounded research cycle is closed.

### archived

The season is no longer active operationally.

It remains available for historical learning, comparison, and future season planning.

## Core Attributes

### season_code

Stable human-readable identifier.

Example:

`SEASON-2026-SUMMER-01`

Purpose:

Allows humans, docs, agents, briefs, and reviews to refer to the same season without relying on database ids.

### season_name

Short name of the season.

Example:

`Лето как тест самостоятельности`

Purpose:

Gives the season a recognizable title for planning and review.

### research_question

The central question the season investigates.

Purpose:

Defines what the season is trying to understand.

### primary_hypothesis

The leading explanation or assumption being tested.

Purpose:

Gives the season a falsifiable or refinable direction.

### start_date

The date the season begins or is intended to begin.

Purpose:

Defines the opening boundary for the cycle.

### end_date

The date the season ends or is intended to end.

Purpose:

Prevents seasons from continuing indefinitely.

### status

Lifecycle state of the season.

Allowed conceptual states:

- `draft`
- `active`
- `completed`
- `archived`

Purpose:

Controls whether the season is being designed, actively used, reviewed, or retained historically.

## Relationships

These are logical relationships only.

They are not table definitions.

They are not foreign keys.

### research.briefs

A season may have one or more research briefs.

Briefs translate the season question into research strategy, phenomenon focus, signal categories, and investigation plan.

Object specification:

`braincoach-docs/07_automation/production_os/01_research/research_brief.md`

### research.reviews

A season should produce at least one season review.

Reviews summarize repeated phrases, strong cases, offer signals, candidate phenomena, and lessons learned.

### production.executions

A season may guide multiple production executions.

Executions are public or operational actions created to test, expose, or capture signals around the season question.

### production.outcomes

A season may accumulate outcomes from production executions.

Outcomes capture responses, comments, DMs, interviews, repeated phrases, and resonance/dissonance signals.

### agent.runs

A season may coordinate agent runs.

Agent runs show which strategist, marketer, writer, editor, or analyst produced which artifact from which input.

## Season Types

The list is preliminary.

### Phenomenon Discovery

Used when the main goal is to discover or clarify a human phenomenon.

### Offer Discovery

Used when the main goal is to discover offer signals, language, objections, or demand shape.

### Market Discovery

Used when the main goal is to understand audience segments, market layers, or communication angles.

### Validation Season

Used when the main goal is to validate an existing hypothesis, phenomenon, or mechanism.

## Example Season

### season_code

`SEASON-2026-SUMMER-01`

### season_name

Лето как тест самостоятельности

### research_question

Что происходит с ребёнком, когда исчезает внешний оператор?

### primary_hypothesis

Внешняя система маскирует отсутствие внутренней системы.

### status

`draft`

### type

Phenomenon Discovery

### strategic meaning

This season investigates summer as a natural stress test for self-management, learning ownership, and dependence on external operators.

## Non-Goals

A Research Season is not:

- a content plan;
- a marketing campaign;
- a product launch;
- a CRM object;
- a database table;
- a migration;
- a replacement for validated observations or phenomena in `bgs_core`.

## Related Concepts

### Season Registry

Existing document:

`braincoach-docs/03_knowledge/03_registries/season_registry.md`

Relationship:

Season Registry is the accepted knowledge registry for research seasons.

This specification defines the canonical object contract for future Production OS / `research.seasons` design.

It does not replace Season Registry.

### Season Review

Existing document:

`braincoach-docs/07_automation/production_os/05_intelligence/season_review.md`

Relationship:

Season Review is the closing intelligence artifact for a Research Season.

It turns season activity and captured signals into lessons learned, candidate phenomena, and knowledge updates.

### Seasonal Phenomena

Existing concept:

Phenomenon Registry states that a phenomenon can evolve across seasons and can link to a season.

Relationship:

A Research Season may investigate one or more phenomena, but the season itself is not a phenomenon.

Validated phenomena remain knowledge objects, not production-cycle containers.

### Season Intelligence Loop

Existing concept:

Repository journal and Research Schema v1 refer to the Season Intelligence Loop as the process that turns research, production, telemetry, review, and agent improvement into the next season.

Relationship:

Research Season is the root object of that loop.

Without a season, the loop has no stable question, scope, or closure point.

### Research Schema v1 for bgs_orch

Existing document:

`braincoach-docs/07_automation/research_schema_v1_bgs_orch.md`

Relationship:

Research Schema v1 proposes `research.seasons` as a future `bgs_orch` object.

This specification defines that object conceptually before any schema migration or DDL is drafted.

### DEC-016

Decision:

`bgs_core` stores human reality data.

`bgs_orch` stores knowledge, research process, and production telemetry.

Relationship:

Research Season belongs to `bgs_orch`, not `bgs_core`.

### DEC-017

Decision:

New BrainCoach-owned objects in `bgs_orch` must be created outside `public`, in separate schemas.

Relationship:

Future `research.seasons` belongs under `research.*`, but it must not be created until a separate approved schema migration exists.

## Future Work

After this specification is reviewed and accepted, future work may discuss:

- `research.seasons` table;
- `research` schema migration;
- first season registry entry for `SEASON-2026-SUMMER-01`;
- Research Brief Specification v1;
- draft migration for `CREATE SCHEMA research`.

These are not approved by this document.

Any future SQL must remain draft-only until explicit approval.
