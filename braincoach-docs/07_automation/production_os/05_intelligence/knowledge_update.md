# Knowledge Update Specification v1

Status: Draft
Date: 2026-06-14
Depends on:

- DEC-016 BGS Database Boundary: Core vs Orch
- DEC-017 BGS Orch Schema Segregation
- Research Schema v1 for bgs_orch
- Season Review Specification v1
- Signal Capture Specification v1

Layer: Architecture / Knowledge OS / Update Governance

## Purpose Of This Document

Define the canonical concept of Knowledge Update for BrainCoach.

This document specifies the object and governance boundary.

It does not define SQL.

It does not approve migration.

It does not create a table or schema.

It does not approve automatic writes to `bgs_core`.

## Definition

Knowledge Update is the governed process that turns accepted Season Review recommendations into explicit changes to BrainCoach knowledge.

It is the bridge between:

```text
bgs_orch
↓
research process memory
↓
knowledge update recommendation
↓
bgs_core or Knowledge OS
```

Knowledge Update answers:

```text
What should BrainCoach change in its knowledge after this season?
```

It does not answer:

```text
What did one post return?
```

That belongs to Production Outcome.

It does not answer:

```text
What candidate meaning can be extracted?
```

That belongs to Signal Capture.

## Purpose

Knowledge Update exists to prevent unreviewed production telemetry from silently becoming canonical knowledge.

It solves these tasks:

- receives recommendations from Season Review;
- separates process-memory updates from validated reality updates;
- defines which objects may be updated;
- defines which objects may be created as candidates;
- defines what requires validation before promotion;
- protects `bgs_core` from premature research/process writes;
- creates traceability from season evidence to knowledge changes.

It does not solve these tasks:

- it does not store raw outcomes;
- it does not perform Signal Capture;
- it does not replace Season Review;
- it does not approve automatic `bgs_core` writes;
- it does not create final offers;
- it does not create migrations or schemas.

## Position In Season Intelligence Loop

Knowledge Update follows Season Review:

```text
Reality
↓
Production OS
↓
Production Outcome
↓
Signal Capture
↓
Season Review
↓
Knowledge Update
↓
Knowledge OS
↓
Next Season
```

Season Review recommends changes.

Knowledge Update applies or records approved changes.

Next Season uses updated knowledge as input.

## Boundary: bgs_orch To bgs_core

According to DEC-016:

```text
bgs_core = human reality data
bgs_orch = knowledge + research process + production telemetry
```

Knowledge Update must respect this boundary.

### bgs_orch Updates

Updates may remain in `bgs_orch` when they describe:

- research process memory;
- season learning;
- prompt improvements;
- agent evaluation;
- content/process learning;
- knowledge registry metadata;
- future research questions;
- candidate phenomena;
- candidate patterns;
- candidate offer signals.

### bgs_core Promotion

Promotion to `bgs_core` may be considered only when the update becomes validated reality about people or observed reality.

Examples:

- validated observation;
- validated signal candidate;
- validated phenomenon;
- verified interview-derived reality object;
- GPS fact;
- person-linked observation.

Promotion is not automatic.

Promotion requires explicit validation and separate approved rules.

## Updateable Objects

Knowledge Update may recommend changes to the following object categories.

### Phenomena

Possible actions:

- create phenomenon candidate;
- strengthen existing phenomenon candidate;
- reject weak phenomenon candidate;
- recommend validation work.

Boundary:

Validated phenomena belong to `bgs_core` only after separate validation.

### Patterns

Possible actions:

- create candidate pattern;
- merge similar candidate patterns;
- rename candidate pattern;
- mark pattern as weak or unresolved.

Boundary:

Patterns remain process knowledge until validated against reality.

### Offer Signals

Possible actions:

- create candidate offer signal;
- summarize repeated demand language;
- link objections to possible offer discovery;
- recommend future offer research.

Boundary:

Offer signals are not offers.

No product offer is approved by Knowledge Update alone.

### Prompt Library

Possible actions:

- recommend prompt refinement;
- mark prompt behavior issue;
- add examples to future agent prompts;
- update evaluation criteria.

Boundary:

Prompt updates belong to `bgs_orch` / agent process memory.

They do not belong to `bgs_core`.

### Research Questions

Possible actions:

- create new research question;
- refine existing research question;
- propose next-season investigation;
- mark a question as answered, unresolved, or invalid.

Boundary:

Research questions are process memory, not human reality data.

### Knowledge Assets

Possible actions:

- create a new knowledge asset recommendation;
- update metadata;
- link season evidence to an existing knowledge asset;
- recommend archival or supersession.

Boundary:

Live `bgs_orch.knowledge_assets` updates require separate reviewed draft upsert files and manual approval.

Do not use `003_seed_knowledge_assets.sql` for live registry updates.

### Season Registry

Possible actions:

- propose a new season;
- update season status after review;
- link review output to a season record;
- mark follow-up seasons.

Boundary:

Future physical updates require the approved registry path or migration rules.

## Creatable Candidate Objects

Knowledge Update may create or recommend creating these candidate objects:

- candidate phenomenon;
- candidate pattern;
- candidate offer signal;
- new season proposal;
- new research question;
- prompt improvement candidate;
- agent evaluation note;
- knowledge asset update recommendation;
- future interview target group;
- validation task.

Candidate objects are not validated reality.

They remain candidates until accepted through the relevant review or validation process.

## Validation Requirements

Validation is required before:

- writing human reality into `bgs_core`;
- treating a phenomenon as validated;
- treating a pattern as canonical;
- promoting offer-signal material into offer strategy;
- linking a signal to a person, child, family, or GPS record;
- changing source-of-truth registries;
- changing production agent behavior in a way that affects live workflows.

