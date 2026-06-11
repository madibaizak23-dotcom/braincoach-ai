# bgs_system_map_v1

## status

draft_v1

## purpose

Описать верхнеуровневую структуру Brain Growth System (BGS).

Документ отвечает на вопрос:

«Из каких систем состоит BGS и как они взаимодействуют между собой?»

---

# system_overview

```text
Brain Growth System (BGS)
```

Единая операционная система знаний, развития, исследований и принятия решений.

---

# layer_1_shared_system_layers

```text
BGS

├── bgs_core
├── bgs_orch
├── bgs_vector
├── bgs_analytics
└── bgs_observability
```

Это постоянные системные слои.

Они существуют независимо от конкретных доменов и используются всей экосистемой.

---

# bgs_core

## purpose

Источник истины системы.

## contains

* knowledge_os
* memory
* canon
* ontology
* registries
* decisions
* events

## key_question

```text
Что система знает?
```

---

# bgs_orch

## purpose

Координация агентов и процессов.

## contains

* workflow_orchestration
* agent_execution
* task_routing
* automation_runtime
* state_management

## current_technologies

* n8n
* vertex_workflows
* future_agent_runtimes

## key_question

```text
Что система делает?
```

---

# bgs_vector

## purpose

Семантическая память и поиск.

## contains

* embeddings
* vector_indexes
* retrieval_systems
* rag_infrastructure

## key_question

```text
Что система может быстро найти?
```

---

# bgs_analytics

## purpose

Исследование среды и выявление закономерностей.

## contains

* market_intelligence
* content_intelligence
* learning_intelligence
* trend_analysis
* behavioral_analytics

## key_question

```text
Что происходит?
```

---

# bgs_observability

## purpose

Наблюдение за состоянием экосистемы.

## contains

* logs
* monitoring
* audits
* telemetry
* health_checks

## key_question

```text
Что происходит внутри системы?
```

---

# layer_2_domain_layers

Доменные слои используют общие системные слои.

```text
BGS

├── education
├── marketing
├── research
├── family
├── business
└── partnerships
```

Домены не создают собственную память, онтологию или источник истины.

Домены используют общие системные слои BGS.

---

# education

## purpose

Развитие детей и подростков.

## future_systems

* braincoach_gps
* learning_intelligence
* development_tracking
* parent_intelligence

---

# marketing

## purpose

Исследование внимания и построение контентных систем.

## future_systems

* market_intelligence
* content_factory
* trend_monitoring
* signal_discovery

---

# research

## purpose

Сбор и накопление знаний.

## future_systems

* research_pipelines
* knowledge_extraction
* insight_generation

---

# family

## purpose

Поддержка развития семьи.

## future_systems

* family_memory
* family_planning
* family_intelligence

---

# business

## purpose

Поддержка предпринимательской деятельности.

## future_systems

* business_intelligence
* decision_support
* opportunity_discovery

---

# partnerships

## purpose

Поддержка партнерской сети и совместных проектов.

## future_systems

* partner_intelligence
* collaboration_memory
* network_analytics

---

# governance_model

Согласно DEC-009:

Человек не является операционной системой.

Человек отвечает за:

* mission
* vision
* strategy
* architectural_decisions

Экосистема отвечает за:

* process_execution
* information_analysis
* memory_management
* decision_preparation

---

# architectural_rule

Любой новый агент, сервис или workflow обязан определить:

1. domain_layer
2. system_layer
3. source_of_truth

Только после этого выбирается технология реализации.

---

# next_maps

На основе данной карты будут разработаны:

* bgs_agent_map_v1
* bgs_data_flow_map_v1
* bgs_runtime_map_v1
* bgs_source_of_truth_map_v1
* bgs_memory_map_v1

---

# related_decisions

* DEC-008-bgs-data-architecture.md
* DEC-009-human-ai-operating-model.md

---

# status_note

Документ является базовой картой экосистемы BGS.

Все будущие домены, агенты, сервисы и инфраструктурные решения должны согласовываться с данной картой.
