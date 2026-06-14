# repository_journal

## status

active

## purpose

Журнал эволюции Brain Growth System.

Документ отвечает на вопрос:

«Какие значимые изменения происходили в развитии системы?»

---

# journal_principles

Журнал не является логом.

Журнал не является списком коммитов.

Журнал фиксирует только изменения, имеющие значение для развития BGS.

---

# inclusion_rule

Запись создается только если изменение влияет на:

* архитектуру
* память
* знания
* агентов
* инфраструктуру
* домены
* источники истины
* модель управления

Обычные коммиты в журнал не попадают.

---

# journal_entry_template

## entry_id

Уникальный идентификатор записи.

---

## date

Дата события.

---

## type

Допустимые значения:

```text
architecture
milestone
agent
domain
infrastructure
knowledge
governance
runtime
```

---

## title

Краткое название события.

---

## summary

Краткое описание произошедшего.

---

## impact

Что изменилось для системы.

---

## related_assets

Связанные документы.

---

## related_decisions

Связанные решения.

---

# entries

---

## RJ-001

### date

2026-06-07

### type

milestone

### title

Stage 2 Repository Registry Completed

### summary

Завершена синхронизация репозиториев и сформирован единый repository registry.

### impact

Система получила единый источник информации о структуре репозиториев.

### related_assets

* repository_registry.txt
* system_snapshot.md

---

## RJ-002

### date

2026-06-09

### type

infrastructure

### title

Cloud SQL Backup Strategy Implemented

### summary

Созданы резервные копии рабочих баз данных и настроен архив в Cloud Storage.

### impact

Появилась гарантированная точка восстановления системы.

### related_assets

* braincoach_dev.backup
* n8n_v2_clean.backup

---

## RJ-003

### date

2026-06-10

### type

architecture

### title

BGS Architecture Foundation Established

### summary

Создан базовый пакет архитектурных документов Brain Growth System.

### impact

Система получила формализованную модель устройства, памяти, событий, данных и управления.

### related_assets

* bgs_system_map_v1.md
* bgs_agent_map_v1.md
* bgs_data_flow_map_v1.md
* bgs_runtime_map_v1.md
* bgs_memory_map_v1.md
* bgs_event_map_v1.md
* bgs_governance_map_v1.md

### related_decisions

* DEC-008-bgs-data-architecture.md
* DEC-009-human-ai-operating-model.md
* DEC-010-naming-conventions.md
* DEC-011-source-of-truth-model.md

---

## RJ-004

### date

2026-06-13

### type

runtime

### title

BrainCoach GPS Workflow Migrated To BGS Core GPS MVP-1

### summary

The Stage 3 BrainCoach GPS OS workflow was migrated to `BrainCoach GPS MVP-1 — bgs_core adapted.json`, imported into n8n, configured with required tokens by the owner, and confirmed operational.

### impact

The current workflow source of truth now uses the live `bgs_core` GPS MVP-1 persistence model. The legacy `BrainCoach GPS OS — Stage 3 Complete.json` export was removed from the repository to avoid duplicate production workflow exports.

### related_assets

* braincoach-docs/07_automation/03_n8n/BrainCoach GPS MVP-1 — bgs_core adapted.json
* braincoach-docs/07_automation/03_n8n/BrainCoach GPS MVP-1 — bgs_core adapted.diff-report.md
* braincoach-docs/07_automation/02_workflows/tracker_capture_v1.md

### related_decisions

* DEC-014-bgs-core-mvp-v1.md

---

## RJ-005

### date

2026-06-13

### type

runtime

### title

BGS Orchestration Knowledge Tables Confirmed

### summary

The owner executed the `bgs_orch` SQL foundation for Knowledge OS repository synchronization. `knowledge_events` was created, and `knowledge_assets` was confirmed as already existing.

### impact

The Orchestration Layer now has confirmed persistence for repository event tracking and Knowledge Object asset registry synchronization. This supports future automated repository monitoring and Knowledge OS sync workflows.

### related_assets

* braincoach-docs/05_operations/13_runtime/03_inventory.md
* braincoach-docs/07_automation/03_n8n/knowledge_registry_sync_v1.json
* braincoach-docs/07_automation/06_storage_architecture.md

### related_decisions

* DEC-011-source-of-truth-model.md
* DEC-013-orchestration-runtime-strategy.md

---

## RJ-006

### date

2026-06-14

### type

architecture

### title

BGS Database Boundary Accepted

### summary

DEC-016 formalized the canonical database boundary: `bgs_core` remains the human reality data database, while `bgs_orch` owns knowledge, research process, and production telemetry.

### impact

