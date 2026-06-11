# research_signal_generation_v1

## status

draft

## purpose

Преобразовать observations в research_signal_candidates.

Signal Generation является первым аналитическим уровнем Brain Growth System.

---

## principle

Signal не является диагнозом.

Signal не является выводом.

Signal является повторяющимся паттерном поведения, обнаруженным в наблюдениях.

---

## input

source:

observations

пример:

* не начинает деятельность без напоминания
* требуется внешний контроль
* ожидает указаний перед началом действий

---

## output

table:

research_signal_candidates

пример:

low_initiation

---

## transformation_flow

observations

↓

pattern detection

↓

research_signal_candidate

---

## signal_definition

Signal должен:

* основываться на наблюдениях
* быть повторяемым
* объяснять группу наблюдений
* быть нейтральным

---

## signal_quality_criteria

Хороший signal:

* наблюдаем
* объясняет поведение
* не является диагнозом
* не содержит оценок

Плохой signal:

* ленивый
* неуспешный
* проблемный
* безответственный

---

## example_01

observations:

* не начинает задачу без напоминания
* ждёт указаний
* редко проявляет инициативу

signal:

low_initiation

---

## example_02

observations:

* прекращает деятельность после первых трудностей
* избегает сложных задач
* быстро переключается на другое

signal:

low_persistence

---

## example_03

observations:

* требуется постоянный контроль
* работает только рядом со взрослым
* прекращает работу после ухода взрослого

signal:

external_regulation_dependency

---

## example_04

observations:

* часто отвлекается
* переключается между задачами
* теряет фокус

signal:

attention_instability

---

## storage

table:

research_signal_candidates

fields:

* candidate_id
* observation_id
* signal_name
* confidence
* status
* created_at

---

## confidence_model

0.00 - 0.30

слабый сигнал

---

0.31 - 0.70

умеренный сигнал

---

0.71 - 1.00

сильный сигнал

---

## governance

research_signal_candidate не является истиной.

Signal остается гипотезой до накопления достаточного количества наблюдений.

---

## resulting_flow

interview_responses

↓

observations

↓

research_signal_candidates

↓

future signal validation

↓

future trajectory assessment

---

## next_step

signal_validation_v1

Цель:

отделить устойчивые сигналы от случайных наблюдений.
