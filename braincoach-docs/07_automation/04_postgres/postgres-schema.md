# PostgreSQL Schema

Status: Active DBA Snapshot
Last Updated: 2026-06-08
Database: `braincoach_dev`
Schema: `public`

## Purpose

This document is the current database dictionary for the BrainCoach operational PostgreSQL layer.

PostgreSQL owns:

- user state
- conversation memory
- tracker entries
- knowledge registry mirrors
- research observations
- offer and outcome persistence
- operational event history

The current source snapshot was collected from `information_schema.columns`.

## Current Inventory

### Base Tables

Current public base tables: 20

| table | BrainCoach role |
| --- | --- |
| `clients` | user identity, qualification state, engagement state |
| `content_assets` | content items generated from hypotheses |
| `content_hypotheses` | content experiment hypotheses |
| `content_metrics` | performance metrics for content assets |
| `conversation_state` | active Scout/qualification working memory |
| `decision_log` | operational mirror of architectural and system decisions |
| `events` | user/system event audit trail |
| `knowledge_assets` | authoritative repository knowledge object registry |
| `knowledge_events` | GitHub sync event log |
| `knowledge_objects` | governance catalog of Knowledge Object classes |
| `memory_facts` | extracted user-linked memory facts/signals |
| `memory_items` | long-term user memory items |
| `messages` | conversation history |
| `observations` | research/tracker observations created from entries |
| `offers_and_outcomes` | offer, response, outcome, and conversion signal storage |
| `offers_sent` | sent offer tracking |
| `research_signal_candidates` | staging table for potential signals extracted from observations |
| `system_decisions` | simple decision storage for system/user decisions |
| `tracker_entries` | persistent tracker notes, insights, hypotheses, observations |
| `user_profiles` | aggregated user profile memory |

### Views

Current public views discovered through `information_schema.columns`: 2

| view | BrainCoach role |
| --- | --- |
| `v_qualification_funnel` | qualification and booking funnel analytics |
| `v_users_by_stage` | active users by stage analytics |

## Tables

### `clients`

Purpose: User identity, qualification state, engagement state, and high-level lifecycle status.

| column | type | nullable | default |
| --- | --- | --- | --- |
| `id` | `uuid` | no | `gen_random_uuid()` |
| `telegram_user_id` | `bigint` | no |  |
| `first_name` | `character varying` | yes |  |
| `username` | `character varying` | yes |  |
| `current_stage` | `character varying` | yes |  |
| `current_keyword` | `character varying` | yes |  |
| `qualification_depth` | `integer` | yes | `0` |
| `consultation_interest` | `boolean` | yes | `false` |
| `emotional_state` | `character varying` | yes |  |
| `emotional_intensity` | `integer` | yes | `0` |
| `interaction_type` | `character varying` | yes |  |
| `total_messages` | `integer` | yes | `0` |
| `created_at` | `timestamp without time zone` | yes | `now()` |
| `updated_at` | `timestamp without time zone` | yes | `now()` |
| `last_message_at` | `timestamp without time zone` | yes |  |
| `allow_reminders` | `boolean` | yes | `false` |
| `last_nudge_sent_at` | `timestamp without time zone` | yes |  |

### `content_assets`

Purpose: Content items produced by the Content Factory and linked to testable hypotheses.

| column | type | nullable | default |
| --- | --- | --- | --- |
| `id` | `uuid` | no | `gen_random_uuid()` |
| `title` | `character varying` | yes |  |
| `content_type` | `character varying` | yes |  |
| `hypothesis_id` | `uuid` | yes |  |
| `publication_date` | `timestamp without time zone` | yes |  |
| `status` | `character varying` | yes |  |
| `metadata` | `jsonb` | yes | `'{}'::jsonb` |

### `content_hypotheses`

Purpose: Content experiment hypotheses used to connect knowledge, content production, and market feedback.

| column | type | nullable | default |
| --- | --- | --- | --- |
| `id` | `uuid` | no | `gen_random_uuid()` |
| `hypothesis_name` | `character varying` | no |  |
| `description` | `text` | yes |  |
| `status` | `character varying` | yes | `'active'::character varying` |
| `created_at` | `timestamp without time zone` | yes | `now()` |

### `content_metrics`

