# BrainCoach AI — Архитектурный Анализ
**Role:** Senior Solution Architect  
**Date:** 2026-06-01  
**Статус существующей системы:** Production-partial (Qualification Engine — 65/100, остальные — stubs)

---

## Предварительная оценка: стоит ли автоматизировать?

> [!IMPORTANT]
> **Вывод: Да, автоматизация оправдана — но только на конкретных участках.**

| Участок | Ручной процесс | Автоматизация | Решение |
|---------|---------------|---------------|---------|
| Приём кодового слова → первый вопрос | ~2 мин на ответ, теряются лиды ночью | Мгновенно, 24/7 | **Автоматизировать** |
| Квалификация Q1–Q3 | Менеджер теряет нить при 10+ диалогах | Structured dialogue, не забывает | **Автоматизировать** |
| Финальный офер после Q3 | Живой человек конвертирует лучше | AI плохо читает «тёплые» сигналы | **Гибрид: AI готовит → менеджер отправляет** |
| Запись на консультацию | Ручная — теряются лиды | Ссылка + подтверждение автоматом | **Автоматизировать** |
| Сама консультация | Живой эксперт необходим | AI не заменит | **Ручной процесс** |
| Реактивация sleeping | Ручной забывается | Scheduled job | **Автоматизировать** |

**Главное правило:** AI квалифицирует → менеджер закрывает. Гибридная модель даёт лучшую конверсию, чем полная автоматизация.

---

# ЭТАП 1 — Архитектура системы

## 1.1 Основные сущности и их роли

```
┌─────────────────────────────────────────────────────────────────┐
│                    ИСТОЧНИКИ ТРАФИКА                             │
│   Instagram DM  │  TikTok Comment  │  Telegram Direct           │
└──────────────────────────┬──────────────────────────────────────┘
                           │ кодовое слово / обращение
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│                    ТОЧКА ВХОДА                                   │
│              Telegram Bot (единый канал)                         │
│   Instagram/TikTok → "Напиши в Telegram: [слово]"               │
└──────────────────────────┬──────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│                    n8n ORCHESTRATION                             │
│  [Intake] → [Qualify] → [Offer] → [Book] → [Reactivate]        │
└──────┬──────────────────────────────────────────────────────────┘
       │                        │                    │
       ▼                        ▼                    ▼
  PostgreSQL              Google Sheets           Notion
  (state/memory)          (knowledge)             (CRM layer)
```

## 1.2 Стейты пользователя (Stage Machine)

Существующий Stage Map корректен. Добавляю **критический недостающий стейт**:

```
new_lead
  └─→ q1 → q2 → q3
              └─→ offer_transition → offer
                      └─→ booking_intent → booking_requested ← [НОВЫЙ]
                              └─→ booked → followup → sleeping
                                                          └─→ reactivated
```

> [!WARNING]
> **`booking_requested` отсутствует в текущем stage_map.md** — это разрыв между `booking_intent` и `booked`. Без него невозможно отследить случаи, когда пользователь выразил намерение, но ещё не оплатил. Это прямая потеря конверсии.

## 1.3 Пользовательские состояния (User States)

Два уровня состояния — оба должны храниться в PostgreSQL:

**Macro-state** (`clients.current_stage`): позиция в воронке  
**Micro-state** (`conversation_state`): текущий шаг внутри стейта

```
clients.current_stage = 'q2'
conversation_state.current_q_number = 2
conversation_state.qualification_signals = {pain_points: [...], emotional_state: 'frustrated'}
```

## 1.4 Источник данных → Сегмент

| Кодовое слово | Сегмент | Тип диагностики | Консультация |
|---------------|---------|----------------|--------------|
| РАЗБОР | Разбор ситуации | Ситуационная | 1:1 разбор |
| ПАМЯТЬ | Когнитивный | Память/концентрация | Когнитивный коучинг |
| ФОКУС | Когнитивный | Рассеянность/прокрастинация | Когнитивный коучинг |
| СИСТЕМА | Системный | Продуктивность | Системная сессия |
| СОСТОЯНИЕ | Эмоциональный | Выгорание/ресурс | Психоэнергетика |
| НИШ | Бизнес | Позиционирование | Стратегическая сессия |
| ЕНТ | Образование | Подготовка к экзамену | Учебный план |
| АРХИТЕКТУРА | Системный | Мышление/структура | Архитектурная сессия |

