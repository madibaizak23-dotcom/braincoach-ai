# Season Review Specification v1

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
- Signal Capture Specification v1

Layer: Architecture / Production OS / Seasonal Knowledge Review

## Purpose Of This Document

Define the canonical concept of Season Review for BrainCoach.

This document specifies the object.

It does not define SQL.

It does not approve migration.

It does not create `research.reviews`.

## Definition

Season Review is the object that reviews a full Research Season and turns its captured candidates into seasonal knowledge.

It does not analyze one Production Outcome.

It analyzes the season as a whole.

It answers:

```text
What did this season teach BrainCoach?
```

## Purpose

Season Review exists to close the Season Intelligence Loop.

It solves these tasks:

- reviews all relevant Signal Captures across a season;
- consolidates repeated candidates into stronger patterns;
- compares candidates across channels, formats, executions, and outcomes;
- identifies lessons learned;
- identifies strong cases and interview learnings;
- identifies candidate phenomena and offer-signal patterns;
- recommends what should be updated in knowledge;
- recommends what should remain unresolved or be tested in a future season.

It does not solve these tasks:

- it does not store raw comments, DMs, polls, or metrics;
- it does not replace Production Outcome;
- it does not analyze only one execution;
- it does not automatically validate phenomena;
- it does not automatically write to `bgs_core`;
- it does not create product offers.

## Position In Production OS

Season Review is the closing review object in the Season Intelligence Loop:

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

Signal Capture creates structured candidates.

Season Review evaluates those candidates across the full season.

Knowledge Update later applies approved changes to registries, decisions, research memory, or validated reality objects.

## Core Attributes

These are logical attributes only.

They are not SQL columns.

### review_code

Stable human-readable identifier for the season review.

Example:

`REVIEW-2026-SUMMER-01`

Purpose:

Allows humans, agents, and knowledge updates to reference the same review.

### season_code

The Research Season being reviewed.

Example:

`SEASON-2026-SUMMER-01`

Purpose:

Keeps review tied to the root season question and scope.

### review_period

The time window covered by the review.

Examples:

- full season;
- first half of season;
- post-season review;
- focused review after a campaign burst.

Purpose:

Makes the scope of the review explicit.

### source_capture_set

The Signal Captures included in the review.

Purpose:

Defines the evidence base for candidate consolidation.

### reviewed_outcome_set

The Production Outcomes considered by the review.

Purpose:

Allows review to compare candidate meaning against raw response volume and context.

### reviewed_execution_set

The Production Executions considered by the review.

Purpose:

Allows review to compare what was planned, what was executed, and what produced useful response.

### top_repeated_phrases

Repeated phrases that remained important after comparison across the season.

Purpose:

Distinguishes season-level language patterns from isolated repeated phrases.

### consolidated_candidates

Candidates grouped and strengthened during review.

Examples:

- external-operator dependency;
- summer structure collapse;
- fear of future independence failure;
- parent reminder overload.

Purpose:

Turns individual captures into season-level candidate knowledge.

### rejected_candidates

Candidates that were reviewed and rejected or deprioritized.

Purpose:

Prevents weak or misleading interpretations from silently persisting.

### strong_cases

Concrete cases that best represent season learning.

Purpose:

Preserves evidence-rich cases for future research, interviews, and knowledge update.

### interview_learnings

Lessons or unresolved questions from interviews or interview candidates.

Purpose:

Connects public signal capture with deeper qualitative learning.

### offer_signal_summary

Summary of offer-signal candidates discovered during the season.

Purpose:

Keeps offer discovery as knowledge work without turning the review into an offer.

### candidate_phenomena

Phenomenon candidates suggested by season evidence.

Purpose:

Identifies patterns that may later become validated phenomena after separate review or promotion.

### lessons_learned

Season-level lessons about people, process, market language, content strategy, agents, or research design.

Purpose:

Turns season activity into reusable knowledge.

### knowledge_update_recommendations

Recommended updates to registries, specs, prompts, briefs, future seasons, or validated reality stores.

Purpose:

Defines what should happen after the review without applying those updates automatically.

### review_status

Status of the review.

Candidate values:

- draft;
- in_review;
- accepted;
- superseded;
- archived.

Purpose:

Tracks whether the review is still being formed or has been accepted as season memory.

### reviewed_by

Who or what performed the review.

Examples:

- Malik;
- analyst agent;
- strategist agent;
- manual review;
- review panel.

Purpose:

Preserves accountability and supports agent evaluation.

## Candidate Consolidation

Season Review receives candidates from Signal Capture.

Incoming candidates may include:

- repeated phrases;
- objection signals;
- fear signals;
- offer signals;
- strong cases;
- interview candidates;
- resonance signals;
- dissonance signals;
- phenomenon candidates.

### Grouping

Candidates are grouped by meaning, not only by exact wording.

Example:

The phrases:

- `Без меня ничего не делает`
- `Сам не начинает`
- `Нужен постоянный контроль`

may be grouped under:

`Dependency on External Operator`

### Comparison

Grouped candidates are compared across:

- outcomes;
- executions;
- channels;
- content formats;
- communication angles;
- audience segments;
- interview evidence;
- time windows.

Purpose:

Determine whether a candidate is isolated, repeated, channel-specific, format-specific, or season-wide.

### Strengthening

A candidate becomes stronger when:

- it appears across multiple outcomes;
- it appears in both public comments and DMs;
- it appears in strong cases;
- it survives interview follow-up;
- it appears across channels or formats;
- it explains more than one response pattern;
- it connects to the season research question.

