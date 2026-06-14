# DEC-016 BGS Database Boundary: Core vs Orch

## Status

Accepted

## Date

2026-06-14

## Owner

Malik

## Layer

Architecture / Database Governance

## Decision

BrainCoach keeps the current two-database architecture:

```text
bgs_core
    ↓
human reality data

bgs_orch
    ↓
knowledge, research process, production telemetry
```

No new database is created at this stage.

## Rationale

`bgs_core` remains the source of truth for data about people and observed reality:

- persons
- conversations
- parent_interviews
- interview_responses
- observations
- tracker_entries
- research_signal_candidates
- future human / GPS / interview data

`bgs_orch` remains the orchestration and knowledge-process database. It may contain schemas for:

- knowledge registry
- research seasons
- season reviews
- research briefs
- marketing briefs
- content plans
- production execution telemetry
- agent runs
- prompt versions
- workflow metadata

## Boundary Rule

`bgs_core` answers:

> What is happening with people?

`bgs_orch` answers:

> How does BrainCoach collect, process, analyze and turn reality into knowledge?

## Implementation Rule

Season Research OS / Production OS objects should be added to `bgs_orch`, preferably under separate schemas:

```sql
knowledge.*
research.*
production.*
agent.*
```

Do not add season production telemetry, agent evaluation or prompt-performance data to `bgs_core`.

## Future Migration Trigger

A separate database such as `bgs_research` may be considered only after the research / production telemetry layer becomes large and operationally independent.

Suggested trigger:

- 5-10 completed research seasons
- repeated season review workflow
- accumulated agent performance history
- clear need for separate access, scaling or governance

Until then, premature database separation is rejected.

## Consequences

- Human data stays clean in `bgs_core`.
- Knowledge and research-process memory stays in `bgs_orch`.
- Production OS can evolve without polluting the human-data source of truth.
- Future migration remains possible without changing the current canonical boundary.

## Related

- DEC-008 BGS Data Architecture
- DEC-011 Source Of Truth Model
- DEC-013 Orchestration Runtime Strategy
- DEC-014 BGS Core MVP v1
- DEC-015 GPS Trajectory Research Placement
