# Memory Engine v1 Design

Last Updated: 2026-05-31

## Purpose

Memory Engine v1 persists durable user memory and makes it available to future qualification flows.

This is the active next product milestone after Intake Engine v1 Stable.

## Milestone Goal

From `active/00-project-journal.md`:

Persist `memory_updates` into long-term client memory and use memory in future qualification flows.

## Current Implementation Status

| Component | Status | Evidence |
|-----------|--------|----------|
| Intake Engine outputs `memory_updates` | Present in Qualification Engine output contract | `active/03-qualification-engine.md` |
| `memory_items` table | Defined in bootstrap SQL and `src/postgres/initDatabase.js` | `active/04-braincoach-database-bootstrap.md`, `src/postgres/initDatabase.js` |
| `user_profiles` table | Defined in bootstrap SQL and `src/postgres/initDatabase.js` | `active/04-braincoach-database-bootstrap.md`, `src/postgres/initDatabase.js` |
| Memory repository | Implemented | `src/postgres/memoryRepository.js` |
| Profile repository | Implemented | `src/postgres/profileRepository.js` |
| Memory extractor prompt | Exists | `prompts/memory/memory_extractor.md` |
| Memory retriever prompt | Exists | `prompts/memory/memory_retriever.md` |
| n8n memory persistence nodes | Not started | No active workflow evidence |
| n8n memory retrieval nodes | Not started | No active workflow evidence |

## In Scope For v1

Memory Engine v1 should handle:

- reading `memory_updates` from the Qualification Engine output
- storing durable memory in PostgreSQL
- avoiding duplicate memory where possible
- retrieving active memories for a Telegram user
- making retrieved memory available to future qualification flow logic

## Out Of Scope For v1

Memory Engine v1 does not include:

- RAG implementation
- vector database
- multi-agent architecture
- social intelligence
- content intelligence
- offer generation
- booking logic
- voice intake

## Input Contract

The current Qualification Engine output contract includes:

```json
{
  "memory_updates": []
}
```

Exact item shape inside `memory_updates` is TBD.

The Memory Extractor prompt outputs:

```json
{
  "memory_candidate": true,
  "memory_items": [],
  "confidence": 0.0,
  "reasoning_summary": ""
}
```

Exact mapping between `memory_updates` and `memory_items` is TBD.

## Storage Targets

### `memory_items`

Purpose:

Long-term extracted memories with confidence, source, observation count, and active flag.

Fields from existing code and bootstrap docs:

- `id`
- `telegram_user_id`
- `memory_type`
- `memory_category`
- `memory_content`
- `confidence`
- `source`
- `first_observed_at`
- `last_confirmed_at`
- `observation_count`
- `is_active`
- `created_at`
- `updated_at`

Existing repository operations:

- `createMemory`
- `getMemories`
- `getMemoriesByType`
- `incrementObservation`
- `deactivateMemory`

### `user_profiles`

Purpose:

Aggregated user profile across stable interests, goals, decision style, learning style, motivation drivers, strengths, recurring challenges, and preferred response style.

Fields from existing code and bootstrap docs:

- `telegram_user_id`
- `profile_version`
- `primary_interests`
- `long_term_goals`
- `decision_style`
- `learning_style`
- `motivation_drivers`
- `strengths`
- `recurring_challenges`
- `preferred_response_style`
- `profile_confidence`
- `last_profile_update`
- `created_at`

Existing repository operations:

- `getProfile`
- `createProfile`
- `updateProfile`
- `upsertProfile`

## Memory Quality Rules

From `prompts/memory/memory_extractor.md`:

Store:

- goals
- projects
- learning objectives
- career aspirations
- business interests
- stable preferences
- recurring challenges
- long-term habits
- personal operating patterns

Do not store:

- temporary moods
- greetings
- one-time complaints
- small talk
- short-lived events

Rule:

Prefer missing a memory item over storing low-quality memory.

## Retrieval Rules

From `prompts/memory/memory_retriever.md`:

Retrieve only memories relevant to the current discussion.

Prioritize:

- active goals
- current projects
- recurring patterns
- known preferences
- previous obstacles

Do not overload responses with unnecessary memory.

## Proposed v1 Flow

This flow is derived from existing milestone goals and repository code. Exact n8n implementation is TBD.

1. Intake Engine validates Qualification Engine output.
2. Memory Engine reads `memory_updates`.
3. Memory Engine filters for durable memory.
4. Memory Engine stores accepted items in `memory_items`.
5. If a duplicate memory already exists, Memory Engine increments observation count.
6. Future qualification flows retrieve active memory by `telegram_user_id`.
7. Retrieved memory is passed into qualification context.

## Integration Point

Current best integration point:

After `Validate - Qualification JSON` and before or after `Postgres - Update Client`.

Exact node placement is TBD and should be validated in n8n-v2 before production promotion.

## Deduplication

Existing database design includes a unique index on:

- `telegram_user_id`
- `memory_type`
- `memory_content`

Existing repository function `incrementObservation(memoryId)` supports repeated observations.

Exact conflict handling strategy in n8n is TBD.

## Validation Criteria

Memory Engine v1 is complete when:

- `memory_updates` can be parsed from validated Qualification Engine output
- durable memory can be inserted into `memory_items`
- duplicate memory does not create uncontrolled duplicates
- observation count can increase for repeated memories
- active memories can be retrieved by `telegram_user_id`
- retrieved memory can be supplied to a future qualification step
- all behavior is validated in n8n-v2 before production promotion

## Open Questions

| Question | Status |
|----------|--------|
| What is the exact JSON shape for each `memory_updates` item? | TBD |
| Should memory persistence happen inside the Intake Engine workflow or a separate Memory Engine workflow? | TBD |
| Should `memory_items` or `memory_facts` be the primary v1 memory table? | TBD |
| Should `user_profiles` be updated in v1 or deferred? | TBD |
| Should every assistant/user message be stored in `messages` before memory extraction? | TBD |
| Should memory extraction use the existing `memory_extractor.md` prompt or the existing Qualification Engine `memory_updates` output? | TBD |
| What n8n-v2 nodes will implement memory persistence? | TBD |
| What smoke test proves memory retrieval affects future qualification? | TBD |