Purpose: Captured performance metrics for published content assets.

| column | type | nullable | default |
| --- | --- | --- | --- |
| `id` | `uuid` | no | `gen_random_uuid()` |
| `content_id` | `uuid` | yes |  |
| `views` | `integer` | yes |  |
| `avg_watch_seconds` | `numeric` | yes |  |
| `likes` | `integer` | yes |  |
| `comments` | `integer` | yes |  |
| `shares` | `integer` | yes |  |
| `saves` | `integer` | yes |  |
| `followers_gained` | `integer` | yes |  |
| `captured_at` | `timestamp without time zone` | yes | `now()` |

### `conversation_state`

Purpose: Active Scout and qualification working memory for a Telegram user.

| column | type | nullable | default |
| --- | --- | --- | --- |
| `id` | `uuid` | no | `gen_random_uuid()` |
| `telegram_user_id` | `bigint` | no |  |
| `current_q_number` | `integer` | yes |  |
| `question_asked_at` | `timestamp without time zone` | yes |  |
| `expected_response_by` | `timestamp without time zone` | yes |  |
| `qualification_signals` | `jsonb` | yes |  |
| `pain_points` | `jsonb` | yes |  |
| `conversation_tone` | `character varying` | yes |  |
| `updated_at` | `timestamp without time zone` | yes | `now()` |
| `sub_stage` | `character varying` | yes | `'q_surface'::character varying` |
| `pattern_type` | `character varying` | yes |  |

### `decision_log`

Purpose: Operational mirror of BrainCoach architectural and governance decisions.

| column | type | nullable | default |
| --- | --- | --- | --- |
| `id` | `uuid` | no | `gen_random_uuid()` |
| `decision_id` | `character varying` | no |  |
| `title` | `character varying` | no |  |
| `decision_date` | `date` | no |  |
| `decision_text` | `text` | no |  |
| `reason` | `text` | yes |  |
| `status` | `character varying` | no | `'accepted'::character varying` |
| `related_documents` | `jsonb` | yes | `'[]'::jsonb` |
| `created_at` | `timestamp without time zone` | yes | `now()` |
| `updated_at` | `timestamp without time zone` | yes | `now()` |

### `events`

Purpose: Audit trail for user and system events.

| column | type | nullable | default |
| --- | --- | --- | --- |
| `id` | `uuid` | no | `gen_random_uuid()` |
| `telegram_user_id` | `bigint` | no |  |
| `event_name` | `character varying` | no |  |
| `event_category` | `character varying` | yes |  |
| `old_stage` | `character varying` | yes |  |
| `new_stage` | `character varying` | yes |  |
| `keyword` | `character varying` | yes |  |
| `model_used` | `character varying` | yes |  |
| `metadata` | `jsonb` | yes |  |
| `created_at` | `timestamp without time zone` | yes | `now()` |

### `knowledge_assets`

Purpose: Authoritative registry of repository Knowledge Objects after Stage 2 Full Repository Registry.

Current role: primary source of truth for known repository assets.

| column | type | nullable | default |
| --- | --- | --- | --- |
| `id` | `uuid` | no | `gen_random_uuid()` |
| `object_type` | `character varying` | no |  |
| `object_name` | `character varying` | no |  |
| `object_path` | `text` | no |  |
| `version` | `character varying` | yes |  |
| `status` | `character varying` | yes | `'active'::character varying` |
| `first_seen` | `timestamp without time zone` | yes | `now()` |
| `last_updated` | `timestamp without time zone` | yes | `now()` |
| `metadata` | `jsonb` | yes | `'{}'::jsonb` |

Stage 3 note: this table should feed relationship discovery and graph construction.

### `knowledge_events`

Purpose: GitHub synchronization event log for the Knowledge Registry.

| column | type | nullable | default |
| --- | --- | --- | --- |
| `id` | `uuid` | no | `gen_random_uuid()` |
| `event_type` | `character varying` | no |  |
| `repository` | `character varying` | no |  |
| `branch` | `character varying` | no |  |
| `commit_id` | `character varying` | no |  |
| `event_timestamp` | `timestamp without time zone` | yes |  |
| `metadata` | `jsonb` | yes | `'{}'::jsonb` |
| `created_at` | `timestamp without time zone` | yes | `now()` |
| `object_type` | `character varying` | yes |  |

