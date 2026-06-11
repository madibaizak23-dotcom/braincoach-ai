# DEC-013 Orchestration Runtime Strategy

## Status

Approved

## Date

2026-06-10

---

# Context

В экосистеме BrainCoach уже существуют несколько исторических runtime-инстансов:

* n8n-server-firestore
* n8n-v2-clean
* n8n-v2-postgres

Параллельно создан новый контур Brain Growth System (BGS):

* bgs_core
* bgs_orch
* bgs_analytics

Возник вопрос:

Следует ли использовать существующий runtime n8n или создать отдельный orchestration runtime для BGS.

---

# Decision

Создать отдельный orchestration runtime для BGS.

Существующие n8n-инстансы считаются legacy-runtime.

Они продолжают работать, но не становятся основой новой архитектуры.

---

# Approved Architecture

```text
Brain Growth System

├── Core
│   └── bgs_core
│
├── Orchestration
│   ├── bgs_orch
│   └── bgs-orchestrator
│
└── Analytics
    └── bgs_analytics
```

---

# Runtime Ownership

Primary Runtime:

bgs-orchestrator

Owner:

bgs_admin

---

# Database Ownership

bgs_core

Owner:

bgs_admin

---

bgs_orch

Owner:

bgs_admin

---

bgs_analytics

Owner:

bgs_admin

---

# Legacy Boundary

Legacy Runtime:

* n8n-server-firestore
* n8n-v2-clean
* n8n-v2-postgres

Legacy runtimes остаются доступными.

Новые BGS агенты не проектируются вокруг legacy-runtime.

---

# Design Principle

Не смешивать:

* legacy automation
* BGS orchestration

Каждая система имеет собственный жизненный цикл.

---

# Why

Отделение позволяет:

* безопасно развивать BGS
* независимо менять архитектуру
* внедрять новые агенты
* не создавать скрытые зависимости
* избежать накопления технического долга

---

# First Runtime Target

Service:

bgs-orchestrator

Purpose:

Запуск системных агентов BGS.

Первые агенты:

* AGENT-004 orch_repository_guardian

Будущие агенты:

* orchestration agents
* memory agents
* analytics agents

---

# Success Criteria

Создан отдельный runtime для BGS.

Первый агент запускается через bgs-orchestrator.

Legacy runtime не используется как основной orchestration слой BGS.

---

# Result

BGS получает собственный независимый orchestration runtime.
