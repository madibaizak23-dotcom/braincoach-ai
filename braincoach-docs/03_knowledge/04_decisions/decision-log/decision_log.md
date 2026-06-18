## DEC-035 Weekly Production Cycle Freeze

Date: 2026-06-18

Decision:

After a weekly content seed is installed, BrainCoach freezes the weekly structure until the end of that production cycle.

Frozen objects:

Weekly Strategy Brief, main conversation, main tension, main question, Channel Matrix, publishing scheduler hypothesis, `content_plan`, and `content_units`.

Allowed changes:

Only `generated_content_assets`, texts, scripts, visual briefs, CTA wording, and production notes may change during the live week.

Reason:

BrainCoach has moved from manual content planning to a production pipeline:

Weekly Strategy Brief -> content_plan -> content_units -> generated_content_assets -> review -> publishing -> signal_capture -> knowledge_update.

The first live week must collect signals under stable conditions instead of constantly improving the structure before it is tested.

Status:

Accepted

Related:

* Weekly Content Generation MVP-1
* Weekly Content Automation Build Order
* Cascading Content Generation
* Weekly Content Plan Seed 2026-06-22

## DEC-034 Cascading Content Generation

Date: 2026-06-18

Decision:

BrainCoach adopts Cascading Content Generation as the required process for weekly multi-channel content production.

Agents must not generate all reels, stories, posts, and adaptations in one flat pass.

Required flow:

Week Intelligence -> Weekly Strategy -> Daily Map -> Channel Matrix -> Asset Generation -> Consistency QA -> Human Approval.

Status:

Accepted

Related:

* Cascading Content Generation Protocol v1
* Weekly Content Generation MVP-1
* Weekly Content Automation MVP-1 Build Plan
* Marketing Agent Sync Protocol v1

## DEC-033 Weekly Content Automation Build Order

Date: 2026-06-18

Decision:

BrainCoach will build Weekly Content Automation MVP-1 through Postgres production memory, n8n weekly package generation, Telegram weekly review, daily publishing monitor, execution / outcome capture, Tracker monitoring, and weekly correction report.

SQL remains draft-only until explicit migration approval.

Status:

Accepted

Related:

* Weekly Content Automation MVP-1 Build Plan
* Draft Weekly Content Automation MVP-1 SQL
* Weekly Content Generation MVP-1
* Marketing & Sales Automation MVP-1

## DEC-032 Weekly Content Generation MVP-1

Date: 2026-06-18

Decision:

BrainCoach proceeds to Weekly Content Generation MVP-1.

The MVP transforms one approved weekly strategy into a multi-channel production package with reels, stories, Threads, Facebook, Telegram, publishing windows, KPI, CTA, visual brief, and signal capture plan.

Status:

Accepted

Related:

* Weekly Content Generation MVP-1
* Content Factory v2.0
* Generation Module v1.0
* Publishing Scheduler Hypothesis v1
* Marketing & Sales Automation MVP-1

## DEC-031 Marketing & Sales Automation MVP-1

Date: 2026-06-18

Decision:

BrainCoach proceeds to the first Marketing & Sales Automation MVP.

MVP-1 starts with intelligence and routing, not blind publishing or automatic replies.

Core loop:

content response -> signal classification -> noise filtering -> payment trigger / lead candidate detection -> Telegram operator decision -> manual follow-up -> sales discovery outcome -> weekly correction.

Status:

Accepted

Related:

* Marketing & Sales Automation MVP-1
* Instagram Intelligence Inbox MVP-1.5
* Instagram Social Automation MVP-2 Plan
* Offer Discovery v1
* Automation Objective Control Principle v1

## DEC-030 Automation As Objective Control System

Date: 2026-06-18

Decision:

BrainCoach adopts Automation as Objective Control System as the governing principle for its automation complex.

The goal of automation is not to produce more content, tasks, reports, or agent outputs.

The goal is to build an information system that objectively reflects current reality and helps move the system toward defined goals through feedback, correction, and improved control.

Core formula:

Goal -> current reality -> observable data -> interpretation -> constraint -> contradiction -> decision -> action -> measurement -> correction -> movement toward goal.

Status:

Accepted

Related:

* Automation Objective Control Principle v1
* BrainCoach Thinking OS Practice v1
* Operational Philosophy v2.0
* Practice Loop v1
* DEC-020 Thinking OS As Practice

## DEC-029 Publishing Scheduler Hypothesis