### `knowledge_objects`

Purpose: Governance catalog of BrainCoach Knowledge Object classes and lifecycle state.

| column | type | nullable | default |
| --- | --- | --- | --- |
| `id` | `uuid` | no | `gen_random_uuid()` |
| `object_type` | `character varying` | no |  |
| `class` | `character varying` | no |  |
| `owner` | `character varying` | no |  |
| `source_of_truth` | `character varying` | no |  |
| `lifecycle` | `character varying` | yes |  |
| `status` | `character varying` | no |  |
| `created_at` | `timestamp without time zone` | yes | `now()` |
| `updated_at` | `timestamp without time zone` | yes | `now()` |

### `memory_facts`

Purpose: Extracted user-linked memory facts and signals.

| column | type | nullable | default |
| --- | --- | --- | --- |
| `id` | `uuid` | no | `gen_random_uuid()` |
| `telegram_user_id` | `bigint` | no |  |
| `signal_type` | `character varying` | no |  |
| `meaning` | `text` | yes |  |
| `severity` | `character varying` | yes |  |
| `recommended_action` | `text` | yes |  |
| `created_at` | `timestamp without time zone` | yes | `now()` |
| `updated_at` | `timestamp without time zone` | yes | `now()` |

### `memory_items`

Purpose: Long-term memory extracted from conversations.

| column | type | nullable | default |
| --- | --- | --- | --- |
| `id` | `uuid` | no | `gen_random_uuid()` |
| `telegram_user_id` | `bigint` | no |  |
| `memory_type` | `character varying` | no |  |
| `memory_category` | `character varying` | yes |  |
| `memory_content` | `text` | no |  |
| `confidence` | `numeric` | yes |  |
| `source` | `character varying` | yes |  |
| `first_observed_at` | `timestamp without time zone` | yes | `now()` |
| `last_confirmed_at` | `timestamp without time zone` | yes | `now()` |
| `observation_count` | `integer` | yes | `1` |
| `is_active` | `boolean` | yes | `true` |
| `created_at` | `timestamp without time zone` | yes | `now()` |
| `updated_at` | `timestamp without time zone` | yes | `now()` |

### `messages`

Purpose: Conversation history.

| column | type | nullable | default |
| --- | --- | --- | --- |
| `id` | `uuid` | no | `gen_random_uuid()` |
| `telegram_user_id` | `bigint` | no |  |
| `role` | `character varying` | no |  |
| `content` | `text` | no |  |
| `model_used` | `character varying` | yes |  |
| `intent` | `character varying` | yes |  |
| `confidence` | `numeric` | yes |  |
| `emotional_signal` | `character varying` | yes |  |
| `message_tokens` | `integer` | yes |  |
| `created_at` | `timestamp without time zone` | yes | `now()` |

### `observations`

Purpose: Research and tracker observations created from tracker entries.

| column | type | nullable | default |
| --- | --- | --- | --- |
| `id` | `uuid` | no | `gen_random_uuid()` |
| `telegram_user_id` | `bigint` | no |  |
| `observation_text` | `text` | no |  |
| `source_entry_id` | `uuid` | no |  |
| `current_state` | `character varying` | yes | `'captured'::character varying` |
| `created_at` | `timestamp without time zone` | yes | `now()` |
| `updated_at` | `timestamp without time zone` | yes | `now()` |

Stage 3 note: observations are a natural source for signal, phenomenon, and trajectory graph edges.

### `offers_and_outcomes`

Purpose: Offer, response, outcome, and conversion signal storage.

| column | type | nullable | default |
| --- | --- | --- | --- |
| `id` | `uuid` | no | `gen_random_uuid()` |
| `telegram_user_id` | `bigint` | no |  |
| `offers` | `text` | yes |  |
| `responses` | `text` | yes |  |
| `outcomes` | `text` | yes |  |
| `conversion_signals` | `text` | yes |  |
| `created_at` | `timestamp without time zone` | yes | `now()` |
| `updated_at` | `timestamp without time zone` | yes | `now()` |

### `offers_sent`

Purpose: Sent offer tracking.

