# System Evolution Log

Status: Active

Purpose:

Chronological record of major architectural decisions, milestones, discoveries, and system transitions within BrainCoach Knowledge OS.

---

## 2026-06-14

### Production OS Structure Normalization v1 Applied

Status: Applied

Objective:

Package the newly defined Production OS object specifications into a readable canon and normalized documentation structure before further object design.

Outcome:

* Created Production OS Canon v1 as the reading map for the full object flow.
* Created Production OS Structure Normalization v1 with applied directory structure, canonical file names, link migration record, canon membership, and infrastructure boundaries.
* Moved Production OS object specs into domain folders under `braincoach-docs/07_automation/production_os/`.
* Added `README.md` as the Production OS folder index.
* Updated repository links and the reviewed draft live-registry upsert file to canonical paths.
* Reconfirmed that `003_seed_knowledge_assets.sql` must not be used for live knowledge asset registration.

Explicit Non-Action:

* No SQL was executed.
* No migration was approved.
* No live `bgs_orch.knowledge_assets` update was applied.

Artifacts:

* `braincoach-docs/07_automation/production_os/00_production_os_canon_v1.md`
* `braincoach-docs/07_automation/production_os/README.md`
* `braincoach-docs/07_automation/production_os/06_governance/production_os_structure_normalization_v1.md`

---

### Knowledge Update Specification v1 Drafted

Status: Draft

Depends On:

* `DEC-016 BGS Database Boundary: Core vs Orch`
* `DEC-017 BGS Orch Schema Segregation`
* `Season Review Specification v1`

Objective:

Define the governed process that turns accepted Season Review recommendations into explicit knowledge changes while enforcing the `bgs_orch` / `bgs_core` boundary.

Outcome:

* Knowledge Update defined as the bridge from season review recommendations to Knowledge OS changes.
* Updateable object categories documented: phenomena, patterns, offer signals, prompt library, research questions, knowledge assets, and season registry.
* Creatable candidate objects documented: candidate phenomenon, candidate pattern, candidate offer signal, new season proposal, new research question, prompt improvement candidate, agent evaluation note, knowledge asset update recommendation, future interview target group, and validation task.
* Validation requirements, allowed draft automation, and never-automatic actions documented.
* Boundary documented: no automatic `bgs_core` writes and no live registry updates without reviewed draft upsert approval.

Explicit Non-Action:

* No SQL was executed.
* No migration was approved.
* No table was created.
* No `bgs_core` write or promotion rule was created.

Spec Location:

* `braincoach-docs/07_automation/production_os/05_intelligence/knowledge_update.md`

---

### Season Review Specification v1 Drafted

Status: Draft

Depends On:

* `DEC-016 BGS Database Boundary: Core vs Orch`
* `DEC-017 BGS Orch Schema Segregation`
* `Research Schema v1 for bgs_orch`
* `Signal Capture Specification v1`

Objective:

Define the canonical Season Review object as the season-level review that consolidates Signal Captures into seasonal knowledge.

Outcome:

* Season Review defined as the object that reviews the full Research Season, not one outcome.
* Candidate Consolidation section added.
* Review inputs defined: repeated phrases, objection signals, fear signals, offer signals, strong cases, interview candidates, resonance signals, dissonance signals, and phenomenon candidates.
* Consolidation process documented: grouping, comparison, strengthening, rejection/weakening, and recommendations for Knowledge Update.
* Future physical object `research.reviews` remains draft-only until explicit migration approval.

Explicit Non-Action:

* No SQL was executed.
* No migration was approved.
* No table was created.
* `research.reviews` was not created.

Spec Location:

* `braincoach-docs/07_automation/production_os/05_intelligence/season_review.md`

---

### Signal Capture Specification v1 Drafted

Status: Draft

Depends On:

* `DEC-016 BGS Database Boundary: Core vs Orch`
* `DEC-017 BGS Orch Schema Segregation`
* `Research Schema v1 for bgs_orch`
* `Production Outcome Specification v1`

