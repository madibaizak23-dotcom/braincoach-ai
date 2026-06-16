# Production OS

Status: Active Index
Date: 2026-06-14

Start here:

`braincoach-docs/07_automation/production_os/00_production_os_canon_v1.md`

## Sections

- `01_research/` — Research Season and Research Brief
- `02_marketing/` — Marketing Brief
- `03_content/` — Content Plan
- `04_execution/` — Production Execution and Production Outcome
- `05_intelligence/` — Signal Capture, Daily Intelligence Report, Weekly Intelligence Report, Season Review, Knowledge Update
- `06_governance/` — Production OS documentation governance

## Audit Closure

- `05_intelligence/signal_aggregation_layer_v1.md` — groups isolated candidates before pattern detection
- `05_intelligence/daily_intelligence_report_v1.md` — daily operational intelligence artifact for signals, patterns, bottlenecks, and next-day priorities
- `05_intelligence/daily_intelligence_report_generator_v1.md` — design spec for future draft generation from live intelligence sources
- `05_intelligence/weekly_intelligence_report_v1.md` — weekly research intelligence artifact
- `06_governance/candidate_promotion_governance_v1.md` — governs movement from candidates to knowledge or validated reality
- `06_governance/production_release_gate_v1.md` — requires Compliance Gate before Production Review and Release for human-data artifacts
- `06_governance/production_os_audit_closure_v1.md` — closes alignment review gaps before technical implementation

## Boundary

Production OS is documentation and process architecture for `bgs_orch`.

It does not approve SQL, DDL, migrations, or automatic writes to `bgs_core`.

## Release Gate

Human-data artifacts follow:

```text
Feature Ready
↓
Compliance Gate
↓
Production Review
↓
Release
```

If Compliance Gate is blocked, release is blocked.

Daily Intelligence Report Generator v1 remains in `05_intelligence/` while it is an intelligence architecture spec. A separate workflow design under `07_automation/02_workflows/` should only be created after implementation approval.