| column | type | nullable | default |
| --- | --- | --- | --- |
| `id` | `uuid` | no | `gen_random_uuid()` |
| `telegram_user_id` | `bigint` | no |  |
| `offer_id` | `character varying` | no |  |
| `keyword` | `character varying` | yes |  |
| `offer_message` | `text` | yes |  |
| `status` | `character varying` | yes | `'pending'::character varying` |
| `response_at` | `timestamp without time zone` | yes |  |
| `user_response` | `text` | yes |  |
| `created_at` | `timestamp without time zone` | yes | `now()` |

### `research_signal_candidates`

Purpose: Staging table for potential signals extracted from tracker observations.

| column | type | nullable | default |
| --- | --- | --- | --- |
| `id` | `uuid` | no | `gen_random_uuid()` |
| `telegram_user_id` | `bigint` | no |  |
| `source_observation_id` | `uuid` | no |  |
| `source_entry_id` | `uuid` | yes |  |
| `signal_text` | `text` | no |  |
| `signal_type` | `character varying` | no | `'unknown'::character varying` |
| `confidence` | `numeric` | yes |  |
| `evidence` | `text` | yes |  |
| `status` | `character varying` | no | `'candidate'::character varying` |
| `metadata` | `jsonb` | no | `'{}'::jsonb` |
| `created_at` | `timestamp without time zone` | yes | `now()` |
| `updated_at` | `timestamp without time zone` | yes | `now()` |

Knowledge OS placement: Research Layer / Tracker Intake.

This table receives signal candidates after `OBS_CreateObservation` and before any promotion into confirmed signals, deviations, or phenomena.

### `system_decisions`

Purpose: Simple system/user decision storage.

| column | type | nullable | default |
| --- | --- | --- | --- |
| `id` | `bigint` | no | `nextval('system_decisions_id_seq'::regclass)` |
| `telegram_user_id` | `bigint` | yes |  |
| `title` | `text` | yes |  |
| `decision_text` | `text` | yes |  |
| `status` | `text` | yes | `'accepted'::text` |
| `created_at` | `timestamp without time zone` | yes | `now()` |

### `tracker_entries`

Purpose: Persistent tracker notes, insights, hypotheses, observations, and raw captured entries.

| column | type | nullable | default |
| --- | --- | --- | --- |
| `id` | `uuid` | no | `gen_random_uuid()` |
| `telegram_user_id` | `bigint` | no |  |
| `content` | `text` | no |  |
| `entry_type` | `character varying` | yes | `'note'::character varying` |
| `tags` | `jsonb` | yes | `'[]'::jsonb` |
| `metadata` | `jsonb` | yes | `'{}'::jsonb` |
| `created_at` | `timestamp without time zone` | yes | `now()` |

### `user_profiles`

Purpose: Aggregated user profile memory generated from memory items, qualification state, and recurring patterns.

| column | type | nullable | default |
| --- | --- | --- | --- |
| `telegram_user_id` | `bigint` | no |  |
| `profile_version` | `integer` | yes | `1` |
| `primary_interests` | `jsonb` | yes |  |
| `long_term_goals` | `jsonb` | yes |  |
| `decision_style` | `character varying` | yes |  |
| `learning_style` | `character varying` | yes |  |
| `motivation_drivers` | `jsonb` | yes |  |
| `strengths` | `jsonb` | yes |  |
| `recurring_challenges` | `jsonb` | yes |  |
| `preferred_response_style` | `character varying` | yes |  |
| `profile_confidence` | `numeric` | yes |  |
| `last_profile_update` | `timestamp without time zone` | yes | `now()` |
| `created_at` | `timestamp without time zone` | yes | `now()` |

## Views

### `v_qualification_funnel`

Purpose: Qualification and booking funnel analytics.

| column | type | nullable |
| --- | --- | --- |
| `new_leads` | `bigint` | yes |
| `in_qualification` | `bigint` | yes |
| `offer_shown` | `bigint` | yes |
| `booked` | `bigint` | yes |
| `conversion_rate` | `numeric` | yes |

### `v_users_by_stage`

Purpose: Active users by stage analytics.

| column | type | nullable |
| --- | --- | --- |
| `current_stage` | `character varying` | yes |
| `user_count` | `bigint` | yes |
| `avg_depth` | `numeric` | yes |
| `active_24h` | `bigint` | yes |