Objective:

Define the canonical Signal Capture object as the interpretation layer that turns Production Outcomes into structured knowledge candidates.

Outcome:

* Signal Capture defined as the object/process that extracts candidates from raw outcomes.
* Candidate types defined: repeated phrase, objection signal, fear signal, offer signal, strong case, interview candidate, resonance signal, dissonance signal, and phenomenon candidate.
* Boundary documented: Signal Capture does not store raw comments/DMs/metrics and does not create validated reality in `bgs_core`.
* Future physical placement remains unresolved and may belong under `research.*` or `knowledge.*`.

Explicit Non-Action:

* No SQL was executed.
* No migration was approved.
* No table was created.
* No `bgs_core` write or promotion rule was created.

Spec Location:

* `braincoach-docs/07_automation/production_os/05_intelligence/signal_capture.md`

---

### Production Outcome Specification v1 Drafted

Status: Draft

Depends On:

* `DEC-016 BGS Database Boundary: Core vs Orch`
* `DEC-017 BGS Orch Schema Segregation`
* `Research Schema v1 for bgs_orch`
* `Research Season Specification v1`
* `Research Brief Specification v1`
* `Marketing Brief Specification v1`
* `Content Plan Specification v1`
* `Production Execution Specification v1`

Objective:

Define the canonical Production Outcome object as the raw response layer between Production Execution and Signal Capture.

Outcome:

* Production Outcome defined as the object that records what the environment returned after execution.
* Core attributes defined conceptually, not as SQL.
* Relationships documented with `production.executions`, `signal.capture`, `research.reviews`, and `agent.runs`.
* Related concepts linked: Production Execution, Signal Capture, Season Review, Offer Discovery, and Research Schema v1.
* Future physical object `production.outcomes` remains draft-only until explicit migration approval.

Explicit Non-Action:

* No SQL was executed.
* No migration was approved.
* No table was created.
* `production.outcomes` was not created.

Spec Location:

* `braincoach-docs/07_automation/production_os/04_execution/production_outcome.md`

---

### Production Execution Specification v1 Drafted

Status: Draft

Depends On:

* `DEC-016 BGS Database Boundary: Core vs Orch`
* `DEC-017 BGS Orch Schema Segregation`
* `Research Schema v1 for bgs_orch`
* `Research Season Specification v1`
* `Research Brief Specification v1`
* `Marketing Brief Specification v1`
* `Content Plan Specification v1`

Objective:

Define the canonical Production Execution object as the factual record of what actually happened in production.

Outcome:

* Production Execution defined as the object that records published, sent, launched, or completed production actions.
* Core attributes defined conceptually, not as SQL.
* Relationships documented with `content.plans`, `production.outcomes`, `signal.capture`, `research.reviews`, and `agent.runs`.
* Related concepts linked: Research Season, Content Plan, Production Outcomes, Signal Capture, Season Review, and Agent Runs.
* Future physical object `production.executions` remains draft-only until explicit migration approval.

Explicit Non-Action:

* No SQL was executed.
* No migration was approved.
* No table was created.
* `production.executions` was not created.

Spec Location:

* `braincoach-docs/07_automation/production_os/04_execution/production_execution.md`

---

### Content Plan Specification v1 Drafted

Status: Draft

Depends On:

* `DEC-016 BGS Database Boundary: Core vs Orch`
* `DEC-017 BGS Orch Schema Segregation`
* `Research Schema v1 for bgs_orch`
* `Research Season Specification v1`
* `Research Brief Specification v1`
* `Marketing Brief Specification v1`

Objective:

Define the canonical Content Plan object as the bridge between Marketing Brief and Production Execution.

Outcome:

