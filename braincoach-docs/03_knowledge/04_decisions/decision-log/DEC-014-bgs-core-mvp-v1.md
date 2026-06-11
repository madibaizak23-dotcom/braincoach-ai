# DEC-014 BGS Core MVP v1

## Status

Approved

## Date

2026-06-10

---

# Context

После утверждения:

* DEC-008 BGS Data Architecture
* DEC-009 Human-AI Operating Model
* DEC-011 Source Of Truth Model
* DEC-012 BGS Foundation Bootstrap
* DEC-013 Orchestration Runtime Strategy

необходимо определить минимальный состав BGS Core для запуска первого рабочего контура BrainCoach.

Первой прикладной системой становится Parent Interview Bot.

Необходимо создать минимальный набор сущностей, достаточный для:

* проведения интервью родителей
* хранения истории взаимодействий
* накопления наблюдений
* формирования исследовательских сигналов
* интеграции с Knowledge OS

без преждевременного усложнения модели данных.

---

# Decision

В качестве первой версии BGS Core принимается BGS Core MVP v1.

Все новые компоненты Parent Interview Bot должны использовать данные сущности как основную модель хранения.

---

# BGS Core MVP v1

## persons

Главная сущность участников системы.

Используется для:

* родителей
* детей
* экспертов
* консультантов
* будущих ролей экосистемы

---

## conversations

Контейнер диалогов.

Хранит информацию о сессиях общения.

---

## messages

История сообщений.

Хранит входящие и исходящие сообщения внутри диалогов.

---

## parent_interviews

Экземпляры прохождения интервью родителями.

---

## interview_responses

Ответы на вопросы интервью.

Хранятся отдельно от структуры вопросов.

Это позволяет изменять интервью без потери накопленных данных.

---

## observations

Базовая исследовательская сущность системы.

Содержит наблюдения о поведении, развитии и особенностях человека.

---

## tracker_entries

Журнал исследовательских записей.

Содержит заметки, инсайты, гипотезы и прочие записи исследовательского контура.

---

## research_signal_candidates

Потенциальные сигналы, выявленные на основе наблюдений.

Используются для дальнейшего анализа и формирования исследовательских выводов.

---

## knowledge_assets

Объекты знаний Knowledge OS.

Содержат исследования, регистры, стандарты, методологии и прочие знания системы.

---

## decisions

Хранилище утвержденных архитектурных и системных решений.

Содержит DEC-документы и будущие решения BGS.

---

# Design Principle

Observation First.

Все аналитические сущности должны формироваться из наблюдений.

Базовая последовательность:

Observation
→ Research Signal Candidate
→ Hypothesis
→ Assessment
→ Trajectory

Система не должна создавать траектории и выводы без накопления наблюдений.

---

# Deferred Objects

Следующие сущности не входят в MVP и откладываются до появления достаточного объема данных:

* phenomena
* trajectory_profiles
* trajectory_dimensions
* mechanisms
* experiments
* knowledge_graph
* memory_graph
* vector_indexes
* embeddings
* cases

---

# Success Criteria

Успешным результатом считается:

* создание BGS Core MVP v1
* запуск Parent Interview Bot на новой модели данных
* запись интервью в bgs_core
* запись наблюдений в observations
* создание research_signal_candidates на основе наблюдений
* интеграция с Knowledge OS через knowledge_assets и decisions

---

# Consequences

Новые агенты BGS обязаны использовать BGS Core MVP v1 как основную модель хранения данных.

Расширение модели допускается только после появления реальных данных и подтвержденной необходимости новых сущностей.

---

# Related Decisions

* DEC-008 BGS Data Architecture
* DEC-009 Human-AI Operating Model
* DEC-011 Source Of Truth Model
* DEC-012 BGS Foundation Bootstrap
* DEC-013 Orchestration Runtime Strategy