## Constraints

Source: `information_schema.table_constraints` snapshot from 2026-06-08.

### Primary Keys

| table | constraint | column |
| --- | --- | --- |
| `clients` | `clients_pkey` | `id` |
| `content_assets` | `content_assets_pkey` | `id` |
| `content_hypotheses` | `content_hypotheses_pkey` | `id` |
| `content_metrics` | `content_metrics_pkey` | `id` |
| `conversation_state` | `conversation_state_pkey` | `id` |
| `decision_log` | `decision_log_pkey` | `id` |
| `events` | `events_pkey` | `id` |
| `knowledge_assets` | `knowledge_assets_pkey` | `id` |
| `knowledge_events` | `knowledge_events_pkey` | `id` |
| `knowledge_objects` | `knowledge_objects_pkey` | `id` |
| `memory_facts` | `memory_facts_pkey` | `id` |
| `memory_items` | `memory_items_pkey` | `id` |
| `messages` | `messages_pkey` | `id` |
| `observations` | `observations_pkey` | `id` |
| `offers_and_outcomes` | `offers_and_outcomes_pkey` | `id` |
| `offers_sent` | `offers_sent_pkey` | `id` |
| `research_signal_candidates` | `research_signal_candidates_pkey` | `id` |
| `system_decisions` | `system_decisions_pkey` | `id` |
| `tracker_entries` | `tracker_entries_pkey` | `id` |
| `user_profiles` | `user_profiles_pkey` | `telegram_user_id` |

### Unique Constraints

| table | constraint | column(s) | role |
| --- | --- | --- | --- |
| `clients` | `clients_telegram_user_id_key` | `telegram_user_id` | one client per Telegram user |
| `conversation_state` | `conversation_state_telegram_user_id_key` | `telegram_user_id` | one active state per Telegram user |
| `decision_log` | `decision_log_decision_id_key` | `decision_id` | one operational record per decision id |
| `knowledge_assets` | `unique_object_path` | `object_path` | prevents duplicate repository assets |
| `knowledge_objects` | `uq_knowledge_object_type` | `object_type` | one governance row per object type |
| `offers_sent` | `offers_sent_telegram_user_id_offer_id_key` | `telegram_user_id`, `offer_id` | prevents duplicate offer sends per user and offer |

### Foreign Keys

Source: dedicated foreign key snapshot from 2026-06-08.

| table | constraint | local column | target |
| --- | --- | --- | --- |
| `conversation_state` | `conversation_state_telegram_user_id_fkey` | `telegram_user_id` | `clients.telegram_user_id` |
| `events` | `events_telegram_user_id_fkey` | `telegram_user_id` | `clients.telegram_user_id` |
| `memory_facts` | `memory_facts_telegram_user_id_fkey` | `telegram_user_id` | `clients.telegram_user_id` |
| `memory_items` | `memory_items_telegram_user_id_fkey` | `telegram_user_id` | `clients.telegram_user_id` |
| `messages` | `messages_telegram_user_id_fkey` | `telegram_user_id` | `clients.telegram_user_id` |
| `observations` | `fk_observation_entry` | `source_entry_id` | `tracker_entries.id` |
| `offers_and_outcomes` | `offers_and_outcomes_telegram_user_id_fkey` | `telegram_user_id` | `clients.telegram_user_id` |
| `offers_sent` | `offers_sent_telegram_user_id_fkey` | `telegram_user_id` | `clients.telegram_user_id` |
| `research_signal_candidates` | `research_signal_candidates_source_entry_id_fkey` | `source_entry_id` | `tracker_entries.id` |
| `research_signal_candidates` | `research_signal_candidates_source_observation_id_fkey` | `source_observation_id` | `observations.id` |
| `research_signal_candidates` | `research_signal_candidates_telegram_user_id_fkey` | `telegram_user_id` | `clients.telegram_user_id` |
| `tracker_entries` | `tracker_entries_telegram_user_id_fkey` | `telegram_user_id` | `clients.telegram_user_id` |
| `user_profiles` | `user_profiles_telegram_user_id_fkey` | `telegram_user_id` | `clients.telegram_user_id` |

### Not-Null Checks