Date: 2026-06-18

Decision:

BrainCoach adopts Publishing Scheduler Hypothesis as the planning layer for channel timing.

External advice about best posting times may be used only as a candidate hypothesis.

The scheduler must compare planned windows, actual publish times, and production outcomes before adapting.

Publishing automation must start with reminders, approval cards, execution recording, and analytics feedback before any autopublishing.

Weekly Content Plan is treated as a weekly hypothesis test: plan with time, publish, measure, correct, and reinforce repeated working windows.

Status:

Accepted

Related:

* Publishing Scheduler Hypothesis v1
* Instagram Analytics MVP-1
* Instagram Social Automation MVP-2 Plan
* Weekly Sprint v1
* Production Execution Specification v1

## DEC-028 Marketing Intelligence Agent Sync

Date: 2026-06-18

Decision:

BrainCoach adopts a Marketing Intelligence Agent Sync protocol.

Perplexity research, founder conversations, market observations, content plans, production outcomes, and signal logs must move through the Knowledge OS before agents treat them as shared operational knowledge.

The repository commit is the knowledge release boundary.

After commit, push, and successful `knowledge_registry_sync_v1`, bots and agents may use committed artifacts as shared context if they can trace the claim to a repository source path.

Status:

Accepted

Related:

* Marketing Agent Sync Protocol v1
* Knowledge Registry Sync v1
* Agent Architecture v1.0
* Production OS Canon v1
* DEC-027 Production Visual Framing Layer

## DEC-027 Production Visual Framing Layer

Date: 2026-06-18

Decision:

BrainCoach adopts Navigation Universe as the master visual framing layer above existing Visual OS worlds.

Navigation Universe becomes the umbrella layer for visual coherence.

Existing visual worlds remain active.

Core meaning:

BrainCoach is a Human Development Navigation System.

Most content units should include at least one navigation recognition element:

* route
* path
* trajectory line
* checkpoint
* signal
* navigation marker
* direction arrow
* map
* coordinates
* dashboard
* tracker
* progress path

Status:

Accepted

Related:

* Visual Meaning System v1
* Visual World Principle v1.0

## DEC-026 Weekly Sprint

Date: 2026-06-18

Decision:

BrainCoach adopts Weekly Sprint as the planning layer that turns tracker notes, habits, study blocks, content work, client work, events, preparation, reminders, and free windows into a weekly control loop.

Weekly Sprint is not a task list.

It is a control loop:

Goal

->

Week structure

->

Time blocks

->

Load check

->

Reminders

->

Execution feedback

->

Correction

Status:

Accepted

Related:

* Weekly Sprint v1
* Practice Loop v1
* tracker_capture_v1

## DEC-025 Practice Loop

Date: 2026-06-18

Decision:

BrainCoach adopts Practice Loop as the operational use of its foundation stack for founder self-tracking, client tracking, marketing, offer discovery, product decisions, and agent reasoning.

The loop connects tracker input to DOTU, TOC, TRIZ, Logic Discipline, adaptation patterns / radicals, decision, action, and feedback.

Core loop:

Observation

->

Interpretation

->

Choice

->

Action

->

Measurement

->

Correction

Tracker entries are no longer treated only as saved notes or raw signal candidates.

They become intake material for a self-correcting practice loop.

Status:

Accepted

Related:

* Practice Loop v1
* DEC-020 Thinking OS As Practice
* DEC-021 DOTU And Sociology Foundation Intake
* DEC-022 Goldratt Choice Practice
* DEC-023 TRIZ Contradiction Practice
* DEC-024 Logic Discipline Practice

## DEC-024 Logic Discipline Practice

Date: 2026-06-18

Decision:

BrainCoach adopts Logic Discipline Practice as an active foundation practice for humans and agents.

Core rule:

No conclusion without valid reasoning.

No inference without premises.

No premise without meaning.

No meaning without boundaries.

No claim stronger than its logical support.

Agents must check term meaning, statement, premise, quantifier / scope, inference, conclusion, contradiction, and reality feedback.

Status:

Accepted

Related:

* Logic Discipline Practice v1
* DEC-020 Thinking OS As Practice
* DEC-022 Goldratt Choice Practice
* DEC-023 TRIZ Contradiction Practice

## DEC-023 TRIZ Contradiction Practice

Date: 2026-06-18

Decision:

BrainCoach adopts TRIZ Contradiction Practice as an active foundation practice.

