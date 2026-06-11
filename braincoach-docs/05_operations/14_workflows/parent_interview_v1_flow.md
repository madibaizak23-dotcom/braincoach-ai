# parent_interview_v1_flow

## status

approved

## date

2026-06-10

---

## purpose

Определить первый рабочий поток прохождения интервью родителем внутри Brain Growth System.

Документ описывает движение данных от первого сообщения до появления observations и research_signal_candidates.

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

## flow

### step_01_person_identification

Пользователь начинает диалог.

Система:

* определяет telegram_user_id
* ищет существующую запись в persons
* создаёт новую запись при отсутствии

result:

person_id

---

### step_02_interview_creation

Создаётся новый объект интервью.

table:

parent_interviews

result:

interview_id

status:

started

---

### step_03_question_delivery

Система отправляет вопрос родителю.

Источник вопросов:

Parent Interview Script v1

knowledge_asset:

Parent Interview Script v1

---

### step_04_response_capture

Ответ родителя сохраняется.

table:

interview_responses

result:

question_code
response_text

---

### step_05_next_question

Система определяет следующий вопрос.

Если вопросы остались:

возврат к step_03

Если интервью завершено:

переход к step_06

---

### step_06_interview_completion

Интервью получает статус:

completed

table:

parent_interviews

---

### step_07_observation_generation

Ответы анализируются.

Из ответов извлекаются наблюдения.

table:

observations

examples:

* без меня не начинает
* быстро теряет интерес
* избегает сложных задач
* самостоятельно организует деятельность

---

### step_08_signal_candidate_generation

На основе observations создаются кандидаты в сигналы.

table:

research_signal_candidates

examples:

* low_initiation
* external_motivation_dependency
* weak_self_regulation
* persistence_signal

---

## resulting_data_flow

person

↓

parent_interview

↓

interview_responses

↓

observations

↓

research_signal_candidates

---

## success_criteria

После завершения интервью система содержит:

* person
* completed interview
* interview responses
* observations
* research signal candidates

без ручной обработки данных человеком.

---

## next_step

Создать workflow первого Parent Interview Bot внутри bgs-orchestrator.
