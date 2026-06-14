# Research Schema v1 for bgs_orch

Status: Draft
Date: 2026-06-14
Depends on: DEC-016 BGS Database Boundary Core vs Orch
Layer: Architecture / Storage / Research Process

## Purpose

Define the first architecture-level schema design for storing BrainCoach research-process, production-process and agent-performance data inside `bgs_orch`.

This document is a specification only.

No SQL migration is approved by this document.

## Boundary

According to DEC-016:

```text
bgs_core = human reality data
bgs_orch = knowledge + research process + production telemetry
```

Therefore all objects in this document belong to `bgs_orch`.

They describe how BrainCoach produces knowledge.

They do not describe children, parents or developmental reality directly.

## Core Rule

`bgs_orch` stores process memory.

`bgs_core` stores validated reality objects.

## Objects That Belong To bgs_orch

### research.seasons

Stores research seasons.

Object specification:

`braincoach-docs/07_automation/production_os/01_research/research_season.md`

Examples:

- Summer Independence
- Digital Dependency
- Motivation
- Responsibility
- Learning Ownership

Purpose:

Track research questions, hypotheses, time windows and season status.

---

### research.briefs

Stores strategic and research briefs for a season.

Object specification:

`braincoach-docs/07_automation/production_os/01_research/research_brief.md`

Includes:

- research question
- strategic insight
- market hypothesis
- phenomenon focus
- signal categories

---

### research.executions

Stores research execution steps linked to a season.

Examples:

- strategist output
- marketer output
- writer output
- analyst output
- manual research pass

---

### research.reviews

Stores season review outputs.

Object specification:

`braincoach-docs/07_automation/production_os/05_intelligence/season_review.md`

Includes:

- top repeated phrases
- strong cases
- DM count
- interview count
- offer signals
- candidate phenomena
- lessons learned

---

### production.executions

Stores published or executed production actions.

Examples:

- Instagram post
- Telegram message
- story series
- reel
- poll
- interview invitation

This is not the source of truth for content.

It is execution telemetry.

---

### production.outcomes

Stores response metrics and signal-acquisition results.

Examples:

- comments
- strong cases
- DM
- interviews
- repeated phrases
- CTA performance
- channel resonance / dissonance

---

### agent.runs

Stores individual AI agent runs.

Examples:

- strategist run
- marketer run
- writer run
- editor run
- analyst run

Purpose:

Track what agent produced which artifact and from what input.

---

### agent.evaluations

Stores quality evaluation of agent outputs.

Examples:

- did the strategist find the right market layer?
- did the marketer create signal capture?
- did the writer generate comments?
- did the post create resonance or dissonance?
- did the format fit the platform?

---

### agent.prompt_versions

Stores prompt versions used by agents.

Purpose:

Allow improvement of AI agents over time.

## Objects That Do Not Belong To bgs_orch

The following validated reality objects belong to `bgs_core`:

- persons
- conversations
- parent_interviews
- interview_responses
- observations
- tracker_entries
- research_signal_candidates
- validated signals
- phenomena
- offer signals
- GPS facts

## Promotion Rule

Data may move conceptually from `bgs_orch` to `bgs_core` only when it becomes a validated reality object.

Example:

```text
comment in production.outcomes
↓
strong case in research.review
↓
validated observation
↓
bgs_core.observations
```

## Non-Goals

This document does not:

- create a new database
- approve SQL migration
- modify bgs_core
- define final table DDL
- replace DEC-016
- store all content as permanent knowledge

## Migration Status

No migration should be executed until separate approval.

Next possible step:

Create SQL draft only after this architecture spec is reviewed and accepted.

DEC-017 adds a schema segregation rule:

- do not create new BrainCoach-owned research / production / agent tables in `public`;
- `research.seasons` and related objects require a separate approved schema migration;
- future SQL must be draft-only until explicit approval.

## Related Object Specifications

The following conceptual object specifications now refine this schema design:

- `braincoach-docs/07_automation/production_os/00_production_os_canon_v1.md`
- `braincoach-docs/07_automation/production_os/01_research/research_season.md`
- `braincoach-docs/07_automation/production_os/01_research/research_brief.md`
- `braincoach-docs/07_automation/production_os/02_marketing/marketing_brief.md`
- `braincoach-docs/07_automation/production_os/03_content/content_plan.md`
- `braincoach-docs/07_automation/production_os/04_execution/production_execution.md`
- `braincoach-docs/07_automation/production_os/04_execution/production_outcome.md`
- `braincoach-docs/07_automation/production_os/05_intelligence/signal_capture.md`
- `braincoach-docs/07_automation/production_os/05_intelligence/season_review.md`
- `braincoach-docs/07_automation/production_os/05_intelligence/knowledge_update.md`

Note:

`marketing.briefs` is a logical future object introduced by Marketing Brief Specification v1.

DEC-017 has not yet approved a dedicated `marketing.*` schema. Physical placement for a future Marketing Brief object requires a later approved decision or migration design.

`Content Plan` is a logical future object introduced by Content Plan Specification v1.

DEC-017 has not approved a `content.*` schema. Physical placement for a future Content Plan object requires a later decision and may belong under `production.*` or `research.*`.

`Signal Capture` is a logical future object introduced by Signal Capture Specification v1.

Physical placement for a future Signal Capture object requires a later decision and may belong under `research.*` or `knowledge.*`.

`Knowledge Update` is a logical future object introduced by Knowledge Update Specification v1.

Physical placement for a future Knowledge Update object requires a later decision and may belong under `knowledge.*` or `research.*`.

## Strategic Meaning

This schema allows BrainCoach to store not only knowledge about people, but also knowledge about how BrainCoach discovers knowledge.

It creates the foundation for:

```text
Season
↓
Research Brief
↓
Marketing Brief
↓
Content Plan
↓
Execution
↓
Telemetry
↓
Season Review
↓
Agent Improvement
↓
Next Season
```

This is the first formal layer of BrainCoach Production OS.
