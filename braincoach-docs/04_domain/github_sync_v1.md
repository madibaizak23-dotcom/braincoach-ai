# GitHub Sync v1

## Purpose

Synchronize BrainCoach Source of Truth objects from GitHub into PostgreSQL operational mirrors.

---

## Source of Truth

GitHub

---

## Trigger

Git Push

---

## Processor

n8n

---

## Targets

### knowledge_objects

Operational catalog of BrainCoach objects.

### decision_log

Operational mirror of BrainCoach decisions.

---

## Direction

GitHub → PostgreSQL

---

## Conflict Rule

GitHub wins.

GitHub is authoritative.

PostgreSQL stores operational representations only.

---

## Sync Flow

Git Push
↓
GitHub Webhook
↓
n8n
↓
Detect Changed Files
↓
Classify Object Type
↓
Update PostgreSQL

---

## Supported Objects v1

* Canon
* Ontology
* Phenomenon Registry
* Season Registry
* Knowledge Objects
* Decision Log

---

## Deferred

Not part of Sync v1:

* Embeddings
* pgvector
* RAG
* Knowledge Graph
* Multi-Agent Retrieval
