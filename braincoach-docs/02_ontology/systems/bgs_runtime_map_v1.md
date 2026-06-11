# bgs_runtime_map_v1

## status

draft_v1

## purpose

Описать технологическую реализацию Brain Growth System.

Документ отвечает на вопрос:

«Какие платформы и сервисы обеспечивают работу BGS?»

---

# architectural_principle

BGS проектируется вокруг функций.

Технологии являются реализацией функций.

Технологии могут изменяться.

Функции системы должны сохраняться.

---

# runtime_overview

```text
BGS

├── bgs_core
├── bgs_orch
├── bgs_vector
├── bgs_analytics
└── bgs_observability
```

Каждый слой имеет собственный runtime.

---

# bgs_core_runtime

## purpose

Хранение знаний и памяти системы.

## primary_runtime

```text
github
```

## storage

```text
knowledge_os_repository
```

## contains

* canon
* foundation
* ontology
* decisions
* registries
* research
* memory_assets

## source_of_truth

Согласно DEC-011:

```text
knowledge_os
```

---

# bgs_orch_runtime

## purpose

Оркестрация процессов и агентов.

## primary_runtime

```text
n8n
```

## future_runtimes

```text
vertex_agent_engine
cloud_run_agents
```

## responsibilities

* workflow_execution
* task_routing
* agent_coordination
* event_processing

## database

```text
bgs_orch
```

---

# bgs_vector_runtime

## purpose

Семантический поиск и контекстная память.

## primary_runtime

```text
vertex_ai_embeddings
```

## future_components

```text
vector_store
retrieval_layer
semantic_memory
```

## responsibilities

* embeddings
* retrieval
* context_assembly
* semantic_search

## database

```text
bgs_vector
```

---

# bgs_analytics_runtime

## purpose

Исследование среды и обнаружение закономерностей.

## primary_runtime

```text
vertex_ai
```

## responsibilities

* trend_analysis
* signal_detection
* market_intelligence
* learning_intelligence
* research_processing

## database

```text
bgs_analytics
```

---

# bgs_observability_runtime

## purpose

Мониторинг системы.

## primary_runtime

```text
cloud_logging
```

## supporting_runtimes

```text
cloud_monitoring
cloud_storage
```

## responsibilities

* logging
* monitoring
* auditing
* backup_validation

## database

```text
bgs_observability
```

---

# infrastructure_layer

## cloud_platform

```text
google_cloud_platform
```

Является базовой инфраструктурой BGS.

---

## current_services

```text
cloud_run

cloud_sql

cloud_storage

secret_manager

vertex_ai

cloud_logging

cloud_monitoring
```

---

# data_storage_map

## github

Назначение:

```text
knowledge_storage
code_storage
architecture_storage
```

---

## postgresql

Назначение:

```text
runtime_state
events
agent_state
workflow_state
```

---

## cloud_storage

Назначение:

```text
backups
exports
snapshots
archives
```

---

## google_sheets

Назначение:

```text
reference_data
signal_dictionaries
classification_rules
```

---

# integration_layer

## telegram

Назначение:

```text
human_input
human_output
```

---

## web_apps

Назначение:

```text
tests
forms
surveys
dashboards
```

---

## future_channels

```text
whatsapp
email
web_portal
mobile_apps
```

---

# agent_execution_model

```text
human
        ↓
telegram
        ↓
bgs_orch
        ↓
agents
        ↓
bgs_core
bgs_vector
bgs_analytics
        ↓
response
```

---

# current_state

## operational

```text
github
google_cloud
postgresql
vertex_ai
telegram
n8n
```

---

## planned

```text
repository_guardian

market_intelligence

learning_intelligence

content_intelligence

memory_keeper
```

---

# migration_target

Текущие базы:

```text
braincoach_dev

n8n_v2_clean
```

Рассматриваются как переходные.

Целевая структура:

```text
bgs_core

bgs_orch

bgs_vector

bgs_analytics

bgs_observability
```

---

# runtime_rule

Ни один runtime не является источником истины сам по себе.

Каждый runtime обязан использовать source_of_truth согласно DEC-011.

---

# related_documents

* bgs_system_map_v1.md
* bgs_agent_map_v1.md
* bgs_data_flow_map_v1.md
* DEC-008-bgs-data-architecture.md
* DEC-009-human-ai-operating-model.md
* DEC-010-naming-conventions.md
* DEC-011-source-of-truth-model.md

---

# status_note

Документ описывает текущую и целевую технологическую реализацию Brain Growth System.

Технологии могут меняться.

Архитектурные роли слоев BGS должны сохраняться.
