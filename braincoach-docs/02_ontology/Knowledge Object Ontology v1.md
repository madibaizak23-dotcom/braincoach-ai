# Knowledge Object Ontology v1

Status: Active

Version: 1.0

Date: 2026-06-04

---

## Purpose

Define what constitutes a Knowledge Object inside BrainCoach Knowledge OS.

Knowledge Objects are the primary units of organizational knowledge.

All registries, governance systems, AI agents, workflows, and repositories operate on Knowledge Objects.

---

## Definition

A Knowledge Object is any identifiable artifact that stores, structures, governs, or evolves knowledge within the BrainCoach ecosystem.

A Knowledge Object must have:

* identity
* type
* location
* lifecycle
* version history

---

## Knowledge Object Categories

### Canon

Foundational principles that define BrainCoach.

Examples:

* Core Principles
* Worldview Documents
* Brand Canon

---

### Ontology

Definitions of concepts and relationships.

Examples:

* BrainCoach Unified Ontology
* Knowledge Object Ontology
* Phenomenon Ontology

---

### Registry

System records and indexes.

Examples:

* Phenomenon Registry
* Season Registry
* Version Registry
* Knowledge Object Registry

---

### ADR

Architecture Decision Records.

Examples:

* ADR-001
* ADR-002

---

### Decision

Operational decisions.

Examples:

* Decision Logs
* Governance Decisions

---

### Research

Investigation and analysis artifacts.

Examples:

* Research Papers
* Discovery Documents
* Hypothesis Exploration

---

### Knowledge Asset

Reusable knowledge resources.

Examples:

* Frameworks
* Models
* Methodologies
* Prompt Libraries

---

### Operational Document

Documents required for operating the system.

Examples:

* Workflow Inventory
* Architecture Reviews
* Deployment Plans

---

## Lifecycle States

A Knowledge Object may exist in one of the following states:

* draft
* active
* deprecated
* archived

---

## Metadata Requirements

Every Knowledge Object should maintain:

* object_type
* object_name
* object_path
* version
* status
* created_at
* updated_at

---

## Governance Rule

All significant knowledge artifacts introduced into BrainCoach Knowledge OS should be represented as Knowledge Objects.

Knowledge Objects are the canonical unit of knowledge management within the system.
