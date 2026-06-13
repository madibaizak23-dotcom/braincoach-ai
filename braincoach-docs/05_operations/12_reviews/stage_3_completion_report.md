# Stage 3 — Observation & Signal Extraction Pipeline

Status: Completed

Date: 2026-06-09

---

## Goal

Build the first operational research intake pipeline: capture reality through Telegram, persist structured observations, and extract signal candidates without prematurely promoting every observation into a confirmed signal.

---

## What Changed

Stage 3 shifted from the originally planned Knowledge Relationships scope toward an executable research intake path.

Original Stage 3 intent (from Stage 2 deferrals):

- relationship mapping
- semantic indexing
- registry reconciliation

Actual Stage 3 delivery:

- Tracker Layer operational in production
- Observation Layer operational
- Signal Extraction Layer operational
- `research_signal_candidates` staging table populated from live workflow
- BrainCoach GPS OS V3 deployed as the Stage 3 production workflow

This re-scoping was intentional. The system needed a working path from raw input to structured research objects before graph construction could produce meaningful edges.

---

## Current State

### Operational Components

| Component | Status |
| --- | --- |
| Telegram Tracker | Operational |
| PostgreSQL | Connected |
| n8n workflow (BrainCoach GPS OS V3) | Superseded by `BrainCoach GPS MVP-1 — bgs_core adapted` on 2026-06-13 |
| Observation Layer | Operational |
| Signal Extraction Layer | Operational |
| `research_signal_candidates` | Receiving live data |

### Validated Pipeline

```text
Telegram (text / voice)
↓
Tracker Entry
↓
Observation
↓
Signal Candidate
↓
PostgreSQL persistence
```

### First Validated Signal Categories

- `self_initiation`
- `dependence_external`

### Stage 3 Workflow Export

- `braincoach-docs/07_automation/03_n8n/BrainCoach GPS OS — Stage 3 Complete.json`

Superseded 2026-06-13 by:

- `braincoach-docs/07_automation/03_n8n/BrainCoach GPS MVP-1 — bgs_core adapted.json`

---

## Decisions Taken

1. **Candidate staging before signal promotion.** Observations do not become confirmed signals directly. `research_signal_candidates` acts as the review and confidence layer.

2. **Incremental workflow evolution.** The existing Tracker MVP was extended with `OBS_CreateObservation`, `SIG_ExtractSignalCandidate`, `SIG_ParseCandidate`, `SIG_HasCandidate`, and `DB_SaveSignalCandidate` without redesigning the intake path.

3. **BrainCoach GPS OS V3 as Stage 3 baseline.** V3 was the authoritative working version for Stage 3 and was superseded by the BGS Core GPS MVP-1 adapted workflow on 2026-06-13.

4. **No architectural changes for classification noise.** Research notes and parent reflections can be misclassified as behavioral signals. This is tracked for Signal Taxonomy v2, not fixed in Stage 3.

5. **Knowledge Relationships deferred.** Graph construction and relationship discovery remain future work and move to Stage 4 planning scope where appropriate.

---

## Remaining Constraints

- Signal taxonomy is immature; non-behavioral text can be misclassified.
- Extractor output metadata (`tags`, `summary`) from entry classification is not fully persisted into `tracker_entries.metadata`.
- No deduplication across observations or signal candidates.
- No promotion path from candidate → confirmed signal → deviation → phenomenon.
- No analytics layer over accumulated signal data.
- LLM provider mix in production (Gemini for transcription/classification context, OpenAI for signal extraction in V3 export) — Vertex AI migration deferred to Stage 4.
- Knowledge graph and relationship tables not yet created.

---

## Deferred to Stage 4

- Vertex AI Migration
- Analytics Layer
- Signal Aggregation
- Pattern Detection
- Weekly Reports
- Knowledge relationship discovery (originally planned for Stage 3)
- Signal candidate review and promotion workflow
- Signal Taxonomy v2

---

## Outcome

BrainCoach transitioned from registry-aware documentation architecture to an operational research intake system.

The system can now:

- capture observations from Telegram in production
- persist structured research objects in PostgreSQL
- extract and store signal candidates with confidence and evidence
- accumulate data for future analytics and pattern detection

Stage 3 established the first closed loop between reality capture and structured research storage.

Next stage focus: make accumulated signals useful through aggregation, pattern detection, and reporting.
