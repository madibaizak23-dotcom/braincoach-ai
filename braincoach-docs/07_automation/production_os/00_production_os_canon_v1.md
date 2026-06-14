# Production OS Canon v1

Status: Draft
Date: 2026-06-14
Layer: Architecture / Production OS / Canon

## Purpose

Provide the canonical reading map for BrainCoach Production OS.

This document does not create new domain objects.

It organizes the object specifications that already exist.

## Canonical Flow

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

## Object Map

| step | object | question answered | specification |
| --- | --- | --- | --- |
| 01 | Research Season | What are we trying to understand? | `braincoach-docs/07_automation/production_os/01_research/research_season.md` |
| 02 | Research Brief | How will we investigate it? | `braincoach-docs/07_automation/production_os/01_research/research_brief.md` |
| 03 | Marketing Brief | How will we expose the research to the market and capture signals? | `braincoach-docs/07_automation/production_os/02_marketing/marketing_brief.md` |
| 04 | Content Plan | Which research artifacts will create signal surfaces? | `braincoach-docs/07_automation/production_os/03_content/content_plan.md` |
| 05 | Production Execution | What actually happened in production? | `braincoach-docs/07_automation/production_os/04_execution/production_execution.md` |
| 06 | Production Outcome | What did the environment return? | `braincoach-docs/07_automation/production_os/04_execution/production_outcome.md` |
| 07 | Signal Capture | What knowledge candidates can be extracted? | `braincoach-docs/07_automation/production_os/05_intelligence/signal_capture.md` |
| 08 | Season Review | What did the season teach BrainCoach? | `braincoach-docs/07_automation/production_os/05_intelligence/season_review.md` |
| 09 | Knowledge Update | What should BrainCoach change in its knowledge? | `braincoach-docs/07_automation/production_os/05_intelligence/knowledge_update.md` |

## Boundary

Production OS belongs to `bgs_orch` process memory until a candidate is validated and explicitly promoted.

`bgs_core` remains the source of truth for human reality data.

## Database Status

This canon is documentation only.

It does not approve:

- SQL;
- DDL;
- migrations;
- schema creation;
- table creation;
- automatic writes to `bgs_core`.

## Related Architecture

- `braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-016-bgs-database-boundary-core-vs-orch.md`
- `braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-017-bgs-orch-schema-segregation.md`
- `braincoach-docs/07_automation/research_schema_v1_bgs_orch.md`
- `braincoach-docs/07_automation/production_os/06_governance/production_os_structure_normalization_v1.md`

## Audit Closure Layer

The following documents close the gap between `Signal Candidate` and `Knowledge Asset` before technical implementation:

- `braincoach-docs/07_automation/production_os/06_governance/production_os_audit_closure_v1.md`
- `braincoach-docs/07_automation/production_os/06_governance/candidate_promotion_governance_v1.md`
- `braincoach-docs/07_automation/production_os/05_intelligence/signal_aggregation_layer_v1.md`
- `braincoach-docs/07_automation/production_os/05_intelligence/weekly_intelligence_report_v1.md`

## Packaging Status

The object specifications are now normalized under:

`braincoach-docs/07_automation/production_os/`

The structure normalization record is:

`braincoach-docs/07_automation/production_os/06_governance/production_os_structure_normalization_v1.md`
