# Production OS Structure Normalization v1

Status: Applied
Date: 2026-06-14
Layer: Architecture / Documentation Governance / Production OS

## Purpose

Normalize the documentation structure for the newly discovered BrainCoach Production OS domain.

This document records the applied directory structure, canonical file names, link migration rules, and scope boundaries.

It does not create new Production OS domain objects.

The file movement was completed as a documentation refactor.

It does not approve SQL, DDL, or database migration.

## Problem Solved

The Production OS object specifications were created during architecture discovery.

Before normalization, files were located directly under `braincoach-docs/07_automation/`:

- `research_season_specification_v1.md`
- `research_brief_specification_v1.md`
- `marketing_brief_specification_v1.md`
- `content_plan_specification_v1.md`
- `production_execution_specification_v1.md`
- `production_outcome_specification_v1.md`
- `signal_capture_specification_v1.md`
- `season_review_specification_v1.md`
- `knowledge_update_specification_v1.md`

This was appropriate during discovery.

It is no longer ideal for navigation because alphabetical sorting hides the system flow.

## Applied Directory Structure

Current structure:

```text
braincoach-docs/
└── 07_automation/
    ├── production_os/
    │   ├── 00_production_os_canon_v1.md
    │   ├── README.md
    │   ├── 01_research/
    │   │   ├── research_season.md
    │   │   └── research_brief.md
    │   ├── 02_marketing/
    │   │   └── marketing_brief.md
    │   ├── 03_content/
    │   │   └── content_plan.md
    │   ├── 04_execution/
    │   │   ├── production_execution.md
    │   │   └── production_outcome.md
    │   ├── 05_intelligence/
    │   │   ├── signal_capture.md
    │   │   ├── season_review.md
    │   │   └── knowledge_update.md
    │   └── 06_governance/
    │       └── production_os_structure_normalization_v1.md
    ├── 03_n8n/
    ├── 04_postgres/
    ├── 07_domain_interfaces.md
    └── 08_agent_architecture.md
```

## Canonical File Names

| previous file | canonical file |
| --- | --- |
| `research_season_specification_v1.md` | `production_os/01_research/research_season.md` |
| `research_brief_specification_v1.md` | `production_os/01_research/research_brief.md` |
| `marketing_brief_specification_v1.md` | `production_os/02_marketing/marketing_brief.md` |
| `content_plan_specification_v1.md` | `production_os/03_content/content_plan.md` |
| `production_execution_specification_v1.md` | `production_os/04_execution/production_execution.md` |
| `production_outcome_specification_v1.md` | `production_os/04_execution/production_outcome.md` |
| `signal_capture_specification_v1.md` | `production_os/05_intelligence/signal_capture.md` |
| `season_review_specification_v1.md` | `production_os/05_intelligence/season_review.md` |
| `knowledge_update_specification_v1.md` | `production_os/05_intelligence/knowledge_update.md` |

## Production OS Canon

The canonical reading entry point is:

`braincoach-docs/07_automation/production_os/00_production_os_canon_v1.md`

It maps:

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

## Link Migration Plan

File movement was handled as a documentation refactor.

Completed steps:

1. Moved the nine object specification files into `production_os/` domain folders with canonical names.
2. Update all links in:
   - `research_schema_v1_bgs_orch.md`;
   - object specs;
   - `system_evolution_log.md`;
   - `repository_journal.md`;
   - live-registry draft upsert files;
   - any future canon files.
3. Ran repository-wide search for old file paths.
4. Did not create redirect stubs because no workflow dependency was identified during this refactor.
5. Updated the reviewed draft live-registry upsert file only.
6. Did not update `003_seed_knowledge_assets.sql`.

## Production OS Canon Members

The following documents become part of Production OS Canon:

- Research Season Specification v1;
- Research Brief Specification v1;
- Marketing Brief Specification v1;
- Content Plan Specification v1;
- Production Execution Specification v1;
- Production Outcome Specification v1;
- Signal Capture Specification v1;
- Season Review Specification v1;
- Knowledge Update Specification v1.

## Infrastructure Documents

The following remain infrastructure or architecture support documents, not Production OS object specs:

- `research_schema_v1_bgs_orch.md`;
- `06_storage_architecture.md`;
- `04_postgres/*`;
- `03_n8n/*`;
- `08_agent_architecture.md`;
- `07_domain_interfaces.md`;
- `automation_architecture.md`;
- DEC-016;
- DEC-017;
- Migration Governance Rule v1.

## Boundary Rules

Production OS documentation normalization must not:

- create new database objects;
- create or move PostgreSQL schemas;
- apply SQL;
- update live `bgs_orch.knowledge_assets`;
- use `003_seed_knowledge_assets.sql` for registration;
- change the accepted DEC-016 or DEC-017 boundaries.

## Open Decisions

The following remain unresolved and require later decisions:

- whether Content Plan belongs physically under `production.*` or `research.*`;
- whether Signal Capture belongs physically under `research.*` or `knowledge.*`;
- whether Knowledge Update belongs physically under `knowledge.*` or `research.*`;
- whether a dedicated `marketing.*` schema is ever needed;
- whether old object spec paths should become redirect stubs after movement.

## Recommended Next Step

Recommended next step:

```text
Production OS v1 Review
↓
Review canonical object flow
↓
Review unresolved physical placement decisions
↓
Only then consider draft implementation planning
```
