# Content Plan Specification v1

Status: Draft
Date: 2026-06-14
Depends on:

- DEC-016 BGS Database Boundary: Core vs Orch
- DEC-017 BGS Orch Schema Segregation
- Research Schema v1 for bgs_orch
- Research Season Specification v1
- Research Brief Specification v1
- Marketing Brief Specification v1

Layer: Architecture / Production OS / Research Artifacts

## Purpose Of This Document

Define the canonical concept of a Content Plan for BrainCoach.

This document specifies the object.

It does not define SQL.

It does not approve migration.

It does not create a table or schema.

## Definition

A Content Plan is the object that turns a Marketing Brief into a planned sequence of research artifacts.

It defines which concrete publications, messages, stories, polls, prompts, and other content units will create surfaces for signal capture.

It is not simply a list of posts.

## Purpose

A Content Plan exists to make market interaction executable without losing the research purpose.

It solves these tasks:

- converts communication angles into concrete artifact sequence;
- defines formats and channels for market interaction;
- places signal-capture points inside the sequence;
- creates entry points for interviews;
- gives writers, editors, and agents a bounded production plan;
- prepares the input for Production Execution.

It does not solve these tasks:

- it does not define the research question;
- it does not replace the Marketing Brief;
- it does not record what was actually published;
- it does not store production outcomes;
- it does not validate signals or phenomena;
- it does not become a CRM or offer object.

## Position In Production OS

