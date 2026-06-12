# System Evolution Log

Status: Active

Purpose:

Chronological record of major architectural decisions, milestones, discoveries, and system transitions within BrainCoach Knowledge OS.

---

## 2026-06-12

### GPS MVP-1 Reality Tracker Migration Applied

Status: Completed

Objective:

Create the first live `bgs_core` foundation for GPS Daily Tracker without changing the existing Conversation Engine.

Applied Manually In Cloud SQL:

* `004_gps_reality_tracker_mvp1.sql`

Live Tables Confirmed:

* `trajectory_domains`
* `trajectories`
* `person_roles`
* `activity_types`
* `activity_events`
* `activity_confirmations`
* `trajectory_entries`

Seed Data Confirmed:

* `trajectory_domains`: 7 rows
* `activity_types`: 11 rows

Repository Documentation Location:

* `braincoach-docs/07_automation/04_postgres/004_gps_reality_tracker_mvp1.sql`
* `braincoach-docs/07_automation/04_postgres/GPS_MVP1_MIGRATION_FINAL_REVIEW.md`
* `braincoach-docs/07_automation/04_postgres/postgres-schema.md`
* `braincoach-docs/07_automation/04_postgres/braincoach_owned_tables.md`

Safety Confirmation:

* Existing tables were not altered.
* Existing data was not deleted.
* `conversation_events`, `conversations`, and `messages` were not changed.
* GPS matrix/report tables were not created in MVP-1.

Repository / Database Alignment:

The live `bgs_core` state and repository PostgreSQL documentation are now aligned for GPS MVP-1 Reality Tracker.

New Governance Rule:

Every future database migration must update the migration SQL, schema documentation, owned-table inventory, and system/milestone logs in the same working session. No migration is considered complete until repository documentation and live database state are reconciled.

Formal Rule:

`braincoach-docs/07_automation/04_postgres/migration_governance_rule_v1.md`

Session Outcome:

* Live PostgreSQL `bgs_core` checked.
* Live schema reconciled with repository documentation.
* GPS Reality Tracker MVP-1 created.
* Seven new Reality Tracker tables added.
* Conversation Engine compatibility preserved.
* Boundary clarified between Reality Tracker and later GPS Layer.
* Migration Governance approach formalized.
* Trajectory Architecture formalization started.

---

2026-06-09
Stage 3 Completed
BrainCoach GPS OS V3 Production Baseline


# sprint_log_2026_06_10

## status

completed

---

## milestone

BGS Core MVP Foundation Completed

---

## completed

✓ DEC-014 BGS Core MVP v1

✓ bgs_core_schema_v1

✓ 001_bgs_core_bootstrap.sql

✓ bgs_core physical database created

✓ 10 core tables created

✓ 002_seed_decisions.sql

✓ decisions registry seeded

✓ 003_seed_knowledge_assets.sql

✓ knowledge assets seeded

✓ parent_interview_questions_registry

✓ parent_interview_bot_mvp

✓ observation_extraction_v1

✓ research_signal_generation_v1

✓ signal_validation_v1

---

## major outcome

Впервые сформирован полный исследовательский контур Brain Growth System.

---

## resulting flow

parent

↓

parent_interview

↓

interview_responses

↓

observations

↓

research_signal_candidates

↓

validated_signals

---

## architecture achievements

Создан первый production-ready контур bgs_core

Создан первый knowledge registry

Создан первый decisions registry

Зафиксирован source of truth для исследовательного контура

Подготовлена база для Parent Interview Bot

Подготовлена база для будущего BrainCoach GPS

---

## key insight

Фокус спринта был смещен с инфраструктуры на модель данных.

Основным результатом является не создание таблиц, а создание первого непрерывного потока знаний внутри BGS.

---

## next milestone

trajectory_assessment_v1

Цель:

преобразование validated_signals в профиль развития человека.

---

## sprint result

BGS перешел от проектирования архитектуры к созданию первой рабочей knowledge system.


## 2026-06-09

### Stage 3 — Observation & Signal Extraction Pipeline Completed

Status: Completed

Objective:

Build the first operational research intake pipeline from Telegram capture through signal candidate staging.

Scope Realignment:

Stage 3 originally deferred from Stage 2 as Knowledge Relationships. Actual delivery focused on executable research intake because the system required a working observation-to-signal path before graph construction could produce meaningful edges.

