# DEC-011-source-of-truth-model

## status

approved

## date

2026-06-10

---

# context

По мере развития Brain Growth System количество источников данных постоянно увеличивается.

Система использует:

* GitHub
* PostgreSQL
* Google Sheets
* Vertex AI
* Cloud Storage
* n8n
* документы Knowledge OS

Без явного определения источников истины возникает риск:

* дублирования данных
* конфликтов версий
* расхождения знаний
* ошибок автоматизации
* неправильных действий агентов

Для долгосрочной устойчивости необходимо определить, какой источник является авторитетным для каждого типа информации.

---

# decision

В BGS каждый тип информации обязан иметь один главный источник истины.

Если данные существуют в нескольких местах, только один источник считается авторитетным.

Все остальные копии являются производными представлениями.

---

# principle

```text
one_domain
one_truth
one_owner
```

Для каждого типа данных существует:

* один источник истины
* один владелец
* один процесс обновления

---

# source_of_truth_hierarchy

```text
BGS

├── knowledge_truth
├── code_truth
├── runtime_truth
├── reference_truth
├── reasoning_truth
└── archive_truth
```

---

# knowledge_truth

## source

Knowledge OS

## location

```text
00_canon
01_foundation
02_ontology
03_knowledge
```

## owner

bgs_core

## authority

Авторитетный источник знаний системы.

Содержит:

* канон
* решения
* исследования
* онтологии
* регистры
* архитектуру

При конфликте знаний побеждает Knowledge OS.

---

# code_truth

## source

GitHub repositories

## owner

repository_guardian

## authority

Авторитетный источник кода.

Содержит:

* исходный код
* инфраструктуру
* workflow exports
* конфигурации
* историю изменений

При конфликте версий побеждает GitHub.

---

# runtime_truth

## source

PostgreSQL

## owner

bgs_orch

## authority

Авторитетный источник состояния системы.

Содержит:

* agent_state
* workflow_state
* execution_history
* events
* operational_data

При конфликте состояния побеждает PostgreSQL.

---

# reference_truth

## source

Google Sheets

## owner

domain_owners

## authority

Авторитетный источник управляемых справочников.

Примеры:

* keyword_dictionary
* signal_dictionary
* classification_rules
* lookup_tables

Google Sheets используется только для управляемых справочников.

Knowledge OS не должен использоваться как оперативный справочник.

---

# reasoning_truth

## source

Vertex AI

## owner

bgs_analytics

## authority

Источник рассуждений.

Vertex не является источником истины.

Vertex производит:

* гипотезы
* объяснения
* выводы
* предложения

Все результаты должны опираться на утвержденные источники истины.

---

# archive_truth

## source

Cloud Storage

## owner

bgs_observability

## authority

Источник архивов.

Содержит:

* backups
* snapshots
* exports
* recovery_assets

Архив не является рабочим источником данных.

---

# non_authoritative_systems

Следующие системы не являются источниками истины:

## n8n

Назначение:

Оркестрация процессов.

Не хранит авторитетные данные.

---

## agents

Назначение:

Выполнение задач.

Не являются владельцами знаний.

---

## workflows

Назначение:

Автоматизация.

Не являются источниками истины.

---

## prompts

Назначение:

Управление поведением.

Не являются источниками истины.

---

# conflict_resolution

При конфликте данных применяется следующий порядок.

## знания

```text
knowledge_os
>
vertex
>
agents
```

---

## код

```text
github
>
local_files
```

---

## состояние

```text
postgresql
>
workflow_memory
>
agent_memory
```

---

## справочники

```text
google_sheets
>
local_copies
```

---

## архивы

```text
cloud_storage
>
local_exports
```

---

# search_before_create

Любой агент обязан соблюдать порядок:

1. проверить source_of_truth
2. проверить registries
3. проверить decisions
4. проверить existing_assets
5. только потом создавать новое

Принцип:

```text
search_before_create
```

---

# architectural_rule

Перед созданием любого нового объекта необходимо определить:

```text
где хранится истина?
```

Если источник истины не определен, проектирование считается незавершенным.

---

# consequences

BGS получает единый механизм разрешения конфликтов данных.

Любой агент может определить:

* где искать знания
* где искать код
* где искать состояние
* где искать справочники
* где искать архивы

Это позволяет масштабировать экосистему без потери согласованности данных.

---

# related_decisions

* DEC-008-bgs-data-architecture.md
* DEC-009-human-ai-operating-model.md
* DEC-010-naming-conventions.md

---

# status_note

Данное решение определяет источники истины для всей экосистемы Brain Growth System.

Ни один новый сервис, агент или workflow не может быть спроектирован без явного указания своего source_of_truth.
