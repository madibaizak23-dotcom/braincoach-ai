# DEC-017 BGS Orch Schema Segregation

## Status

Accepted

## Date

2026-06-14

## Owner

Malik

## Layer

Architecture / Database Governance / Storage

## Context

DEC-016 fixed the database boundary:

- `bgs_core` = human reality data
- `bgs_orch` = knowledge + research process + production telemetry

After live inventory of `bgs_orch.public`, approximately 97 public tables were found.

Most `public` tables belong to n8n/runtime.

BrainCoach-owned tables confirmed by live database inspection in `bgs_orch.public`:

- `knowledge_assets`
- `knowledge_events`
- `repository_journal`

Confirmation note:

- `knowledge_assets` and `knowledge_events` were confirmed with live `\d` output.
- `repository_journal` was confirmed by the live `information_schema.tables` inventory. Its column/index structure still requires a separate `\d repository_journal` confirmation before any migration depends on it.

The problem:

BrainCoach should not keep adding research, production, and agent-process tables to `public`, because `public` is already mixed with n8n/runtime storage.

## Decision

New BrainCoach-owned objects in `bgs_orch` must be created in separate schemas, not in `public`.

Proposed schemas:

- `knowledge.*`
- `research.*`
- `production.*`
- `agent.*`

No SQL is approved by this decision.

No schema is created by this decision.

No existing table is moved by this decision.

## Boundary

`public` remains for:

- n8n/runtime tables
- legacy public tables
- currently existing BrainCoach-owned public tables until a separate approved migration moves them

`knowledge.*` is reserved for:

- knowledge registry
- knowledge events
- future knowledge process objects

`research.*` is reserved for:

- seasons
- briefs
- reviews
- research execution memory

`production.*` is reserved for:

- executions
- outcomes
- channel telemetry
- production process memory

`agent.*` is reserved for:

- runs
- evaluations
- prompt versions
- agent performance history

## Migration / Future Work

Existing `knowledge_assets` and `knowledge_events` remain in `public` for now.

`repository_journal` remains in `public` for now.

Moving existing BrainCoach-owned public tables into `knowledge.*` is allowed only through a separate approved migration.

`research.seasons` must not be created until after DEC-017 is accepted and a separate schema migration is reviewed and approved.

Any future SQL for `knowledge.*`, `research.*`, `production.*`, or `agent.*` must be draft-only until explicit approval.

Future migration drafts must specify:

- target database: `bgs_orch`
- target schema
- ownership boundary
- rollback or no-rollback rationale
- live verification plan
- confirmation that `bgs_core` is not modified

## Non-Actions

This decision does not:

- execute SQL
- create schemas
- create tables
- move existing tables
- modify production database state
- modify `bgs_core`
- approve `research.seasons` or any other table DDL

## Consequences

The `bgs_orch.public` schema remains stable and mostly runtime-owned.

BrainCoach-owned process memory gets a clean future namespace.

Season Research OS, Production OS, and agent-performance memory can evolve without further polluting `public`.

The boundary created by DEC-016 becomes enforceable at schema level.

## Related

- DEC-013 Orchestration Runtime Strategy
- DEC-016 BGS Database Boundary: Core vs Orch
- `braincoach-docs/07_automation/04_postgres/BGS_ORCH_PUBLIC_TABLES_2026_06_14.md`
- `braincoach-docs/07_automation/research_schema_v1_bgs_orch.md`
