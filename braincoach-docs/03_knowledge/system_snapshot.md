# BRAINCOACH SYSTEM SNAPSHOT

Date: 2026-06-13

Status: Active Reference

---

# Practice Loop

Status:

Active Practice

Decision:

DEC-025 Practice Loop

Artifact:

`braincoach-docs/05_operations/14_workflows/practice_loop_v1.md`

BrainCoach foundation stack is now used as a daily and weekly practice loop for founder self-tracking, client tracking, marketing, offer discovery, product decisions, and agent reasoning.

Core loop:

```text
Raw tracker idea / observation
->
DOTU control frame
->
Current reality and goal vector
->
TOC constraint
->
TRIZ contradiction
->
Logic discipline
->
Adaptation / radical lens
->
Decision or experiment
->
Action
->
Feedback from reality
->
Updated model
```

Operational short form:

```text
Observe
->
Interpret
->
Choose
->
Act
->
Measure
->
Correct
```

Tracker entries are intake material for this self-correcting loop, not only saved notes.

Council Mode:

Tracker also acts as external working memory and practical method support.

It applies preserved source methods to current reality:

* DOTU for control and feedback;
* Goldratt / TOC for constraint and choice;
* Altshuller / TRIZ for contradiction and stronger solution;
* Lobanov / Russian Logic for valid reasoning and indeterminate states;
* DOTU / Sociology for human and social layers;
* adaptation patterns / radicals for support strategy.

The goal is not author imitation.

The goal is method application to the founder's and clients' current reality.

Adaptation patterns / radicals are diagnostic lenses, not identity labels.

Logic states remain ternary:

```text
validated
contradicted
indeterminate
```

# Weekly Sprint

Status:

Working Specification

Decision:

DEC-026 Weekly Sprint

Artifact:

`braincoach-docs/05_operations/14_workflows/weekly_sprint_v1.md`

Weekly Sprint turns tracker notes, habits, study blocks, content work, client work, events, preparation, reminders, and free windows into a weekly control loop.

Core loop:

```text
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
```

Weekly Sprint can include personal routines, breathing exercises, son's study blocks, content production, delayed posting, masterclass preparation, recovery windows, and weekly review.

No actual reminder automation has been created yet.

# Current Production System

BrainCoach GPS MVP-1 — bgs_core adapted

Telegram
→ Tracker Entry
→ Observation
→ Signal Candidate
→ PostgreSQL

Operational Components:

| Component | Status |
| --- | --- |
| Telegram Tracker | Operational |
| PostgreSQL | Connected |
| n8n (BrainCoach GPS MVP-1 — bgs_core adapted) | Production |
| Observation Layer | Operational |
| Signal Extraction Layer | Operational |
| research_signal_candidates | Receiving live data |

First Validated Signal Categories:

* self_initiation
* dependence_external

---

# Knowledge Registry Sync

Status:

Active Sync Workflow

Artifact:

`braincoach-docs/07_automation/03_n8n/knowledge_registry_sync_v1.md`

Workflow JSON:

`braincoach-docs/07_automation/03_n8n/knowledge_registry_sync_v1.json`

Current flow:

```text
GitHub Trigger
->
Knowledge Event Parser
->
Knowledge Event Store
->
Extract Assets
->
Knowledge Asset Store
```

Agent reliance rule:

Agents may rely on prepared repository documents after the relevant commit is pushed, `knowledge_registry_sync_v1` executes successfully, and the relevant source paths are registered or updated in `knowledge_assets`.

Unsynced local changes remain candidate context, not synced operational knowledge.

Successful n8n executions are operational evidence that pushed repository updates can become available to the Knowledge Registry.

Agents still need retrieval, prompt routing, or explicit context loading to use the relevant asset content during a task.

---

# Current Knowledge OS Structure

00_canon

01_foundation

02_ontology

03_knowledge

 01_research

 02_intelligence

 03_registries

 04_decisions

04_domain

 01_marketing

 02_education

 03_community

 04_products

05_operations

 planning

 priorities

 reviews

06_analytics

07_automation

---

# Knowledge Registry Status

Stage:

Stage 3 Completed

Registry Status:

Operational

Synchronization:

GitHub → PostgreSQL