Season Research OS / Production OS objects now have a clear placement rule. They belong in `bgs_orch`, preferably under `knowledge.*`, `research.*`, `production.*`, and `agent.*` schemas. No new database is created at this stage.

### related_assets

* braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-016-bgs-database-boundary-core-vs-orch.md
* braincoach-docs/07_automation/06_storage_architecture.md
* braincoach-docs/03_knowledge/system_snapshot.md

### related_decisions

* DEC-008-bgs-data-architecture.md
* DEC-011-source-of-truth-model.md
* DEC-013-orchestration-runtime-strategy.md
* DEC-014-bgs-core-mvp-v1.md

---

## RJ-007

### date

2026-06-14

### type

architecture

### title

Research Schema v1 for bgs_orch Drafted

### summary

Created the first architecture-level schema design for Season Research OS, Production OS telemetry, and agent-performance memory inside `bgs_orch`.

### impact

BrainCoach can now design the Season Intelligence Loop inside the existing database boundary set by DEC-016, without creating a new database, modifying `bgs_core`, or approving SQL migration.

### related_assets

* braincoach-docs/07_automation/research_schema_v1_bgs_orch.md
* braincoach-docs/07_automation/06_storage_architecture.md
* braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-016-bgs-database-boundary-core-vs-orch.md

### related_decisions

* DEC-016-bgs-database-boundary-core-vs-orch.md

---

## RJ-008

### date

2026-06-14

### type

runtime

### title

Research Schema v1 Registered In Live Knowledge Assets

### summary

The owner manually applied the reviewed `bgs_orch.knowledge_assets` upsert for DEC-016 and Research Schema v1. A live verification query returned both assets as active GitHub-sourced knowledge assets.

### impact

The live orchestration registry now recognizes the database-boundary decision and the Research Schema v1 architecture spec as tracked Knowledge Assets.

### related_assets

* braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-016-bgs-database-boundary-core-vs-orch.md
* braincoach-docs/07_automation/research_schema_v1_bgs_orch.md
* braincoach-docs/07_automation/04_postgres/draft_bgs_orch_knowledge_assets_upsert_dec016_research_schema_v1.sql

### related_decisions

* DEC-016-bgs-database-boundary-core-vs-orch.md

---

## RJ-009

### date

2026-06-14

### type

architecture

### title

BGS Orch Schema Segregation Accepted

### summary

DEC-017 established that new BrainCoach-owned objects in `bgs_orch` must be created in separate schemas rather than in `public`.

### impact

The repository now has a schema-level guardrail for Season Research OS, Production OS, and agent-performance memory. `public` remains for n8n/runtime and legacy public tables; future BrainCoach-owned tables should target `knowledge.*`, `research.*`, `production.*`, or `agent.*` through draft SQL only until approved.

### related_assets

* braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-017-bgs-orch-schema-segregation.md
* braincoach-docs/07_automation/04_postgres/BGS_ORCH_PUBLIC_TABLES_2026_06_14.md
* braincoach-docs/07_automation/research_schema_v1_bgs_orch.md

### related_decisions

* DEC-016-bgs-database-boundary-core-vs-orch.md

---

## RJ-010

### date

2026-06-14

### type

architecture

### title

Research Season Specification v1 Drafted

### summary

Created the first canonical object specification for Research Season as the root object of the Season Intelligence Loop.

### impact

BrainCoach now has a conceptual object contract for future `research.seasons` work without creating SQL, schemas, tables, or migrations. The document links Season Registry, Season Review, Seasonal Phenomena, and Season Intelligence Loop to prevent term drift.

### related_assets

* braincoach-docs/07_automation/production_os/01_research/research_season.md
* braincoach-docs/07_automation/research_schema_v1_bgs_orch.md
* braincoach-docs/03_knowledge/03_registries/season_registry.md

### related_decisions

* DEC-016-bgs-database-boundary-core-vs-orch.md
* DEC-017-bgs-orch-schema-segregation.md

---

## RJ-011

### date

2026-06-14

### type

architecture

### title

Research Brief Specification v1 Drafted

### summary

Created the canonical object specification for Research Brief as the bridge between Research Season and Marketing Brief.

### impact

BrainCoach now has a clear object for turning a season question into a concrete research program without creating SQL, migrations, or tables. This prepares the next Production OS object after Research Season.

### related_assets

* braincoach-docs/07_automation/production_os/01_research/research_brief.md
* braincoach-docs/07_automation/production_os/01_research/research_season.md
* braincoach-docs/07_automation/research_schema_v1_bgs_orch.md

### related_decisions

* DEC-016-bgs-database-boundary-core-vs-orch.md
* DEC-017-bgs-orch-schema-segregation.md

---

## RJ-012

### date

