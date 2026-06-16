# BrainCoach Compliance Gate v1

Status: Accepted Standard
Date: 2026-06-16
Owner: BrainCoach Development Standards

## Purpose

Любой новый продукт, бот, сайт, форма или workflow BrainCoach считается системой обработки пользовательских данных.

Перед проектированием и реализацией необходимо пройти Compliance Gate и явно зафиксировать:

- какие данные собираются;
- зачем они нужны;
- где они хранятся;
- как фиксируется согласие;
- передаются ли данные во внешние ИИ;
- требуется ли обезличивание;
- как пользователь может быть удален или обезличен.

Если данные не нужны для продукта, они не собираются.

## Scope

Compliance Gate обязателен для:

- Telegram-ботов;
- сайтов и лендингов с формами;
- анкет, опросов и интервью;
- n8n workflows;
- AI-агентов;
- внутренних админок и dashboards;
- интеграций со сторонними сервисами;
- любых MVP, которые получают данные от детей, родителей, клиентов или команды BrainCoach.

## Development Rule

Нельзя начинать реализацию нового продукта, бота, сайта, формы или workflow, пока Compliance Gate не заполнен хотя бы на уровне MVP.

Нельзя запускать продукт, если:

- собираются любые пользовательские данные, но нет Privacy Policy;
- нет явного текста согласия;
- нет действия пользователя, подтверждающего согласие;
- факт согласия не сохраняется;
- персональные данные передаются во внешний ИИ без проверки на обезличивание;
- нет процедуры удаления или обезличивания пользователя.

В Production OS Compliance Gate является частью Definition of Done:

```text
Feature Ready
↓
Compliance Gate
↓
Production Review
↓
Release
```

Если Compliance Gate имеет статус `Blocked`, релиз запрещен.

## Step 1. Data Check

Зафиксировать, какие данные собираются:

- Telegram ID;
- username;
- имя;
- email;
- телефон;
- голос;
- фото;
- ответы пользователя;
- наблюдения;
- другое.

Для каждого типа данных указать:

- зачем он нужен;
- можно ли обойтись без него;
- является ли он обязательным или опциональным;
- передается ли он во внешние сервисы.

## Step 2. Consent

Если собираются любые данные пользователя, проверить:

- есть ссылка на Privacy Policy;
- есть текст согласия;
- есть действие пользователя: кнопка, чекбокс или другое явное подтверждение;
- согласие фиксируется в системе.

Без этого запуск запрещен.

Минимальная запись согласия должна включать:

- user identifier;
- consent version;
- timestamp;
- source: bot, site, form, workflow;
- ссылку или идентификатор версии Privacy Policy.

## Step 3. Storage

Зафиксировать:

- где физически хранится информация;
- используется ли PostgreSQL BGS Core;
- используются ли сторонние сервисы;
- есть ли резервное копирование;
- ограничен ли доступ.

Правило хранения:

- данные о человеке, родителе, ребенке, интервью, наблюдениях и долгосрочной траектории относятся к human reality data;
- по умолчанию такие данные должны храниться в `bgs_core` или в явно утвержденном хранилище;
- `bgs_orch` используется для orchestration, knowledge, research process и production telemetry, но не должен становиться неявным хранилищем персональных данных.

## Step 4. External AI

Если данные уходят во внешний ИИ, включая:

- OpenAI;
- Claude;
- Perplexity;
- другие LLM или AI-сервисы;

проверить:

- можно ли обезличить данные;
- действительно ли нужно передавать исходный текст;
- нет ли имени, телефона, username, email или других прямых идентификаторов;
- можно ли заменить идентификаторы внутренними pseudonymous IDs;
- можно ли передать summary вместо полного текста.

По умолчанию во внешний ИИ передаются только обезличенные данные.

Запрещено передавать во внешний ИИ без отдельного обоснования:

- телефон;
- email;
- Telegram username;
- имя ребенка;
- голосовые сообщения;
- фото;
- полные переписки с ребенком или родителем.

## Step 5. Deletion

Проверить:

- можно ли удалить пользователя;
- можно ли обезличить историю;
- есть ли процедура удаления;
- кто имеет право выполнить удаление;
- какие связанные записи остаются в агрегированном или обезличенном виде.

Минимальное MVP-требование: должна быть описана ручная процедура удаления или обезличивания, даже если автоматического интерфейса еще нет.

## Step 6. Public Materials

Запрещено публиковать:

- скриншоты с именами;
- Telegram usernames;
- голосовые сообщения;
- детские данные;
- переписки;
- фото детей или родителей без отдельного явного согласия.

Разрешено:

- агрегированные данные;
- статистика;
- обезличенные цитаты;
- синтетические примеры;
- кейсы, где прямые и косвенные идентификаторы удалены.

## Step 7. MVP Rule

Для MVP достаточно:

1. Privacy Policy.
2. Ссылка на нее в боте или на сайте.
3. Кнопка согласия перед первым вопросом.
4. Сохранение факта согласия.
5. Обезличивание данных перед внешним ИИ.
6. Описанная процедура удаления или обезличивания.

Не усложнять систему раньше времени, но не запускать сбор данных без этих минимальных условий.

## Required Template

Каждая новая продуктовая или workflow-спецификация должна содержать блок:

```md
## Compliance Gate

Status: Draft | Passed | Blocked
Date:
Owner:
Product / Workflow:

### 1. Data

Collected:
- Telegram ID:
- Username:
- Name:
- Email:
- Phone:
- Voice:
- Photo:
- User answers:
- Observations:
- Other:

Not collected:
-

### 2. Consent

- Privacy Policy link:
- Consent text:
- User action:
- Consent storage:
- Consent version:

### 3. Storage

- Primary storage:
- PostgreSQL BGS Core:
- PostgreSQL BGS Orch:
- Third-party services:
- Backups:
- Access limits:

### 4. External AI

- External AI services:
- Data sent:
- Anonymization / pseudonymization:
- Direct identifiers removed:
- Raw text required:

### 5. Deletion

- User deletion:
- History anonymization:
- Manual procedure:
- Owner:

### 6. Public Materials

- Personal screenshots excluded:
- Usernames excluded:
- Voice/photo/child data excluded:
- Only aggregated or anonymized materials used:

### 7. MVP Compliance

- Privacy Policy:
- Link shown before first question:
- Consent button/check:
- Consent saved:
- Data anonymized before external AI:
- Deletion/anonymization procedure documented:
```

## Review Outcome

Compliance Gate can have one of three statuses:

- `Draft` - information is incomplete; implementation may be discussed but not launched.
- `Passed` - MVP compliance is satisfied; implementation and launch may proceed within the documented scope.
- `Blocked` - launch is forbidden until listed issues are resolved.

Any scope change that adds new data types, new storage, new external AI, or new public use of materials requires another Compliance Gate review.
