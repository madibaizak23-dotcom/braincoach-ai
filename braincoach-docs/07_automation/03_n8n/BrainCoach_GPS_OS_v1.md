# BrainCoach GPS OS v1

## Назначение

BrainCoach GPS OS — персональная Knowledge OS для фиксации, поиска, исследования и развития знаний пользователя через Telegram.

Система объединяет:

* Tracker
* Memory Retrieval
* Decisions
* Interview Engine
* Voice Input

в единый интерфейс через Telegram.

---

## Архитектура

### Intake Layer

Входящие сообщения проходят через единый слой обработки.

Потоки:

Text → SYS_LoadClient

Voice → VOI_GetFile → LLM_VOI_Transcriber → VOI_NormalizeMessage → SYS_LoadClient

После нормализации все сообщения становятся текстом и обрабатываются одинаково.

---

## Core Components

### SYS_LoadClient

Загружает или создает клиента.

Обеспечивает:

* client profile
* conversation state
* current stage
* qualification signals

---

### CMD_Router

Определяет маршрут обработки сообщения.

Возможные маршруты:

* tracker
* command

---

## Modules

### TRK — Tracker

Назначение:

Сохранение мыслей, наблюдений, инсайтов и решений.

Компоненты:

* TRK_SaveRawMessage
* LLM_TRK_Extractor
* TRK_ParseJSON
* TRK_SaveEntry

---

### REC — Recent

Команда:

/recent

Показывает последние записи пользователя.

---

### LST — Last

Команда:

/last

Возвращает последнюю запись.

---

### CNT — Count

Команда:

/count

Возвращает количество записей в трекере.

---

### FND — Find

Команда:

/find <keyword>

Поиск по сохраненным записям.

---

### DEC — Decisions

Команды:

/decision <text>
/decisions

Назначение:

Фиксация и просмотр архитектурных и продуктовых решений.

Таблица:

system_decisions

---

### INT — Interview

Команда:

/interview <topic>

Использует Gemini Flash для генерации следующего исследовательского вопроса.

Назначение:

Помощь в исследовании тем и формировании гипотез.

---

### VOI — Voice

Назначение:

Поддержка голосового ввода.

Компоненты:

* VOI_GetFile
* LLM_VOI_Transcriber
* VOI_NormalizeMessage

Используется Gemini Audio Transcription.

---

## Naming Convention

CMD_ — Command Routing

SYS_ — System

TRK_ — Tracker

REC_ — Recent

LST_ — Last

CNT_ — Count

FND_ — Find

DEC_ — Decision

INT_ — Interview

VOI_ — Voice

LLM_ — Gemini / Language Models

SEM_ — Semantic Layer (planned)

TRAJ_ — Trajectory Layer (planned)

---

## Current Status

Version: v1

State: Operational

Implemented:

✓ Voice Intake

✓ Tracker

✓ Recent

✓ Last

✓ Count

✓ Find

✓ Decisions

✓ Interview Engine

Planned:

* Semantic Search
* Trajectory Engine
* Memory Graph
* Knowledge Registry Sync