## 1.5 Точки отказа (Failure Points)

| # | Точка отказа | Вероятность | KPI Impact | Митигация |
|---|-------------|-------------|-----------|-----------|
| 1 | Пользователь написал слово, нет ответа >2 мин | Высокая | −30% DM conversion | Telegram webhook + n8n всегда on |
| 2 | LLM классифицировал intent неверно | Средняя | −20% qualification | Confidence threshold + fallback вопрос |
| 3 | PostgreSQL timeout | Низкая | −100% для сессии | Retry logic + cached defaults |
| 4 | Google Sheets недоступен | Средняя | Стоп квалификации | Кешировать sheets в memory/Redis |
| 5 | Оффер отправлен, менеджер не увидел | Высокая | −40% close rate | Notion notification + Telegram alert |
| 6 | Пользователь завис в Q2, нет ответа 3 дня | Высокая | Потеря лида | Timeout → reactivation flow |
| 7 | Дубль user_id (разные аккаунты) | Низкая | Confusion | UNIQUE constraint + merge logic |

## 1.6 KPI системы

| KPI | Метрика | Цель | Как измерять |
|-----|---------|------|-------------|
| DM Conversion | % написавших кодовое слово → вошли в Q1 | >80% | events: keyword_received / q1_started |
| Qualification Completion | % Q1 → Q3 completed | >60% | events: q1_started / qualification.stage_completed |
| Offer Acceptance | % получивших оффер → booking_intent | >40% | events: offer.sent / offer.accepted |
| Booking Rate | % booking_intent → booked | >70% | events: booking_intent / booked |
| Funnel Conversion | % new_lead → booked | >15% | clients: stage progression |
| Reactivation Rate | % sleeping → reactivated | >20% | events: reactivation.started / responded |
| Response Time | Среднее время первого ответа бота | <30 сек | events timestamps |
| Manager Handoff Time | Время от offer_transition до менеджера | <1 час | events + Notion notification time |

---

# ЭТАП 2 — Структура n8n Workflows

## Архитектурный принцип

> [!IMPORTANT]
> **Один главный workflow + специализированные sub-workflows.**  
> Не монолит, не микросервисы. Оптимальный баланс — **5 workflows** с чёткими boundaries.

## Workflow Map

```
WF-01: INTAKE (Main Router)          ← Telegram Trigger
  ├─→ WF-02: QUALIFICATION ENGINE
  ├─→ WF-03: OFFER ENGINE  
  ├─→ WF-04: BOOKING ENGINE          [НОВЫЙ — нет в репо]
  └─→ WF-05: REACTIVATION ENGINE

WF-06: TIMEOUT WATCHDOG              ← Schedule Trigger (каждый час)
WF-07: MANAGER NOTIFIER              ← внутренний helper
```

## WF-01: INTAKE (Главный маршрутизатор)

**Назначение:** Единая точка входа. Определяет, что делать с каждым сообщением.

```
[Telegram Trigger]
      │
      ▼
[Postgres: Find or Create Client]
      │
      ├─ client.current_stage = 'unsubscribed' → [Stop silently]
      │
      ├─ client.current_stage = 'sleeping' → [WF-05 Reactivation]
      │
      ├─ client.current_stage IN (q1,q2,q3) → [WF-02 Qualification]
      │
      ├─ client.current_stage IN (offer, booking_intent) → [WF-03/04]
      │
      └─ client.current_stage = 'new_lead' OR keyword detected
            │
            ▼
      [Google Sheets: Load keywords_master]
            │
            ▼
      [LLM: Intake Classifier]           ← Gemini Flash (дешевле)
      {keyword, segment, intent, confidence, source_channel}
            │
            ├─ confidence < 0.6 → [Ask clarifying question] → [Save to PG]
            │
            └─ confidence ≥ 0.6 → [WF-02 Qualification]
```

**Данные на входе:** `{telegram_user_id, message_text, message_type, chat_id}`  
**Данные на выходе:** `{client_id, keyword, segment, intent, route_to}`  
**Сохраняется в PG:** clients UPSERT, events: `classification.intent_detected`

---

## WF-02: QUALIFICATION ENGINE (Существующий — доработать)

**Текущий статус:** 65/100 — есть граф, нужна доработка node schemas

