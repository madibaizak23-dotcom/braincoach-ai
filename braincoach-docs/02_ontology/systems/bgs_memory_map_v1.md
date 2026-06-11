# bgs_memory_map_v1

## status

draft_v1

## purpose

Описать архитектуру памяти Brain Growth System.

Документ отвечает на вопрос:

«Что система должна помнить и как организована память BGS?»

---

# memory_principle

Согласно DEC-009:

Человек не является хранилищем знаний системы.

Память является функцией BGS.

---

# memory_definition

Память BGS — это способность системы:

* сохранять информацию
* связывать информацию
* находить информацию
* обновлять информацию
* использовать прошлый опыт

---

# memory_architecture

```text id="n8r1jz"
BGS Memory

├── canonical_memory
├── knowledge_memory
├── decision_memory
├── operational_memory
├── research_memory
├── domain_memory
└── episodic_memory
```

---

# canonical_memory

## purpose

Хранение фундаментальных истин системы.

## source

```text id="0pt3rv"
00_canon
```

## examples

* principles
* vision
* mission
* axioms
* core beliefs

## update_frequency

Редко.

---

# knowledge_memory

## purpose

Хранение знаний системы.

## source

```text id="p8abdt"
03_knowledge
```

## examples

* research
* intelligence
* registries
* frameworks
* methodologies

## update_frequency

Постоянно.

---

# decision_memory

## purpose

Хранение архитектурных решений.

## source

```text id="iz1rjk"
DEC documents
```

## examples

* DEC-008
* DEC-009
* DEC-010
* DEC-011

## update_frequency

По мере появления новых решений.

---

# operational_memory

## purpose

Хранение состояния системы.

## source

```text id="d6smpo"
postgresql
```

## examples

* workflow_state
* agent_state
* execution_history
* task_status
* runtime_events

## update_frequency

Непрерывно.

---

# research_memory

## purpose

Хранение результатов исследований.

## source

```text id="k5yuk3"
research_assets
```

## examples

* studies
* observations
* hypotheses
* findings
* evidence

## update_frequency

Постоянно.

---

# domain_memory

## purpose

Хранение знаний по конкретным доменам.

## examples

### education

* development_patterns
* learning_models
* parent_observations

### marketing

* signals
* trends
* content_patterns

### business

* opportunities
* experiments
* business_models

### family

* plans
* observations
* family_intelligence

---

# episodic_memory

## purpose

Память о событиях.

## source

```text id="my7r2g"
events
```

## examples

* conversations
* milestones
* launches
* incidents
* system_changes

## update_frequency

Непрерывно.

---

# memory_lifecycle

```text id="76q3c0"
observation
      ↓
classification
      ↓
storage
      ↓
linking
      ↓
retrieval
      ↓
reuse
```

---

# memory_flow

## step_1_capture

Система получает новую информацию.

Источники:

* человек
* агенты
* исследования
* события
* внешняя среда

---

## step_2_classification

Информация классифицируется.

Определяется:

* тип
* домен
* значимость
* источник

---

## step_3_storage

Информация сохраняется в соответствующем типе памяти.

---

## step_4_linking

Создаются связи:

```text id="x8sg0d"
knowledge
↔ decisions

research
↔ observations

events
↔ outcomes

domains
↔ patterns
```

---

## step_5_retrieval

При запросе формируется контекст.

---

## step_6_update

Информация обновляется при появлении новых данных.

---

# memory_hierarchy

При конфликте памяти действует порядок:

```text id="v7u3lq"
canonical_memory
        ↓
decision_memory
        ↓
knowledge_memory
        ↓
research_memory
        ↓
operational_memory
        ↓
episodic_memory
```

Верхние уровни имеют больший приоритет.

---

# memory_owners

## core_memory_keeper

Основной владелец памяти.

Отвечает за:

* memory_integrity
* memory_updates
* memory_linking

---

## core_knowledge_curator

Отвечает за знания.

---

## core_decision_guardian

Отвечает за решения.

---

# retrieval_rule

Перед созданием нового знания агент обязан выполнить:

```text id="hsy3u2"
retrieve
before
create
```

Порядок:

1. canonical_memory
2. decision_memory
3. knowledge_memory
4. research_memory
5. domain_memory

Только затем допускается создание нового объекта.

---

# memory_storage_map

## github

Содержит:

* canonical_memory
* knowledge_memory
* decision_memory

---

## postgresql

Содержит:

* operational_memory
* event_memory

---

## vector_store

Содержит:

* retrieval_indexes
* semantic_links

---

## cloud_storage

Содержит:

* archives
* snapshots
* backups

---

# future_memory_agents

Планируемые агенты:

* core_memory_keeper
* vector_memory_retriever
* memory_link_builder
* memory_quality_auditor

---

# related_documents

* bgs_system_map_v1.md
* bgs_agent_map_v1.md
* bgs_data_flow_map_v1.md
* bgs_runtime_map_v1.md
* DEC-009-human-ai-operating-model.md
* DEC-011-source-of-truth-model.md

---

# status_note

Память является центральным механизмом Brain Growth System.

Любой новый агент, workflow или сервис обязан определить:

* какую память использует
* какую память обновляет
* какую память создает

до начала реализации.
