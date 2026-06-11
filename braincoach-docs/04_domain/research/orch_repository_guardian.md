# orch_repository_guardian

## status

design

## purpose

Контроль эволюции Brain Growth System.

Агент отслеживает изменения в репозиториях, архитектуре, Knowledge OS и инфраструктуре, формируя единую историю развития системы.

---

# mission

Сделать так, чтобы BGS понимала собственную историю развития лучше любого человека.

---

# system_layer

bgs_orch

---

# domain

research

---

# source_of_truth

## code

github

## architecture

knowledge_os

## runtime

postgresql

---

# key_question

Что изменилось в системе и какие последствия это вызывает?

---

# inputs

## github

Источники:

* commits
* pull_requests
* tags
* releases

---

## knowledge_os

Источники:

* decisions
* registries
* ontology
* architecture_maps

---

## runtime

Источники:

* workflow_changes
* agent_changes
* deployment_events

---

# outputs

## change_summary

Краткое описание изменений.

---

## architecture_alert

Уведомление о возможном архитектурном конфликте.

---

## milestone_detection

Обнаружение значимых этапов развития.

Примеры:

* stage_completed
* architecture_changed
* domain_created
* agent_activated

---

## repository_journal_entry

Запись в журнал развития системы.

---

# responsibilities

## repository_monitoring

Следить за изменениями репозиториев.

---

## diff_analysis

Анализировать изменения.

Не только:

* что изменилось

Но и:

* зачем изменилось
* что затронуто
* какие последствия возможны

---

## milestone_tracking

Фиксировать этапы развития.

Примеры:

```text
stage_1_complete

stage_2_complete

stage_3_complete

architecture_v2

new_domain_created
```

---

## architecture_consistency_check

Проверять соответствие изменений:

* DEC решениям
* Source Of Truth
* Naming Conventions
* System Maps

---

## registry_updates

Предлагать обновления:

* repository_registry
* agent_registry
* decision_registry

---

# event_subscriptions

## github_commit_detected

---

## repository_updated

---

## architecture_document_changed

---

## decision_created

---

## workflow_created

---

## workflow_modified

---

## agent_registered

---

# memory_interaction

Читает:

* decision_memory
* knowledge_memory
* architecture_memory

Записывает:

* episodic_memory
* repository_history

---

# future_capabilities

## automated_release_notes

Автоматическая генерация release notes.

---

## architecture_drift_detection

Обнаружение расхождения между архитектурой и реализацией.

---

## implementation_gap_detection

Определение:

```text
описано в архитектуре
но не реализовано
```

---

## orphan_detection

Определение:

```text
реализовано
но нигде не описано
```

---

# success_metrics

## repository_visibility

Система знает все изменения.

---

## milestone_accuracy

Корректно определяются этапы развития.

---

## architecture_alignment

Минимизация расхождений между Knowledge OS и реализацией.

---

# implementation_phases

## phase_1

GitHub monitoring

commit tracking

change summaries

---

## phase_2

Knowledge OS monitoring

decision tracking

milestone detection

---

## phase_3

Architecture intelligence

drift detection

registry synchronization

---

# dependencies

* bgs_system_map_v1
* bgs_agent_map_v1
* bgs_data_flow_map_v1
* bgs_memory_map_v1
* bgs_governance_map_v1
* repository_registry
* agent_registry

---

# long_term_vision

orch_repository_guardian становится цифровым летописцем Brain Growth System.

Он хранит не только историю изменений, а историю причин, решений, последствий и эволюции всей экосистемы.