The snapshot includes PostgreSQL-generated `CHECK` constraints with names like `2200_17944_1_not_null`. These represent not-null enforcement already reflected in the column dictionary as `nullable = no`.

Explicit check constraints:

| table | constraint | rule |
| --- | --- | --- |
| `research_signal_candidates` | `chk_research_signal_candidates_confidence` | `confidence` is null or between `0` and `1` |
| `research_signal_candidates` | `chk_research_signal_candidates_status` | `status` is one of `candidate`, `accepted`, `rejected`, `merged`, `promoted` |

## Indexes

Source: `pg_indexes` snapshot from 2026-06-08.

The index snapshot also includes n8n internal tables in the same `public` schema, such as `workflow_entity`, `credentials_entity`, `execution_entity`, `agents`, and related platform tables. This document lists only BrainCoach-owned tables from the current database inventory.

### `clients`

| index | definition |
| --- | --- |
| `clients_pkey` | unique btree on `id` |
| `clients_telegram_user_id_key` | unique btree on `telegram_user_id` |
| `idx_clients_current_stage` | btree on `current_stage` |
| `idx_clients_keyword` | btree on `current_keyword` |
| `idx_clients_last_message` | partial btree on `last_message_at` where `current_stage` is `sleeping` or `inactive` |
| `idx_clients_stage_keyword` | btree on `current_stage`, `current_keyword` |
| `idx_clients_telegram_id` | btree on `telegram_user_id` |

### `content_assets`

| index | definition |
| --- | --- |
| `content_assets_pkey` | unique btree on `id` |

### `content_hypotheses`

| index | definition |
| --- | --- |
| `content_hypotheses_pkey` | unique btree on `id` |

### `content_metrics`

| index | definition |
| --- | --- |
| `content_metrics_pkey` | unique btree on `id` |

### `conversation_state`

| index | definition |
| --- | --- |
| `conversation_state_pkey` | unique btree on `id` |
| `conversation_state_telegram_user_id_key` | unique btree on `telegram_user_id` |
| `idx_conv_state_user_id` | btree on `telegram_user_id` |

### `decision_log`

| index | definition |
| --- | --- |
| `decision_log_pkey` | unique btree on `id` |
| `decision_log_decision_id_key` | unique btree on `decision_id` |
| `idx_decision_log_date` | btree on `decision_date` |
| `idx_decision_log_decision_id` | btree on `decision_id` |
| `idx_decision_log_status` | btree on `status` |

### `events`

| index | definition |
| --- | --- |
| `events_pkey` | unique btree on `id` |
| `idx_events_category_created` | btree on `event_category`, `created_at DESC` |
| `idx_events_created_at` | btree on `created_at DESC` |
| `idx_events_event_name` | btree on `event_name` |
| `idx_events_user_id` | btree on `telegram_user_id` |

### `knowledge_assets`

| index | definition |
| --- | --- |
| `knowledge_assets_pkey` | unique btree on `id` |
| `unique_object_path` | unique btree on `object_path` |

### `knowledge_events`

| index | definition |
| --- | --- |
| `knowledge_events_pkey` | unique btree on `id` |

### `knowledge_objects`

| index | definition |
| --- | --- |
| `knowledge_objects_pkey` | unique btree on `id` |
| `uq_knowledge_object_type` | unique btree on `object_type` |

### `memory_facts`

| index | definition |
| --- | --- |
| `memory_facts_pkey` | unique btree on `id` |
| `idx_memory_facts_signal` | btree on `signal_type` |
| `idx_memory_facts_user` | btree on `telegram_user_id` |

### `memory_items`

| index | definition |
| --- | --- |
| `memory_items_pkey` | unique btree on `id` |
| `idx_memory_active` | btree on `is_active` |
| `idx_memory_type` | btree on `memory_type` |
| `idx_memory_unique` | unique btree on `telegram_user_id`, `memory_type`, `memory_content` |
| `idx_memory_user` | btree on `telegram_user_id` |

### `messages`

| index | definition |
| --- | --- |
| `messages_pkey` | unique btree on `id` |
| `idx_messages_created_at` | btree on `created_at` |
| `idx_messages_user_id` | btree on `telegram_user_id` |
| `idx_messages_user_recent` | btree on `telegram_user_id`, `created_at DESC` |

