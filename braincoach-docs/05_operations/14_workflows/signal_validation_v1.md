# signal_validation_v1

## status

draft

## purpose

Отделить устойчивые исследовательские сигналы от случайных наблюдений.

Signal Validation является границей между исследовательским контуром и контуром навигации Brain Growth System.

---

## principle

Observation является фактом.

Research Signal Candidate является гипотезой.

Только подтвержденный сигнал может использоваться для построения траектории.

---

## input

source:

research_signal_candidates

---

## output

validated signals

будущий источник для trajectory assessment.

---

## validation_levels

### level_01_candidate

Статус по умолчанию.

Источник:

research_signal_candidates

Требования:

* создан на основе observations
* еще не подтвержден

---

### level_02_supported

Сигнал подтверждается несколькими observations.

Требования:

* минимум 3 связанных observations
* confidence выше порога

---

### level_03_validated

Сигнал стабильно подтверждается.

Требования:

* наблюдается во времени
* подтверждается несколькими ответами интервью
* не противоречит другим данным

---

## validation_rules

### rule_01_frequency

Чем чаще встречается паттерн, тем выше вероятность устойчивого сигнала.

---

### rule_02_consistency

Сигнал должен подтверждаться разными наблюдениями.

Не допускается построение сигнала по одному наблюдению.

---

### rule_03_temporal_stability

Сигнал должен сохраняться во времени.

Случайное событие не является сигналом.

---

### rule_04_conflict_check

Если наблюдения противоречат друг другу:

сигнал не валидируется автоматически.

---

## example_01

observations:

* не начинает без напоминания
* ждёт указаний
* редко проявляет инициативу

signal:

low_initiation

status:

supported

---

## example_02

observations:

* прекращает задачу после первых трудностей
* избегает сложных задач
* переключается на более лёгкую деятельность

signal:

low_persistence

status:

validated

---

## confidence_update

candidate

0.00 - 0.30

---

supported

0.31 - 0.70

---

validated

0.71 - 1.00

---

## governance

Сигнал не является диагнозом.

Сигнал не является характеристикой личности.

Сигнал является рабочей исследовательской моделью поведения.

---

## resulting_flow

interview_responses

↓

observations

↓

research_signal_candidates

↓

signal_validation

↓

validated_signals

↓

trajectory_assessment

---

## success_criteria

Система способна:

* отделять случайные наблюдения от устойчивых паттернов
* повышать confidence сигнала
* создавать набор validated signals
* передавать validated signals в контур траектории

---

## next_step

trajectory_assessment_v1

Цель:

построение профиля развития на основе validated signals.
