# BRAINCOACH SYSTEM SNAPSHOT

Date: 2026-06-13

Status: Active Reference

---

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

---

# Core Object

SELF_LEARNING_CAPABILITY

Definition:

Ability to independently acquire new knowledge, skills, and competencies without constant external management.

Core Question:

Can a person encounter a new problem and organize learning independently?

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

RESEARCH_SELF_LEARNING

Current Research Question:

How does Self Learning Capability emerge and develop?

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

Main Transformation

From:

Child learns only under supervision

To:

Child independently masters complex knowledge and skills

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
