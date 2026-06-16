## DEC-018 BrainCoach Compliance Gate v1

Date: 2026-06-16

Decision:

BrainCoach adopts Compliance Gate v1 as a mandatory development standard before creating any new product, bot, site, form, workflow, AI-agent, or data-collecting MVP.

Any new BrainCoach system that receives user data is treated as a user data processing system by default.

Before implementation and launch, the team must explicitly document:

- collected data types;
- user consent flow;
- physical and logical storage;
- use of PostgreSQL BGS Core or other storage;
- third-party services;
- external AI data transfer;
- anonymization or pseudonymization requirements;
- deletion or history anonymization procedure;
- rules for public materials.

Minimum MVP rule:

1. Privacy Policy exists.
2. Privacy Policy link is shown in the bot, site, form, or workflow entry point.
3. User gives consent before the first question or data collection step.
4. Consent fact is saved.
5. Data is anonymized before external AI by default.
6. Deletion or anonymization procedure is documented.

Launch is blocked if user data is collected without consent capture, Privacy Policy reference, or external AI anonymization review.

Status:

Accepted

Related:

* Compliance Gate v1
* DEC-008 BGS Data Architecture
* DEC-014 BGS Core MVP v1
* DEC-016 BGS Database Boundary: Core vs Orch

## DEC-017 BGS Orch Schema Segregation

Date: 2026-06-14

Decision:

New BrainCoach-owned objects in `bgs_orch` must be created in separate schemas, not in `public`.

Proposed schemas:

- `knowledge.*`
- `research.*`
- `production.*`
- `agent.*`

Boundary:

- `public` remains for n8n/runtime and legacy public tables.
- `knowledge.*` is for knowledge registry, knowledge events, and future knowledge process objects.
- `research.*` is for seasons, briefs, reviews, and research execution memory.
- `production.*` is for executions, outcomes, channel telemetry, and production process memory.
- `agent.*` is for runs, evaluations, prompt versions, and agent performance history.

Migration / Future Work:

Existing `knowledge_assets`, `knowledge_events`, and `repository_journal` remain in `public` for now.

Moving existing BrainCoach-owned public tables into `knowledge.*` requires a separate approved migration.

`research.seasons` must not be created until a separate schema migration is reviewed and approved.

Any future SQL must be draft-only until explicit approval.

Status:

Accepted

Related:

* DEC-013 Orchestration Runtime Strategy
* DEC-016 BGS Database Boundary: Core vs Orch
* BGS_ORCH_PUBLIC_TABLES_2026_06_14
* Research Schema v1 for bgs_orch

## DEC-016 BGS Database Boundary: Core vs Orch

Date: 2026-06-14

Decision:

BrainCoach keeps the current two-database architecture:

- `bgs_core` = human reality data
- `bgs_orch` = knowledge, research process, production telemetry

No new database is created at this stage.

Boundary:

`bgs_core` answers: what is happening with people?

`bgs_orch` answers: how BrainCoach collects, processes, analyzes and turns reality into knowledge.

Implementation:

Season Research OS / Production OS objects belong in `bgs_orch`, preferably under `knowledge.*`, `research.*`, `production.*`, and `agent.*` schemas.

Do not add season production telemetry, agent evaluation, or prompt-performance data to `bgs_core`.

Status:

Accepted

Related:

* DEC-008 BGS Data Architecture
* DEC-011 Source Of Truth Model
* DEC-013 Orchestration Runtime Strategy
* DEC-014 BGS Core MVP v1
* DEC-015 GPS Trajectory Research Placement

## DEC-015 GPS Trajectory Research Placement

Date: 2026-06-12

Decision:

GPS trajectory hypotheses are placed first in Research, with a draft Intelligence synthesis and draft Ontology Candidates staging file.

No Canon, Foundation, Phenomenon Registry, or accepted Registry update is approved.

Status:

Accepted

Related:

