# BrainCoach Tooling Playbook v1

## Purpose

This document defines the operational roles of AI tools used in the BrainCoach ecosystem.

The goal is not to use one AI for everything.
The goal is to build a coordinated intelligence stack where each tool operates within its strongest domain.

## Core Principle

Research -> Architecture -> Implementation -> Validation -> Knowledge Capture

## Tool Hierarchy

### Layer 1 — Web Intelligence

#### Comet
**Role:**  
AI Browser Operating Environment

**Purpose:**  
Continuous interaction with the open web.

**Responsibilities:**
- research sessions
- multi-tab investigations
- source collection
- competitor monitoring
- trend discovery
- web-based workflows

**Important Principle:**  
Comet is optimized for discovery.

Comet is not the final repository of knowledge.

Important findings must be transferred to:
- documentation
- architecture artifacts
- project journal

**Rule:**  
Do not let important knowledge remain only in the browser.
Capture it before ending the research session.

#### Spaces
**Purpose:**  
Project-level separation.

**Examples:**
- BrainCoach Core
- BrainCoach Content Intelligence
- BrainCoach Research Lab
- Insurance Systems

**Rule:**  
One strategic initiative per Space.

#### Profiles
**Purpose:**  
Context isolation.

**Examples:**
- Architect
- Researcher
- Content Strategist
- Insurance Business

**Rule:**  
Never mix unrelated workstreams inside a single profile.

### Layer 2 — Research Intelligence

#### Perplexity
**Role:**  
Research Intelligence Layer

**Purpose:**  
Understand what is already known.

**Responsibilities:**
- market research
- competitor analysis
- technology comparisons
- API research
- best practices
- industry intelligence

**Core Question:**  
"What does the world already know about this problem?"

**Outputs:**
- research summaries
- technology comparisons
- implementation references
- market insights

### Layer 3 — Alternative Intelligence

#### Antigravity
**Role:**  
Alternative Intelligence Layer

**Purpose:**  
Generate non-obvious solutions.

**Responsibilities:**
- systems thinking
- memetics
- social dynamics
- alternative architectures
- unconventional strategies
- cognitive models

**Core Question:**  
"What are the less obvious ways to solve this problem?"

**Outputs:**
- conceptual models
- strategic alternatives
- system-level perspectives

### Layer 4 — Architecture Intelligence

#### ChatGPT
**Role:**  
Architectural and Product Headquarters

**Purpose:**  
Transform research into coherent systems.

**Responsibilities:**
- data architecture
- system architecture
- customer intelligence
- RAG architecture
- memory architecture
- analytics architecture
- content systems
- marketing systems

**Core Question:**  
"How should the system be designed?"

**Outputs:**
- architecture documents
- operating models
- workflows
- roadmaps
- strategic decisions

### Layer 5 — Implementation Intelligence

#### Codex
**Role:**  
AI Software Engineer

**Purpose:**  
Convert architecture into working systems.

**Responsibilities:**
- repository analysis
- code generation
- refactoring
- technical audits
- implementation planning
- code maintenance

**Core Question:**  
"How should this be built?"

**Outputs:**
- code
- modules
- technical improvements
- implementation plans

**Primary Context:**  
braincoach-ai repository

### Layer 6 — Source of Truth

#### VS Code
**Role:**  
Knowledge and Development Workspace

**Purpose:**  
Permanent project memory and execution center.

**Stores:**
- source code
- workflows
- architecture
- documentation
- project journal
- decision records
- Git history

**Rule:**  
All important decisions must eventually be documented or committed through VS Code.

VS Code is the operational center of BrainCoach.

### Layer 7 — Operational Data Layer

#### PostgreSQL
**Role:**  
Operational Memory and Intelligence Store

**Purpose:**  
Persistent storage of:

- clients
- events
- memory
- analytics
- content signals

**Rule:**  
Operational truth lives in PostgreSQL.

Documentation truth lives in versioned project artifacts in VS Code.

Knowledge truth lives in architecture documents and decision records.

## Validation

Validation includes review, testing, verification, and rollback decisions.

## Decision Flow

Comet  
↓  
Web Intelligence  
Perplexity  
↓  
Research Intelligence  
Antigravity  
↓  
Alternative Intelligence  
ChatGPT  
↓  
Architecture Intelligence  
Codex  
↓  
Implementation Intelligence  
VS Code  
↓  
Knowledge Capture and Source of Truth  
PostgreSQL  
↓  
Operational Data Layer

## BrainCoach Development Principle

Do not start with implementation.

Follow this sequence:
- Research
- Alternative Perspectives
- Architecture
- Implementation
- Validation
- Documentation
- Scaling

## Tool Selection Matrix

- Need market research? -> Perplexity
- Need alternative strategic thinking? -> Antigravity
- Need architecture? -> ChatGPT
- Need code or repository work? -> Codex
- Need project execution and storage? -> VS Code
- Need open-web investigation? -> Comet
- Need persistent operational data? -> PostgreSQL

## Rules of Use

- Choose the smallest tool that can solve the task well.
- Do not use one tool outside its strongest domain unless necessary.
- Do not treat chat output as source of truth until it is documented.
- Do not leave important decisions only inside chats.
- Record reusable knowledge in versioned project artifacts.

## AI Governance

**Rules:**
- Architecture before implementation.
- Validation before deployment.
- Documentation before scaling.
- Versioning before major changes.
- Production stability over experimentation.

BrainCoach prioritizes durable systems over rapid feature accumulation.

## Long-Term Vision

The BrainCoach ecosystem should operate as a coordinated intelligence network.
Each tool contributes a specialized capability.

Tools are transient.
Source of truth lives in:
- Git
- documentation
- architecture
- PostgreSQL
- versioned project artifacts

The system should remain tool-independent and architecture-driven.