* Content Plan defined as the object that translates a Marketing Brief into a sequence of research artifacts.
* Core attributes defined conceptually, not as SQL.
* Relationships documented with `marketing.briefs`, `production.executions`, `production.outcomes`, `research.reviews`, and `agent.runs`.
* Related concepts linked: Research Season, Research Brief, Marketing Brief, Production Execution, Signal Capture, Season Review, and Offer Discovery.
* Physical schema placement for a future Content Plan object remains unresolved under DEC-017 and may belong under `production.*` or `research.*`.

Explicit Non-Action:

* No SQL was executed.
* No migration was approved.
* No table was created.
* No `content.*` schema was introduced.

Spec Location:

* `braincoach-docs/07_automation/production_os/03_content/content_plan.md`

---

### Marketing Brief Specification v1 Drafted

Status: Draft

Depends On:

* `DEC-016 BGS Database Boundary: Core vs Orch`
* `DEC-017 BGS Orch Schema Segregation`
* `Research Schema v1 for bgs_orch`
* `Research Season Specification v1`
* `Research Brief Specification v1`

Objective:

Define the canonical Marketing Brief object as the bridge between Research Brief and Content Plan.

Outcome:

* Marketing Brief defined as the object that translates a research program into market interaction and signal capture.
* Core attributes defined conceptually, not as SQL.
* Relationships documented with `research.briefs`, `content.plans`, `production.executions`, and `research.reviews`.
* Related concepts linked: Research Season, Research Brief, Offer Discovery, Season Review, Seasonal Phenomena, and Content Plan.
* Physical schema placement for a future `marketing.briefs` object remains unresolved under DEC-017 and requires a later approved decision or migration design.

Explicit Non-Action:

* No SQL was executed.
* No migration was approved.
* No table was created.
* `marketing.briefs` remains future work.

Spec Location:

* `braincoach-docs/07_automation/production_os/02_marketing/marketing_brief.md`

---

### Knowledge Assets Seed Governance Clarified

Status: Active

Objective:

Prevent `003_seed_knowledge_assets.sql` from becoming a mixed live registry update mechanism.

Outcome:

* `003_seed_knowledge_assets.sql` is explicitly treated as historical/dev bootstrap only.
* New spec, decision, and architecture documents must not be registered through this seed.
* Live `bgs_orch.knowledge_assets` updates must use separate reviewed draft upsert files targeting the confirmed live schema.
* Fresh spec/architecture additions were removed from the seed to keep it from drifting into a live registry substitute.

Explicit Non-Action:

* No SQL was executed.
* No live registry update was applied.
* No PostgreSQL schema was changed.

Governance Location:

* `braincoach-docs/07_automation/04_postgres/migration_governance_rule_v1.md`

---

### Research Brief Specification v1 Drafted

Status: Draft

Depends On:

* `DEC-016 BGS Database Boundary: Core vs Orch`
* `DEC-017 BGS Orch Schema Segregation`
* `Research Schema v1 for bgs_orch`
* `Research Season Specification v1`

Objective:

Define the canonical Research Brief object as the bridge between Research Season and Marketing Brief.

Outcome:

* Research Brief defined as the object that translates a season question into a concrete research program.
* Core attributes defined conceptually, not as SQL.
* Relationships documented with `research.seasons`, `marketing.briefs`, `research.reviews`, and `agent.runs`.
* Related concepts linked: Research Season, Research Schema v1, Offer Discovery, Seasonal Phenomena, Marketing Brief, and Agent Runs.

Explicit Non-Action:

* No SQL was executed.
* No migration was approved.
* No table was created.
* `research.briefs` remains future work.

Spec Location:

* `braincoach-docs/07_automation/production_os/01_research/research_brief.md`

---

### Research Season Specification v1 Drafted

Status: Draft

Depends On:

* `DEC-016 BGS Database Boundary: Core vs Orch`
* `DEC-017 BGS Orch Schema Segregation`
* `Research Schema v1 for bgs_orch`

Objective:

Define the canonical Research Season object before drafting `research.seasons` SQL or creating any schema/table.

Outcome:

