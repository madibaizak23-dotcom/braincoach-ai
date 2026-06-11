# bgs_governance_map_v1

## status

draft_v1

## purpose

Описать модель управления Brain Growth System.

Документ отвечает на вопрос:

«Кто имеет право принимать решения, изменять систему и управлять знаниями внутри BGS?»

---

# governance_principle

Согласно DEC-009:

Человек является источником целей.

Система является исполнителем целей.

Управление BGS строится вокруг разделения ответственности между человеком и агентами.

---

# governance_hierarchy

```text
human
    ↓
governance_layer
    ↓
core_layer
    ↓
system_agents
    ↓
domain_agents
    ↓
workflows
```

---

# authority_levels

```text
level_0
level_1
level_2
level_3
level_4
```

---

# level_0_founder_authority

## owner

human

## role

Стратегический управляющий системы.

## permissions

* define_mission
* define_vision
* approve_architecture
* approve_decisions
* create_domains
* retire_domains

## examples

* создание нового домена
* изменение архитектуры
* изменение принципов системы
* утверждение DEC

---

# level_1_architecture_governance

## owners

* core_decision_guardian
* core_knowledge_curator

## permissions

* architecture_validation
* decision_consistency_check
* governance_monitoring

## restrictions

Не могут изменять стратегию.

---

# level_2_system_governance

## owners

system_agents

### examples

* core_memory_keeper
* orch_repository_guardian
* observability_system_auditor

## permissions

* manage_operations
* update_memory
* monitor_state
* execute_workflows

## restrictions

Не могут менять архитектуру.

---

# level_3_domain_governance

## owners

domain_agents

### examples

* education_parent_intelligence
* marketing_market_intelligence
* business_opportunity_discovery

## permissions

* domain_execution
* domain_analysis
* domain_recommendations

## restrictions

Не могут создавать новые системные правила.

---

# level_4_workflow_execution

## owners

workflows

## permissions

* execute_tasks
* move_data
* trigger_events

## restrictions

Не могут принимать решения.

---

# governance_domains

Управление разделяется по направлениям ответственности.

---

# architecture_governance

## owner

human

## scope

* system_structure
* system_layers
* architecture_decisions

---

# knowledge_governance

## owner

core_knowledge_curator

## scope

* knowledge_quality
* ontology_consistency
* knowledge_classification

---

# memory_governance

## owner

core_memory_keeper

## scope

* memory_integrity
* memory_updates
* memory_linking

---

# event_governance

## owner

event_router

## scope

* event_validation
* event_routing
* event_lifecycle

---

# workflow_governance

## owner

orch_workflow_coordinator

## scope

* workflow_execution
* workflow_recovery
* workflow_monitoring

---

# runtime_governance

## owner

observability_system_auditor

## scope

* infrastructure_health
* monitoring
* audit_control

---

# decision_model

Все решения делятся на три категории.

---

# strategic_decisions

## authority

human

## examples

* new_domain
* architecture_change
* mission_change

---

# tactical_decisions

## authority

agent_recommendation

human_approval

## examples

* process_change
* workflow_change
* research_priorities

---

# operational_decisions

## authority

system_agents

## examples

* routing
* classification
* indexing
* memory_updates

---

# memory_permissions

## create_memory

Разрешено:

* core_memory_keeper
* authorized_agents

---

## update_memory

Разрешено:

* core_memory_keeper

---

## delete_memory

Требует отдельного решения.

По умолчанию запрещено.

---

# knowledge_permissions

## create_knowledge

Разрешено:

* core_knowledge_curator
* authorized_research_agents

---

## modify_knowledge

Требует проверки согласованности.

---

## delete_knowledge

По умолчанию запрещено.

---

# architecture_permissions

Создание или изменение следующих объектов требует одобрения человека:

* system_layers
* domain_layers
* governance_rules
* source_of_truth_rules
* architecture_decisions

---

# escalation_model

Если агент сталкивается с:

* uncertainty
* conflicting_decisions
* governance_violation
* missing_authority

то выполняется:

```text
agent
    ↓
governance_escalation
    ↓
human_review
```

---

# governance_principles

## principle_1

```text
human_sets_direction
```

---

## principle_2

```text
agents_execute
```

---

## principle_3

```text
memory_before_action
```

---

## principle_4

```text
search_before_create
```

---

## principle_5

```text
architecture_before_implementation
```

---

# governance_metrics

В будущем система отслеживает:

* decision_quality
* memory_integrity
* workflow_reliability
* governance_violations
* architecture_compliance

---

# related_documents

* DEC-009-human-ai-operating-model.md
* DEC-010-naming-conventions.md
* DEC-011-source-of-truth-model.md
* bgs_system_map_v1.md
* bgs_agent_map_v1.md
* bgs_memory_map_v1.md
* bgs_event_map_v1.md

---

# status_note

Данный документ определяет систему власти и ответственности внутри Brain Growth System.

Любой новый агент, сервис, workflow или домен обязан определить свой уровень полномочий и зону ответственности до начала реализации.
