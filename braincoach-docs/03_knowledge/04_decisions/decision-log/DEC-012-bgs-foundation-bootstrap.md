# DEC-012 BGS Foundation Bootstrap

## Status

Approved

## Date

2026-06-10

---

# Purpose

Зафиксировать первую рабочую инфраструктуру Brain Growth System (BGS).

Документ является Source of Truth для административных пользователей и системных баз данных BGS.

---

# MILESTONE-001

## BGS Administrative Boundary Established

Достигнуто:

* Создан пользователь `bgs_admin`
* Создана база `bgs_core`
* Создана база `bgs_orch`
* Создана база `bgs_analytics`
* BGS отделен от инфраструктуры n8n
* BGS отделен от legacy-баз

Дата достижения:

2026-06-10

---

# User Model

## postgres

Назначение:

Инфраструктурный администратор Cloud SQL.

Использование:

* аварийное восстановление
* обслуживание инстанса
* системное администрирование

Не используется агентами BGS.

---

## n8n_user

Назначение:

Технический пользователь платформы n8n.

Основная база:

* n8n_v2_clean

Область ответственности:

* workflows
* executions
* credentials
* automation runtime

Не является владельцем BGS.

---

## bgs_admin

Назначение:

Системный владелец Brain Growth System.

Область ответственности:

* BGS Core
* BGS Orchestration
* BGS Analytics

Является главным административным пользователем BGS.

---

# Database Model

## bgs_core

Owner:

bgs_admin

Назначение:

Source of Truth системы знаний.

Будущие компоненты:

* knowledge assets
* ontology
* memory
* registries
* decisions

---

## bgs_orch

Owner:

bgs_admin

Назначение:

Orchestration Layer.

Будущие компоненты:

* repository_journal
* agent_registry
* execution_registry
* workflow_registry
* event processing

---

## bgs_analytics

Owner:

bgs_admin

Назначение:

Analytics Layer.

Будущие компоненты:

* intelligence signals
* trend analysis
* behavioral analytics
* content analytics

---

# Ownership Model

Infrastructure Layer

* postgres

Application Layer

* n8n_user

System Layer

* bgs_admin

---

# Source Of Truth

Для всех новых компонентов BGS:

1. Пользователь: bgs_admin
2. Базы данных: bgs_core, bgs_orch, bgs_analytics
3. Новые агенты не используют legacy базы напрямую

---

# Result

Сформирована первая независимая административная граница BGS.
