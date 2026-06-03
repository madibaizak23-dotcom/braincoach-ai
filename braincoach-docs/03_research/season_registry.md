# BrainCoach Season Registry v1.1
Status: Accepted
Date: 2026-06-03

## Назначение

Season Registry фиксирует исследовательские сезоны BrainCoach.
Сезон объединяет феномены, вопросы, гипотезы и эксперименты вокруг одной исследовательской программы.
Если Phenomenon Registry хранит атом знания, то Season Registry хранит программу исследования.

## Роль сезона

- Сезон задаёт один исследовательский фокус.
- Сезон ограничивает диапазон вопросов.
- Сезон помогает удерживать смысловую связность исследований и выводов.
- Сезон живёт дольше отдельных материалов и короче всей системы.
- Сезон превращает разрозненные феномены в осмысленную линию исследования.

## Принципы

- Один сезон = одна главная исследовательская гипотеза или одна большая исследовательская линия.
- Сезон должен быть сформулирован через вопрос о человеке.
- Сезон не является темой ради темы.
- Сезон завершается новым пониманием, проверенной закономерностью или уточнением исходной гипотезы.
- Сезон должен иметь начало, фокус, ход проверки и завершение.
- Сезон не должен длиться бесконечно.

## Структура записи

Каждая запись должна содержать:

- Season-ID
- Title
- Reason for opening
- Main question
- Core hypothesis
- Scope
- Included phenomena
- Included experiments
- Start date
- End date
- Status
- Evidence summary
- Key outcomes
- Key mechanisms
- Cognitive shift
- Canonical impact
- Next season

## Поля

### Season-ID
Уникальный идентификатор сезона.

### Title
Короткое название сезона.

### Reason for opening
Почему сезон был открыт: какое повторяющееся наблюдение, разрыв или риск это запустило.

### Main question
Главный исследовательский вопрос сезона.

### Core hypothesis
Центральная гипотеза, которую сезон проверяет.

### Scope
Границы сезона: что входит и что не входит.

### Included phenomena
Список феноменов, относящихся к сезону.

### Included experiments
Список экспериментов, проведённых в рамках сезона.

### Start date
Дата старта сезона.

### End date
Дата завершения сезона.

### Status
Состояние сезона: draft, active, closing, closed, archived.

### Evidence summary
Общая оценка силы результатов сезона: weak, moderate, strong.

### Key outcomes
Главные результаты сезона.

### Key mechanisms
Механизмы, которые удалось подтвердить или уточнить.

### Cognitive shift
Новое понимание о человеке, которое дал сезон.

### Canonical impact
Влияние сезона на другие слои: none, knowledge_update, ontology_update, canon_candidate.

### Next season
Следующий исследовательский фокус, если он уже виден.

## Research Flow

Season → Phenomena → Questions → Hypotheses → Experiments → Outcomes → Mechanisms → Cognitive Shift

## Правила ведения

- Не смешивать сезон с контентным календарём.
- Не открывать сезон без главного вопроса.
- Не закрывать сезон без итогового понимания.
- Не создавать сезон, если он не усиливает исследование человека.
- Не повторять сезон без новой исследовательской ценности.

## Стратегическая ценность

Season Registry делает исследование последовательным.
Он позволяет группировать феномены в программы, а не хранить их как разрозненные записи.
Со временем это создаёт карту долгосрочной исследовательской работы BrainCoach.

## Минимальная запись

```md
Season-ID:
Title:
Reason for opening:
Main question:
Core hypothesis:
Scope:
Included phenomena:
Included experiments:
Start date:
End date:
Status:
Evidence summary:
Key outcomes:
Key mechanisms:
Cognitive shift:
Canonical impact:
Next season:
```