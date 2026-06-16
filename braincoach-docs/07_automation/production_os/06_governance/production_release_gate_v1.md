# Production Release Gate v1

Status: Accepted Standard
Date: 2026-06-16
Layer: Architecture / Production OS / Governance

## Purpose

Define the mandatory release gate for any new BrainCoach artifact that may collect, process, store, or publish data related to a person.

This document operationalizes DEC-018 inside Production OS.

It is not a legal policy.

It is a production Definition of Done rule.

## Core Rule

No new feature, workflow, bot, site, form, agent, dashboard, course, report, or recommendation system that works with a person may be released without data and consent review.

In BrainCoach OS terms:

```text
Feature Ready
↓
Compliance Gate
↓
Production Review
↓
Release
```

## Scope

This gate applies to:

- Parent Interviewer;
- GPS Tracker;
- Team Tracker;
- Voice Diaries;
- Growth Intelligence;
- Trajectory Reports;
- future courses;
- recommendations;
- any future product that collects user answers, observations, voice, photos, contact details, identifiers, or behavioral data.

## Definition Of Done

An artifact is not `Release Ready` until the following are checked:

- collected data is listed;
- unnecessary data collection is removed;
- Privacy Policy exists or the artifact is explicitly blocked;
- Privacy Policy link is shown before data collection;
- consent text exists;
- user action confirms consent;
- consent fact is stored;
- storage location is documented;
- `bgs_core` vs `bgs_orch` boundary is respected;
- third-party services are listed;
- external AI transfer is reviewed;
- anonymization or pseudonymization is applied by default before external AI;
- direct identifiers are not sent to external AI without explicit justification;
- deletion or anonymization procedure exists;
- public materials exclude names, usernames, voice, photos, child data, and raw conversations.

## Release States

Recommended release states:

```text
draft
↓
feature_ready
↓
compliance_gate_passed
↓
production_review_passed
↓
released
```

Blocking state:

```text
feature_ready
↓
compliance_blocked
```

## Compliance Gate Outcomes

### Passed

The artifact may proceed to Production Review.

Minimum conditions:

- Privacy Policy is referenced;
- consent is captured before the first question or data collection step;
- consent is stored;
- data storage is documented;
- external AI transfer is anonymized by default;
- deletion or anonymization procedure is documented.

### Blocked

The artifact must not proceed to Production Review or Release.

Blocking conditions:

- user data is collected without consent;
- Privacy Policy is missing;
- consent is not stored;
- storage location is unclear;
- external AI receives raw personal data without review;
- deletion or anonymization procedure is missing;
- public materials include personal or child data.

### Draft

The artifact may be discussed and designed, but not launched.

## Production Review Checklist

Before release, Production Review must confirm:

- Compliance Gate status is `Passed`;
- release scope matches the reviewed data scope;
- no new data types were added after the gate;
- no new external AI service was added after the gate;
- no new third-party storage was added after the gate;
- owner is named for deletion or anonymization requests;
- public launch materials are anonymized or aggregated.

If scope changed, the artifact returns to Compliance Gate.

## Relationship To Data Architecture

This gate completes the operational data governance loop:

```text
DEC-016 -> where human data belongs
DEC-017 -> how orchestration and knowledge process schemas are organized
DEC-018 -> how human data may be collected safely
Production Release Gate -> when release is allowed
```

## Non-Goals

This document does not:

- replace Privacy Policy;
- provide legal advice;
- define SQL;
- approve database migrations;
- create storage schemas;
- approve automatic writes to `bgs_core`;
- replace human review.

## Related

- `braincoach-docs/05_operations/16_conventions/compliance_gate_v1.md`
- `braincoach-docs/03_knowledge/04_decisions/decision-log/decision_log.md`
- `braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-016-bgs-database-boundary-core-vs-orch.md`
- `braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-017-bgs-orch-schema-segregation.md`
