BrainCoach Intake Engine v1 Stable
Overview

Historical predecessor:
archive/qualification-engine-v3-cursor-original.json

Name: BrainCoach Intake Engine v1 Stable

Purpose:

Обработка входящих сообщений Telegram через BrainCoach AI.

Workflow выполняет:

идентификацию клиента
создание клиента при первом обращении
классификацию запроса
эмоциональный анализ
квалификацию клиента
обновление состояния клиента
запись событий в PostgreSQL
отправку следующего вопроса в Telegram

Данная версия является первым стабильным production-эталоном BrainCoach AI Intake System.

Scope

Входит:

Telegram
PostgreSQL
Google Sheets
Intake Classifier
Emotional Reflection
Qualification Engine
Validation Layer
Client State Management
Event Logging

Не входит:

Offer Engine
Booking Engine
Calendar
Payment Logic
Voice Intake
Reactivation Engine
Production Workflow Architecture
Telegram Trigger
        ↓
Postgres - Find Client
        ↓
IF - Client Exists?
   ├─ YES
   │
   └─ NO
         ↓
Postgres - Create Client
         ↓

keywords_master
        ↓
qualification_flow
        ↓
memory_signals
        ├─ Intake Classifier
        ├─ Emotional Reflection
        └─ Qualification Engine

         ↓
IF - All Valid?
      /      \
   TRUE      FALSE
     ↓          ↓
Postgres      Telegram
Update        Send Error
Client

     ↓
Postgres
Insert Event

     ↓
Telegram
Send Question
Credentials Used
Telegram

Используется Telegram Bot API

PostgreSQL

Используется BrainCoach PostgreSQL Database

Google Sheets

Используется Google Sheets OAuth

OpenAI

Используются модели:

GPT-5.4-NANO
GPT-5.4-MINI
Node-by-Node Flow
1. Telegram Trigger

Получает входящие сообщения пользователя

Ожидаемые поля:

{
  "message": {
    "text": "...",
    "chat": {
      "id": 123
    },
    "from": {
      "id": 456
    }
  }
}
2. Postgres - Find Client

Поиск клиента по:

telegram_user_id
3. IF - Client Exists?

Проверка существования клиента

TRUE

Переход к чтению Google Sheets

FALSE

Создание нового клиента

4. Postgres - Create Client

Создание новой записи клиента

Начальные значения:

{
  "current_stage": "new_lead",
  "total_messages": 0
}
5. GoogleSheets - keywords_master

Справочник ключевых слов

Используется Intake Classifier

6. GoogleSheets - qualification_flow

Справочник логики квалификации

Используется Qualification Engine

7. GoogleSheets - memory_signals

Справочник эмоциональных сигналов

Используется Emotional Reflection

AI Layer
8. OpenAI - Intake Classifier
Model

GPT-5.4-NANO

Purpose

Первичная классификация сообщения

Output
{
  "keyword": "",
  "segment": "",
  "consultation_type": "",
  "intent": "",
  "emotional_driver": "",
  "emotional_state": "",
  "emotional_intensity": 0,
  "interaction_type": "",
  "qualification_readiness": "",
  "memory_candidate": false,
  "memory_items": [],
  "confidence": 0,
  "next_route": ""
}
9. OpenAI - Emotional Reflection
Model

GPT-5.4-NANO

Purpose

Анализ эмоционального состояния пользователя

Output
{
  "emotional_state": "",
  "emotional_intensity": 0,
  "behavioral_signal": "",
  "tone_adjustment": "",
  "pace_adjustment": "",
  "state_change": "",
  "confidence": 0
}
10. OpenAI - Qualification Engine
Model

GPT-5.4-MINI

Purpose

Определение глубины квалификации и следующего вопроса

Output
{
  "qualification_depth": "",
  "pain_detected": true,
  "pain_summary": "",
  "emotional_driver_confirmed": true,
  "desired_outcome": "",
  "consultation_readiness": "",
  "offer_eligibility_signal": "",
  "next_question": "",
  "next_stage": "",
  "memory_updates": [],
  "confidence": 0
}
Validation Layer
11. Validate - Intake JSON

Проверяет корректность JSON от Intake Classifier

Result
{
  "valid": true
}

или

{
  "valid": false
}
12. Validate - Emotional JSON

Проверяет корректность JSON от Emotional Reflection

Result
{
  "valid": true
}

или

{
  "valid": false
}
13. Validate - Qualification JSON

Проверяет корректность JSON от Qualification Engine

Result
{
  "valid": true
}

или

{
  "valid": false
}
14. IF - All Valid?

Проверяет:

Validate Intake JSON = true
AND
Validate Emotional JSON = true
AND
Validate Qualification JSON = true
TRUE Branch

Workflow продолжается

FALSE Branch

Пользователь получает сообщение:

Извините, произошла ошибка обработки.
Попробуйте ещё раз через несколько секунд.
Client State Management
15. Postgres - Update Client

Обновляются поля таблицы clients

