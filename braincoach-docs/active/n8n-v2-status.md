# n8n-v2 Status

Last Updated: 2026-05-31

## Purpose

This document tracks the operational status of n8n-v2.

n8n-v2 is the next-generation BrainCoach automation platform. It is intended to support active development and future production promotion after validation.

## Current Decision

BrainCoach maintains two n8n environments:

| Environment | Role | Status |
|-------------|------|--------|
| n8n-prod | Stable legacy production | Active |
| n8n-v2 | Next-generation development platform | TBD |

Production stability belongs to n8n-prod.
New development should happen in n8n-v2 after deployment and validation.

## n8n-prod

| Item | Value |
|------|-------|
| Environment name | n8n-prod |
| Version | 1.93 |
| Role | Stable legacy production |
| Main workflow | Intake Engine v1 Stable |
| Production rule | Critical fixes only |
| Active development | No |

## n8n-v2

| Item | Value |
|------|-------|
| Environment name | n8n-v2 |
| Version | TBD |
| Cloud Run service | TBD |
| URL | TBD |
| Deployment status | TBD |
| Database target | TBD |
| Credentials configured | TBD |
| Stable workflow imported | TBD |
| Smoke test completed | TBD |

## Planned Infrastructure

From `braincoach-docs/n8n-v2-deployment-plan.md`:

| Area | Planned approach | Current status |
|------|------------------|----------------|
| Cloud Run | Separate service for n8n-v2 | TBD |
| PostgreSQL | Single Cloud SQL instance with prod/dev separation | TBD |
| Production data | `braincoach_prod` | TBD |
| Development data | `braincoach_dev` | TBD |
| Workflow lifecycle | Prototype in n8n-v2, validate, document, commit, promote | Not started |

## Required Credentials

| Credential | Required for | Status |
|------------|--------------|--------|
| Telegram Bot API | Telegram trigger and replies | TBD |
| PostgreSQL | Client state, events, memory | TBD |
| Google Sheets OAuth | Semantic control layer | TBD |
| OpenAI | Intake, emotional, qualification models | TBD |

## Phase Status

| Phase | Item | Status |
|-------|------|--------|
| Phase 1 | Deploy n8n-v2 | TBD |
| Phase 1 | Connect Cloud SQL | TBD |
| Phase 1 | Configure credentials | TBD |
| Phase 1 | Configure Git workflow | In progress |
| Phase 2 | Import Intake Engine v1 Stable | TBD |
| Phase 2 | Validate PostgreSQL | TBD |
| Phase 2 | Validate Telegram | TBD |
| Phase 2 | Validate OpenAI | TBD |
| Phase 3 | Memory Engine | Not started |
| Phase 3 | Memory Persistence | In progress in repository code only |
| Phase 3 | Memory Retrieval | Not started |
| Phase 4 | RAG | Future |
| Phase 4 | Content Intelligence | Future |
| Phase 4 | Social Intelligence | Future |
| Phase 5 | Performance validation | Not started |
| Phase 5 | Rollback testing | Not started |
| Phase 5 | Operational review | Not started |
| Phase 6 | Production promotion | Blocked until validation and stable operation |

## Immediate Deployment Checklist

1. Confirm n8n-v2 Cloud Run service exists or create it.
2. Confirm n8n-v2 version.
3. Confirm database target for development data.
4. Configure required credentials.
5. Import `workflows/reference-node-exports/intake-engine-v1-stable.json`.
6. Run smoke test for Telegram, PostgreSQL, Google Sheets, OpenAI, validation, event logging, and Telegram response.
7. Export the validated n8n-v2 workflow.
8. Record result in `active/00-project-journal.md`.

## Promotion Rule

n8n-v2 must not replace n8n-prod until:

- critical workflows run successfully
- PostgreSQL integration is validated
- Telegram integration is validated
- rollback procedures are tested
- Memory Engine operates successfully
- documented architecture review is completed
- stable operation is observed for 2 to 4 weeks

## Open Items

| Question | Status |
|----------|--------|
| Has n8n-v2 been deployed? | TBD |
| What exact n8n version will v2 use? | TBD |
| What is the n8n-v2 URL? | TBD |
| What database or schema will n8n-v2 use? | TBD |
| Are credentials separate from production? | TBD |
| Has Intake Engine v1 Stable been imported into v2? | TBD |
| Has v2 smoke testing passed? | TBD |