2026-06-14

### type

architecture

### title

Marketing Brief Specification v1 Drafted

### summary

Created the canonical object specification for Marketing Brief as the bridge between Research Brief and Content Plan.

### impact

BrainCoach now has a formal object contract for translating a research program into market interaction, signal capture, case collection, and interview conversion without creating SQL, schemas, tables, or migrations.

### related_assets

* braincoach-docs/07_automation/production_os/02_marketing/marketing_brief.md
* braincoach-docs/07_automation/production_os/01_research/research_brief.md
* braincoach-docs/07_automation/research_schema_v1_bgs_orch.md

### related_decisions

* DEC-016-bgs-database-boundary-core-vs-orch.md
* DEC-017-bgs-orch-schema-segregation.md

---

## RJ-013

### date

2026-06-14

### type

governance

### title

Knowledge Assets Seed Governance Clarified

### summary

Clarified that `003_seed_knowledge_assets.sql` is a historical/dev bootstrap seed and must not be used as the mechanism for registering new live Knowledge Assets.

### impact

Future decision, architecture, and spec documents should be registered in live `bgs_orch.knowledge_assets` only through separate reviewed draft upsert files that target the confirmed live schema and use `ON CONFLICT (source_path)`.

### related_assets

* braincoach-docs/07_automation/04_postgres/003_seed_knowledge_assets.sql
* braincoach-docs/07_automation/04_postgres/migration_governance_rule_v1.md
* braincoach-docs/07_automation/04_postgres/draft_bgs_orch_knowledge_assets_upsert_dec016_research_schema_v1.sql

---

## RJ-014

### date

2026-06-14

### type

architecture

### title

Content Plan Specification v1 Drafted

### summary

Created the canonical object specification for Content Plan as the bridge between Marketing Brief and Production Execution.

### impact

BrainCoach now has a formal object contract for turning market interaction strategy into concrete research artifacts, signal-capture points, and interview entry points without creating SQL, schemas, tables, or migrations.

### related_assets

* braincoach-docs/07_automation/production_os/03_content/content_plan.md
* braincoach-docs/07_automation/production_os/02_marketing/marketing_brief.md
* braincoach-docs/07_automation/research_schema_v1_bgs_orch.md

### related_decisions

* DEC-016-bgs-database-boundary-core-vs-orch.md
* DEC-017-bgs-orch-schema-segregation.md

---

## RJ-015

### date

2026-06-14

### type

architecture

### title

Production Execution Specification v1 Drafted

### summary

Created the canonical object specification for Production Execution as the factual record of what actually happened in production.

### impact

BrainCoach now has a formal object contract for separating planned content from completed production actions and anchoring later outcomes, signal capture, and season review without creating SQL, schemas, tables, or migrations.

### related_assets

* braincoach-docs/07_automation/production_os/04_execution/production_execution.md
* braincoach-docs/07_automation/production_os/03_content/content_plan.md
* braincoach-docs/07_automation/research_schema_v1_bgs_orch.md

### related_decisions

* DEC-016-bgs-database-boundary-core-vs-orch.md
* DEC-017-bgs-orch-schema-segregation.md

---

## RJ-016

### date

2026-06-14

### type

architecture

### title

Production Outcome Specification v1 Drafted

### summary

Created the canonical object specification for Production Outcome as the raw response layer between Production Execution and Signal Capture.

### impact

BrainCoach now separates what was executed from what the environment returned and from what the system later interprets as signals. This keeps outcomes factual and preserves Signal Capture as a distinct interpretation layer.

### related_assets

* braincoach-docs/07_automation/production_os/04_execution/production_outcome.md
* braincoach-docs/07_automation/production_os/04_execution/production_execution.md
* braincoach-docs/07_automation/research_schema_v1_bgs_orch.md

### related_decisions

* DEC-016-bgs-database-boundary-core-vs-orch.md
* DEC-017-bgs-orch-schema-segregation.md

---

## RJ-017

### date

2026-06-14

### type

architecture

### title

Signal Capture Specification v1 Drafted

### summary

Created the canonical object specification for Signal Capture as the interpretation layer that turns Production Outcomes into structured knowledge candidates.

### impact

BrainCoach now separates raw response facts from candidate meaning. Signal Capture can identify repeated phrases, objections, fear signals, offer signals, strong cases, interview candidates, resonance, dissonance, and phenomenon candidates without treating them as validated reality.

### related_assets

* braincoach-docs/07_automation/production_os/05_intelligence/signal_capture.md
* braincoach-docs/07_automation/production_os/04_execution/production_outcome.md
* braincoach-docs/07_automation/research_schema_v1_bgs_orch.md

### related_decisions