Validation should consider:

- evidence volume;
- evidence diversity;
- cross-outcome repetition;
- interview confirmation;
- contradiction checks;
- source traceability;
- season-review acceptance;
- owner approval.

## Automatic Updates

Some updates may be automated only when they are process-level and low risk.

Allowed automatic or semi-automatic candidates:

- draft knowledge update record;
- draft next-season question;
- draft prompt improvement note;
- draft agent evaluation note;
- draft knowledge asset registration file;
- draft registry update proposal;
- draft validation task.

These outputs are drafts.

They require review before becoming canonical.

## Never Automatic

The following must never happen automatically:

- write validated reality into `bgs_core`;
- create or update person-linked observations;
- validate a phenomenon;
- approve an offer;
- change live workflow behavior;
- apply PostgreSQL migration;
- update live `bgs_orch.knowledge_assets`;
- overwrite decision logs;
- delete or archive source-of-truth knowledge assets.

## Core Attributes

These are logical attributes only.

They are not SQL columns.

### update_code

Stable human-readable identifier for the update.

Example:

`KUPD-2026-SUMMER-01-001`

### season_code

The season that produced the update recommendation.

Example:

`SEASON-2026-SUMMER-01`

### review_code

The Season Review that recommended the update.

Example:

`REVIEW-2026-SUMMER-01`

### update_type

The type of knowledge update.

Candidate values:

- phenomenon_candidate;
- pattern_candidate;
- offer_signal_candidate;
- research_question_update;
- prompt_update;
- knowledge_asset_update;
- season_proposal;
- validation_task;
- bgs_core_promotion_candidate.

### target_layer

Where the update belongs.

Candidate values:

- bgs_orch;
- bgs_core_candidate;
- Knowledge OS documentation;
- prompt library;
- agent process memory;
- season registry.

### source_evidence

Summary of evidence from Season Review.

### proposed_change

The concrete change being proposed.

### validation_required

Whether the update requires validation before application.

### approval_status

Candidate values:

- draft;
- needs_review;
- approved;
- rejected;
- applied;
- superseded.

### owner

Who owns approval or application of the update.

### applied_reference

Reference to the artifact, document, registry update, or migration that applied the change.

## Example

### season_code

`SEASON-2026-SUMMER-01`

### review_code

`REVIEW-2026-SUMMER-01`

### update_code

`KUPD-2026-SUMMER-01-001`

### update_type

`phenomenon_candidate`

### proposed_change

Create a candidate phenomenon:

`Dependency on External Operator`

### source_evidence

Season Review consolidated repeated phrases and strong cases around children who function under external structure but lose initiative during summer.

Evidence included:

- repeated phrase `Без меня ничего не делает`;
- repeated phrase `Сам не начинает`;
- strong cases involving coach/school/parent structure;
- parent demand for early detection.

### target_layer

`bgs_orch`

### validation_required

`true`

### approval_status

`draft`

### note

This update creates a candidate only.

It does not create a validated phenomenon in `bgs_core`.

## Relationships

These are logical relationships only.

They are not table definitions.

They are not foreign keys.

### season.reviews

Knowledge Update consumes Season Review recommendations.

### signal.capture

Signal Captures provide candidate-level evidence that Season Review consolidates before update recommendation.

### bgs_orch

Most Knowledge Update drafts and process-memory changes belong to `bgs_orch`.

### bgs_core

Only validated reality may move to `bgs_core`.

Knowledge Update may recommend promotion, but cannot perform it without separate validation and approval.

### knowledge_assets

Knowledge asset registry updates must use reviewed draft upsert files for live `bgs_orch.knowledge_assets`.

### agent.runs

Agent runs may draft or evaluate Knowledge Updates.

The update records the proposed change; the agent run records the process that produced or reviewed it.

## Non-Goals

Knowledge Update is not:

- Production Outcome;
- Signal Capture;
- Season Review;
- automatic validation;
- automatic `bgs_core` write;
- offer approval;
- live registry migration;
- PostgreSQL migration;
- table.

## Related Concepts

### Season Review

Existing document:

`braincoach-docs/07_automation/production_os/05_intelligence/season_review.md`

Relationship:

Season Review recommends Knowledge Updates.

Knowledge Update governs what can be changed.

### DEC-016

Existing decision:

`braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-016-bgs-database-boundary-core-vs-orch.md`

Relationship:

DEC-016 defines the `bgs_core` / `bgs_orch` boundary that Knowledge Update must enforce.

### DEC-017

Existing decision:

`braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-017-bgs-orch-schema-segregation.md`

Relationship:

DEC-017 controls future schema placement for new BrainCoach-owned objects in `bgs_orch`.

### Migration Governance Rule v1

Existing document:

`braincoach-docs/07_automation/04_postgres/migration_governance_rule_v1.md`

Relationship:

Knowledge Update must respect PostgreSQL migration governance and live registry update rules.

### Offer Discovery

Existing decision:

`braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-007-offer-discovery-layer.md`

Relationship:

Knowledge Update may create offer-signal candidates, but does not approve offers.

## Future Work

After this specification is reviewed and accepted, future work may discuss:

- Knowledge Update template v1;
- candidate promotion rule v1;
- validated reality promotion checklist;
- future object placement under `knowledge.*` or `research.*`;
- first post-season Knowledge Update example for `SEASON-2026-SUMMER-01`;
- agent workflow for drafting Knowledge Updates;
- draft migration only after explicit approval.

Important:

Physical placement of a future Knowledge Update object requires a later decision.

Knowledge Update may belong under `knowledge.*` or `research.*`, but this document does not approve either placement.

This document does not create a table or schema.

It does not approve DDL.

Any future SQL must remain draft-only until explicit approval.