### Rejection Or Weakening

A candidate may be rejected or weakened when:

- it appears only once;
- it depends on one ambiguous comment;
- it conflicts with stronger evidence;
- it is a content artifact rather than a real audience pattern;
- it reflects wording introduced by BrainCoach more than audience language;
- it cannot be connected to the season question.

### Recommendation For Knowledge Update

After consolidation, Season Review may recommend:

- update an existing knowledge asset;
- create a new phenomenon candidate;
- create or refine a research question;
- update future Research Briefs;
- update Marketing Brief language;
- update agent prompts;
- promote a candidate toward `bgs_core` only after separate validation;
- reject or archive weak candidates.

Season Review recommends Knowledge Update.

It does not apply Knowledge Update automatically.

## Relationships

These are logical relationships only.

They are not table definitions.

They are not foreign keys.

### research.seasons

A Season Review belongs to one Research Season.

The season provides the question, hypothesis, scope, and closure boundary.

### signal.capture

Season Review consumes Signal Captures across the season.

It compares and consolidates them into stronger or weaker seasonal candidates.

### production.outcomes

Production Outcomes provide raw response context for evaluating the strength of captured candidates.

### production.executions

Production Executions explain what production actions created the response surfaces.

### knowledge.update

Knowledge Update is the downstream process that may apply approved changes after review.

Season Review produces recommendations, not automatic updates.

### bgs_core

Season Review does not directly write validated reality into `bgs_core`.

Promotion requires separate validation and approved promotion rules.

### agent.runs

Agent runs may prepare, draft, critique, or evaluate a Season Review.

The review records the seasonal learning; the agent run records the process that produced or changed it.

## Example

### season_code

`SEASON-2026-SUMMER-01`

### season_name

Лето как тест самостоятельности

### research_question

Что происходит с ребёнком, когда исчезает внешний оператор?

### primary_hypothesis

Внешняя система маскирует отсутствие внутренней системы.

### review_code

`REVIEW-2026-SUMMER-01`

### top_repeated_phrases

- `Без меня ничего не делает`;
- `Сам не начинает`;
- `Все лето телефон`;
- `Нужен постоянный контроль`.

### consolidated_candidates

- `Dependency on External Operator`;
- `Summer Structure Collapse`;
- `Reminder Dependency`;
- `Fear of Future Independence Failure`.

### strong_cases

- Child performs well under coach structure but freezes during unstructured summer days.
- Parent reminders create apparent discipline but hide lack of self-starting.
- Child can follow a written plan but cannot restart after interruption.

### offer_signal_summary

Parents asked how to detect the problem earlier and how to distinguish helpful structure from dependency.

This is an offer-signal candidate, not an approved offer.

### knowledge_update_recommendations

- Create a phenomenon candidate around external-operator dependency.
- Update future Research Briefs to investigate restart ability after structure interruption.
- Refine Marketing Brief language around `parent as operating system`.
- Prepare interview follow-up for parents with strong summer structure-collapse cases.

## Non-Goals

Season Review is not:

- Production Outcome;
- Signal Capture;
- raw comment storage;
- analytics dashboard;
- CRM record;
- offer;
- automatic Knowledge Update;
- validated phenomenon by itself;
- direct `bgs_core` write;
- migration;
- table.

## Related Concepts

### Research Season

Existing document:

`braincoach-docs/07_automation/production_os/01_research/research_season.md`

Relationship:

Research Season gives the review its question, time boundary, and closure point.

### Signal Capture

Existing document:

`braincoach-docs/07_automation/production_os/05_intelligence/signal_capture.md`

Relationship:

Signal Capture creates candidates.

Season Review consolidates candidates.

### Production Outcome

Existing document:

`braincoach-docs/07_automation/production_os/04_execution/production_outcome.md`

Relationship:

Production Outcomes provide raw response context for review.

### Offer Discovery

Existing decision:

`braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-007-offer-discovery-layer.md`

Relationship:

Season Review may summarize offer-signal candidates.

It does not create or approve an offer.

### Research Schema v1 for bgs_orch

Existing document:

`braincoach-docs/07_automation/research_schema_v1_bgs_orch.md`

Relationship:

Research Schema v1 proposes `research.reviews` as a future `bgs_orch` object.

This specification defines that object conceptually before any schema migration or DDL is drafted.

### BGS Core Boundary

Existing decision:

`DEC-016 BGS Database Boundary: Core vs Orch`

Relationship:

Season Review belongs to `bgs_orch` process memory.

Validated reality belongs to `bgs_core` only after separate validation and promotion.

### Knowledge Update

Existing document:

`braincoach-docs/07_automation/production_os/05_intelligence/knowledge_update.md`

Relationship:

Season Review recommends Knowledge Updates.

Knowledge Update governs what may be changed, what remains a candidate, and what requires validation before promotion.

## Future Work

After this specification is reviewed and accepted, future work may discuss:

- candidate promotion rules from `bgs_orch` to `bgs_core`;
- first Season Review template;
- future object `research.reviews`;
- review status model;
- agent workflow for season review;
- draft migration only after explicit approval.

Important:

DEC-017 already identifies `research.*` as an approved proposed schema family for research process memory.

Research Schema v1 already proposes `research.reviews` as a future object.

This document does not create `research.reviews`.

It does not approve DDL.

Any future SQL must remain draft-only until explicit approval.