* DEC-016-bgs-database-boundary-core-vs-orch.md
* DEC-017-bgs-orch-schema-segregation.md

---

## RJ-018

### date

2026-06-14

### type

architecture

### title

Season Review Specification v1 Drafted

### summary

Created the canonical object specification for Season Review as the season-level object that consolidates Signal Captures into seasonal knowledge.

### impact

BrainCoach now has a formal review object that looks across the whole season, groups and compares captured candidates, strengthens or rejects them, and produces recommendations for Knowledge Update without treating review as an automatic database write or validated reality.

### related_assets

* braincoach-docs/07_automation/production_os/05_intelligence/season_review.md
* braincoach-docs/07_automation/production_os/05_intelligence/signal_capture.md
* braincoach-docs/07_automation/research_schema_v1_bgs_orch.md

### related_decisions

* DEC-016-bgs-database-boundary-core-vs-orch.md
* DEC-017-bgs-orch-schema-segregation.md

---

## RJ-019

### date

2026-06-14

### type

architecture

### title

Knowledge Update Specification v1 Drafted

### summary

Created the canonical object and governance specification for Knowledge Update as the process that turns accepted Season Review recommendations into explicit knowledge changes.

### impact

BrainCoach now has a formal boundary for moving from `bgs_orch` process memory toward Knowledge OS changes and possible `bgs_core` promotion. The spec defines updateable objects, creatable candidates, validation requirements, allowed draft automation, and actions that must never happen automatically.

### related_assets

* braincoach-docs/07_automation/production_os/05_intelligence/knowledge_update.md
* braincoach-docs/07_automation/production_os/05_intelligence/season_review.md
* braincoach-docs/07_automation/research_schema_v1_bgs_orch.md

### related_decisions

* DEC-016-bgs-database-boundary-core-vs-orch.md
* DEC-017-bgs-orch-schema-segregation.md

---

## RJ-020

### date

2026-06-14

### type

architecture

### title

Production OS Structure Normalization v1 Applied

### summary

Created Production OS Canon v1 and applied the normalization refactor that packages Production OS object specifications into a dedicated ordered documentation structure.

### impact

BrainCoach now has a readable top-level map for the full Production OS flow and canonical domain folders for research, marketing, content, execution, intelligence, and governance without confusing live registry updates with historical bootstrap seeds.

### related_assets

* braincoach-docs/07_automation/production_os/00_production_os_canon_v1.md
* braincoach-docs/07_automation/production_os/README.md
* braincoach-docs/07_automation/production_os/06_governance/production_os_structure_normalization_v1.md
* braincoach-docs/07_automation/research_schema_v1_bgs_orch.md

### related_decisions

* DEC-016-bgs-database-boundary-core-vs-orch.md
* DEC-017-bgs-orch-schema-segregation.md

---

## RJ-021

### date

2026-06-14

### type

architecture

### title

Daily Intelligence Report v1 Drafted

### summary

Created the draft Production OS specification for BrainCoach Daily Intelligence Report v1 as a daily operational intelligence artifact for system state, active signals, emerging patterns, product insights, bottlenecks, and next-day priorities.

### impact

BrainCoach now has a daily intelligence object between raw observations and weekly synthesis. The artifact helps convert accumulated observations and signal candidates into research direction, product insight, knowledge update candidates, and weekly rollup material without changing SQL, migrations, or production workflow.

### related_assets

* braincoach-docs/07_automation/production_os/05_intelligence/daily_intelligence_report_v1.md
* braincoach-docs/07_automation/production_os/05_intelligence/weekly_intelligence_report_v1.md
* braincoach-docs/07_automation/production_os/05_intelligence/signal_aggregation_layer_v1.md
* braincoach-docs/07_automation/production_os/00_production_os_canon_v1.md
* braincoach-docs/07_automation/production_os/README.md

### related_decisions

* DEC-016-bgs-database-boundary-core-vs-orch.md
* DEC-017-bgs-orch-schema-segregation.md

---

# journal_management

Основным владельцем журнала является:

```text
orch_repository_guardian
```

---

# journal_rules

Агент может предлагать новую запись.

Добавление записи выполняется только если изменение соответствует правилам журнала.

---

# future_automation

В будущем orch_repository_guardian автоматически:

* анализирует изменения GitHub
* обнаруживает milestone
* формирует draft записей
* предлагает обновление журнала

---

# related_documents

* repository_registry.txt
* agent_registry.md
* bgs_agent_map_v1.md
* bgs_memory_map_v1.md
* bgs_event_map_v1.md

---

# status_note

repository_journal является историей развития Brain Growth System.

Документ фиксирует не действия, а изменения, повлиявшие на эволюцию системы.
