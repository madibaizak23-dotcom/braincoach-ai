# Function Vector Model

Document ID: FVM-001

Version: v1.0

Status: Active

Layer: BrainCoach Intelligence

Purpose: Functional Representation Framework

---

# Purpose

Function Vector Model (FVM) является базовой моделью представления человеческой адаптации внутри BrainCoach OS.

Вместо типирования личности система оценивает выраженность адаптационных функций.

Это позволяет описывать состояние человека, команды, проекта или процесса через функциональный профиль, а не через ярлыки и категории.

---

# Core Principle

BrainCoach не отвечает на вопрос:

"Кто этот человек?"

BrainCoach отвечает на вопрос:

"Какие функции сейчас помогают развитию, а какие ограничивают его?"

---

# Function Registry

Current Function Set:

| Function      | Description                     |
| ------------- | ------------------------------- |
| Energy        | Запуск движения                 |
| Understanding | Построение моделей              |
| Safety        | Управление рисками              |
| Connection    | Поддержание отношений           |
| Direction     | Удержание стратегического курса |
| Visibility    | Демонстрация ценности           |
| Order         | Создание воспроизводимых систем |

---

# Function Vector Definition

Function Vector представляет собой набор относительных оценок по каждой функции.

Example:

```json
{
  "energy": 0.85,
  "understanding": 0.70,
  "safety": 0.40,
  "connection": 0.55,
  "direction": 0.80,
  "visibility": 0.35,
  "order": 0.25
}
```

---

# Interpretation Rules

Высокое значение функции не означает преимущество.

Низкое значение функции не означает недостаток.

Интерпретация всегда зависит от контекста.

Пример:

Высокий Safety полезен при управлении рисками.

Высокий Safety может тормозить запуск нового проекта.

---

# Function States

Каждая функция может находиться в одном из состояний.

## Dominant

Функция существенно влияет на поведение.

Range:

0.75 – 1.00

---

## Active

Регулярно участвует в принятии решений.

Range:

0.50 – 0.74

---

## Supportive

Используется эпизодически.

Range:

0.25 – 0.49

---

## Latent

Практически не участвует в текущем поведении.

Range:

0.00 – 0.24

---

# Function Balance Principle

Развитие не означает максимизацию всех функций.

Развитие означает достаточный баланс функций для текущей задачи.

---

# Example: Student Profile

Function Vector:

Energy: High

Understanding: High

Direction: Moderate

Order: Low

Interpretation:

Ученик способен запускать обучение и быстро понимать новые концепции.

Основное ограничение — отсутствие устойчивой системы выполнения.

Support Focus:

Strengthen Order Function.

---

# Example: Project Profile

Energy: High

Direction: High

Visibility: High

Order: Low

Result:

Проект хорошо запускается и активно продвигается.

Высок риск незавершенности и операционного хаоса.

---

# Function Deficit Logic

BrainCoach анализирует не только сильные функции.

Особое внимание уделяется дефицитам.

Example:

High Energy

High Direction

Low Order

Interpretation:

Основная проблема не в мотивации.

Основная проблема в системности.

---

# Function Overload Logic

Избыточная функция также может создавать ограничения.

Example:

Very High Safety

Low Energy

Result:

Паралич действий через анализ рисков.

---

# Function Interaction Model

Функции работают как система.

Некоторые сочетания усиливают друг друга.

---

## Common Synergies

Energy + Visibility

Высокая способность запускать инициативы и вовлекать людей.

---

Understanding + Direction

Стратегическое мышление.

---

Direction + Order

Создание устойчивых систем.

---

Connection + Visibility

Социальное влияние.

---

Safety + Order

Надежность и качество.

---

# Common Failure Combinations

Energy High

Order Low

Result:

Много запусков, мало завершений.

---

Understanding High

Energy Low

Result:

Много моделей, мало действий.

---

Visibility High

Understanding Low

Result:

Сильная презентация без глубины.

---

Direction High

Connection Low

Result:

Сильная стратегия, слабая поддержка людей.

---

# Observation Framework

Function Vectors не вычисляются по одному наблюдению.

Минимальные источники:

* observation entries
* behavior logs
* conversation signals
* activity records
* progress history

---

# Confidence Model

Каждая функция имеет отдельный confidence score.

Example:

Energy:

0.82

Confidence:

0.91

Meaning:

Система достаточно уверена в оценке функции Energy.

---

# Relationship With Adaptation Patterns

System Functions
↓
Function Vector
↓
Adaptation Patterns
↓
Compensating Patterns
↓
Support Strategies

Patterns помогают объяснить происхождение функции.

Function Vector используется для принятия решений.

---

# Agent Usage

Observation Agent

Определяет возможные функциональные сигналы.

---

Intelligence Agent

Формирует Function Vector.

---

Coaching Agent

Подбирает вопросы и интервенции.

---

GPS Agent

Отслеживает динамику изменения функций.

---

# Future Extensions

Planned:

* Team Function Vectors
* Family Function Vectors
* Seasonal Function Vectors
* Learning Function Vectors
* Phenomena Correlation Engine

---

# Safety Rules

* Не использовать для диагностики.
* Не использовать для типирования личности.
* Не сообщать оценки как факты.
* Использовать только как рабочие гипотезы.
* Всегда подтверждать выводы наблюдаемыми данными.

---

Status: Active

Owner: BrainCoach Intelligence

Registry: Function Vector Model

Version: v1.0