Implemented:

* Telegram Tracker operational in production
* Observation Layer operational (`observations` populated from tracker entries)
* Signal Extraction Layer operational (`SIG_*` nodes in BrainCoach GPS OS V3)
* `research_signal_candidates` receiving live data
* BrainCoach GPS OS V3 deployed as current production workflow

Validated Pipeline:

Telegram (text / voice)

↓

Tracker Entry

↓

Observation

↓

Signal Candidate

↓

PostgreSQL persistence

Validated Capabilities:

* signal classification
* confidence scoring
* evidence extraction
* metadata jsonb storage
* relational links (entry → observation → candidate)

First Validated Signal Categories:

* self_initiation
* dependence_external

Decisions:

* candidate staging before signal promotion — no direct observation-to-signal promotion
* incremental workflow evolution — intake path preserved, signal layer added
* BrainCoach GPS OS V3 as production baseline
* classification noise tracked for Signal Taxonomy v2, no architectural change in Stage 3

Known Limitation:

Research notes and parent reflections can currently be misclassified as behavioral signals.

Deferred to Stage 4:

* Vertex AI Migration
* Analytics Layer
* Signal Aggregation
* Pattern Detection
* Weekly Reports
* Knowledge relationship discovery
* signal candidate promotion workflow

Outcome:

BrainCoach transitioned from registry-aware documentation architecture to operational research intake. The system can now transform live Telegram input into structured research objects and staged signal candidates.

Next Stage:

Stage 4 — Analytics & Intelligence Layer

Goals:

* unify LLM provider strategy through Vertex AI
* aggregate signal candidates into analyzable datasets
* detect recurring patterns across observations
* produce weekly research reports
* prepare foundation for knowledge graph edges

## 2026-06-05

### DEC-005 Adopted

Major Discovery:

SELF_LEARNING_CAPABILITY accepted as a central research object and long-term development direction.

Impact:

Shifted system focus from content production toward learning systems and knowledge acquisition.

---

## 2026-06-06

### Database Governance Formalized

Status: Completed

Artifacts Added:

* postgres-schema.md
* braincoach_owned_tables.md

Outcome:

Explicit separation established between:

* BrainCoach application data
* n8n runtime infrastructure

Database ownership boundaries documented.

Future graph architecture will operate exclusively on BrainCoach-owned objects.

---


## 2026-06-08

### Tracker Layer MVP Started

Status: Completed

Objective:

Create the first persistent memory layer for BrainCoach Tracker.

Implemented:

* tracker_entries table
* user-linked note storage
* timestamped entries
* entry types
* tag support

First Recorded Insight:

"Интервью является первым узлом траектории"

Outcome:

BrainCoach can now persist observations, ideas, hypotheses and insights independently of chat history.

Significance:

This is the first operational component of the future Trajectory Layer and Personal Knowledge Memory System.

### Signal Candidate Staging Table Added

Status: Completed

Objective:

Create a safe staging layer between observations and confirmed signals.

Implemented:

* research_signal_candidates table
* confidence scoring field
* candidate lifecycle status
* source links to observations and tracker_entries
* BrainCoach-owned table documentation

Outcome:

Tracker can now evolve from raw observation capture toward signal detection without immediately promoting every observation into a formal signal.

Significance:

This is the first database object supporting the future path:

Observation

↓

Signal Candidate

↓

Signal

↓

Deviation

↓

Phenomenon


## 2026-06-07

### Stage 2 — Full Repository Registry Completed

Status: Completed

Objective:

Populate knowledge_assets with the complete inventory of BrainCoach Knowledge OS.

Implemented:

* Full repository scan workflow
* GitHub API repository tree extraction
* Repository-wide asset classification
* PostgreSQL registry synchronization
* object_path based upsert strategy

Registry Cleanup:

* Legacy path duplicates removed
* Historical folder naming inconsistencies reconciled
* Repository registry normalized

Results:

* 104 active Knowledge Objects synchronized
* 104 unique object paths validated
* Full repository inventory established
* knowledge_assets became repository-wide source of truth

Registry Coverage:

* Canon
* Foundation
* Ontology
* Research
* Intelligence
* Registries
* Decisions
* Domains
* Operations
* Automation