Registry Mode:

Full Repository Registry

Current Registry Coverage:

104 active knowledge objects

104 unique object paths

Repository Coverage:

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

Result:

knowledge_assets is the authoritative registry of BrainCoach Knowledge Objects.

---

# Major Discovery

Discovery Sprint 2026-06 identified a new central object for BrainCoach.

Previous Focus:

* Memory
* Attention
* Concentration
* Exam Preparation

Current Focus:

SELF_LEARNING_CAPABILITY

Positioning Update 2026-06-16:

BrainCoach now uses Trajectory Intelligence System as the top-level category.

Self Learning Capability remains a key mechanism-level object, not the top-level market category.

---

# Thinking OS Practice

Status:

Active Practice

Decision:

DEC-020 Thinking OS As Practice

Practice Artifact:

`braincoach-docs/01_foundation/braincoach_thinking_os_practice_v1.md`

Core Rule:

BrainCoach Thinking OS is not a theory collection.

It is the required practice for serious analysis and decisions.

Minimum chain:

DOTU Control Frame

в†“

Sociological Context

в†“

Constraint Detection

в†“

Contradiction Detection

в†“

Demand / Payment Trigger

в†“

Signal / Phenomenon

в†“

Decision

в†“

Feedback

Operational rule:

No random thinking.

No theory for decoration.

No framework without decision.

---

# DOTU And Sociology Foundation Intake

Status:

Active Foundation Intake

Decision:

DEC-021 DOTU And Sociology Foundation Intake

Artifact:

`braincoach-docs/01_foundation/dotu_sociology_foundation_intake_v1.md`

Boundary:

Canon remains unchanged.

Source concepts move top-down:

Foundation

в†“

Ontology Candidates

в†“

Knowledge / Intelligence Objects

в†“

Signal and Phenomenon Mapping

в†“

Domain Models

в†“

Marketing Translation

в†“

Operations / GPS / Survey / Offer

Core rule:

The model is not the world.

The model is a map with a measure of approximation.

Terms describe processes, layers, regimes, and mechanisms.

Terms must not become labels for people.

---

# Goldratt Choice Practice

Status:

Active Practice

Decision:

DEC-022 Goldratt Choice Practice

Artifact:

`braincoach-docs/01_foundation/goldratt_choice_practice_v1.md`

Core rule:

Choice is not preference selection.

Choice is disciplined reasoning under constraint.

Minimum chain:

Goal

в†“

Current reality

в†“

Constraint

в†“

Conflict / contradiction

в†“

Assumptions

в†“

Invalid assumption

в†“

Better option

в†“

Reality feedback

Agent requirement:

Every choice recommendation must state expected signal, feedback window, and correction rule.

---

# TRIZ Contradiction Practice

Status:

Active Practice

Decision:

DEC-023 TRIZ Contradiction Practice

Artifact:

`braincoach-docs/01_foundation/triz_contradiction_practice_v1.md`

Domain Guide:

`braincoach-docs/04_domain/triz_guide.md`

Core rule:

A contradiction is a high-value signal.

It is a signal of unresolved design, not a reason to choose a weak compromise.

Minimum chain:

Desired improvement

в†“

Worsening effect

в†“

Contradiction

в†“

Resources

в†“

Separation

в†“

Inventive option

в†“

Reality feedback

---

# Logic Discipline Practice

Status:

Active Practice

Decision:

DEC-024 Logic Discipline Practice

Artifact:

`braincoach-docs/01_foundation/logic_discipline_practice_v1.md`

Core rule:

No conclusion without valid reasoning.

No inference without premises.

No premise without meaning.

No meaning without boundaries.

No claim stronger than its logical support.

Agent requirement:

Every serious output must check term meaning, premise, quantifier / scope, inference, conclusion, contradiction, and reality feedback.

Working basis:

Russian Logic is the primary working foundation candidate for formal reasoning, syllogistic analysis, quantifier discipline, and ternary treatment of unresolved states.

Ternary states:

* true / validated
* false / contradicted
* unknown / candidate / indeterminate

Claim labels:

* observed fact
* source statement
* interpretation
* inference
* hypothesis
* validated knowledge
* market signal
* decision

---

# Core Object