current_stage
current_keyword
qualification_depth
consultation_interest
emotional_state
emotional_intensity
interaction_type
total_messages
updated_at
last_message_at

Также:

total_messages = total_messages + 1
Event Logging
16. Postgres - Insert Event

Запись события в таблицу events

event_name
qualification_completed
event_category
intake
Сохраняемые поля
telegram_user_id
event_name
event_category
old_stage
new_stage
keyword
model_used
metadata
created_at
metadata

JSONB объект с результатами работы AI

Пример:

{
  "next_question": "Что именно чаще всего забывается: слова, имена, дела или прочитанное?",
  "pain_detected": true,
  "desired_outcome": "Понять, что именно происходит с памятью, и улучшить её работу",
  "qualification_depth": "initial",
  "consultation_readiness": "medium",
  "offer_eligibility_signal": "candidate_for_cognitive_diagnostics"
}
Telegram Output
17. Telegram - Send Question

Пользователю отправляется:

{{$node["Validate - Qualification JSON"].json.parsed.next_question}}

Пример:

Что именно чаще всего забывается: слова, имена, дела или прочитанное?
PostgreSQL Tables
clients

Используемые поля

id
telegram_user_id
first_name
username
current_stage
current_keyword
qualification_depth
consultation_interest
emotional_state
emotional_intensity
interaction_type
total_messages
created_at
updated_at
last_message_at
events

Используемые поля

id
telegram_user_id
event_name
event_category
old_stage
new_stage
keyword
model_used
metadata
created_at
Google Sheets Dependencies

Используются листы:

keywords_master
qualification_flow
memory_signals
Expected Inputs
{
  "message": {
    "text": "память",
    "chat": {
      "id": 300628321
    },
    "from": {
      "id": 300628321
    }
  }
}
Example Production Output
{
  "keyword": "память",
  "qualification_depth": "initial",
  "consultation_readiness": "medium",
  "offer_eligibility_signal": "candidate_for_cognitive_diagnostics",
  "next_stage": "problem_specifics",
  "next_question": "Что именно чаще всего забывается: слова, имена, дела или прочитанное?"
}
Version
BrainCoach Intake Engine v1 Stable
Release Date: 30 May 2026
Status: Production Stable
Notes

Это первая полностью рабочая production-версия BrainCoach Intake Engine.

Следующие системы будут строиться поверх неё:

Memory Engine
Stage Manager
Offer Engine
Booking Engine
Reactivation Engine
Voice Intake Engine

Данный workflow является базовым эталоном всей экосистемы BrainCoach AI.

# Production Status

Status: Stable

Validated Components:

✅ Telegram Trigger
✅ PostgreSQL Client State
✅ PostgreSQL Event Logging
✅ Google Sheets Configuration Layer
✅ Intake Classifier
✅ Emotional Reflection
✅ Qualification Engine
✅ JSON Validation Layer
✅ Telegram Response Layer

Last Verified:
2026-05-30

{
  "keyword": "память",
  "qualification_depth": "initial",
  "pain_detected": true,
  "consultation_readiness": "medium",
  "offer_eligibility_signal": "candidate_for_cognitive_diagnostics",
  "next_stage": "problem_specifics",
  "next_question": "Что именно чаще всего забывается: слова, имена, дела или прочитанное?"
}


# Status: Stable

Validated Components

✅ Telegram Trigger
✅ PostgreSQL Client State
✅ PostgreSQL Event Logging
✅ Google Sheets Control Layer
✅ Intake Classifier
✅ Emotional Reflection
✅ Qualification Engine
✅ JSON Validation Layer
✅ Telegram Response Layer

Last Verified

2026-05-30

# Lessons Learned

- Qualification Engine depends on Intake Classifier and Emotional Reflection outputs
- All AI outputs must pass JSON validation before state update
- Telegram nodes should reference Telegram Trigger chat.id directly
- PostgreSQL Update Client runs before Event Logging
- Event metadata stores qualification results for analytics
- Google Sheets acts as the behavioral control layer

## Historical Notes

The original qualification-engine-v3 was generated with Cursor AI.

Several compatibility issues were later identified during production validation:

- OpenAI output format mismatch
- Node reference mismatch
- Missing merge synchronization
- Invalid validation expressions

These issues were repaired in Intake Engine v1 Stable.

# Validation Evidence

Date: 2026-05-30

Validation steps completed:

✅ Workflow executed successfully

✅ PostgreSQL client update confirmed

✅ PostgreSQL event logging confirmed

✅ Telegram response delivery confirmed

✅ JSON validation layer confirmed

✅ IF All Valid routing confirmed

✅ Export created

✅ Export imported into a new n8n workflow

✅ Workflow graph rendered correctly after import

✅ End-to-end test completed using keyword:
"память"

Expected result:

- Client profile updated
- Event logged
- Qualification completed
- Next question delivered to Telegram

Result:

BrainCoach Intake Engine v1 Stable validated and confirmed operational.