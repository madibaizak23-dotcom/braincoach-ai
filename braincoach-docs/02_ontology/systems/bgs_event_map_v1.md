# bgs_event_map_v1

## status

draft_v1

## purpose

Описать событийную модель Brain Growth System.

Документ отвечает на вопрос:

«Какие события существуют в BGS и как они управляют поведением системы?»

---

# event_principle

BGS проектируется как event-driven system.

Агенты не работают постоянно.

Агенты реагируют на события.

---

# event_definition

Событие — это факт изменения состояния системы или внешней среды.

Событие не является решением.

Событие не является действием.

Событие сообщает:

```text
что-то произошло
```

---

# event_flow

```text
event
    ↓
classification
    ↓
routing
    ↓
agent_activation
    ↓
processing
    ↓
memory_update
    ↓
new_event
```

---

# event_architecture

```text
BGS Events

├── system_events
├── memory_events
├── knowledge_events
├── workflow_events
├── agent_events
├── domain_events
├── human_events
└── external_events
```

---

# system_events

## purpose

События состояния системы.

## examples

* system_started
* system_stopped
* service_deployed
* backup_completed
* restore_completed
* runtime_failure

## owner

bgs_observability

---

# memory_events

## purpose

События памяти.

## examples

* memory_created
* memory_updated
* memory_linked
* memory_archived
* memory_deleted

## owner

core_memory_keeper

---

# knowledge_events

## purpose

События знаний.

## examples

* knowledge_created
* knowledge_updated
* registry_updated
* ontology_updated
* decision_created

## owner

core_knowledge_curator

---

# workflow_events

## purpose

События выполнения процессов.

## examples

* workflow_started
* workflow_completed
* workflow_failed
* workflow_cancelled

## owner

orch_workflow_coordinator

---

# agent_events

## purpose

События агентов.

## examples

* agent_activated
* agent_completed
* agent_failed
* agent_escalated

## owner

orch_agent_coordinator

---

# domain_events

## purpose

События доменов.

## examples

### education

* observation_received
* development_signal_detected
* assessment_completed

### marketing

* trend_detected
* signal_detected
* content_published

### research

* research_completed
* insight_generated

---

# human_events

## purpose

События взаимодействия человека с системой.

## examples

* user_message_received
* decision_approved
* decision_rejected
* feedback_received

## owner

bgs_orch

---

# external_events

## purpose

События внешней среды.

## examples

* github_commit_detected
* repository_updated
* market_change_detected
* new_research_detected
* social_signal_detected

## owner

analytics_agents

---

# event_lifecycle

## step_1_generation

Возникает событие.

Пример:

```text
new_research_detected
```

---

## step_2_classification

Определяется:

* event_type
* source
* priority
* domain

---

## step_3_routing

Событие направляется нужному агенту.

Пример:

```text
new_research_detected
        ↓
analytics_research_scout
```

---

## step_4_processing

Агент выполняет действие.

---

## step_5_memory_update

Результат сохраняется в память.

---

## step_6_new_event

Создается новое событие.

Пример:

```text
research_processed
```

---

# event_priority

## critical

Требуют немедленной реакции.

Примеры:

* runtime_failure
* backup_failure
* data_loss_detected

---

## high

Влияют на работу системы.

Примеры:

* workflow_failed
* agent_failed
* memory_corruption_detected

---

## normal

Основной поток событий.

Примеры:

* observation_received
* knowledge_created
* trend_detected

---

## low

Информационные события.

Примеры:

* report_generated
* audit_completed

---

# event_storage

## source_of_truth

```text
postgresql
```

---

## target_database

```text
bgs_orch
```

---

## future_tables

```text
events

event_types

event_subscriptions

event_history

event_failures
```

---

# event_routing_rule

Событие никогда не должно обращаться напрямую к домену.

Маршрут всегда проходит через системные слои.

Пример:

```text
event
    ↓
bgs_orch
    ↓
agent
    ↓
memory
    ↓
domain
```

---

# event_driven_governance

Согласно DEC-009:

Человек не обязан инициировать большинство процессов.

Система должна реагировать на события самостоятельно.

---

# future_event_agents

Планируемые агенты:

* event_router
* event_classifier
* event_auditor
* event_replayer

---

# related_documents

* bgs_system_map_v1.md
* bgs_agent_map_v1.md
* bgs_data_flow_map_v1.md
* bgs_runtime_map_v1.md
* bgs_memory_map_v1.md
* DEC-009-human-ai-operating-model.md

---

# status_note

События являются главным механизмом координации Brain Growth System.

Все агенты, workflow и сервисы должны взаимодействовать через события, а не через прямые зависимости.
