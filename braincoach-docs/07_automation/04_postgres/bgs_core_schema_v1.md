# BGS Core Schema v1

## Status

Draft

## Date

2026-06-10

---

# Purpose

Документ описывает первую рабочую схему данных BGS Core.

Схема реализует решение:

DEC-014 BGS Core MVP v1

Документ используется как источник проектирования SQL-модели и будущих миграций.

---

# Core Design Principles

## Observation First

Основная ценность системы формируется через наблюдения.

Базовый поток:

Person
→ Interview
→ Observation
→ Signal Candidate
→ Knowledge

---

## Human-Centered Model

Система хранит данные о людях и их развитии.

Все сущности привязываются к Person.

---

## Knowledge Separation

Знания, наблюдения и коммуникации являются отдельными слоями данных.

---

# Entity Model

## persons

Главная сущность системы.

### Purpose

Хранение участников экосистемы.

### Relationships

persons
├── conversations
├── parent_interviews
├── observations
├── tracker_entries
└── research_signal_candidates

---

## conversations

Контейнер диалогов.

### Stage Constraint

`chk_conversation_stage` allows:

* `new`
* `waiting_q1`
* `waiting_q2`
* `waiting_q3`
* `waiting_q4`
* `waiting_q5`
* `analysis`
* `completed`

`waiting_q5` was added for Summer Map v1.1.

### Relationships

persons
└── conversations
└── messages

---

## messages

Сообщения внутри диалогов.

---

## parent_interviews

Экземпляр прохождения интервью.

### Relationships

persons
└── parent_interviews
└── interview_responses

---

## interview_responses

Ответы на вопросы интервью.

---

## observations

Базовая исследовательская сущность.

### Purpose

Фиксация наблюдаемого поведения.

### Examples

* Без меня не начинает
* Быстро бросает задачу
* Сам организует тренировку

---

## tracker_entries

Исследовательский журнал.

### Types

* note
* observation
* insight
* hypothesis

---

## research_signal_candidates

Кандидаты в сигналы.

### Input

observations

### Output

будущие signal objects

---

## knowledge_assets

Объекты Knowledge OS.

### Examples

* Phenomena
* Research
* Registry
* Methodology
* Standard

---

## decisions

Утвержденные решения системы.

### Examples

* DEC-008
* DEC-009
* DEC-011
* DEC-012
* DEC-013
* DEC-014

---

# Relationship Overview

persons

├── conversations
│   └── messages
│
├── parent_interviews
│   └── interview_responses
│
├── observations
│
├── tracker_entries
│
└── research_signal_candidates

knowledge_assets

decisions

---

# Future Extensions

Следующие сущности не входят в v1:

* phenomena
* trajectory_profiles
* trajectory_dimensions
* assessments
* memory_graph
* knowledge_graph
* embeddings
* vector_indexes

Добавление допускается после накопления реальных данных.

---

# Success Criteria

Схема поддерживает:

* Parent Interview Bot
* Observation Capture
* Signal Discovery
* Knowledge OS Integration

без необходимости дополнительных сущностей.