* Research Season defined as the root object of the Season Intelligence Loop.
* Lifecycle proposed: `draft`, `active`, `completed`, `archived`.
* Core attributes defined conceptually, not as SQL.
* Relationships documented with `research.briefs`, `research.reviews`, `production.executions`, `production.outcomes`, and `agent.runs`.
* Existing Season Registry, Season Review, Seasonal Phenomena, and Season Intelligence Loop concepts linked to avoid terminology conflict.

Explicit Non-Action:

* No SQL was executed.
* No migration was approved.
* No table was created.
* `research.seasons` remains future work.

Spec Location:

* `braincoach-docs/07_automation/production_os/01_research/research_season.md`

---

### BGS Orch Schema Segregation Accepted

Status: Completed

Decision:

`DEC-017 BGS Orch Schema Segregation`

Objective:

Prevent new BrainCoach-owned research, production, and agent-process tables from being added to `bgs_orch.public`, which is already mixed with n8n/runtime tables.

Accepted Rule:

New BrainCoach-owned objects in `bgs_orch` must be created in separate schemas:

* `knowledge.*`
* `research.*`
* `production.*`
* `agent.*`

Boundary:

* `public` remains for n8n/runtime and legacy public tables.
* `knowledge.*` is reserved for knowledge registry, knowledge events, and future knowledge process objects.
* `research.*` is reserved for seasons, briefs, reviews, and research execution memory.
* `production.*` is reserved for executions, outcomes, channel telemetry, and production process memory.
* `agent.*` is reserved for runs, evaluations, prompt versions, and agent performance history.

Migration / Future Work:

* Existing `knowledge_assets`, `knowledge_events`, and `repository_journal` remain in `public` for now.
* Moving existing BrainCoach-owned public tables into `knowledge.*` requires a separate approved migration.
* `research.seasons` must not be created until a separate schema migration is reviewed and approved.
* Any future SQL must be draft-only until explicit approval.

Explicit Non-Action:

* No SQL was executed.
* No schema was created.
* No existing table was moved.
* No production database was modified.

---

### Research Schema v1 for bgs_orch Drafted

Status: Draft

Depends On:

`DEC-016 BGS Database Boundary: Core vs Orch`

Objective:

Define the first architecture-level schema design for storing BrainCoach research-process, production-process, and agent-performance data inside `bgs_orch`.

Scope:

* `research.seasons`
* `research.briefs`
* `research.executions`
* `research.reviews`
* `production.executions`
* `production.outcomes`
* `agent.runs`
* `agent.evaluations`
* `agent.prompt_versions`

Boundary:

* `bgs_orch` stores process memory.
* `bgs_core` stores validated reality objects.

Explicit Non-Action:

* No new database was created.
* No SQL migration was approved.
* `bgs_core` was not modified.
* No final table DDL was defined.

Spec Location:

* `braincoach-docs/07_automation/research_schema_v1_bgs_orch.md`

Live Registry Confirmation:

Owner manually applied the `bgs_orch.knowledge_assets` upsert after review. Verification query returned two active assets:

* `DEC-016 BGS Database Boundary: Core vs Orch` — `decision`, `github`, `active`
* `Research Schema v1 for bgs_orch` — `architecture`, `github`, `active`

Codex did not run the SQL against PostgreSQL.

---

### BGS Database Boundary Accepted

Status: Completed

Decision:

`DEC-016 BGS Database Boundary: Core vs Orch`

Objective:

Formalize the canonical database boundary between `bgs_core` and `bgs_orch` before adding Season Research OS / Production OS objects.

Accepted Boundary:

* `bgs_core` = human reality data.
* `bgs_orch` = knowledge, research process, production telemetry.

Boundary Rule:

* `bgs_core` answers: what is happening with people?
* `bgs_orch` answers: how BrainCoach collects, processes, analyzes and turns reality into knowledge.

Implementation Rule:

