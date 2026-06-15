# BrainCoach GPS MVP-1.1 — Reflection Coach GPS Publish

Status: Production

Activated: 2026-06-15

Workflow export:

`braincoach-docs/07_automation/03_n8n/BrainCoach GPS MVP-1.1 — Reflection Coach GPS Publish.json`

Supersedes:

`braincoach-docs/07_automation/03_n8n/BrainCoach GPS MVP-1 — bgs_core adapted.json`

## Summary

MVP-1.1 promotes the Reflection Coach layer into the active BrainCoach GPS workflow.

The existing GPS capture pipeline remains unchanged:

```text
Telegram
-> tracker_entries
-> observations
-> research_signal_candidates
-> PostgreSQL
```

The change is limited to the reply layer after successful observation capture.

## Reflection Coach Layer

Added node:

`TRK_BuildReflectionReply`

Position in workflow:

```text
TRK_GetEntryCount
-> TRK_BuildReflectionReply
-> TRK_ReplySaved
```

The previous static save reply is replaced by compact rotating responses.

## Response Strategy

The response layer is intentionally short because GPS is not a standalone chat bot. It is an observation capture companion.

Target format:

```text
1 screen
1-2 short lines
```

Response types:

* confirmation
* short reflection question
* mission
* rare GPS signal question
* deep milestone question

Base confirmations:

```text
🧭 Записал.
✅ Сохранил.
👍 Есть.
🎯 Поймал момент.
🏒 Принял.
```

Short questions:

```text
Что чувствовал?
Было легко?
Где стало сложно?
Что помогло начать?
Сам заметил?
```

Missions:

```text
🏅 Наблюдатель +1. Поймай ещё один момент.
✅ Записал. Миссия: заметить момент перед стартом.
🎯 Поймай момент, когда не хотелось начинать.
```

Rare GPS signal questions after accumulated usage:

```text
🏒 Что сегодня сделал без напоминаний?
⚡ В какой момент было больше всего энергии?
🎯 Что оказалось сложнее, чем ожидал?
🧭 Что помогло не бросить?
🚀 Что захотелось сделать самому?
```

Deep milestone questions:

```text
5
15
30
50
75
100
then every 50 observations
```

These questions support the GPS domains of initiative, persistence, ownership, self-regulation, and internal launch.

## Activation Notes

The workflow was promoted from sandbox after live Telegram tests confirmed:

* text observation capture works
* Reflection Coach replies render correctly in Telegram
* Russian text and emoji encoding are valid
* milestone response at 5 observations works
* voice path was corrected to route through `VOI_CheckVoice`

Telegram trigger routing:

```text
TG_Trigger
-> VOI_CheckVoice
```

Voice branch:

```text
VOI_CheckVoice
-> VOI_GetFile
-> VOI_Transcribe
-> VOI_NormalizeTranscript
-> SYS_LoadContext
```

Text branch:

```text
VOI_CheckVoice
-> SYS_LoadContext
```

## Database Impact

No schema changes.

No new tables.

No new write paths.

Existing count query reused:

```sql
SELECT COUNT(*) as total
FROM tracker_entries
WHERE person_id = '{{ $("SYS_BuildInputContext").first().json.person_id }}'::uuid;
```

## Pilot KPI

The primary evaluation metric is not response quality by itself.

Primary KPI:

```text
Does the number of observations per user increase by 20-30% compared to GPS MVP-1?
```

Secondary indicators:

* observations per user per day
* share of active days with at least one observation
* retention of observation habit after one week

## Rollback

Rollback is workflow-level only:

1. Deactivate MVP-1.1 workflow.
2. Reactivate `BrainCoach GPS MVP-1 — bgs_core adapted` if needed.
3. No database rollback is required.
