# BrainCoach Automation — Domain Architecture v1.0

Status: Active

Date: 2026-06-06

---

# Purpose

This document defines the major operational domains of BrainCoach OS.

Domains separate responsibilities.

Domains reduce coupling.

Domains enable scalable automation.

---

# Core Principle

One domain.

One responsibility.

Domains may interact.

Domains should not absorb each other.

---

# Domain Overview

BrainCoach consists of four primary domains:

1. Governance Domain
2. Research Domain
3. Business Domain
4. Operations Domain

---

# Governance Domain

Purpose:

Manage system knowledge and governance.

Owns:

* Canon
* Ontology
* Registries
* ADRs
* Decisions
* Knowledge Object Definitions

Primary Storage:

GitHub

Operational Mirror:

PostgreSQL

---

# Research Domain

Purpose:

Transform reality into knowledge.

Pipeline:

Reality

↓

Observation

↓

Deviation

↓

Signal

↓

Phenomenon

↓

Research

↓

Model

Owns:

* signal_feed
* signals
* phenomena
* seasons
* experiments
* outcomes
* models
* interviews

Primary Storage:

PostgreSQL

Canonical Output:

Knowledge Objects

---

# Business Domain

Purpose:

Manage human interactions.

Owns:

* clients
* messages
* conversation_state
* memory_items
* user_profiles
* offers
* consultations

Primary Storage:

PostgreSQL

Primary Objective:

Relationship and conversion management.

---

# Operations Domain

Purpose:

Transform knowledge into assets.

Pipeline:

Knowledge Object

↓

Insight Package

↓

Asset Blueprint

↓

Generated Asset

↓

Feedback

Owns:

* insight_packages
* asset_blueprints
* generated_assets
* feedback_events

Primary Storage:

PostgreSQL

Primary Objective:

Asset production.

---

# Domain Relationships

Governance

↓

Research

↓

Operations

↓

Market

↓

Research

Business

↓

Research

Business

↓

Operations

Governance supports all domains.

---

# Separation Rule

Research should not become CRM.

CRM should not become Research.

Operations should not become Governance.

Each domain maintains its responsibility.

---

# Strategic Principle

Governance creates consistency.

Research creates understanding.

Operations create assets.

Business creates outcomes.

Together they form BrainCoach OS.
