# Marketing Brief Specification v1

Status: Draft
Date: 2026-06-14
Depends on:

- DEC-016 BGS Database Boundary: Core vs Orch
- DEC-017 BGS Orch Schema Segregation
- Research Schema v1 for bgs_orch
- Research Season Specification v1
- Research Brief Specification v1

Layer: Architecture / Production OS / Market Interaction

## Purpose Of This Document

Define the canonical concept of a Marketing Brief for BrainCoach.

This document specifies the object.

It does not define SQL.

It does not approve migration.

It does not create `marketing.briefs`.

## Definition

A Marketing Brief is the object that translates a Research Brief into a market interaction and signal-capture program.

It turns a research program into a communication strategy for learning from the market.

It is not a content plan.

## Purpose

A Marketing Brief exists to make research observable in the market without reducing the research to content production.

It defines:

- target audience;
- market angle;
- signal categories;
- communication hypotheses;
- mechanisms for collecting cases;
- mechanisms for moving from public response to interviews.

It solves these tasks:

- converts research focus into market-facing language and angles;
- identifies who should be exposed to the season question;
- defines what kind of response would count as a signal;
- creates a bridge between research intent and content planning;
- guides execution toward learning, not only reach or engagement;
- prepares the input for Content Plan.

It does not solve these tasks:

- it does not define individual posts;
- it does not schedule content;
- it does not store production metrics;
- it does not validate phenomena;
- it does not replace Offer Discovery.

## Position In Production OS