```
[Subworkflow Trigger] ← from WF-01
      │
      ▼
[Postgres: Load client + conversation_state]
      │
      ▼
[Google Sheets: Load qualification_flow for keyword+stage]
      │
      ▼
[Google Sheets: Load memory_signals]
      │
      ▼
[Postgres: Load last 5 messages]   ← conversation context
      │
      ▼
[LLM: Emotional Reflection]        ← параллельно
[LLM: Qualification Engine]        ← основной
      │
      ▼
[Validate JSON responses]
      │
      ├─ invalid → [Telegram: Send error gracefully] → [Log system.error]
      │
      └─ valid →
            │
            ▼
      [IF: qualification_depth >= threshold?]
            │
            ├─ YES → [Trigger WF-03 Offer Engine]
            │         [Update stage: offer_transition]
            │         [Log: qualification.stage_completed]
            │
            └─ NO  → [Next qualification question]
                      [Update conversation_state]
                      [Update clients.qualification_depth]
                      [Log: qualification.question_asked]
                      [Telegram: Send question]
```

**Данные передаются в WF-03:**  
```json
{
  "telegram_user_id": "...",
  "keyword": "ФОКУС",
  "segment": "cognitive",
  "qualification_depth": 78,
  "pain_points": ["прокрастинация", "рассеянность"],
  "emotional_state": "frustrated",
  "consultation_interest": 0.85
}
```

---

## WF-03: OFFER ENGINE (Stub → реализовать)

```
[Subworkflow Trigger] ← from WF-02
      │
      ▼
[Google Sheets: Load offer_rules] ← проверка eligibility
      │
      ▼
[IF: client meets offer criteria?]
      │
      ├─ NO → [Nurture message] → [Stage: sleeping] → [Schedule reactivation]
      │
      └─ YES →
            │
            ▼
      [Google Sheets: Load offers_master by keyword]
            │
            ▼
      [LLM: Offer Generator]     ← персонализация под pain_points
            │
            ▼
      [Postgres: Insert offers_sent {status: 'pending'}]
            │
            ▼
      [Telegram: Send offer message]
            │
            ▼
      [Postgres: Update stage → 'offer']
      [Log: offer.sent]
            │
            ▼
      [WF-07: Notify Manager]   ← КРИТИЧНО для конверсии
```

---

## WF-04: BOOKING ENGINE (Новый — создать)

> [!IMPORTANT]
> Этот workflow критически отсутствует. Без него booking_intent → booked происходит вручную и теряются лиды.

```
[Telegram Trigger: positive signal on offer stage]
      │
      ▼
[Detect booking intent signal]
{signals: ["как", "хочу", "запишите", "да", "сколько стоит"]}
      │
      ▼
[Update stage: booking_requested]
[Log: booking.requested]
      │
      ▼
[Telegram: Send booking link + instructions]
      │
      ▼
[WF-07: Notify Manager URGENTLY]   ← приоритетный алерт
      │
      ▼
[Schedule: check payment in 24h]
      │
      ├─ Payment confirmed → Update stage: booked
      │                      Log: booked
      │                      Telegram: Confirmation message
      │
      └─ No payment → Telegram: Gentle reminder
                      IF 3 days → Stage: sleeping
```

---

## WF-05: REACTIVATION ENGINE (Stub → реализовать)

```
[Schedule Trigger: каждые 6 часов]
      │
      ▼
[Postgres Query: sleeping clients]
WHERE current_stage = 'sleeping'
AND last_message_at < NOW() - INTERVAL '30 days'
AND current_stage != 'unsubscribed'
      │
      ▼
[FOR EACH sleeping client]:
      │
      ▼
[Google Sheets: Load followups_master]
      │
      ▼
[LLM: Generate personalized reactivation message]
← использует memory_items для персонализации
      │
      ▼
[Telegram: Send reactivation]
[Log: reactivation.started]
      │
      ▼
[Wait for response → back to WF-01]
```

---

## WF-06: TIMEOUT WATCHDOG (Новый)

```
[Schedule: каждый час]
      │
      ▼
[Postgres: Find clients stuck in stage > max_time]
WHERE current_stage IN ('q1','q2','q3')
AND conversation_state.question_asked_at < NOW() - INTERVAL '3 days'
      │
      ▼
[FOR EACH stuck client]:
  → Send gentle nudge message
  → IF already nudged → Stage: sleeping
  → Log: stage.time_exceeded
```

