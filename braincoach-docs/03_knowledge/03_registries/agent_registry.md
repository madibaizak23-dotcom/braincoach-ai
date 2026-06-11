# agent_registry

## status

active

## purpose

Единый реестр агентов Brain Growth System.

Документ отвечает на вопрос:

«Какие агенты существуют в системе и каково их текущее состояние?»

---

# registry_principles

Каждый агент должен иметь:

* уникальный идентификатор
* владельца
* системный слой
* статус
* источник истины
* описание ответственности

---

# lifecycle_statuses

Допустимые статусы:

```text
planned
design
building
testing
active
paused
retired
```

---

# agent_record_structure

Каждая запись агента должна содержать:

```text
agent_id
agent_name
system_layer
domain
status
owner
source_of_truth
runtime
description
dependencies
```

---

# system_agents

## AGENT-001

### agent_name

core_memory_keeper

### system_layer

bgs_core

### domain

system

### status

planned

### owner

bgs_core

### source_of_truth

knowledge_os

### runtime

future

### description

Управление памятью системы.

### dependencies

* bgs_memory_map_v1
* DEC-011-source-of-truth-model

---

## AGENT-002

### agent_name

core_decision_guardian

### system_layer

bgs_core

### domain

system

### status

planned

### owner

bgs_core

### source_of_truth

knowledge_os

### runtime

future

### description

Контроль архитектурных решений.

---

## AGENT-003

### agent_name

core_knowledge_curator

### system_layer

bgs_core

### domain

system

### status

planned

### owner

bgs_core

### source_of_truth

knowledge_os

### runtime

future

### description

Управление структурой знаний.

---

# orchestration_agents

## AGENT-004

### agent_name

orch_repository_guardian

### system_layer

bgs_orch

### domain

research

### status

design

### owner

bgs_orch

### source_of_truth

github

### runtime

n8n

### description

Мониторинг эволюции системы и репозиториев.

### dependencies

* github
* repository_registry
* knowledge_os

---

## AGENT-005

### agent_name

orch_workflow_coordinator

### system_layer

bgs_orch

### domain

system

### status

planned

### owner

bgs_orch

### source_of_truth

postgresql

### runtime

n8n

### description

Управление workflow.

---

## AGENT-006

### agent_name

orch_agent_coordinator

### system_layer

bgs_orch

### domain

system

### status

planned

### owner

bgs_orch

### runtime

future

### description

Координация взаимодействия агентов.

---

# analytics_agents

## AGENT-007

### agent_name

analytics_market_intelligence

### system_layer

bgs_analytics

### domain

marketing

### status

planned

### owner

bgs_analytics

### source_of_truth

knowledge_os

### runtime

vertex_ai

### description

Анализ рынка и трендов.

---

## AGENT-008

### agent_name

analytics_content_intelligence

### system_layer

bgs_analytics

### domain

marketing

### status

planned

### owner

bgs_analytics

### runtime

vertex_ai

### description

Анализ контентных паттернов.

---

## AGENT-009

### agent_name

analytics_learning_intelligence

### system_layer

bgs_analytics

### domain

education

### status

planned

### owner

bgs_analytics

### runtime

vertex_ai

### description

Анализ обучения и развития.

---

## AGENT-010

### agent_name

analytics_research_scout

### system_layer

bgs_analytics

### domain

research

### status

planned

### owner

bgs_analytics

### runtime

vertex_ai

### description

Поиск новых исследований и знаний.

---

# observability_agents

## AGENT-011

### agent_name

observability_system_auditor

### system_layer

bgs_observability

### domain

system

### status

planned

### owner

bgs_observability

### runtime

future

### description

Мониторинг состояния системы.

---

## AGENT-012

### agent_name

observability_backup_guardian

### system_layer

bgs_observability

### domain

system

### status

planned

### owner

bgs_observability

### runtime

future

### description

Контроль резервного копирования.

---

# implementation_priority

## phase_1

Первые агенты для реализации:

1. orch_repository_guardian
2. analytics_market_intelligence
3. core_memory_keeper

---

## phase_2

Следующие агенты:

1. analytics_learning_intelligence
2. core_knowledge_curator
3. observability_backup_guardian

---

## phase_3

Полная агентная экосистема.

---

# registry_rules

Каждый новый агент обязан:

* быть описан в agent_registry
* иметь owner
* иметь source_of_truth
* иметь system_layer
* иметь статус жизненного цикла

До регистрации агент не считается частью BGS.

---

# related_documents

* bgs_agent_map_v1.md
* bgs_governance_map_v1.md
* bgs_runtime_map_v1.md
* DEC-010-naming-conventions.md
* DEC-011-source-of-truth-model.md

---

# status_note

Данный документ является официальным реестром агентов Brain Growth System.

Любой агент должен быть зарегистрирован здесь до начала реализации.
