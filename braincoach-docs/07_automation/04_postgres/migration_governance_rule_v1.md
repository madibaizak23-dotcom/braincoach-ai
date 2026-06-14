# Migration Governance Rule v1

Status: Active Governance Rule
Date: 2026-06-12
Scope: BrainCoach BGS PostgreSQL changes

## Purpose

Every applied PostgreSQL migration in BrainCoach BGS must be accompanied by live verification and repository documentation updates.

No database change is considered complete until the live database state, SQL migration files, database documentation, and system logs are aligned.

## Required Migration Sequence

Minimum required actions for every applied migration:

1. Apply Migration
2. Verify Live Schema
3. Update Database Documentation
4. Update Milestone Log
5. Update System Evolution Log

## Source Of Truth Order

When sources disagree, use this priority order:

1. Live PostgreSQL
2. SQL Migrations
3. Database Canon / Governance Docs
4. System Logs

Live PostgreSQL has priority when there is a mismatch.

## Knowledge Assets Registry Rule

`003_seed_knowledge_assets.sql` is a historical/dev bootstrap seed for the old knowledge assets shape.

It must not be used to register new decision, architecture, or spec documents.

For live `bgs_orch.knowledge_assets`, use a separate reviewed draft upsert file that targets the confirmed live columns:

* `asset_name`
* `asset_type`
* `source_path`
* `source_of_truth`
* `status`

Live registry upserts must use `ON CONFLICT (source_path)` and must be applied manually only after explicit approval.

## Required Migration Record

For each migration, document:

* migration id
* date applied
* author / executor
* new tables
* new fields
* new indexes
* breaking changes
* rollback strategy

## Required Documentation Updates

At minimum, update:

* `braincoach-docs/07_automation/04_postgres/postgres-schema.md`
* `braincoach-docs/07_automation/04_postgres/braincoach_owned_tables.md`
* `braincoach-docs/05_operations/12_reviews/bgs_milestone_log.md`
* `braincoach-docs/03_knowledge/04_decisions/system_evolution_log.md`

When relevant, also update:

* table-specific contracts in `braincoach-docs/07_automation/04_postgres/`
* final migration review notes
* decision logs
* workflow or integration documentation that depends on the changed schema

## Rollback Strategy Rule

Every final migration review must include a rollback strategy.

Allowed rollback strategy types:

* no rollback required because the migration is additive and unused by production flows
* manual rollback SQL
* backup / restore plan
* forward-fix with rationale

## Forbidden

The following are not allowed:

* applying migrations without logging
* changing schema without updating documentation
* updating documentation without verifying live schema
* treating repository SQL as authoritative when it differs from live PostgreSQL

## Definition Of Done

A migration is complete only when all are true:

* SQL applied
* live schema verified
* docs updated
* logs updated
* commit created
* sync confirmed

## Current Reference

This rule was formalized after the GPS MVP-1 Reality Tracker migration alignment on 2026-06-12.