The Content Plan is the fourth object in the Season Intelligence Loop:

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
```

The Marketing Brief defines audience, market angle, communication hypotheses, signal capture strategy, and interview conversion strategy.

The Content Plan defines the concrete artifact sequence that tests those choices in the market.

Execution later records what was actually published, sent, or run.

## Core Attributes

These are logical attributes only.

They are not SQL columns.

### content_plan_code

Stable human-readable identifier for the content plan.

Example:

`CPLAN-2026-SUMMER-01-W01`

Purpose:

Allows humans, agents, and execution records to refer to the same content plan.

### season_code

The Research Season this content plan belongs to.

Example:

`SEASON-2026-SUMMER-01`

Purpose:

Keeps the plan connected to the root season question.

### marketing_brief_code

The Marketing Brief this content plan translates.

Example:

`MBRIEF-2026-SUMMER-01-M01`

Purpose:

Preserves traceability from market strategy to concrete artifacts.

### content_sequence

The planned order of content units.

Purpose:

Defines the narrative and research progression across the plan.

### content_units

The individual artifacts planned for creation.

Examples:

- post;
- story;
- Telegram message;
- poll;
- carousel;
- short video;
- interview invitation;
- case prompt.

Purpose:

Defines the units that can later become production executions.

### formats

The expression formats used by the content units.

Examples:

- definition;
- contrast;
- question;
- case prompt;
- checklist;
- reflection prompt;
- story sequence;
- poll.

Purpose:

Makes the plan concrete enough for production without writing the final asset copy.

### channels

The channels where the content units are intended to appear.

Examples:

- Instagram;
- Telegram;
- direct message;
- email;
- parent community;
- coach channel.

Purpose:

Connects the plan to realistic audience surfaces.

### cta_strategy

The call-to-action strategy across the sequence.

Purpose:

Defines how the plan asks for comments, replies, examples, DMs, poll responses, or interview participation.

### signal_capture_points

The planned moments where BrainCoach expects useful signals to appear.

Examples:

- comment prompt after a definition post;
- poll after a contrast story;
- DM invitation after a strong case prompt;
- interview invitation after repeated language appears.

Purpose:

Prevents content from being judged only by reach or aesthetic quality.

### interview_entry_points

The planned points where public response can move into an interview.

Purpose:

Turns strong cases into deeper research input.

### success_criteria

The conditions that make the content plan useful.

Examples:

- repeated phrases appear;
- concrete cases are captured;
- one or more interview candidates emerge;
- at least one communication angle produces resonance or resistance;
- the Season Review gains stronger evidence.

Purpose:

Keeps the plan aligned with research learning rather than generic content output.

## Relationships

These are logical relationships only.

They are not table definitions.

They are not foreign keys.

### marketing.briefs

A Content Plan is derived from a Marketing Brief.

The Marketing Brief provides audience, market hypothesis, communication angles, signal capture strategy, and interview conversion strategy.

Note:

`marketing.briefs` is a logical reference, not an approved physical schema or table.

### production.executions

A Content Plan may produce multiple Production Executions.

Execution records what was actually published, sent, or run.

### production.outcomes

Production Outcomes may record the response generated by content units.

Examples:

- comments;
- DMs;
- poll answers;
- saves;
- repeated phrases;
- strong cases;
- interview candidates.

### research.reviews

Research Reviews evaluate whether the content plan helped the season learn.

The review should consider both production outcomes and signal quality.

### agent.runs

Agent runs may create, refine, critique, or evaluate Content Plans.

The Content Plan records the planned artifact sequence; the agent run records the process that produced or changed it.

## Example

### season_code

`SEASON-2026-SUMMER-01`

### season_name

Лето как тест самостоятельности

### content_plan_code

`CPLAN-2026-SUMMER-01-W01`

### marketing_brief_code

`MBRIEF-2026-SUMMER-01-M01`

### content_sequence

Example content week:

| day | artifact focus | purpose |
| --- | --- | --- |
| Monday | Definition of independence | Establish the season language and separate independence from free time. |
| Tuesday | First dependency signal | Ask parents what breaks first when reminders disappear. |
| Wednesday | What breaks in summer | Surface concrete cases of structure loss. |
| Thursday | Day without reminders | Create a low-friction case prompt and poll. |
| Friday | Parent as operating system | Test the external-operator hypothesis in audience language. |
| Saturday | What has already been tried | Capture failed solutions, objections, and offer signals. |
| Sunday | Interview entry | Move strong cases into DM or interview invitation. |

### cta_strategy

- Ask for concrete examples before asking for opinions.
- Use polls to separate weak agreement from lived cases.
- Invite detailed replies into DM.
- Use Sunday as the explicit interview entry point.

### signal_capture_points

- Tuesday comments about first breakdown points.
- Thursday poll and replies about reminders.
- Friday resistance or resonance around "parent as operating system".
- Saturday comments about attempted solutions.
- Sunday interview opt-ins.

### success_criteria

- at least one repeated phrase cluster appears;
- at least one strong case is captured;
- at least one interview candidate emerges;
- one communication angle becomes sharper;
- the next Season Review has stronger evidence about summer independence.

## Non-Goals

A Content Plan is not:

- a Research Brief;
- a Marketing Brief;
- published content;
- production metrics;
- a CRM object;
- an offer;
- a migration;
- a table.

## Related Concepts

### Research Season

Existing document:

`braincoach-docs/07_automation/production_os/01_research/research_season.md`

Relationship:

The Research Season provides the root question and season boundary.

### Research Brief

Existing document:

`braincoach-docs/07_automation/production_os/01_research/research_brief.md`

Relationship:

The Research Brief defines how the season question will be investigated.

### Marketing Brief

Existing document:

`braincoach-docs/07_automation/production_os/02_marketing/marketing_brief.md`

Relationship:

The Marketing Brief is the direct input to the Content Plan.

Marketing Brief defines market interaction strategy.

Content Plan defines the artifact sequence that will execute that strategy.

### Production Execution

Existing document:

`braincoach-docs/07_automation/production_os/04_execution/production_execution.md`

Relationship:

Production Execution records what was actually published, sent, or run from the plan.

### Signal Capture

Existing concept:

Signal Capture is the process of collecting useful market and reality signals from audience response.

Relationship:

Content Plan defines where signals are expected to appear.

Production Outcomes and Research Reviews later evaluate whether they did.

### Season Review

Existing concept:

Season Review is the closing intelligence artifact for a Research Season.

Relationship:

Season Review evaluates whether the Content Plan produced useful evidence, repeated language, cases, interview candidates, and offer signals.

### Offer Discovery

Existing decision:

`braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-007-offer-discovery-layer.md`

Relationship:

A Content Plan may create artifacts that expose offer signals, objections, failed solutions, and demand language.

It is not itself an offer.

## Future Work

After this specification is reviewed and accepted, future work may discuss:

- Signal Capture Specification v1;
- Season Review Specification v1;
- future object `production.content_plans` or `research.content_plans`;
- agent workflow for generating Content Plans;
- draft migration only after explicit approval.

Important:

DEC-017 currently approved `knowledge.*`, `research.*`, `production.*`, and `agent.*` as proposed schemas.

DEC-017 has not approved a `content.*` schema.

Physical placement of a future Content Plan object requires a later decision.

Content Plan may belong under `production.*` or `research.*`, but this document does not approve either placement.

These are not approved by this document.

Any future SQL must remain draft-only until explicit approval.
