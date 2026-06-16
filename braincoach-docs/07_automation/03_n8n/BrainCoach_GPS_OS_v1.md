# BrainCoach GPS OS

## Назначение

BrainCoach GPS OS — персональная Knowledge OS для фиксации, поиска, исследования и развития знаний пользователя через Telegram.

Система объединяет:

* Tracker
* Observation Layer
* Signal Extraction Layer
* Memory Retrieval
* Decisions
* Interview Engine
* Voice Input

в единый интерфейс через Telegram.

---

## Positioning Alignment

Current BrainCoach category:

Trajectory Intelligence System

Research Object:

Trajectory Development

Mechanism Layer:

Learning Intelligence

Sub-object:

Self Learning Capability

GPS is the operational capture and intelligence interface for observing trajectory signals over time.

---

## Версия

Version: MVP-1 bgs_core adapted

State: Production

Export: `BrainCoach GPS MVP-1 — bgs_core adapted.json`

Supersedes: `BrainCoach GPS OS — Stage 3 Complete.json`

Previous versions:

* v1 — базовый Tracker без Observation и Signal layers
* v2 — промежуточные итерации signal extraction

V3 — текущая рабочая production-версия.

---

## Архитектура

### Intake Layer

Входящие сообщения проходят через единый слой обработки.

Потоки:

Text → SYS_LoadContext → SYS_BuildInputContext → SYS_RouteInput

Voice → VOI_CheckVoice → VOI_GetFile → VOI_Transcribe → VOI_NormalizeTranscript → SYS_LoadContext

После нормализации все сообщения становятся текстом и обрабатываются одинаково.

---

## Core Components

### SYS_LoadContext

Загружает или создает клиента.

Обеспечивает:

* client profile
* conversation state
* current stage (`tracking`)
* qualification signals

---

### SYS_RouteInput

Определяет маршрут обработки сообщения.

Возможные маршруты:

* tracker — обычный ввод для захвата
* command — slash-команды (`/recent`, `/last`, и т.д.)

---

## Modules

### TRK — Tracker

Назначение:

Сохранение мыслей, наблюдений, инсайтов и решений.

Компоненты:

* TRK_SaveRawEvent
* TRK_ExtractEntry
* TRK_ParseEntry
* TRK_SaveEntry
* TRK_GetEntryCount
* TRK_ReplySaved

Таблицы:

* `messages`
* `tracker_entries`

---

### OBS — Observation Layer

Назначение:

Создание структурированного research-объекта из tracker entry.

Компоненты:

* OBS_CreateObservation

Таблица:

* `observations`

Статус: Operational

---

### SIG — Signal Extraction Layer

Назначение:

Извлечение signal candidates из observations без немедленного promotion в confirmed signals.

Компоненты:

* SIG_ExtractSignalCandidate (LangChain Agent)
* SIG_ParseCandidate
* SIG_HasCandidate
* DB_SaveSignalCandidate

Таблица:

* `research_signal_candidates`

Статус: Operational

Первые валидированные категории:

* self_initiation
* dependence_external

Expected JSON output:

```json
{
  "has_signal": true,
  "signal_text": "",
  "signal_type": "",
  "confidence": 0.0,
  "evidence": "",
  "reason": ""
}
```

---

### HIS — History

Команда:

/recent

Компоненты:

* HIS_CheckRecent
* HIS_LoadEntries
* HIS_FormatReply
* HIS_Reply

Показывает последние 5 записей пользователя.

---

### REC — Recent

Команда:

/recent

(реализовано через HIS-модуль)

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

Использует LLM для генерации следующего исследовательского вопроса.

Назначение:

Помощь в исследовании тем и формировании гипотез.

---

### VOI — Voice

Назначение:

Поддержка голосового ввода.

Компоненты:

* VOI_CheckVoice
* VOI_GetFile
* VOI_Transcribe
* VOI_NormalizeTranscript

---

## Production Pipeline

```text
TG_Trigger
↓
VOI_CheckVoice (voice path)
↓
SYS_LoadContext
↓
SYS_BuildInputContext
↓
SYS_RouteInput
↓
TRK_IsTrackerEvent
↓
TRK_SaveRawEvent
↓
TRK_ExtractEntry
↓
TRK_ParseEntry
↓
TRK_SaveEntry
↓
OBS_CreateObservation
↓
SIG_ExtractSignalCandidate
↓
SIG_ParseCandidate
↓
SIG_HasCandidate
↓
DB_SaveSignalCandidate (if has_signal)
↓
TRK_GetEntryCount
↓
TRK_ReplySaved
```

---

## Naming Convention

CMD_ — Command Routing

SYS_ — System

TRK_ — Tracker

OBS_ — Observation

SIG_ — Signal Extraction

HIS_ — History

REC_ — Recent

LST_ — Last

CNT_ — Count

FND_ — Find

DEC_ — Decision

INT_ — Interview

VOI_ — Voice

LLM_ — Language Models

DB_ — Database persistence

SEM_ — Semantic Layer (planned — Stage 4+)

TRAJ_ — Trajectory Layer (planned)

---

## Current Status

Version: MVP-1.1

State: Production

Implemented:

✓ Voice Intake

✓ Tracker

✓ Observation Layer

✓ Signal Extraction Layer

✓ Recent

✓ Last

✓ Count

✓ Find

✓ Decisions

✓ Interview Engine

Known Limitations:

* Research notes and parent reflections can be misclassified as behavioral signals
* Extractor metadata (tags, summary) not fully persisted into tracker_entries.metadata
* No deduplication across observations or signal candidates
* No promotion path from candidate to confirmed signal
* Mixed LLM providers (Vertex AI migration planned — Stage 4)

Planned (Stage 4):

* Vertex AI Migration
* Analytics Layer
* Signal Aggregation
* Pattern Detection
* Weekly Reports

---

## Documentation References

* Workflow spec: `braincoach-docs/07_automation/02_workflows/tracker_capture_v1.md`
* Production export: `braincoach-docs/07_automation/03_n8n/BrainCoach GPS MVP-1.1 — Reflection Coach GPS Publish.json`
* Production note: `braincoach-docs/07_automation/03_n8n/BrainCoach GPS MVP-1.1 — Reflection Coach GPS Publish.md`
* Previous production export: `braincoach-docs/07_automation/03_n8n/BrainCoach GPS MVP-1 — bgs_core adapted.json`
* Migration report: `braincoach-docs/07_automation/03_n8n/BrainCoach GPS MVP-1 — bgs_core adapted.diff-report.md`
* Signal candidates table: `braincoach-docs/07_automation/04_postgres/research_signal_candidates.md`
* Stage 3 report: `braincoach-docs/05_operations/reviews/stage_3_completion_report.md`
* Stage 4 plan: `braincoach-docs/05_operations/planning/stage_4_planning.md`
