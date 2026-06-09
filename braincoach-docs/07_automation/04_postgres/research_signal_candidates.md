# research_signal_candidates

Status: Active — Operational
Owner: BrainCoach
Database: `braincoach_dev`
Schema: `public`
Migration: `migrations/004_create_research_signal_candidates.sql`
Created: 2026-06-08
Last Updated: 2026-06-09

## Purpose

`research_signal_candidates` is a staging table for potential signals extracted from tracker observations.

This table prevents the workflow from promoting every observation directly into a confirmed signal.

Object flow:

```text
tracker_entries
->
observations
->
research_signal_candidates
```

Stage 3 status: operational. Table receives live data from BrainCoach GPS OS V3 via `DB_SaveSignalCandidate`.

## Knowledge OS Placement

Layer: Research Layer / Tracker Intake

Role:

- receives candidate signals from Tracker observations;
- stores early evidence and confidence;
- supports review, rejection, merging, and later promotion;
- prepares the path toward `signal_registry` and future Knowledge Graph edges.

This table belongs to BrainCoach-owned application data, not n8n runtime infrastructure.

## Columns

| column | type | required | default | description |
| --- | --- | --- | --- | --- |
| `id` | `uuid` | yes | `gen_random_uuid()` | candidate id |
| `telegram_user_id` | `bigint` | yes |  | user who produced the source tracker input |
| `source_observation_id` | `uuid` | yes |  | source observation created by `OBS_CreateObservation` |
| `source_entry_id` | `uuid` | no |  | source tracker entry when available |
| `signal_text` | `text` | yes |  | candidate signal text |
| `signal_type` | `varchar(80)` | yes | `'unknown'` | signal category from extractor |
| `confidence` | `numeric(4,3)` | no |  | confidence score from 0 to 1 |
| `evidence` | `text` | no |  | short source evidence from the observation |
| `status` | `varchar(40)` | yes | `'candidate'` | candidate lifecycle state |
| `metadata` | `jsonb` | yes | `'{}'::jsonb` | extractor metadata and raw model output |
| `created_at` | `timestamp` | no | `now()` | creation timestamp |
| `updated_at` | `timestamp` | no | `now()` | update timestamp |

## Constraints

- primary key: `id`
- `telegram_user_id` references `clients.telegram_user_id`
- `source_observation_id` references `observations.id`
- `source_entry_id` references `tracker_entries.id`
- `confidence` must be null or between `0` and `1`
- `status` must be one of:
  - `candidate`
  - `accepted`
  - `rejected`
  - `merged`
  - `promoted`

## Indexes

| index | purpose |
| --- | --- |
| `idx_research_signal_candidates_user` | user-level lookup |
| `idx_research_signal_candidates_observation` | source observation lookup |
| `idx_research_signal_candidates_entry` | source tracker entry lookup |
| `idx_research_signal_candidates_status` | candidate review queue |
| `idx_research_signal_candidates_type` | signal type analysis |
| `idx_research_signal_candidates_created` | recent candidate retrieval |

## n8n Usage

Production insertion path (BrainCoach GPS OS V3):

```text
OBS_CreateObservation
->
SIG_ExtractSignalCandidate
->
SIG_ParseCandidate
->
SIG_HasCandidate
->
DB_SaveSignalCandidate (if has_signal)
->
TRK_GetEntryCount
```

Status: operational in production.

## Initial Extractor Output

JSON shape:

```json
{
  "has_signal": true,
  "signal_text": "",
  "signal_type": "unknown",
  "confidence": 0.0,
  "evidence": "",
  "reason": ""
}
```

If `has_signal = false`, the workflow skips `DB_SaveSignalCandidate`.

## First Validated Signal Categories

Production data has validated:

- `self_initiation`
- `dependence_external`

## Known Limitations

- Research notes and parent reflections can be misclassified as behavioral signals
- No deduplication across candidates
- No automated promotion workflow (candidate → accepted → promoted)
- Classification taxonomy immature — Signal Taxonomy v2 planned

## BrainCoach Role

This is the first staging table between raw observations and formal signal objects.

It supports the BrainCoach GPS path:

```text
Raw Input
->
Observation
->
Signal Candidate
->
Signal
->
Deviation
->
Phenomenon
```

Current implementation covers through Signal Candidate.

## Stage 4 Tasks

- Signal aggregation across candidates
- Pattern detection from accumulated signal types
- Analytics views over this table
- Promotion workflow (candidate → confirmed signal)
- Signal Taxonomy v2 to reduce classification noise