SELF_LEARNING_CAPABILITY

Definition:

Ability to independently acquire new knowledge, skills, and competencies without constant external management.

Core Question:

Can a person encounter a new problem and organize learning independently?

---

# Current Positioning Hierarchy

Category:

Trajectory Intelligence System

Research Object:

Trajectory Development

Mechanism Layer:

Learning Intelligence

Sub-object:

Self Learning Capability

---

# Accepted Decision

DEC-005

Self Learning Capability is defined as the central research object of BrainCoach.

Consequences:

Research

Intelligence

Cases

Phenomena

Marketing

Offers

must be linked to Self Learning Capability.

---

# Foundation Principles

P0. Systems Are Changeable

P1. Systems Over Objects

P2. Learning As Reconfiguration

P3. Self Learning As The Highest Outcome

P4. Constraints Before Symptoms

P5. Observation Before Explanation

P6. Reality Before Opinion

P7. Transfer Over Performance

P8. Means Shape Outcomes

P9. Direction Matters

Intellectual Roots:

* Mathematics
* Set Theory
* Logic
* Theory of Constraints
* Neuroplasticity
* BrainCoach Practice

---

# Research Layer

Research Object:

TRAJECTORY_DEVELOPMENT

Mechanism Layer:

LEARNING_INTELLIGENCE

Sub-object:

SELF_LEARNING_CAPABILITY

Current Research Question:

Why do children with similar opportunities achieve different outcomes?

Research Assets:

* Observations
* Hypotheses
* Mechanisms
* Longitudinal Cases

Current Operational Objects:

* tracker_entries
* observations
* research_signal_candidates

---

# Intelligence Layer

Knowledge Object:

SELF_LEARNING_CAPABILITY

Current Status:

Critical

Candidate for central Knowledge Graph object.

---

# Registry Layer

Key Registries:

* case_registry
* phenomenon_registry
* experiment_registry
* outcome_registry
* season_registry
* signal_registry
* signal_dictionary

---

# Marketing Positioning

Category:

Trajectory Intelligence System

Who We Serve:

Families pursuing competitive educational and athletic trajectories.

Core Market Question:

We invested so much.

Why didn't it work?

Main Transformation

From:

Families discover too late that opportunity did not become results

To:

Families see the signals, risks, and trajectory patterns long before final results appear

---

# Content Pillars

1. Independence

2. Self Learning

3. Not Feeling Academic Load

4. Potential → Results

5. Brain Learning Mechanisms

---

# Strategic Rule

Knowledge

↓

Domain

↓

Operations

↓

Analytics

↓

Automation

Automation serves Knowledge.

Knowledge does not serve Automation.

---

# Architecture Status

Knowledge OS

Status:

Operational

---

Research OS

Status:

Operational (intake path)

Core Flow:

Reality

↓

Observation

↓

Signal Candidate

↓

Signal

↓

Phenomenon

↓

Research

↓

Model

Current implementation covers:

Reality → Observation → Signal Candidate

---

Production OS

Status:

Architected (Canon v1)

Location:

07_automation/production_os/

Current Scope:

Research Season
↓
Research Brief
↓
Marketing Brief
↓
Content Plan
↓
Production Execution
↓
Production Outcome
↓
Signal Capture
↓
Season Review
↓
Knowledge Update

Implementation Status:

Documentation and architecture complete.

No schemas created.

No tables created.

No SQL approved.

Purpose:

Transform market interaction into knowledge candidates and knowledge updates.

---

Content Factory

Status:

Operational

Modules:

01 Intake

02 Extraction

03 Asset Design

04 Generation

05 Feedback

---

Automation Architecture

Status:

Operational

Documents:

01 Knowledge Objects

02 Object Relationships

03 Object States

04 PostgreSQL Mapping

05 Domain Architecture

06 Storage Architecture

07 Domain Interfaces

08 Agent Architecture

---

BrainCoach GPS OS

Version: MVP-1 bgs_core adapted

Status: Production

Export:

BrainCoach GPS MVP-1 — bgs_core adapted.json

Supersedes:

BrainCoach GPS OS — Stage 3 Complete.json

Capabilities:

* Voice Intake
* Tracker
* Observation Layer
* Signal Extraction Layer
* Recent / Last / Count / Find
* Decisions
* Interview Engine