---

## WF-07: MANAGER NOTIFIER (Helper)

**Это решает ключевой bottleneck:** менеджер не видит горячих лидов вовремя.

```
[Subworkflow Trigger]
Input: {client_id, trigger_type, urgency}
      │
      ▼
[IF urgency = 'critical'] → Telegram alert to manager chat
[Create Notion page in "Hot Leads" DB]
[Log: manager.notified]
```

---

# ЭТАП 3 — Схема данных

## Текущие Production-таблицы (не менять структуру)

```sql
clients            ✅ Production — расширить 2 поля
messages           ✅ Production — не менять
events             ✅ Production — не менять
memory_facts       ✅ Production — не менять
offers_and_outcomes ✅ Production — не менять
```

## Рекомендуемые изменения в `clients`

```sql
-- Добавить 2 поля (не ломают существующую схему):
ALTER TABLE clients ADD COLUMN IF NOT EXISTS
  source_channel VARCHAR(50);  -- 'instagram', 'tiktok', 'telegram_direct', 'unknown'

ALTER TABLE clients ADD COLUMN IF NOT EXISTS  
  manager_assigned_at TIMESTAMP;  -- когда передан менеджеру
```

## Planned-таблицы (приоритет создания)

### ПРИОРИТЕТ 1: `conversation_state`
Уже задокументирована — **создать немедленно**.  
Без неё невозможно знать, на каком вопросе остановился пользователь.

```sql
CREATE TABLE conversation_state (
  telegram_user_id BIGINT PRIMARY KEY REFERENCES clients(telegram_user_id),
  current_q_number INTEGER,
  question_asked_at TIMESTAMP,
  expected_response_by TIMESTAMP,
  qualification_signals JSONB DEFAULT '{}',
  pain_points JSONB DEFAULT '[]',
  conversation_tone VARCHAR(50),
  last_nudge_sent_at TIMESTAMP,      -- для timeout watchdog
  updated_at TIMESTAMP DEFAULT NOW()
);
```

### ПРИОРИТЕТ 2: `offers_sent`
Уже задокументирована — **создать**.  
Без неё невозможно отследить статус офферов.

```sql
CREATE TABLE offers_sent (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  telegram_user_id BIGINT NOT NULL REFERENCES clients(telegram_user_id),
  offer_id VARCHAR(100) NOT NULL,
  keyword VARCHAR(100),
  offer_message TEXT,
  status VARCHAR(50) DEFAULT 'pending',  -- pending, accepted, rejected, expired
  manager_notified_at TIMESTAMP,
  response_at TIMESTAMP,
  user_response TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);
```

### ПРИОРИТЕТ 3: `memory_items`
Долгосрочная память — **создать для персонализации**.

### ПРИОРИТЕТ 4: `user_profiles`
Агрегированный когнитивный профиль — **после memory_items**.

## Полная схема связей

```
clients (1)
  ├── (n) messages
  ├── (n) events  
  ├── (1) conversation_state
  ├── (n) offers_sent
  ├── (n) memory_items
  ├── (1) user_profiles
  └── (n) memory_facts [production]

offers_sent.offer_id → Google Sheets: offers_master.offer_id
events.keyword → Google Sheets: keywords_master.keyword
```

## Схема разделения ответственности (итог)

```
PostgreSQL = WHO (кто пользователь, где находится, что происходит)
Google Sheets = HOW (как квалифицировать, что предложить, как отвечать)
Notion = WHO NEEDS ATTENTION (кому позвонить, что срочно, CRM-вид)
n8n = WHEN & WHERE (оркестрация, маршрутизация, тайминг)
LLM = WHAT TO SAY (генерация, классификация)
```

---

# ЭТАП 4 — Bottlenecks, Риски, Угрозы конверсии

## Critical Bottlenecks

### BN-01: Разрыв Instagram/TikTok → Telegram
**Проблема:** Пользователь видит CTA в Instagram, должен сам перейти в Telegram.  
**Потеря:** ~50-60% конверсии из соцсетей  
**Решение:** Максимально снизить трение:
- CTA: "Напиши мне в Telegram @BrainCoachBot слово ФОКУС" (прямая ссылка)
- t.me/BrainCoachBot?start=ФОКУС — бот получает кодовое слово автоматически через `/start` параметр
- **KPI impact:** +20-30% DM conversion

