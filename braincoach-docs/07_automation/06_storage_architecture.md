# BrainCoach Automation — Storage Architecture v1.0

Status: Active

Date: 2026-06-06

---

# Purpose

This document defines how information is stored across BrainCoach OS.

The purpose is not database design.

The purpose is to establish clear storage responsibilities.

Every storage system has a single responsibility.

Storage systems complement each other.

Storage systems do not compete.

---

# Core Principle

Knowledge and activity are different.

Stable knowledge should not be stored with operational activity.

Operational activity should not be stored with orchestration.

Storage follows responsibility.

---

# Storage Overview

BrainCoach uses six storage layers:

1. Knowledge Storage
2. Operational Storage
3. Retrieval Storage
4. Orchestration Storage
5. External Registry Storage
6. Reasoning Layer

---

# Layer 1 — Knowledge Storage

System:

GitHub

Purpose:

Store stable knowledge.

GitHub is the canonical knowledge repository.

---

## Stores

* Canon
* Foundation
* Ontology
* Registries
* Knowledge Objects
* ADRs
* Decisions
* Research Publications
* System Documentation

---

## Characteristics

Stable

Versioned

Human-readable

Auditable

---

## Source of Truth

GitHub owns knowledge.

No operational workflow may replace GitHub as the knowledge source of truth.

---

# Layer 2 — Operational Storage

System:

PostgreSQL

Purpose:

Store active system state.

Store operational activity.

Store object lifecycles.

---

## Governance Domain

Examples:

* knowledge_objects
* decision_log
* knowledge_assets
* knowledge_events

---

## Research Domain

Examples:

* signal_feed
* signals
* phenomena
* seasons
* experiments
* outcomes
* models
* interviews

---

## Business Domain

Examples:

* clients
* messages
* conversation_state
* memory_items
* user_profiles
* offers
* consultations

---

## Operations Domain

Examples:

* insight_packages
* asset_blueprints
* generated_assets
* feedback_events

---

## Characteristics

Transactional

Queryable

Relational

Operational

---

## Source of Truth

PostgreSQL owns activity.

GitHub owns meaning.

---

# Layer 3 — Retrieval Storage

System:

pgvector

Purpose:

Semantic retrieval.

Knowledge search.

Memory retrieval.

Context assembly.

---

## Stores

Embeddings for:

* Knowledge Objects
* Research Objects
* Conversations
* Assets
* Memories

---

## Characteristics

Semantic

Similarity-based

Fast retrieval

Context generation

---

## Source of Truth

pgvector never owns knowledge.

pgvector stores representations.

Canonical objects remain in GitHub and PostgreSQL.

---

# Layer 4 — Orchestration Storage

System:

n8n

Purpose:

Workflow execution.

Automation state.

Process coordination.

---

## Stores

* workflow executions
* run history
* automation metadata
* temporary processing state

---

## Characteristics

Ephemeral

Operational

Workflow-oriented

---

## Source of Truth

n8n never owns business knowledge.

n8n orchestrates movement between systems.

---

# Layer 5 — External Registry Storage

System:

Google Sheets

Purpose:

Operational registries requiring rapid editing.

---

## Stores

Examples:

* keyword dictionaries
* offer registries
* campaign registries
* temporary operational catalogs

---

## Characteristics

Editable

Accessible

Operationally flexible

---

## Source of Truth

Only operational registries may reside here.

Strategic knowledge must migrate to GitHub.

---

# Layer 6 — Reasoning Layer

System:

Vertex AI

Purpose:

Reasoning.

Classification.

Extraction.

Generation.

Decision support.

---

## Stores

Nothing.

---

## Functions

* classify
* extract
* summarize
* reason
* generate

---

## Principle

Reasoning is not storage.

Reasoning consumes context.

Reasoning produces outputs.

Storage retains outputs.

---

# Storage Flow

Reality

↓

PostgreSQL

↓

Research Objects

↓

Knowledge Objects

↓

GitHub

↓

Embeddings

↓

pgvector

↓

Context Retrieval

↓

Vertex AI

↓

Operations

↓

PostgreSQL

---

# Ownership Rules

GitHub owns:

* knowledge
* doctrine
* governance
* architecture

PostgreSQL owns:

* activity
* state
* lifecycle
* operations

pgvector owns:

* embeddings

n8n owns:

* orchestration

Vertex AI owns:

* reasoning

Google Sheets owns:

* operational registries

---

# Anti-Patterns

Do not store knowledge only in prompts.

Do not store business logic only in workflows.

Do not store canonical knowledge in Google Sheets.

Do not use pgvector as a primary database.

Do not use n8n as a system of record.

---

# Strategic Principle

GitHub remembers what is true.

PostgreSQL remembers what happened.

pgvector remembers what is similar.

n8n remembers what is running.

Vertex AI understands context.

Together they form the operational memory of BrainCoach OS.
