# PostgreSQL Data Model v1

Status: Active

Date: 2026-06-04

## Governance Layer

### knowledge_objects

Registry of Knowledge Object Types

Examples:

* Canon
* Ontology
* Registry
* ADR
* Decision
* Research

---

### decision_log

Operational decisions adopted by BrainCoach Governance.

---

## Event Layer

### knowledge_events

Repository change events classified into Knowledge Objects.

Examples:

* version_registry
* ontology
* canon

---

## Knowledge Layer

### knowledge_assets

Concrete Knowledge Objects stored and managed by BrainCoach Knowledge OS.

Examples:

* ADR-001
* DEC-003
* Knowledge Object Ontology v1
* milestones.md
* releases.md
