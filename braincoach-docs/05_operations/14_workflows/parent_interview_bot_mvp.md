# parent_interview_bot_mvp

## status

draft

## purpose

Первый производственный агент Brain Growth System для проведения интервью родителей и формирования исследовательских данных.

---

## objective

Автоматически провести интервью родителя и сохранить результаты в bgs_core.

Результат работы:

* person
* parent_interview
* interview_responses
* observations
* research_signal_candidates

---

## source_of_truth

knowledge:

bgs_core

tables:

* persons
* parent_interviews
* interview_responses
* observations
* research_signal_candidates

---

## entry_point

telegram

trigger:

новый пользователь или команда:

/start

---

## workflow

### stage_01_person

найти пользователя

table:

persons

если пользователь отсутствует:

создать person

---

### stage_02_interview

создать запись:

parent_interviews

status:

started

---

### stage_03_question_loop

получить следующий вопрос

источник:

Parent Interview Script v1

отправить вопрос

получить ответ

сохранить ответ:

interview_responses

перейти к следующему вопросу

---

### stage_04_completion

изменить статус интервью:

completed

---

### stage_05_observation_extraction

все ответы передаются в Vertex

задача:

выделить наблюдения

результат:

observations

пример:

* без меня не начинает
* быстро теряет интерес
* избегает сложных задач
* требуется внешний контроль

---

### stage_06_signal_generation

на основе observations создать:

research_signal_candidates

пример:

* low_initiation
* weak_self_regulation
* external_motivation_dependency
* low_persistence

---

### stage_07_summary

сформировать краткое резюме интервью

отправить родителю

---

## mvp_success_criteria

успешным считается запуск, если система способна:

* создать person
* провести интервью
* сохранить ответы
* создать observations
* создать research_signal_candidates

без участия человека

---

## not_in_scope

не входят в MVP:

* trajectory scoring
* gps profiles
* assessments
* recommendations
* personalized plans
* analytics dashboards

---

## next_iteration

parent_interview_bot_v2

добавляет:

* trajectory assessment
* readiness estimation
* gps dimensions
* parent report
