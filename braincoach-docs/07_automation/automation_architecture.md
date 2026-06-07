# Automation Architecture v1

Status: Active

## Purpose

Define the structure and responsibilities of the BrainCoach Automation Layer.

The Automation Layer contains all executable systems, workflow definitions, database schemas, interfaces, and agent implementations.

---

## Structure

07_automation

├── 01_agents

├── 02_workflows

├── 03_n8n

├── 04_postgres

└── 05_interfaces

---

## 01_agents

Purpose:

Store agent specifications and behavioral definitions.

Examples:

* scout_agent.md
* qualification_agent.md
* memory_agent.md

Rule:

Agents define reasoning responsibilities.

Agents do not define infrastructure implementation.

---

## 02_workflows

Purpose:

Store workflow specifications as Knowledge Objects.

Examples:

* knowledge_registry_sync_v1.md
* repository_full_sync_v1.md
* qualification_engine_v2.md

Contents:

* purpose
* inputs
* outputs
* dependencies
* implementation references

Rule:

Workflow specifications describe what a workflow does.

They do not contain executable workflow code.

---

## 03_n8n

Purpose:

Store exported n8n workflow files.

Examples:

* knowledge_registry_sync_v1.json
* qualification_engine_v2_scout_memory.json

Rule:

03_n8n acts as the source-of-truth repository for workflow implementations.

Only executable workflow exports belong here.

---

## 04_postgres

Purpose:

Store database architecture and schema definitions.

Examples:

* knowledge_assets.md
* knowledge_events.md
* object_relationships.md

Contents:

* table definitions
* indexes
* constraints
* ownership rules

Rule:

Database structures are documented separately from workflow implementations.

---

## 05_interfaces

Purpose:

Store contracts between system components.

Examples:

* github_webhook.md
* asset_schema.md
* event_schema.md

Contents:

* payload definitions
* schemas
* interface contracts
* validation requirements

Rule:

Interfaces define communication standards between layers.

---

## Architectural Principle

Agents use workflows.

Workflows use interfaces.

Interfaces connect to storage.

Storage persists system state.

This separation allows independent evolution of reasoning, orchestration, communication, and persistence layers.

---

## Long-Term Goal

Automation Layer becomes the operational backbone of BrainCoach Knowledge OS and supports:

* autonomous agents
* workflow orchestration
* knowledge synchronization
* semantic retrieval
* future self-improving systems