Season Research OS / Production OS objects should be added to `bgs_orch`, preferably under separate schemas:

* `knowledge.*`
* `research.*`
* `production.*`
* `agent.*`

Explicit Non-Action:

* No new database is created at this stage.
* Season production telemetry, agent evaluation, and prompt-performance data must not be added to `bgs_core`.

Knowledge Asset:

* `braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-016-bgs-database-boundary-core-vs-orch.md`

Repository Documentation Updated:

* `braincoach-docs/03_knowledge/04_decisions/decision-log/decision_log.md`
* `braincoach-docs/07_automation/06_storage_architecture.md`
* `braincoach-docs/03_knowledge/system_snapshot.md`
* `braincoach-docs/07_automation/04_postgres/002_seed_decisions.sql`
* `braincoach-docs/07_automation/04_postgres/003_seed_knowledge_assets.sql`

---

## 2026-06-13

### BGS Orchestration Knowledge Tables Confirmed

Status: Completed

Objective:

Confirm the live `bgs_orch` persistence tables needed for Knowledge OS repository event tracking and asset registry synchronization.

Applied Manually In `bgs_orch` By Owner:

```sql
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE IF NOT EXISTS knowledge_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_type TEXT NOT NULL,
    repository TEXT NOT NULL,
    branch TEXT NOT NULL,
    commit_id TEXT NOT NULL,
    event_timestamp TIMESTAMPTZ,
    object_type TEXT,
    metadata JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS knowledge_assets (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    object_type TEXT NOT NULL,
    object_name TEXT NOT NULL,
    object_path TEXT NOT NULL UNIQUE,
    version TEXT DEFAULT 'v1',
    status TEXT DEFAULT 'active',
    first_seen TIMESTAMPTZ DEFAULT NOW(),
    last_updated TIMESTAMPTZ DEFAULT NOW(),
    metadata JSONB
);
```

Live Result:

* `pgcrypto` extension confirmed.
* `knowledge_events` table created.
* `knowledge_assets` already existed; PostgreSQL returned `relation "knowledge_assets" already exists, skipping`.

Safety Confirmation:

* SQL was executed manually by owner, not by Codex.
* `knowledge_assets` was not recreated or dropped.
* No existing data deletion was reported.

Repository Documentation Updated:

* `braincoach-docs/05_operations/13_runtime/03_inventory.md`
* `braincoach-docs/05_operations/12_reviews/bgs_milestone_log.md`
* `braincoach-docs/03_knowledge/03_registries/repository_journal.md`

---

## 2026-06-13

### BrainCoach GPS Workflow Migration Completed

Status: Completed

Objective:

Migrate the Stage 3 BrainCoach GPS OS workflow export to the live `bgs_core` GPS MVP-1 persistence model without rebuilding the workflow from scratch.

Completed:

* `BrainCoach GPS MVP-1 — bgs_core adapted.json` imported successfully into n8n.
* Required Telegram and voice intake flow preserved.
* Conversation Engine preserved through `conversations` and `messages`.
* PostgreSQL layer migrated from old Stage 3 fields to live `bgs_core` tables.
* Token/credential configuration completed by owner after import.
* Workflow execution confirmed operational by owner.
* Legacy export `BrainCoach GPS OS — Stage 3 Complete.json` removed from repository to avoid duplication.

Current Workflow Export:

* `braincoach-docs/07_automation/03_n8n/BrainCoach GPS MVP-1 — bgs_core adapted.json`

Migration Report:

* `braincoach-docs/07_automation/03_n8n/BrainCoach GPS MVP-1 — bgs_core adapted.diff-report.md`

Safety Confirmation:

* No database migration was run by Codex.
* No new tables were created by this workflow adaptation.
* Existing Conversation Engine architecture was not removed.

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
* BrainCoach GPS OS V3 deployed as the Stage 3 production workflow; superseded by `BrainCoach GPS MVP-1 — bgs_core adapted` on 2026-06-13

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
