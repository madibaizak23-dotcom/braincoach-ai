# DEC-010-naming-conventions

## status

approved

## date

2026-06-10

---

# context

По мере роста Brain Growth System количество артефактов будет быстро увеличиваться:

* документы
* решения
* исследования
* агенты
* workflow
* базы данных
* таблицы
* сервисы
* репозитории

Без единого стандарта именования система начинает терять предсказуемость.

Разные части экосистемы начинают использовать разные правила.

Это усложняет:

* поиск
* автоматизацию
* индексацию
* RAG
* работу агентов
* сопровождение системы

---

# decision

BGS принимает единый стандарт именования для всех системных объектов.

Основной принцип:

Имена должны быть понятны человеку, предсказуемы для агентов и безопасны для автоматизации.

---

# rule_1_files

Все файлы именуются в формате:

```text
snake_case
```

Примеры:

```text
bgs_system_map_v1.md

source_of_truth_model.md

repository_guardian.md

market_intelligence_framework.md
```

Запрещено:

```text
BGS System Map.md

My New File.md

Final Version.md
```

---

# rule_2_folders

Все папки именуются в формате:

```text
snake_case
```

Примеры:

```text
systems

agent_maps

data_flows

source_of_truth

research_assets
```

---

# rule_3_decisions

Архитектурные решения используют префикс:

```text
DEC-XXX
```

Формат:

```text
DEC-001-name.md
```

Примеры:

```text
DEC-008-bgs-data-architecture.md

DEC-009-human-ai-operating-model.md

DEC-010-naming-conventions.md
```

---

# rule_4_maps

Карты системы используют формат:

```text
*_map_v1.md
```

Примеры:

```text
bgs_system_map_v1.md

bgs_agent_map_v1.md

bgs_runtime_map_v1.md
```

---

# rule_5_registries

Все реестры используют суффикс:

```text
_registry
```

Примеры:

```text
signal_registry.md

repository_registry.md

knowledge_registry.md
```

---

# rule_6_databases

Базы данных именуются по системному слою.

Формат:

```text
bgs_<layer>
```

Примеры:

```text
bgs_core

bgs_orch

bgs_vector

bgs_analytics

bgs_observability
```

Запрещено создавать базы, названия которых отражают временное состояние проекта.

Примеры нежелательных имен:

```text
braincoach_dev

new_database

test_db

n8n_v2_clean
```

---

# rule_7_database_tables

Таблицы PostgreSQL используют:

```text
snake_case
```

Примеры:

```text
tracker_entries

knowledge_assets

agent_runs

workflow_events

memory_objects
```

---

# rule_8_agents

Агенты используют формат:

```text
<layer>-<role>
```

Примеры:

```text
core-memory_keeper

core-decision_guardian

orch-repository_guardian

analytics-market_intelligence

analytics-learning_intelligence

observability-system_auditor
```

---

# rule_9_workflows

Workflow используют формат:

```text
<domain>-<agent>-<action>
```

Примеры:

```text
research-repository_guardian-sync

research-repository_guardian-analyze

education-parent_intake-process

education-gps-observation_ingest

marketing-market_intelligence-trend_scan

marketing-content_intelligence-signal_detection
```

Название workflow должно отвечать на вопросы:

* где работает
* кто выполняет
* что делает

---

# rule_10_services

Сервисы используют формат:

```text
bgs-<purpose>
```

Примеры:

```text
bgs-orch

bgs-api

bgs-memory

bgs-search

bgs-observability
```

---

# rule_11_versions

Версии отражаются явно.

Допустимо:

```text
bgs_system_map_v1.md

bgs_system_map_v2.md

bgs_system_map_v3.md
```

Запрещено:

```text
final.md

final_final.md

new_version.md

latest.md
```

---

# architectural_principle

Любое имя должно отвечать на два вопроса:

```text
Где находится объект?

Что делает объект?
```

Если по названию невозможно определить назначение объекта, имя считается неудачным.

---

# ai_governance_rule

Все агенты обязаны использовать данные соглашения при создании:

* документов
* workflow
* таблиц
* сервисов
* регистров
* артефактов памяти

Новые соглашения могут вводиться только через архитектурное решение (DEC).

---

# consequences

Система получает единый язык именования.

Это обеспечивает:

* предсказуемость структуры
* стабильность автоматизации
* удобство поиска
* качество RAG
* упрощение сопровождения
* совместимость будущих агентов

Данное решение является обязательным для всех новых компонентов Brain Growth System.
