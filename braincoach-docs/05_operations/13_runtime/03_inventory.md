# BGS Runtime Inventory

## Status

Active

## Purpose

Единый реестр инфраструктурных компонентов Brain Growth System.

Документ отвечает на вопрос:

Какие runtime-компоненты реально существуют в экосистеме BGS?

---

# Cloud Project

Project ID:

braincoach-n8n-prod

Status:

Active

---

# Cloud SQL

## Instance

Name:

n8n-db-instance

Status:

Active

Engine:

PostgreSQL 15

Purpose:

Primary data platform

---

# BGS Databases

## bgs_core

Owner:

bgs_admin

Status:

Active

Purpose:

Knowledge Layer

---

## bgs_orch

Owner:

bgs_admin

Status:

Active

Purpose:

Orchestration Layer

---

## bgs_analytics

Owner:

bgs_admin

Status:

Active

Purpose:

Analytics Layer

---

# Database Users

## bgs_admin

Status:

Active

Privileges

Privileges:

* Create Role
* Create Database

Purpose:

Primary administrative account for BGS.

---

## n8n_user

Status:

Active

Purpose:

Legacy n8n runtime account.

Primary Database:

n8n_v2_clean

---

## postgres

Status:

Active

Purpose:

Infrastructure administration and recovery.

---

# BGS Orchestration Layer

Database:

bgs_orch

Status:

Active

---

## Tables

### repository_journal

Status:

Operational

Purpose:

Persistent record of repository evolution.

---

### knowledge_events

Status:

Operational

Purpose:

Repository change event stream for Knowledge OS synchronization.

Live confirmation:

Created in `bgs_orch` by owner on 2026-06-13.

Key fields:

* `id`
* `event_type`
* `repository`
* `branch`
* `commit_id`
* `event_timestamp`
* `object_type`
* `metadata`
* `created_at`

---

### knowledge_assets

Status:

Operational

Purpose:

Authoritative registry of repository Knowledge Objects and tracked assets.

Live confirmation:

`CREATE TABLE IF NOT EXISTS` was run by owner on 2026-06-13. PostgreSQL returned `relation "knowledge_assets" already exists, skipping`, confirming the table already existed in `bgs_orch`.

Key fields:

* `id`
* `object_type`
* `object_name`
* `object_path`
* `version`
* `status`
* `first_seen`
* `last_updated`
* `metadata`

---

### agent_registry

Status:

Operational

Purpose:

Registry of all BGS agents.

---

# Registered Agents

## AGENT-004

Name:

orch_repository_guardian

Status:

building

Domain:

orchestration

Source Of Truth:

repository_journal

Purpose:

Track repository evolution and create persistent change records.

---

# Cloud Run

## bgs-orchestrator

Status:

planned

Purpose:

Primary runtime for BGS agents.

Deployment:

Not Started

Reference:

DEC-013 Orchestration Runtime Strategy

---

# Secret Manager

## Existing

Status:

Partially Configured

Known Secrets:

* postgres-password
* n8n-v2-encryption-key

---

## Planned BGS Secrets

Status:

planned

Future Secrets:

* bgs-admin-password
* gemini-api-key
* github-token
* telegram-bot-token
* openai-api-key

---

# Legacy Runtime Assets

Status:

Retained

Origin:

Pre-BGS Architecture

Artifacts:

* 01_intake.md
* 02_extraction.md
* 03_asset_design.md
* 04_generation.md
* 05_feedback.md
* content_factory.md
* production_learnings.md

Classification:

Legacy Content Factory Layer

Migration:

Not Planned

---

# Current Runtime State

Completed

* Cloud SQL operational
* BGS databases created
* BGS administrative boundary established
* repository_journal operational
* agent_registry operational
* AGENT-004 registered

---

# Next Milestone

MILESTONE-004

BGS Runtime Bootstrap Started

Target:

Deploy bgs-orchestrator runtime and activate AGENT-004.

---

# Last Updated

2026-06-10