The Marketing Brief is the third object in the early Production OS chain:

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
```

The Research Season defines what BrainCoach wants to understand.

The Research Brief defines how the question will be investigated.

The Marketing Brief defines how the investigation will interact with a real audience and capture useful signals.

The Content Plan later turns the Marketing Brief into specific assets, formats, and publishing steps.

## Core Attributes

These are logical attributes only.

They are not SQL columns.

### marketing_brief_code

Stable human-readable identifier for the marketing brief.

Example:

`MBRIEF-2026-SUMMER-01-M01`

Purpose:

Allows humans, agents, and documents to reference the same marketing brief.

### season_code

The Research Season this marketing brief belongs to.

Example:

`SEASON-2026-SUMMER-01`

Purpose:

Keeps market interaction connected to the root season question.

### research_brief_code

The Research Brief this marketing brief translates.

Example:

`BRIEF-2026-SUMMER-01-R01`

Purpose:

Preserves the chain from research program to market-facing strategy.

### target_audience

The audience segment the brief intends to reach.

Examples:

- parents of athletes;
- parents of children with summer structure loss;
- families where external control masks lack of self-management;
- coaches observing motivation collapse outside structured training.

Purpose:

Defines who should produce the most useful response signals.

### market_hypothesis

The hypothesis about how the audience understands, feels, or reacts to the research problem.

Purpose:

Makes the market-facing work testable.

### communication_angles

The angles that may expose the research problem in audience language.

Examples:

- "summer reveals who owns the system";
- "school structure was doing the work";
- "without the external operator, the child freezes";
- "independence is not free time; it is internal structure."

Purpose:

Provides multiple ways to surface the same research question.

### signal_capture_strategy

The strategy for capturing useful audience signals.

Examples:

- prompt comments around repeated phrases;
- invite parents to describe summer breakdown points;
- ask for concrete cases rather than opinions;
- watch for resonance, resistance, and contradictions.

Purpose:

Ensures market interaction produces research material, not only engagement.

### interview_conversion_strategy

The strategy for moving from weak public signals to deeper interviews.

Examples:

- DM parents who describe strong cases;
- invite comments that reveal repeated patterns;
- use a soft interview invitation after a concrete case appears;
- separate curiosity responses from high-signal cases.

Purpose:

Turns public response into deeper research input.

### success_criteria

The conditions that make the marketing brief useful.

Examples:

- repeated audience phrases appear;
- strong cases are captured;
- DMs or interview candidates emerge;
- a communication angle produces resonance or dissonance;
- offer signals become clearer;
- the Research Brief can be sharpened after market response.

Purpose:

Prevents the marketing brief from being judged only by reach or likes.

## Relationships

These are logical relationships only.

They are not table definitions.

They are not foreign keys.

### research.briefs

A Marketing Brief is derived from one Research Brief.

The Research Brief gives it research question, hypothesis, phenomenon focus, signal categories, and investigation scope.

### content.plans

A Marketing Brief may produce one or more Content Plans.

The Content Plan turns market strategy into concrete assets, formats, sequence, and publishing plan.

### production.executions

A Marketing Brief may guide multiple production executions.

Executions test communication angles and generate signal capture opportunities.

### research.reviews

Research Reviews may evaluate whether a Marketing Brief produced useful signals, cases, interview candidates, offer signals, or stronger language.

Marketing Brief outcomes should feed season learning.

## Example

### season_code

`SEASON-2026-SUMMER-01`

### season_name

Лето как тест самостоятельности

### research_brief_code

`BRIEF-2026-SUMMER-01-R01`

### marketing_brief_code

`MBRIEF-2026-SUMMER-01-M01`

### target_audience

Parents whose children lose structure during summer when school, coach, tutor, or parent reminders disappear.

### market_hypothesis

Parents feel the summer problem as laziness or motivation loss, but the deeper issue is absence of an internal operating system.

### communication_angles

- Summer does not create the problem; it reveals it.
- The external operator was holding the system together.
- A child can look disciplined while the structure is external.
- Independence begins when the child can restart without being pushed.

### signal_capture_strategy

- Ask parents what collapsed first after school ended.
- Invite concrete examples, not general opinions.
- Watch for repeated phrases about reminders, freezing, avoidance, and responsibility transfer.
- Separate high-signal cases from agreement-only comments.

### interview_conversion_strategy

- Move parents with detailed examples into DM.
- Invite strong cases into a short interview.
- Use the phrase "what changed when the external structure disappeared?" as the transition question.

### success_criteria

- at least one repeated phrase cluster appears;
- at least one strong case is captured;
- at least one interview candidate emerges;
- the external-operator hypothesis becomes clearer;
- the next Research Brief or Season Review has stronger language.

## Non-Goals

A Marketing Brief is not:

- a content plan;
- an advertising campaign;
- a CRM object;
- an offer;
- a product launch;
- a database table;
- a migration;
- a replacement for Research Brief;
- a replacement for Offer Discovery.

## Related Concepts

### Research Season

Existing document:

`braincoach-docs/07_automation/production_os/01_research/research_season.md`

Relationship:

The Research Season provides the root question and season boundary.

The Marketing Brief must remain traceable to a season.

### Research Brief

Existing document:

`braincoach-docs/07_automation/production_os/01_research/research_brief.md`

Relationship:

The Research Brief is the direct input to the Marketing Brief.

The Marketing Brief should not invent a new research question; it should translate the research program into market interaction.

### Offer Discovery

Existing decision:

`braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-007-offer-discovery-layer.md`

Relationship:

Offer Discovery is a knowledge activity before it is a business activity.

A Marketing Brief may support Offer Discovery by designing ways to capture offer signals, objections, cases, and demand language.

It is not itself an offer.

### Season Review

Existing concept:

Season Review is the closing intelligence artifact for a Research Season.

Relationship:

Season Review evaluates whether Marketing Briefs produced useful signals, cases, language, and interview opportunities.

### Seasonal Phenomena

Existing concept:

Phenomena may evolve across seasons.

Relationship:

A Marketing Brief may test whether a candidate seasonal phenomenon resonates in audience language, but it does not validate the phenomenon by itself.

### Content Plan

Existing document:

`braincoach-docs/07_automation/production_os/03_content/content_plan.md`

Relationship:

Content Plan consumes Marketing Brief and turns it into specific content assets and execution sequence.

Marketing Brief defines why and how to interact with the market.

Content Plan defines what to publish.

## Future Work

After this specification is reviewed and accepted, future work may discuss:

- `marketing.briefs` future object in `bgs_orch`;
- schema placement for `marketing.briefs` under DEC-017;
- Season Review Specification v1;
- agent workflow for generating Marketing Briefs;
- draft migration only after explicit approval.

Important:

DEC-017 currently approved `knowledge.*`, `research.*`, `production.*`, and `agent.*` as proposed schemas.

`marketing.briefs` is a logical future object in this specification. Physical schema placement requires a later approved decision or migration design.

These are not approved by this document.

Any future SQL must remain draft-only until explicit approval.