### `observations`

| index | definition |
| --- | --- |
| `observations_pkey` | unique btree on `id` |

### `offers_and_outcomes`

| index | definition |
| --- | --- |
| `offers_and_outcomes_pkey` | unique btree on `id` |
| `idx_offers_outcomes_user` | btree on `telegram_user_id` |

### `offers_sent`

| index | definition |
| --- | --- |
| `offers_sent_pkey` | unique btree on `id` |
| `offers_sent_telegram_user_id_offer_id_key` | unique btree on `telegram_user_id`, `offer_id` |
| `idx_offers_sent_status` | btree on `status` |
| `idx_offers_sent_user_id` | btree on `telegram_user_id` |

### `research_signal_candidates`

| index | definition |
| --- | --- |
| `research_signal_candidates_pkey` | unique btree on `id` |
| `idx_research_signal_candidates_created` | btree on `created_at DESC` |
| `idx_research_signal_candidates_entry` | btree on `source_entry_id` |
| `idx_research_signal_candidates_observation` | btree on `source_observation_id` |
| `idx_research_signal_candidates_status` | btree on `status` |
| `idx_research_signal_candidates_type` | btree on `signal_type` |
| `idx_research_signal_candidates_user` | btree on `telegram_user_id` |

### `system_decisions`

| index | definition |
| --- | --- |
| `system_decisions_pkey` | unique btree on `id` |

### `tracker_entries`

| index | definition |
| --- | --- |
| `tracker_entries_pkey` | unique btree on `id` |
| `idx_tracker_entries_created` | btree on `created_at DESC` |
| `idx_tracker_entries_type` | btree on `entry_type` |
| `idx_tracker_entries_user` | btree on `telegram_user_id` |

### `user_profiles`

| index | definition |
| --- | --- |
| `user_profiles_pkey` | unique btree on `telegram_user_id` |
| `idx_profile_decision_style` | btree on `decision_style` |
| `idx_profile_learning_style` | btree on `learning_style` |
| `idx_profile_updated` | btree on `last_profile_update DESC` |

## Stage 3 Readiness Notes

Stage 2 is complete: `knowledge_assets` is the authoritative registry for repository Knowledge Objects.

Stage 3 should add relationship discovery without disrupting current tables. The likely next database objects are:

- `knowledge_relationship_candidates`
- `knowledge_relationships`
- optional semantic index or embedding table after relationship rules are stable

Recommended Stage 3 dependency chain:

```text
knowledge_assets
->
knowledge_relationship_candidates
->
knowledge_relationships
->
knowledge_graph / retrieval layer
```

## DBA Snapshot Commands

Use these commands to refresh this document.

### Tables

```sql
SELECT
    table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_type = 'BASE TABLE'
ORDER BY table_name;
```

### Columns

```sql
SELECT
    table_name,
    ordinal_position,
    column_name,
    data_type,
    udt_name,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_schema = 'public'
ORDER BY table_name, ordinal_position;
```

### Constraints

```sql
SELECT
    tc.table_name,
    tc.constraint_name,
    tc.constraint_type,
    kcu.column_name
FROM information_schema.table_constraints tc
LEFT JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
   AND tc.table_schema = kcu.table_schema
WHERE tc.table_schema = 'public'
ORDER BY tc.table_name, tc.constraint_type, tc.constraint_name, kcu.ordinal_position;
```

### Foreign Keys

```sql
SELECT
    tc.table_name,
    kcu.column_name,
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name,
    tc.constraint_name
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
   AND tc.table_schema = kcu.table_schema
JOIN information_schema.constraint_column_usage ccu
    ON ccu.constraint_name = tc.constraint_name
   AND ccu.table_schema = tc.table_schema
WHERE tc.table_schema = 'public'
  AND tc.constraint_type = 'FOREIGN KEY'
ORDER BY tc.table_name, kcu.column_name;
```

### Indexes

```sql
SELECT
    schemaname,
    tablename,
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;
```

## Documentation Status

Columns: updated from live database snapshot.

Constraints: updated from live database snapshot.

Indexes: updated from live database snapshot for BrainCoach-owned tables.

Foreign keys: verified from dedicated foreign key snapshot.
