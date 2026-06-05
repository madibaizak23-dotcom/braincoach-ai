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

* Intelligence
* Knowledge
* Research
* Governance
* Memory
* Infrastructure

---

## Knowledge Objects

| Object Type                    | Class     | Owner      | Source of Truth | Lifecycle                                | Status   |
| ------------------------------ | --------- | ---------- | --------------- | ---------------------------------------- | -------- |
| Canon                          | Knowledge | Canon      | GitHub          | active                                   | accepted |
| Ontology                       | Knowledge | Ontology   | GitHub          | active                                   | accepted |
| Phenomenon Registry            | Knowledge | Research   | GitHub          | active                                   | accepted |
| Season Registry                | Knowledge | Research   | GitHub          | active                                   | accepted |
| Social Intelligence Dictionary | Knowledge | Knowledge  | GitHub          | active                                   | accepted |
| BrainCoach Knowledge OS        | Knowledge | Governance | GitHub          | active                                   | accepted |
| Model                          | Knowledge | Research   | GitHub          | draft → validated → accepted → canonical | active   |

---

## Governance Objects

| Object Type       | Class      | Owner      | Source of Truth | Lifecycle                                                | Status |
| ----------------- | ---------- | ---------- | --------------- | -------------------------------------------------------- | ------ |
| ADR               | Governance | Governance | GitHub          | draft → accepted → archived                              | active |
| Decision Log      | Governance | Governance | GitHub          | draft → accepted → archived                              | active |
| Version Registry  | Governance | Governance | GitHub          | active                                                   | active |
| Future Candidates | Governance | Governance | GitHub          | candidate → deferred → approved → rejected → implemented | active |

---

## Intelligence Objects

| Object Type | Class        | Owner        | Source of Truth     | Lifecycle                                 | Status |
| ----------- | ------------ | ------------ | ------------------- | ----------------------------------------- | ------ |
| Signal Feed | Intelligence | Intelligence | PostgreSQL          | active                                    | active |
| Signal      | Intelligence | Intelligence | GitHub + PostgreSQL | candidate → validated → archived          | active |
| Trend       | Intelligence | Intelligence | GitHub + PostgreSQL | candidate → tracked → accepted → archived | active |
| Pattern     | Intelligence | Intelligence | GitHub              | draft → validated → accepted              | active |

---

## Research Objects

| Object Type | Class    | Owner    | Source of Truth     | Lifecycle                                    | Status |
| ----------- | -------- | -------- | ------------------- | -------------------------------------------- | ------ |
| Event       | Research | Research | PostgreSQL          | observed → archived                          | active |
| Observation | Research | Research | PostgreSQL          | observed → validated → archived              | active |
| Phenomenon  | Research | Research | GitHub + PostgreSQL | candidate → observed → tested → canonical    | active |
| Experiment  | Research | Research | PostgreSQL          | planned → running → completed → archived     | active |
| Outcome     | Research | Research | PostgreSQL          | observed → validated → archived              | active |
| Season      | Research | Research | GitHub + PostgreSQL | draft → active → closing → closed → archived | active |

---

## Memory Objects

| Object Type  | Class  | Owner  | Source of Truth | Lifecycle | Status |
| ------------ | ------ | ------ | --------------- | --------- | ------ |
| Client       | Memory | AI CRM | PostgreSQL      | active    | active |
| Client Event | Memory | AI CRM | PostgreSQL      | active    | active |
| Message      | Memory | AI CRM | PostgreSQL      | active    | active |
| Memory Fact  | Memory | AI CRM | PostgreSQL      | active    | active |

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

## Object Dependency Rule

No object may exist in isolation.

Required relationships:

Event
→ Observation

Observation
→ Signal

Signal
→ Phenomenon

Phenomenon
→ Model

Experiment
→ Phenomenon

Outcome
→ Experiment

Season
→ Phenomenon

Client Event
→ Client

Memory Fact
→ Client

Objects without valid relationships are considered incomplete.

---

## Rule

All BrainCoach objects must be registered in Knowledge Objects Registry.