### BN-02: Менеджер не видит горячих лидов
**Проблема:** Оффер отправлен, менеджер не знает. Лид остывает.  
**Текущее состояние:** WF-07 Manager Notifier не существует  
**Потеря:** −40% close rate  
**Решение:** Notion Hot Leads + Telegram алерт менеджеру при каждом `offer.sent` и `booking_intent`  
**KPI impact:** +25% закрытие в клиента

### BN-03: Qualification Engine — нет чёткого handoff
**Проблема:** После Q3 нет явного момента передачи лида.  
**Текущее состояние:** `offer-engine.json` — stub (8/100)  
**Потеря:** −30% offer conversion  
**Решение:** WF-03 Offer Engine с чёткими триггерами  
**KPI impact:** +15% offer sent rate

### BN-04: Нет `booking_requested` стейта
**Проблема:** Между "хочу записаться" и "оплачено" — чёрный ящик.  
**Потеря:** Невозможно измерить drop-off на этапе оплаты  
**Решение:** WF-04 Booking Engine + новый стейт `booking_requested`  
**KPI impact:** измеримость + +10% booking completion

### BN-05: Google Sheets — единая точка отказа
**Проблема:** Если Sheets недоступен — вся квалификация стоит.  
**Решение:** Кешировать sheets в `n8n Static Data` или PostgreSQL-таблице `sheets_cache`  
**KPI impact:** 99.9% uptime vs текущих ~95%

### BN-06: Нет source_channel tracking
**Проблема:** Невозможно понять, какой контент (Instagram/TikTok/Telegram) даёт лучшие лиды.  
**Решение:** UTM-подобный tracking через `/start` параметр бота  
**KPI impact:** Данные для оптимизации контента

## Риски

| Риск | Вероятность | Severity | Митигация |
|------|-------------|---------|-----------|
| LLM галлюцинирует intent | Средняя | High | JSON schema validation + confidence threshold |
| Пользователь чувствует "бота" | Высокая | High | Тёплый тон + менеджер на финале |
| Дублирование в offers_sent | Низкая | Medium | UNIQUE constraint (telegram_user_id, offer_id) |
| n8n instance downtime | Низкая | Critical | Google Cloud Run fallback или n8n Cloud |
| Spam атака на бота | Средняя | Medium | Rate limiting + spam detection event |
| GDPR/персональные данные | Низкая | High | unsubscribe flow обязателен |

## Что ухудшает конверсию

1. **Более 3 вопросов подряд без эмоционального acknowledgment** → пользователь уходит
2. **Оффер без персонализации** (generic текст) → низкий acceptance rate
3. **Менеджер звонит через 24+ часов** → лид остыл
4. **Нет follow-up через 2-3 дня после оффера** → 60% теряются без ответа
5. **Бот отвечает формально/роботизированно** → потеря доверия к бренду

---

# ЭТАП 5 — Notion как CRM Layer

## Оценка: Notion vs Альтернативы

> [!NOTE]
> Notion уже подключён. Не переносим данные из PostgreSQL в Notion — Notion становится **operational view** для команды, не хранилищем данных.

## Рекомендуемая структура Notion

### Database 1: Hot Leads 🔥
**Назначение:** Все лиды в стейте `offer_transition`, `offer`, `booking_intent`, `booking_requested`

| Поле | Тип | Источник |
|------|-----|---------|
| Name | Title | clients.first_name |
| Username | Text | clients.username |
| Stage | Select | clients.current_stage |
| Keyword | Select | clients.current_keyword |
| Pain Points | Text | conversation_state.pain_points |
| Qualification Depth | Number | clients.qualification_depth |
| Emotional State | Select | clients.emotional_state |
| Offer Sent At | Date | offers_sent.created_at |
| Offer Status | Select | offers_sent.status |
| Manager Action | Checkbox | Менеджер ставит ✓ |
| Notes | Text | Менеджер пишет вручную |
| Last Contact | Date | clients.last_message_at |

**Триггер обновления:** n8n WF-07 обновляет через Notion API при каждом `offer.sent`, `booking_intent`, `booked`

### Database 2: Consultation Calendar 📅
**Назначение:** Записанные консультации, синхронизация с Google Calendar

