# AGENT-004 orch_repository_guardian

## Status

Building

## Version

0.1

---

# Purpose

Отслеживать развитие репозиториев BrainCoach и формировать постоянную историю изменений.

Агент является первым системным агентом слоя Orchestration.

---

# Domain

orchestration

---

# Source Of Truth

Database:

bgs_orch

Tables:

* repository_journal
* agent_registry

---

# Mission

Сохранять историю развития экосистемы независимо от памяти человека.

Агент отвечает на вопрос:

Какие изменения происходили в системе?

---

# Inputs

GitHub Repository Events

Основные события:

* push
* commit
* merge

---

# Outputs

repository_journal records

---

# Version 0.1 Scope

Первая версия ничего не анализирует.

Первая версия только фиксирует изменения.

Принцип:

Capture First

Interpret Later

---

# Workflow

GitHub Event

↓

Extract Metadata

↓

Create Journal Record

↓

repository_journal

---

# Captured Fields

repository_name

commit_hash

commit_message

created_at

status

---

# Not Included In v0.1

Не выполняется:

* AI analysis
* milestone detection
* architecture review
* impact assessment
* repository scoring

---

# Future Roadmap

## Version 0.2

Change Summary Generation

Добавляется:

* change_summary

---

## Version 0.3

Architecture Impact Detection

Добавляется:

* architecture_impact

---

## Version 0.4

Milestone Detection

Добавляется:

* milestone_detected
* milestone_name

---

## Version 1.0

Repository Intelligence

Полноценный анализ развития репозитория.

---

# Runtime

Primary Runtime:

n8n

---

# Registry Entry

agent_id:

AGENT-004

agent_name:

orch_repository_guardian

status:

building

domain:

orchestration

source_of_truth:

repository_journal

---

# Success Criteria

Агент автоматически создает запись в repository_journal после каждого изменения репозитория.

---

# Current Stage

Building

