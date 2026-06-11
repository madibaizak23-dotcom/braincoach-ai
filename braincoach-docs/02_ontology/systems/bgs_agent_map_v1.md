# bgs_agent_map_v1

## status

draft_v1

## purpose

Описать агентную структуру Brain Growth System.

Документ отвечает на вопрос:

«Какие роли должны существовать внутри BGS для обеспечения автономной работы системы?»

---

# agent_architecture_principle

Агент является исполнителем роли.

Роль определяется потребностью системы.

Технология реализации вторична.

Один агент может реализовываться через:

* n8n
* vertex_ai
* cloud_run
* python_service
* future_runtime

---

# layer_1_core_agents

Агенты слоя bgs_core отвечают за знания, память и согласованность системы.

---

## core_memory_keeper

### purpose

Управление памятью системы.

### responsibilities

* memory_updates
* memory_validation
* memory_linking
* memory_cleanup

### key_question

```text
Что система должна помнить?
```

---

## core_decision_guardian

### purpose

Контроль архитектурных решений.

### responsibilities

* decision_tracking
* decision_validation
* architecture_consistency
* decision_registry_updates

### key_question

```text
Соответствует ли действие принятым решениям?
```

---

## core_knowledge_curator

### purpose

Управление Knowledge OS.

### responsibilities

* knowledge_classification
* knowledge_linking
* ontology_alignment
* knowledge_quality_control

### key_question

```text
Где находится знание?
```

---

# layer_2_orchestration_agents

Агенты слоя bgs_orch отвечают за выполнение процессов.

---

## orch_repository_guardian

### purpose

Наблюдение за эволюцией системы.

### responsibilities

* github_monitoring
* diff_analysis
* milestone_detection
* repository_sync
* architecture_alerts

### key_question

```text
Что изменилось в системе?
```

---

## orch_workflow_coordinator

### purpose

Координация workflow.

### responsibilities

* workflow_routing
* workflow_monitoring
* workflow_recovery
* execution_control

### key_question

```text
Что должно быть выполнено?
```

---

## orch_agent_coordinator

### purpose

Координация взаимодействия агентов.

### responsibilities

* task_distribution
* dependency_management
* execution_order_control

### key_question

```text
Как агентам работать вместе?
```

---

# layer_3_vector_agents

Агенты слоя bgs_vector отвечают за поиск и извлечение знаний.

---

## vector_context_builder

### purpose

Подготовка контекста.

### responsibilities

* retrieval
* context_assembly
* relevance_scoring
* context_compression

### key_question

```text
Какой контекст нужен сейчас?
```

---

## vector_memory_retriever

### purpose

Поиск знаний.

### responsibilities

* semantic_search
* memory_lookup
* knowledge_retrieval

### key_question

```text
Что система уже знает?
```

---

# layer_4_analytics_agents

Агенты слоя bgs_analytics отвечают за исследование среды.

---

## analytics_market_intelligence

### purpose

Исследование рынка и трендов.

### responsibilities

* trend_detection
* signal_monitoring
* opportunity_discovery
* market_analysis

### key_question

```text
Что меняется во внешней среде?
```

---

## analytics_content_intelligence

### purpose

Исследование контента.

### responsibilities

* content_pattern_analysis
* hook_detection
* retention_analysis
* topic_monitoring

### key_question

```text
Что привлекает внимание?
```

---

## analytics_learning_intelligence

### purpose

Исследование обучения и развития.

### responsibilities

* methodology_tracking
* learning_analysis
* development_pattern_detection

### key_question

```text
Что способствует развитию?
```

---

## analytics_research_scout

### purpose

Поиск новых знаний.

### responsibilities

* research_discovery
* source_monitoring
* evidence_collection

### key_question

```text
Что нового появилось в знаниях?
```

---

# layer_5_observability_agents

Агенты слоя bgs_observability отвечают за контроль состояния системы.

---

## observability_system_auditor

### purpose

Аудит системы.

### responsibilities

* system_health_monitoring
* anomaly_detection
* audit_generation

### key_question

```text
Система работает корректно?
```

---

## observability_backup_guardian

### purpose

Контроль резервного копирования.

### responsibilities

* backup_verification
* restore_validation
* retention_control

### key_question

```text
Можно ли восстановить систему?
```

---

# domain_agents

Доменные агенты строятся поверх системных агентов.

Примеры:

```text
education_parent_intelligence

education_development_tracker

marketing_signal_discovery

marketing_content_planner

research_insight_generator

family_planning_assistant

business_opportunity_discovery
```

Доменные агенты не создают собственную память и не являются источниками истины.

Они используют системные слои BGS.

---

# execution_rule

Перед созданием нового агента необходимо определить:

1. system_layer
2. purpose
3. responsibilities
4. source_of_truth
5. owner_layer

Только после этого допускается реализация.

---

# future_artifacts

На основе данной карты будут созданы:

* bgs_runtime_map_v1
* bgs_data_flow_map_v1
* bgs_memory_map_v1
* bgs_service_map_v1

---

# related_documents

* DEC-008-bgs-data-architecture.md
* DEC-009-human-ai-operating-model.md
* DEC-010-naming-conventions.md
* DEC-011-source-of-truth-model.md
* bgs_system_map_v1.md