Outcome:

BrainCoach Knowledge Registry transitioned from event-based discovery to full repository awareness.

Current Synchronization Model:

GitHub Repository

↓

Full Repository Registry

↓

knowledge_assets

↓

Future Relationship Layer

Next Stage:

Stage 3 — Knowledge Relationships

Goals:

* relationship extraction
* object graph construction
* dependency mapping
* semantic navigation layer

Result:

BrainCoach Knowledge OS now maintains a complete authoritative registry of repository knowledge assets.

2026-06-07

DEC-007 Accepted

Offer Discovery Layer introduced.

Reason:

Stage 2 Full Repository Registry completed.

Knowledge production is no longer the primary bottleneck.

Current constraint shifted to:

Knowledge → Offer → Revenue

Outcome:

Offer Discovery becomes a formal layer between Knowledge and Business.

### Content Factory Formalized

Status: Completed

Content Factory transformed from a content planning framework into a production operating system.

Modules Introduced:

* 01 Intake
* 02 Extraction
* 03 Asset Design
* 04 Generation
* 05 Feedback

Outcome:

Content production became a repeatable operational process rather than a collection of isolated activities.

---

### Deviation Introduced as a First-Class Object

Status: Accepted

New Learning Flow:

Observation

↓

Deviation

↓

Signal

↓

Phenomenon

Outcome:

Deviation recognized as the primary mechanism for detecting learning opportunities and generating research directions.

---

### Butterfly Principle Added to Foundation Layer

Status: Accepted

Purpose:

Formalize weak signals, small changes, and early deviations as valid research inputs.

Outcome:

Weak signals become explicit targets for observation and investigation.

---

### Automation Layer Formalized

Status: Completed

Documents Introduced:

* 01 Knowledge Objects
* 02 Object Relationships
* 03 Object States
* 04 PostgreSQL Mapping
* 05 Domain Architecture
* 06 Storage Architecture
* 07 Domain Interfaces
* 08 Agent Architecture

Outcome:

Automation architecture separated from conceptual architecture and became an independent system layer.

---

### Domain Model Consolidated

Status: Completed

Core Domains:

* Governance
* Research
* Business
* Operations

Outcome:

Domain boundaries became explicit and reusable across future system extensions.

---

### Storage Architecture Consolidated

Status: Completed

Responsibilities:

GitHub

* Knowledge storage

PostgreSQL

* Operational storage

pgvector

* Retrieval and semantic search

n8n

* Orchestration

Vertex AI

* Reasoning and generation

Outcome:

Infrastructure responsibilities clearly separated and documented.

---

### Stage 1 — Knowledge Registry Foundation Completed

Status: Completed

Objective:

Create the foundational synchronization layer between GitHub and the BrainCoach Knowledge Registry.

Implemented Architecture:

GitHub Push

↓

Webhook

↓

Knowledge Event Parser

↓

knowledge_events

↓

Extract Assets

↓

knowledge_assets

Achievements:

* GitHub webhook operational
* Automatic event registration
* Automatic asset discovery
* Multi-file processing validated
* Asset classification validated
* Metadata persistence validated
* UNIQUE(object_path) constraint implemented
* Insert-or-Update behavior validated
* Duplicate asset creation prevented

Registry Components:

* knowledge_events
* knowledge_assets

Synchronization Mode:

GitHub → PostgreSQL

Conflict Resolution:

object_path based upsert

Current Registry State:

* knowledge_events active
* knowledge_assets active
* Incremental synchronization active

Outcome:

BrainCoach Knowledge OS now maintains a continuously updated registry of discovered knowledge assets.

Next Stage:

Stage 2 — Full Repository Sync

Goal:

Populate knowledge_assets with the complete repository inventory rather than only recently modified objects.

Expected Result:

knowledge_assets becomes the authoritative registry of all BrainCoach Knowledge Objects.

---


## Current Strategic Direction

BrainCoach Evolution Path:

Content System

↓

Research Operating System

↓

Knowledge Production System

↓

Signal Detection and Learning System

↓

Analytics and Intelligence Layer

Current Stage: Stage 4 Planned

Long-Term Goal:

Create a self-improving knowledge ecosystem capable of detecting signals, generating research, producing knowledge assets, and continuously expanding its own understanding of the world.
