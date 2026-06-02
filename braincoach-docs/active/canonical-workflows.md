Scout Memory Layer v1

Status: Working

Capabilities:
- Scout Agent
- Scout Extractor
- Qualification Signals Persistence
- PostgreSQL Storage

Verified:
2026-06-02
# Canonical Workflows

Last Updated: 2026-05-31

## Purpose

This document defines which workflow files are canonical and which workflow artifacts should be used for implementation, import, validation, and future development.

## Source Of Truth Rule

Stable workflow exports are the workflow source of truth after validation.

Historical workflow notes and archived Cursor-generated versions do not override stable exports.

## Current Canonical Workflow

| Field | Value |
|-------|-------|
| Canonical workflow | Intake Engine v1 Stable |
| Stable export | `workflows/reference-node-exports/intake-engine-v1-stable.json` |
| Workflow name in export | BrainCoach qualification-engine |
| Nodes | 19 |
| Connection groups | 17 |
| Execution order | v1 |
| Release commit | 920a0e6 |
| Release tag | intake-engine-v1-stable |
| Production status | Stable |
| Last verified | 2026-05-30 |

## Canonical Workflow Responsibilities

Intake Engine v1 Stable handles:

- Telegram intake
- client lookup
- client creation
- Google Sheets reads
- intake classification
- emotional reflection
- qualification question generation
- JSON validation
- PostgreSQL client update
- PostgreSQL event insert
- Telegram reply
- Telegram error fallback

It does not handle:

- Memory Engine persistence
- Memory retrieval
- Offer Engine
- Booking Engine
- Voice Intake
- Reactivation Engine
- Calendar
- Payment logic

## Canonical Node List

The stable export contains:

1. Telegram Trigger
2. Postgres - Find Client
3. IF - Client Exists?
4. Postgres - Create Client
5. GoogleSheets - keywords_master
6. GoogleSheets - qualification_flow
7. GoogleSheets - memory_signals
8. OpenAI - Intake Classifier
9. OpenAI - Emotional Reflection
10. OpenAI - Qualification Engine
11. Validate - Intake JSON
12. Validate - Emotional JSON
13. Validate - Qualification JSON
14. IF - All Valid?
15. Telegram - Send Error
16. Postgres - Update Client
17. Postgres - Insert Event
18. Telegram - Send Question
19. Merge

## Workflow Validation Evidence

From `active/00-project-journal.md` and `active/03-qualification-engine.md`:

- workflow executed successfully
- PostgreSQL client update confirmed
- PostgreSQL event logging confirmed
- Telegram response delivery confirmed
- JSON validation layer confirmed
- IF All Valid routing confirmed
- export created
- export imported into a new n8n workflow
- workflow graph rendered correctly after import
- end-to-end test completed using the documented memory keyword

## Planned Workflow Environments

| Environment | Workflow role | Status |
|-------------|---------------|--------|
| n8n-prod | Stable legacy production | Active |
| n8n-v2 | Development and future production candidate | TBD |

## Workflow Promotion Rule

No workflow moves directly into production.

Required sequence:

1. Architecture
2. Prototype in n8n-v2
3. Validation
4. Documentation
5. Git commit
6. Production promotion

## Non-Canonical Workflow Information

The following sources are historical or stale and should not override the stable export:

| Source | Status | Reason |
|--------|--------|--------|
| `active/05-current-project-status.md` | Stale | Describes pre-stable v4/v6 state |
| archived Cursor v3 workflow | Archive | Historical predecessor only |
| v4/v6 workflow notes | Archive or stale | Superseded by Intake Engine v1 Stable |
| root `workflows/qualification-engine.md` | Stale or deleted in current reorganization | Superseded by active stable docs |

## Stub Workflows

These workflow files exist as future placeholders:

| Workflow | Status |
|----------|--------|
| `workflows/offer-engine.json` | Stub |
| `workflows/reactivation-engine.json` | Stub |
| `workflows/voice-intake.json` | Stub |

## Open Items

| Question | Status |
|----------|--------|
| Has Intake Engine v1 Stable been imported into n8n-v2? | TBD |
| Has n8n-v2 produced its own validated export? | TBD |
| What export filename should represent v2 validation? | TBD |
| Are offer, reactivation, and voice stubs still planned in current milestone order? | TBD |