---

# Storage Architecture

GitHub

↓

Knowledge Source

PostgreSQL

↓

Knowledge Registry

↓

Research Intake

↓

Operations

pgvector

↓

Retrieval (planned)

n8n

↓

Orchestration

Vertex AI

↓

Reasoning (migration planned — Stage 4)

---

# BGS Database Boundary

Decision:

DEC-016 BGS Database Boundary: Core vs Orch

Status:

Accepted

Current boundary:

* `bgs_core` = human reality data
* `bgs_orch` = knowledge, research process, production telemetry

No new database is created at this stage.

Rule:

* `bgs_core` answers: what is happening with people?
* `bgs_orch` answers: how BrainCoach collects, processes, analyzes and turns reality into knowledge.

Season Research OS / Production OS objects belong in `bgs_orch`, preferably under `knowledge.*`, `research.*`, `production.*`, and `agent.*` schemas.

Do not add season production telemetry, agent evaluation, or prompt-performance data to `bgs_core`.

---

# BGS Orch Schema Governance

Decision:

DEC-017 BGS Orch Schema Segregation

Status:

Accepted

Purpose:

Prevent BrainCoach-owned objects from being mixed with n8n/runtime tables inside bgs_orch.public.

Approved schema families:

* knowledge.*
* research.*
* production.*
* agent.*

Current state:

Existing BrainCoach-owned tables remain in public until separate approved migration.

No schema creation approved yet.

No table migration approved yet.

First candidate implementation scope:

* research.seasons
* research.briefs
* production.executions
* production.outcomes
* research.reviews

# Evolution Status

Stage 1

Knowledge Registry Foundation

Completed

↓

Stage 2

Full Repository Registry

Completed

↓

Stage 3

Observation & Signal Extraction Pipeline

Completed

↓

Stage 4

Analytics & Intelligence Layer

In Progress

Completed:

* Production OS Canon v1
* Research Season model
* Research Brief model
* Marketing Brief model
* Content Plan model
* Production Execution model
* Production Outcome model
* Signal Capture model
* Season Review model
* Knowledge Update model
* Production OS Alignment Review
* Production OS Audit Closure
* Candidate Promotion Governance v1
* Signal Aggregation Layer v1
* Weekly Intelligence Report v1

Pending:

* Pattern Detection
* Analytics Layer
* Knowledge Graph
* Physical schema implementation

---

# Current Production Bottleneck

Resolved:

* Knowledge Architecture
* Research Architecture
* Automation Architecture
* Repository Registry
* Research Intake Pipeline (Tracker → Observation → Signal Candidate)
* BGS Database Boundary (DEC-016)
* BGS Orch Schema Governance (DEC-017)
* Production OS Canon v1
* Production OS Object Model
* Production OS Alignment Review
* Production OS Audit Closure
* Candidate Promotion Governance v1
* Signal Aggregation Layer v1
* Weekly Intelligence Report v1

Current Constraints:

* Signal taxonomy immaturity (classification noise)
* No signal aggregation implementation yet
* No pattern detection implementation
* No analytics layer over accumulated signals
* No weekly intelligence reporting implementation yet
* Knowledge graph and relationship layer not yet built
* Production OS physical implementation not yet started
* LLM provider fragmentation (Vertex AI migration pending)
* Offer Discovery maturation
* Content Factory Optimization
* Content → Consultation Pipeline
* Consultation → Revenue Pipeline

---

# Current Strategic Objective

Transform accumulated signal candidates into actionable intelligence.

Signal Candidate

↓

Aggregation

↓

Pattern Detection

↓

Weekly Report

↓

Research Direction

↓

Knowledge Asset

Objective:

Validate that BrainCoach can continuously transform captured reality into structured signals, detect patterns across time, and produce research intelligence that drives knowledge production.

Architecture Closure:

Signal Candidate

↓

Candidate Promotion Governance

↓

Signal Aggregation Layer

↓

Weekly Intelligence Report

↓

Season Review

↓

Knowledge Update

↓

Knowledge Asset

---

# Current Strategic Question

How do we transform accumulated signal data into repeatable research insights and a parent-facing offer?
