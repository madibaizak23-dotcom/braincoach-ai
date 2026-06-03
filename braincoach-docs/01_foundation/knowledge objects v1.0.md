# BrainCoach Knowledge Objects v1.0

## Status

Accepted

## Date

2026-06-03

## Purpose

Knowledge Objects Registry is the single catalog of core BrainCoach objects.

The registry does not store object content.

The registry stores the existence of objects, their class, owner, source of truth, lifecycle, and status.

---

## Required Fields

Every object must contain:

* Object ID
* Object Type
* Class
* Owner
* Source of Truth
* Lifecycle
* Status

Objects without these fields are invalid.

---

## Allowed Classes

* Knowledge
* Research
* Governance
* Memory
* Infrastructure

---

## Knowledge Objects

| Object Type                    | Class     | Owner      | Source of Truth | Lifecycle | Status   |
| ------------------------------ | --------- | ---------- | --------------- | --------- | -------- |
| Canon                          | Knowledge | Canon      | GitHub          | active    | accepted |
| Ontology                       | Knowledge | Ontology   | GitHub          | active    | accepted |
| Phenomenon Registry            | Knowledge | Research   | GitHub          | active    | accepted |
| Season Registry                | Knowledge | Research   | GitHub          | active    | accepted |
| Social Intelligence Dictionary | Knowledge | Knowledge  | GitHub          | active    | accepted |
| BrainCoach Knowledge OS        | Knowledge | Governance | GitHub          | active    | accepted |

---

## Governance Objects

| Object Type       | Class      | Owner      | Source of Truth | Lifecycle                                                | Status |
| ----------------- | ---------- | ---------- | --------------- | -------------------------------------------------------- | ------ |
| ADR               | Governance | Governance | GitHub          | draft → accepted → archived                              | active |
| Decision Log      | Governance | Governance | GitHub          | draft → accepted → archived                              | active |
| Version Registry  | Governance | Governance | GitHub          | active                                                   | active |
| Future Candidates | Governance | Governance | GitHub          | candidate → deferred → approved → rejected → implemented | active |

---

## Research Objects

| Object Type | Class    | Owner      | Source of Truth     | Lifecycle                                          | Status  |
| ----------- | -------- | ---------- | ------------------- | -------------------------------------------------- | ------- |
| Phenomenon  | Research | Research   | GitHub + PostgreSQL | draft → observed → testing → validated → canonical | active  |
| Observation | Research | Research   | PostgreSQL          | active                                             | planned |
| Experiment  | Research | PostgreSQL | PostgreSQL          | planned                                            | planned |
| Outcome     | Research | PostgreSQL | PostgreSQL          | planned                                            | planned |
| Season      | Research | Research   | GitHub + PostgreSQL | draft → active → closing → closed → archived       | active  |

---

## Memory Objects

| Object Type | Class  | Owner  | Source of Truth | Lifecycle | Status |
| ----------- | ------ | ------ | --------------- | --------- | ------ |
| Client      | Memory | AI CRM | PostgreSQL      | active    | active |
| Event       | Memory | AI CRM | PostgreSQL      | active    | active |
| Message     | Memory | AI CRM | PostgreSQL      | active    | active |
| Memory Fact | Memory | AI CRM | PostgreSQL      | active    | active |

---

## Infrastructure Objects

| Object Type       | Class          | Owner          | Source of Truth | Lifecycle | Status |
| ----------------- | -------------- | -------------- | --------------- | --------- | ------ |
| GitHub Repository | Infrastructure | Infrastructure | GitHub          | active    | active |
| n8n               | Infrastructure | Infrastructure | Google Cloud    | active    | active |
| PostgreSQL        | Infrastructure | Infrastructure | Google Cloud    | active    | active |
| Cloud Run         | Infrastructure | Infrastructure | Google Cloud    | active    | active |
| Cloud SQL         | Infrastructure | Infrastructure | Google Cloud    | active    | active |
| Secret Manager    | Infrastructure | Infrastructure | Google Cloud    | active    | active |

---

## Rule

All BrainCoach objects must be registered in Knowledge Objects Registry.
