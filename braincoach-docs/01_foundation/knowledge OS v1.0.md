## Milestone:BrainCoach Knowledge OS v1.0 Foundation


Date:
2026-06-03

Status:
Released

Scope:
- Canon
- Foundation
- Ontology
- Research Framework
- Governance
- ADR Process
- Decision Log
- Knowledge Objects Registry

Result:
Single Source of Truth established

# BrainCoach Knowledge OS v1.0 - Status

Status: Operational

Date: 2026-06-03

# BrainCoach Knowledge OS v1.0

## Purpose


BrainCoach Knowledge OS is a managed system for producing reliable research, decisions, and outcomes through a clear separation of knowledge, operations, governance, memory, and infrastructure.

The system is built to preserve a single source of truth, prevent meaning drift, and keep changes traceable over time.

---

## BrainCoach Knowledge OS v1.0 — Stop Rule

Architecture Stability > Architecture Expansion

v1.0 is complete.

Do not add new folders.
Do not add new layers.
Do not design new entities.
Do not create new architectural documents.

Allowed:
- Decision Log.
- ADR.
- Knowledge Objects.
- Operational Data.

## Layer 1 — Knowledge

**Source of Truth:** GitHub

This layer contains the stable conceptual system of BrainCoach:

- Canon.
- Ontology.
- Phenomenon Registry.
- Season Registry.
- Social Intelligence.
- Architecture.

Knowledge is changed through Pull Request, Review, and Merge.

---

## Layer 2 — Research Operations

**Source of Truth:** PostgreSQL

This layer contains the live research process:

- Observations.
- Phenomena instances.
- Experiments.
- Outcomes.
- Season progress.
- Research notes.

Research Operations are created and updated by the system as real work happens.

---

## Layer 3 — Governance

**Source of Truth:** PostgreSQL + GitHub

This layer stores why the system changed:

- ADR.
- Decision Log.
- Change Log.
- Version Registry.
- Migration Log.

Governance records the reasons behind changes to Canon, Ontology, Registry, and Seasons.

---

## Layer 4 — User Memory

**Source of Truth:** PostgreSQL

This layer stores user and client memory:

- Clients.
- Events.
- Messages.
- Memory facts.
- Offers and outcomes.

User Memory supports continuity, personalization, and long-term relationship context.

---

## Layer 5 — Infrastructure

**Source of Truth:** GitHub + Google Cloud

This layer contains the technical delivery system:

- GitHub.
- n8n.
- PostgreSQL.
- Cloud Run.
- Cloud SQL.
- Secret Manager.
- Sync jobs.
- Webhooks.
- Backups.

Infrastructure exists to transport and preserve the system, not to define its meaning.

---

## Object Rule

No object exists in the system without:

- Class.
- Owner.
- Source of Truth.
- Lifecycle.

Allowed classes:

- Knowledge.
- Research.
- Governance.
- Memory.
- Infrastructure.

---

## Ontological Rule

No object can be created unless it is linked to at least one existing object.

Forbidden:
- New phenomenon without a season.
- New term without Ontology.
- New mechanism without a phenomenon.
- New experiment without a hypothesis.

## Flow Separation

Do not mix the two flows:

### Knowledge Flow

Canon  
↓  
Ontology  
↓  
Registry  
↓  
Season  
↓  
Research

### Technical Flow

GitHub  
↓  
n8n  
↓  
PostgreSQL  
↓  
Embeddings  
↓  
pgvector  
↓  
RAG

The first flow defines meaning.  
The second flow delivers meaning.

---

## Near-Term Priorities

### Priority 1

Governance:
- Decision Log.
- ADR Registry.

### Priority 2

Knowledge Catalog:
- knowledge_objects.

### Priority 3

Synchronization:
- GitHub → n8n → PostgreSQL.

### Priority 4

Semantic Layer:
- Embeddings.

### Priority 5

Retrieval Layer:
- pgvector.
- RAG.

---

## Deferred Work

The following are not priorities until Governance and Knowledge Catalog are stable:

- Vector search.
- RAG optimization.
- Agent memory retrieval.
- Multi-agent knowledge routing.

The main risk right now is not retrieval quality.  
The main risk is knowledge desynchronization and loss of change history.

---

## Immediate Next Artifact

If one artifact should be built next, it is **Decision Log v1**.

It is the starting point for controlled evolution of the entire Knowledge OS.

---

## Core Principle

BrainCoach Knowledge OS is not a set of tools.  
It is a system that knows what it knows, why it knows it, and how that knowledge changes over time.