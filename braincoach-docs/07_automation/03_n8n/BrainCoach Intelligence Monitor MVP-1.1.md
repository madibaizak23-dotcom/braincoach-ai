# BrainCoach Intelligence Monitor MVP-1.1

Status: Ready for manual test

Source workflow: BrainCoach Intelligence Monitor MVP-1

Export:

`braincoach-docs/07_automation/03_n8n/BrainCoach Intelligence Monitor MVP-1.1.json`

## Goal

Keep the existing System Health monitor metrics and append a Research Intelligence layer for participant activity, observation quality, contributor distribution, and early behavioral patterns.

## Read-only Boundary

The workflow uses one PostgreSQL node:

`DB_ReadIntelligenceSnapshot`

SQL operation:

`WITH ... SELECT`

No write statements are used:

- no `INSERT`
- no `UPDATE`
- no `DELETE`
- no `CREATE`
- no `ALTER`
- no `DROP`

No schema changes.

No new tables.

No production data modifications.

## Report Sections

0. Audience Summary
1. Data Intake Summary
2. Interview Funnel
3. Observation Quality
4. Signal Summary
5. Top Contributors
6. Participant Distribution
7. System Bottlenecks
8. Emerging Behaviors
9. Daily Intelligence Draft

Reflection Coach Metrics is included as an informational subsection. Because Reflection Coach reply types are not stored in the database yet, it currently reports:

`Reflection metrics not yet tracked.`

## SQL Additions

New read-only CTEs:

- `participant_entry_counts`
- `audience_summary`
- `observation_quality`
- `top_contributors`
- `participant_distribution`
- `emerging_behaviors`
- `reflection_coach_metrics`

Existing monitor CTEs preserved:

- `data_intake`
- `interview_funnel`
- `stage_counts`
- `top_today`
- `top_all`
- `status_counts`
- `signal_summary`
- `bottlenecks`
- `repeated_themes`

## New Metrics

- unique participants
- new participants today
- most active participant
- average tracker entries per participant
- observation to signal conversion percentage
- top 5 contributors
- participant distribution by entry count
- Reflection Coach metrics placeholder
- emerging behavior groups from repeated signal candidates

## Manual Test Plan

1. Import or paste the workflow into n8n.
2. Execute via `TRG_ManualRun` and inspect output from `SYS_FormatTelegramReport`.
3. Execute via `Telegram Trigger` and confirm Telegram receives the report.
4. Validate formatting in Telegram:
   - numbered sections 0-9 are visible
   - long lines remain readable
   - no raw SQL or JSON objects leak into the message
   - Emerging Behaviors replaces Signal of the Day
5. Confirm PostgreSQL node uses only `SELECT` SQL.

## Example Report

```text
BrainCoach Intelligence Monitor MVP-1.1
2026-06-15T12:00:00.000Z

0. Audience Summary
- unique participants: 7
- new participants today: 3
- most active participant: Алим (5)
- avg entries per participant: 2.8

1. Data Intake Summary
- tracker_entries total: 22
- tracker_entries today: 8
- tracker_entries last 24h: 10
- observations total: 22
- observations today: 8
- signal_candidates total: 9
- signal_candidates today: 3

2. Interview Funnel
- parent_interviews total: 4
- started: 1
- in_progress: 1
- completed: 2
- abandoned: 0
- active conversations: new: 0, waiting q1: 0, waiting q2: 0, waiting q3: 0, waiting q4: 0, analysis: 0, completed: 0

3. Observation Quality
- observations: 22
- signal candidates: 9
- conversion: 41%

4. Signal Summary
- top signal today: self initiation (2), emotional reaction (1)
- top signal all time: self initiation (5), persistence (3), ownership (1)
- average confidence: 0.74
- low-confidence count: 1
- statuses: candidate: 9

5. Top Contributors
1. Алим — 5
2. Игрок 2 — 4
3. Игрок 3 — 2

6. Participant Distribution
- participants with 1 entry: 4
- participants with 2-5 entries: 3
- participants with >5 entries: 1

7. System Bottlenecks
- observations without signal candidates: 13
- signal candidates without observation_id: 0
- conversations stuck > 6h: 0
- interviews started but no responses: 0
- errors today: 0

8. Emerging Behaviors
- grouped patterns: self initiation (2), persistence (2)

Reflection Coach Metrics
- Reflection metrics not yet tracked.

9. Daily Intelligence Draft
- Today the system is collecting: 8 tracker entries, 8 observations, 3 signal candidates.
- Audience: 7 participants; most active: Алим (5).
- Observation quality: 41% observation to signal conversion.
- Emerging behaviors: self initiation (2), persistence (2).
- Possible bottleneck: observations without signal candidates: 13.
- Manual review: inspect low-confidence candidates, participant concentration, and observation to signal gaps.
```
