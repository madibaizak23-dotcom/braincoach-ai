# BrainCoach Automation — PostgreSQL Mapping v1.0

Status: Active

Date: 2026-06-05

---

# Purpose

This document defines how BrainCoach canonical objects are mapped into PostgreSQL.

The purpose is not database design.

The purpose is to establish a stable translation layer between Knowledge OS and PostgreSQL.

Knowledge defines meaning.

PostgreSQL stores state.

---

# Core Principle

Objects come first.

Database structures come second.

The database must reflect the object model.

The object model must never be changed to fit the database.

---

# Mapping Hierarchy

Knowledge OS

↓

Canonical Objects

↓

Relationships

↓

States

↓

PostgreSQL Records

---

# Mapping Strategy

Each canonical object should have:

* unique identifier
* state
* timestamps
* relationships
* metadata

Every object must remain traceable.

---

# Reality Layer

## Event

Maps to:

events

Stores:

* title
* description
* source
* occurred_at
* metadata

---

## Observation

Maps to:

observations

Stores:

* observation_text
* source
* event_id
* status
* metadata

---

## Deviation

Maps to:

deviations

Stores:

* expected
* actual
* difference
* potential
* status

Purpose:

Track model error.

---

## Signal

Maps to:

signals

Stores:

* signal_name
* description
* confidence
* status

---

## Phenomenon

Maps to:

phenomena

Stores:

* title
* description
* evidence
* status

---

# Knowledge Layer

## Research

Maps to:

research

Stores:

* title
* objective
* findings
* status

---

## Model

Maps to:

models

Stores:

* title
* explanation
* formula
* status

---

## Season

Maps to:

seasons

Stores:

* title
* objective
* status

---

## Knowledge Object

Maps to:

knowledge_objects

Stores:

* object_type
* object_reference
* status

Purpose:

Unified knowledge entry point.

---

# Operations Layer

## Insight Package

Maps to:

insight_packages

Stores:

* observation
* question
* tension
* paradox
* mechanism
* model

---

## Asset Blueprint

Maps to:

asset_blueprints

Stores:

* asset_type
* goal
* angle
* structure

---

## Generated Asset

Maps to:

generated_assets

Stores:

* asset_type
* content
* publication_status

---

## Feedback Event

Maps to:

feedback_events

Stores:

* source
* event_type
* content
* status

---

# Relationship Strategy

Relationships should be stored explicitly.

Examples:

Observation

↓

Event

Signal

↓

Observation

Phenomenon

↓

Signal

Research

↓

Phenomenon

Model

↓

Research

Generated Asset

↓

Asset Blueprint

Feedback Event

↓

Generated Asset

---

# State Strategy

Every object must contain:

* current_state
* created_at
* updated_at

Optional:

* state_changed_at
* archived_at

State history should be preserved.

---

# Registry Strategy

Registries remain knowledge objects.

Examples:

* signal_registry
* deviation_registry
* phenomenon_registry
* season_registry
* experiment_registry
* outcome_registry
* case_registry

Registries may be implemented as dedicated tables or views.

Implementation is a database decision.

---

# Traceability Rule

Every object should support full traceability.

Example:

Feedback Event

↓

Generated Asset

↓

Asset Blueprint

↓

Insight Package

↓

Knowledge Object

↓

Research

↓

Phenomenon

↓

Signal

↓

Observation

↓

Event

---

# Automation Rule

Agents should operate on canonical objects.

Workflows should operate on canonical objects.

PostgreSQL should store canonical objects.

No workflow should bypass the object model.

---

# Operational Principle

Knowledge defines objects.

Objects define relationships.

Relationships define workflows.

PostgreSQL stores the resulting system state.