A contradiction is a high-value signal.

It should be treated as:

signal of unresolved design

not reason to choose a weak compromise

Agents working with contradictions must state desired improvement, worsening effect, contradiction, system level, available resources, possible separation, inventive option, expected signal, feedback window, and correction rule.

Status:

Accepted

Related:

* TRIZ Contradiction Practice v1
* DEC-020 Thinking OS As Practice
* DEC-022 Goldratt Choice Practice

## DEC-022 Goldratt Choice Practice

Date: 2026-06-18

Decision:

BrainCoach adopts Goldratt Choice Practice as an active foundation practice for humans and agents.

Choice is not preference selection.

Choice is disciplined reasoning under constraint:

Goal

↓

Current reality

↓

Constraint

↓

Conflict / contradiction

↓

Assumptions

↓

Invalid assumption

↓

Better option

↓

Reality feedback

Agents must define goal, current reality, constraint, visible options, conflict, assumptions, most testable assumption, proposed choice, expected signal, feedback window, and correction rule.

Status:

Accepted

Related:

* Goldratt Choice Practice v1
* DEC-020 Thinking OS As Practice
* DEC-021 DOTU And Sociology Foundation Intake

## DEC-021 DOTU And Sociology Foundation Intake

Date: 2026-06-18

Decision:

BrainCoach adopts a top-down source intake process for DOTU and Sociology.

Canon remains unchanged.

Source concepts first enter Foundation, then may become Ontology Candidates, then Knowledge / Intelligence Objects, then Signal and Phenomenon mappings, then Domain Models, then Marketing Translation, then Operations / GPS / Survey / Offer use.

Core rule:

The model is not the world.

The model is a map with a measure of approximation.

Terms describe processes, layers, regimes, and mechanisms.

Terms must not become labels for people.

Initial concept areas:

* measure / мера
* control / управление
* full function of control / полная функция управления
* psyche / психика
* psyche structure / строй психики
* biological automatic layer
* fight / flight and automatic defensive reactions
* herd-pack behavior / стадно-стайное поведение
* culture / культура
* society / общество
* humaneness / человечность
* conscience / совесть
* morality / нравственность
* crowd-elitism / толпо-элитаризм
* social control and social inheritance

Status:

Accepted

Related:

* DOTU And Sociology Foundation Intake v1
* DEC-020 Thinking OS As Practice
* BrainCoach Ontology v1.0

## DEC-020 Thinking OS As Practice

Date: 2026-06-18

Decision:

BrainCoach adopts Thinking OS as an active practice for serious analysis, strategic decisions, offer discovery, payment trigger discovery, GPS positioning, production system design, content-to-offer work, AI-agent reasoning, and system reviews.

Practice rule:

No random thinking.

No theory for decoration.

No framework without decision.

Every serious analysis should follow:

DOTU Control Frame

↓

Sociological Context

↓

Constraint Detection

↓

Contradiction Detection

↓

Demand / Payment Trigger

↓

Signal / Phenomenon

↓

Decision

↓

Feedback

Status:

Accepted

Related:

* BrainCoach Thinking OS Practice v1
* DEC-019 Payment Trigger Discovery Priority
* Operational Philosophy v2.0

## DEC-019 Payment Trigger Discovery Priority

Date: 2026-06-18

Decision:

BrainCoach adopts Payment Trigger Discovery as the immediate priority for the next Offer Discovery cycle.

The active commercial constraint is:

Phenomenon

↓

Payment Trigger

↓

Offer

The Wednesday masterclass should be used as cold-audience Offer Discovery, with a target of 10-15 high-quality payment stories.

Offer Discovery must focus on what parents already bought, what failed, what cost meaningful money, what became the last straw, and what transformation they wanted to see earlier.

Summer Map should evolve toward a universal BrainCoach Discovery Engine with multiple templates, Russian / Kazakh language support, PostgreSQL-loaded questions, and answer classification as market, offer, and phenomenon signals.

GPS should be positioned as early visibility into whether trajectory investment converts into real progress, not only as a tracker.

Clarification SJ-2026-06-18-002:

Self Learning Capability is not the buyable result. It is the mechanism that helps produce the buyable result.

Current buyable-result hypothesis:

trajectory stability without constant external management.

Status:

Accepted

Related:

* DEC-007 Offer Discovery Layer
* Market Discovery v1
* Offer Discovery v1
* Strategy Journal 2026-06-18 Payment Trigger

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