| Поле | Тип |
|------|-----|
| Client | Relation → Hot Leads |
| Consultation Type | Select |
| Scheduled At | Date |
| Zoom/Meet Link | URL |
| Status | Select: scheduled / completed / cancelled |
| Notes | Text |

### Database 3: Content → Leads Analytics 📊
**Назначение:** Связь контента и лидов (какое слово/пост дало результат)

| Поле | Тип |
|------|-----|
| Keyword | Select |
| Source Channel | Select |
| Leads Count | Rollup |
| Booked Count | Rollup |
| Conversion Rate | Formula |

### Database 4: Sleeping Leads 😴
**Назначение:** Лиды в sleeping для ручного просмотра и решения по реактивации

**Логика:** n8n раз в неделю синхронизирует sleeping leads → менеджер видит кого стоит реактивировать вручную (личное сообщение конвертирует лучше автоматического)

## Notion vs PostgreSQL — разделение чётко

```
PostgreSQL пишет → n8n читает → n8n пишет в Notion (view only for humans)
Менеджер обновляет Notion → n8n читает статус → пишет в PostgreSQL
```

**Notion НЕ является source of truth. Notion = CRM интерфейс для команды.**

---

# Приоритетный план реализации

## Phase 1 — Quick Wins (неделя 1-2)

| Задача | Bottleneck | KPI Impact |
|--------|-----------|-----------|
| Добавить `/start` параметр (keyword из Telegram link) | BN-01 | +20% DM conversion |
| Создать `conversation_state` таблицу | BN-03 | Enables Q-flow continuity |
| Создать `offers_sent` таблицу | BN-02 | Enables offer tracking |
| WF-07 Manager Notifier (Telegram alert) | BN-02 | +25% close rate |
| Добавить стейт `booking_requested` в stage-map | BN-04 | Измеримость |

## Phase 2 — Core Engines (неделя 3-4)

| Задача | Bottleneck |
|--------|-----------|
| WF-03 Offer Engine (полная реализация) | BN-03 |
| WF-04 Booking Engine | BN-04 |
| Notion Hot Leads DB + n8n интеграция | BN-02 |
| Google Sheets кеш в PG (`sheets_cache`) | BN-05 |

## Phase 3 — Intelligence (неделя 5-6)

| Задача | KPI Impact |
|--------|-----------|
| WF-05 Reactivation Engine | +20% reactivation rate |
| WF-06 Timeout Watchdog | −30% sleeping leads |
| `memory_items` + `user_profiles` | Персонализация офферов |
| source_channel tracking | Контент-аналитика |

## Phase 4 — Optimize (месяц 2+)

| Задача |
|--------|
| A/B тесты офферов по keyword |
| Notion Consultation Calendar + Google Calendar sync |
| Multi-model routing (Gemini Flash для classify, GPT для qualify) |
| Воронка-дашборд (BigQuery + Looker Studio) |

---

# Итоговое архитектурное решение

```
                    CONTENT LAYER
            Instagram / TikTok / Telegram
                         │
                  CTA + keyword link
                         │
                         ▼
                  TELEGRAM BOT
                  t.me/bot?start=KEYWORD
                         │
                         ▼
              n8n WF-01: INTAKE ROUTER
              ┌──────────────────────────┐
              │ 1. Find/Create client    │
              │ 2. Detect stage          │
              │ 3. Classify intent (LLM) │
              │ 4. Route to sub-workflow │
              └──────────┬───────────────┘
                         │
          ┌──────────────┼──────────────┐
          ▼              ▼              ▼
    WF-02            WF-03          WF-05
  QUALIFY           OFFER         REACTIVATE
  (Q1→Q3)        (Ofer send)    (sleeping→q1)
          │              │
          └──────┬────────┘
                 ▼
           WF-04 BOOKING
           (intent→paid)
                 │
                 ▼
          WF-07 NOTIFY
       ┌──────────────────┐
       │ Telegram alert   │
       │ Notion Hot Lead  │
       │ Manager sees it  │
       └──────────────────┘
                 │
        MANAGER CLOSES DEAL
                 │
                 ▼
        Google Calendar booked
        Notion: Consultation scheduled
        PG: stage = 'booked'
```

**Критерий успеха системы:**  
Не количество автоматизированных шагов — а скорость, с которой горячий лид попадает к менеджеру с полным контекстом для закрытия.
