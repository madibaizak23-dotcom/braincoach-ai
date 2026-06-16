# BrainCoach Season Registry v1.1

## Status

Accepted

## Date

2026-06-05

---

# Purpose

Season Registry stores BrainCoach research seasons.

A season unites signals, phenomena, questions, hypotheses, experiments, and outcomes around a single research program.

If Phenomenon Registry stores units of knowledge, Season Registry stores the research programs that generate knowledge.

---

# Role of a Season

* A season defines one research focus.
* A season limits the range of questions.
* A season maintains coherence across observations, signals, phenomena, and conclusions.
* A season lives longer than individual content pieces and shorter than the entire system.
* A season transforms isolated phenomena into a structured investigation.
* A season accumulates evidence until a meaningful cognitive shift becomes possible.

---

# Principles

* One season = one major research question or one major research line.
* Every season must be formulated as a question about humans.
* A season is not a content theme.
* A season begins with reality signals.
* A season ends with a validated mechanism, refined hypothesis, or new model.
* A season must have a beginning, scope, investigation process, and closure.
* A season must not continue indefinitely.
* A season must contribute to understanding people.

---

# Research Flow

Signal

↓

Phenomenon

↓

Question

↓

Hypothesis

↓

Experiment

↓

Outcome

↓

Mechanism

↓

Cognitive Shift

↓

Model

---

# Required Fields

Every season record must contain:

* Season-ID
* Title
* Reason for Opening
* Main Question
* Core Hypothesis
* Scope
* Source Signals
* Included Phenomena
* Included Experiments
* Start Date
* End Date
* Status
* Evidence Summary
* Key Outcomes
* Key Mechanisms
* Cognitive Shift
* Canonical Impact
* Next Season

---

# Fields

## Season-ID

Unique season identifier.

Example:

SEASON-001

---

## Title

Short season name.

---

## Reason for Opening

Why the season was created.

What recurring observation, signal cluster, contradiction, or risk triggered the investigation?

---

## Main Question

The primary research question.

Must be formulated as a question about humans.

Example:

Why do some children become self-learners while others remain dependent on external control?

---

## Core Hypothesis

The central hypothesis being tested.

---

## Scope

Defines boundaries.

What belongs inside the season and what does not.

---

## Source Signals

Signals that initiated the season.

Links to Signal Dictionary.

---

## Included Phenomena

List of phenomena investigated within the season.

Links to Phenomenon Registry.

---

## Included Experiments

List of experiments conducted within the season.

---

## Start Date

Date the season started.

---

## End Date

Date the season ended.

---

## Status

Allowed values:

* draft
* active
* closing
* closed
* archived

---

## Evidence Summary

Overall strength of findings.

Allowed values:

* weak
* moderate
* strong

---

## Key Outcomes

Most important results produced during the season.

---

## Key Mechanisms

Mechanisms validated, refined, or rejected.

---

## Cognitive Shift

The new understanding produced by the season.

One sentence only.

---

## Canonical Impact

Impact on higher knowledge layers.

Allowed values:

* none
* knowledge_update
* ontology_update
* canon_candidate

---

## Next Season

The next research direction emerging from current findings.

---

# Lifecycle

draft

↓

active

↓

closing

↓

closed

↓

archived

---

# Rules

* Do not confuse a season with a content calendar.
* Do not open a season without a main question.
* Do not open a season without supporting signals.
* Do not close a season without a cognitive shift.
* Do not create a season that does not improve understanding of people.
* Do not repeat a season without new research value.
* Every season must contain at least one phenomenon.
* Every season should ideally produce at least one model candidate.

---

# Strategic Value

Season Registry creates continuity in research.

It groups signals and phenomena into coherent programs rather than isolated observations.

Over time it becomes the map of BrainCoach's long-term investigation into human learning, adaptation, performance, and development.

The goal is not to collect seasons.

The goal is to accumulate understanding across time.

---

# Season Records

## SEASON-2026-SUMMER-01

Season-ID:
SEASON-2026-SUMMER-01

Title:
Лето как тест самостоятельности

Reason for Opening:
Лето убирает внешнюю систему управления и делает видимыми скрытые феномены, которые в учебном году могут быть замаскированы школой, расписанием, учителями, тренерами, родительскими напоминаниями и внешним контролем.

Main Question:
Что происходит с ребёнком, когда исчезает внешний оператор?

Core Hypothesis:
Школа и другие внешние структуры могут скрывать отсутствие внутренней системы управления; лето снимает эту внешнюю опору и проявляет реальные сигналы самостоятельности, зависимости, перегруза и распада действия.

Scope:
Летние периоды, каникулы и другие ситуации, где привычная внешняя структура ослабевает или исчезает. В фокусе: самостоятельный старт, удержание действия, зависимость от напоминаний, распад режима, родительская нагрузка и сигналы скрытых феноменов.

Source Signals:
Распад дня без школы; зависимость от напоминаний; родитель как операционная система; усиление проблемы летом; отсутствие самостоятельного старта; возврат старых паттернов после внешней поддержки.

Included Phenomena:
PH-001 / PH-002 / PH-003 / PH-004 / NEW seasonal phenomenon candidates.

Included Experiments:
Контент-план 15-21 июня; DM-сбор кейсов; интервью с родителями; вопросы о том, что ломается летом без школы и что происходит, если перестать напоминать.

Start Date:
2026-06-15

End Date:
2026-06-21

Status:
active

Evidence Summary:
moderate

Key Outcomes:
To be updated after Season Review.

Key Mechanisms:
External operator dependency; hidden structure masking; summer structure collapse.

Cognitive Shift:
Школа скрывает сигналы. Лето делает сигналы видимыми.

Canonical Impact:
knowledge_update

Next Season:
To be defined after Season Review.

---

# Minimal Record Template

```md
Season-ID:

Title:

Reason for Opening:

Main Question:

Core Hypothesis:

Scope:

Source Signals:

Included Phenomena:

Included Experiments:

Start Date:

End Date:

Status:

Evidence Summary:

Key Outcomes:

Key Mechanisms:

Cognitive Shift:

Canonical Impact:

Next Season:
```
