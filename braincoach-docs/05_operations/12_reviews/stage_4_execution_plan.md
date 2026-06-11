# Stage 4 — Execution Plan: Research Registry & Provenance Engine

**Status:** Planned  
**Date:** 2026-06-09  
**Goal:** Build a reliable Research Layer to transform raw observations into validated Canonical Signals.

---

## 1. Goal
Validate that parent observations can be reliably transformed into **Canonical Signals**, creating the first true "Microscope" for Research OS.

## 2. Deliverables
* **`signal_registry.md`**: Архитектурная спецификация (Онтология, жизненный цикл, логика Merge).
* **PostgreSQL Migration**: Создание таблиц `research_signal_candidates` и `signal_registry`.
* **Human Review Workflow**: Реализация контура ревью (Approve/Merge/Reject) в Telegram/n8n.
* **Operational Registry**: Запуск потока накопления данных.

## 3. Success Criteria (Research KPI)
1. **Registry Volume**: Минимум 100 валидированных канонических сигналов.
2. **Review Stability**: Workflow ревью работает без сбоев.
3. **Signal Compression Ratio**: Метрика качества экстракции (Canonical Signals / Raw Observations) стабильна.
4. **Human Throughput**: Скорость обработки сигналов не создает "бутылочное горлышко".

## 4. Exit Criteria
* Достигнут целевой объем в 100+ канонических сигналов.
* Workflow ревью работает в автономном режиме.
* Статистика сигналов (частота, повторения) стала измеримой для перехода к паттерн-аналитике.

## 5. Out of Scope (Strictly Forbidden)
* Pattern Detection / Clustering Engine.
* Phenomenon Discovery.
* Offer Discovery.
* Content Factory integration.
* Любые автоматические генераторы феноменов до завершения накопления данных.

---

**Execution Discipline:** Мы не строим "воздушные замки" кластеризации. Мы строим "микроскоп". Исследование начнется только тогда, когда в реестре будет достаточно материала для анализа.