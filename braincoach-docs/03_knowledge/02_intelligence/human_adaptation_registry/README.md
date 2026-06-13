# Human Adaptation Registry

## Purpose

Human Adaptation Registry (HAR) — внутренний слой BrainCoach Intelligence.

Реестр не предназначен для типирования людей, психологической диагностики или классификации личности.

Его задача — описывать устойчивые адаптационные стратегии, которые могут наблюдаться в поведении человека при решении задач, обучении и взаимодействии со средой.

Все паттерны рассматриваются как рабочие гипотезы и используются исключительно для подбора более эффективных вопросов, инструментов поддержки и компенсирующих механизмов.

---

## Design Principles

### Observation First

Система работает только с наблюдаемым поведением.

Агент анализирует действия, решения, затруднения и устойчивые паттерны поведения.

Система не определяет «кто человек».

Система анализирует «какая стратегия сейчас используется».

### Hypothesis Driven

Любой Adaptation Pattern является гипотезой.

Уровень уверенности может увеличиваться или уменьшаться по мере накопления наблюдений.

### Socratic Support

Паттерны используются не для выдачи выводов, а для выбора более полезных вопросов.

BrainCoach не сообщает пользователю:

"Вы относитесь к типу X."

BrainCoach помогает пользователю самостоятельно исследовать свои способы действия.

### Function Oriented

Основным объектом анализа является функция, а не тип.

Один человек может использовать разные адаптационные стратегии в разных контекстах.

---

## Registry Structure

### System Functions Registry

Описание базовых функций человеческой адаптации.

Функции используются как верхний уровень модели.

### Adaptation Patterns

Описание конкретных адаптационных стратегий.

Каждый паттерн содержит:

* Adaptation Strategy
* World Model
* Observable Indicators
* Verification Signals
* Typical Friction
* Failure Mode
* Core Fear
* Core Need
* Compensating Patterns
* Rule Library
* Socratic Questions
* Development Path

### Compensating Patterns

Реестр компенсирующих механизмов.

Компенсирующие паттерны позволяют снижать трение без изменения базовой стратегии адаптации.

Пример:

* CP-001 Materialization

### Agent Usage

Правила использования реестра агентами BrainCoach.

Содержит:

* Safety Rules
* Observation Rules
* Socratic Question Selection
* Support Strategies

---

## Current Function Model

| Function      | Primary Pattern |
| ------------- | --------------- |
| Energy        | Hyperthymic     |
| Understanding | Schizoid        |
| Safety        | Anxious         |
| Connection    | Emotive         |
| Direction     | Paranoid        |
| Visibility    | Hysteric        |
| Order         | Epileptoid      |

---

## Safety Rules

* Не использовать для диагностики.
* Не использовать для типирования личности.
* Не сообщать выводы как факты.
* Не делать прогнозы без наблюдаемых данных.
* Любой паттерн является временной рабочей гипотезой.

---

## Status

Version: HAR v1

Status: Active

Layer: BrainCoach Intelligence

Purpose: Internal Hypothesis Support