* GPS-HYP-001 Resonance vs Dissonance
* GPS-HYP-002 Desired State to Current State Gap
* GPS-HYP-003 Personal Boundaries as Trajectory Filter
* GPS-HYP-004 Unified Trajectory Model
* GPS-HYP-005 Fibonacci Lifecycle Hypothesis
* gps_trajectory_hypotheses_v1
* gps_trajectory_intelligence_v1
* gps_ontology_candidates_v1

   
## DEC-008 Workflow Naming Convention v1

Date: 2026-06-08

Decision

CMD_ → команды
TRK_ → трекер
REC_ → recent
LST_ → last
CNT_ → count
FND_ → find
INT_ → interview
VOI_ → voice
SEM_ → semantic search
TRAJ_ → trajectory engine

Status

Accepted

## DEC-005

Date: 2026-06-05

Decision:

Определить Self Learning Capability как центральный объект исследования BrainCoach.

BrainCoach больше не рассматривает память, внимание, концентрацию или подготовку к экзаменам как центральные объекты системы.

Данные объекты рассматриваются как механизмы или частные контексты применения.

Центральным объектом становится:

* Self Learning Capability

(способность человека самостоятельно осваивать новые знания и навыки без постоянного внешнего управления)

Reason:

Анализ кейсов BrainCoach показал повторяющийся результат в различных доменах:

* образование
* спорт
* нейрообучение
* развитие личности

Несмотря на различие контекстов, успешные кейсы демонстрируют общий паттерн:

переход от внешнего управления к самостоятельному освоению новых задач.

Следовательно Self Learning Capability является более фундаментальным объектом, чем память, внимание, концентрация или экзаменационная подготовка.

Status:

Accepted

Related:

* SELF_LEARNING_CAPABILITY
* CASE_REGISTRY
* RESEARCH_SELF_LEARNING
* PHENOMENON_REGISTRY

## DEC-004

    Date: 2026-06-04

    Decision:

    Принят переход от Single Object Classification к Multi-Object Impact Analysis.

    Knowledge Events больше не рассматриваются как изменения одного объекта знаний.

    Один Knowledge Event может затрагивать несколько Knowledge Objects одновременно.

    Новая модель:

    * knowledge_objects[]

    Вместо:

    * object_type

    Reason:

    Анализ реальных GitHub Push Events показал, что один коммит часто затрагивает несколько доменов BrainCoach Knowledge OS одновременно.

    Пример:

    * Version Registry
    * Ontology
    * Knowledge Layer

    Текущая модель Single Object Classification теряет часть контекста изменений.

    Status:

    Accepted

    Related:

    * Knowledge Event Classification Pipeline
    * Knowledge Object Ontology v1
    * PostgreSQL Data Model v1


## DEC-003

    Title:
    Transition from Thesis-First to Phenomenon-First Content

    Reason:
    Research and early performance data suggest that contradiction creates stronger curiosity than conclusions.

    Impact:
    All future hooks must begin with observation and contradiction before explanation.

    Status:
    Accepted

## DEC-002

    Date: 2026-06-03

    Decision:
    Принята архитектура BrainCoach Knowledge OS v1.0

    Components:

    * Knowledge Layer
    * Research Operations Layer
    * Governance Layer
    * User Memory Layer
    * Infrastructure Layer

    Governance Structure:

    * ADR
    * Decision Log
    * Version Registry
    * Future Candidates

    Reason:
    После формирования Canon Stack возникла необходимость зафиксировать единую операционную архитектуру системы и прекратить неконтролируемое добавление новых сущностей, папок и архитектурных концепций.

    Status:
    Accepted

    Related:

    * ADR-001
    * BrainCoach Knowledge OS v1.0


## DEC-001

    Date: 2026-06-03

    Decision:
    Создан минимальный BrainCoach Canon Stack.

    Components:
    - Canon v1.0
    - Ontology v1.0
    - Phenomenon Registry v1.0
    - Season Registry v1.0

    Reason:
    Необходим единый Source of Truth перед развитием RAG, PostgreSQL и агентной архитектуры.

    Status:
    Accepted

    ---

