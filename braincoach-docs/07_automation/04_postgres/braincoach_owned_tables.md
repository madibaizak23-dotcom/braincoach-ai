# BrainCoach Owned Tables

Status: Active DBA Rule
Last Updated: 2026-06-18
Database: `braincoach_dev` legacy snapshot, `bgs_core`, `bgs_orch`
Schema: `public`, `production`

## Purpose

This document separates BrainCoach-owned application tables from n8n platform tables that currently share the same PostgreSQL `public` schema.

Reason:

- BrainCoach tables store product, research, memory, registry, and business state.
- n8n platform tables store workflow engine state, credentials, executions, agents, users, projects, tags, and internal runtime metadata.
- Both sets currently appear in `pg_indexes`, `information_schema`, and schema inspection queries.

DBA rule:

BrainCoach documentation should list BrainCoach-owned tables separately from n8n platform tables unless the task is specifically about n8n infrastructure.

Migration governance:

All PostgreSQL migrations must follow `braincoach-docs/07_automation/04_postgres/migration_governance_rule_v1.md`.

Scope note:

This document started as a `braincoach_dev` ownership inventory and now also tracks confirmed BGS-owned tables in `bgs_core` and `bgs_orch`. Database ownership should be explicit for new sections.

Schema segregation rule:

`DEC-017 BGS Orch Schema Segregation` requires new BrainCoach-owned `bgs_orch` tables to be created outside `public`, in separate schemas:

* `knowledge.*`
* `research.*`
* `production.*`
* `agent.*`

Existing BrainCoach-owned `bgs_orch.public` tables remain in place until a separate approved migration moves them.

## BrainCoach-Owned Tables

Current BrainCoach-owned base tables: 20

| table | ownership | role |
| --- | --- | --- |
| `clients` | BrainCoach | user identity, qualification state, engagement state |
| `content_assets` | BrainCoach | content items generated from hypotheses |
| `content_hypotheses` | BrainCoach | content experiment hypotheses |
| `content_metrics` | BrainCoach | content performance metrics |
| `conversation_state` | BrainCoach | active Scout/qualification working memory |
| `decision_log` | BrainCoach | operational mirror of architectural/system decisions |
| `events` | BrainCoach | user/system event audit trail |
| `knowledge_assets` | BrainCoach | authoritative repository Knowledge Object registry |
| `knowledge_events` | BrainCoach | GitHub sync event log |
| `knowledge_objects` | BrainCoach | governance catalog of Knowledge Object classes |
| `memory_facts` | BrainCoach | extracted user-linked memory facts/signals |
| `memory_items` | BrainCoach | long-term user memory items |
| `messages` | BrainCoach | conversation history |
| `observations` | BrainCoach | tracker/research observations |
| `offers_and_outcomes` | BrainCoach | offer, response, outcome, and conversion signal storage |
| `offers_sent` | BrainCoach | sent offer tracking |
| `research_signal_candidates` | BrainCoach | staging table for potential signals extracted from observations |
| `system_decisions` | BrainCoach | simple system/user decision storage |
| `tracker_entries` | BrainCoach | persistent tracker notes, insights, hypotheses, observations |
| `user_profiles` | BrainCoach | aggregated user profile memory |

## BGS Core-Owned Tables

Current `bgs_core` MVP-1 Reality Tracker tables confirmed live on 2026-06-12: 7

| table | ownership | role |
| --- | --- | --- |
| `activity_confirmations` | BrainCoach / BGS Core | confirmation, correction, or dispute records for activity events |
| `activity_events` | BrainCoach / BGS Core | concrete activity facts for GPS Reality Tracker |
| `activity_types` | BrainCoach / BGS Core | lookup table for allowed activity types |
| `person_roles` | BrainCoach / BGS Core | role assignments for persons, optionally linked to trajectories |
| `trajectories` | BrainCoach / BGS Core | one development trajectory for a person |
| `trajectory_domains` | BrainCoach / BGS Core | lookup table for GPS trajectory domains |
| `trajectory_entries` | BrainCoach / BGS Core | free-form trajectory notes linked to persons, trajectories, tracker entries, or observations |

Live seed confirmation:

| table | rows confirmed | date |
| --- | ---: | --- |
| `trajectory_domains` | 7 | 2026-06-12 |
| `activity_types` | 11 | 2026-06-12 |

## BGS Orch-Owned Tables

Current BrainCoach-owned `bgs_orch.public` tables confirmed live on 2026-06-13/2026-06-14: 3

Full `bgs_orch.public` table inventory:

`braincoach-docs/07_automation/04_postgres/BGS_ORCH_PUBLIC_TABLES_2026_06_14.md`

Schema confirmation:

`bgs_orch` currently has no custom domain schemas. Owner-provided schema list on 2026-06-14:

| schema | role |
| --- | --- |
| `public` | active application/runtime schema |
| `information_schema` | PostgreSQL system schema |
| `pg_catalog` | PostgreSQL system schema |
| `pg_toast` | PostgreSQL system schema |

| table | ownership | role |
| --- | --- | --- |
| `knowledge_events` | BrainCoach / BGS Orch | repository event stream for Knowledge OS synchronization |
| `knowledge_assets` | BrainCoach / BGS Orch | live registry of repository Knowledge Assets by `source_path` |
| `repository_journal` | BrainCoach / BGS Orch | persistent repository evolution journal |

Future BrainCoach-owned tables must not be added to `bgs_orch.public` without a new accepted decision overriding DEC-017.

### BGS Orch Production Tables

Current BrainCoach-owned `bgs_orch.production` tables confirmed live on 2026-06-18: 11

Final review:

`braincoach-docs/07_automation/04_postgres/BGS_ORCH_PRODUCTION_MVP1_FINAL_REVIEW.md`

Installed migrations:

* `braincoach-docs/07_automation/04_postgres/007_bgs_orch_instagram_analytics_mvp1.sql`
* `braincoach-docs/07_automation/04_postgres/008_bgs_orch_weekly_content_automation_mvp1.sql`

Installed operational seed:

* `braincoach-docs/07_automation/04_postgres/009_seed_weekly_content_plan_2026_06_22.sql`
* `braincoach-docs/07_automation/04_postgres/010_seed_generated_assets_2026_06_22_monday_mvp.sql`
* `braincoach-docs/07_automation/04_postgres/011_update_monday_generated_assets_public_language_v1.sql`

Seed confirmation:

* `CPLAN-2026-06-22-W01` installed as `draft`.
* 68 `content_units` confirmed.
* `publishing_scheduler_hypothesis` confirmed as candidate weekly baseline.
* 11 Monday `generated_content_assets` confirmed.
* All 11 Monday generated assets remain `pending / pending`.
* 4 Monday generated assets corrected by public-language review while remaining `pending / pending`.

| table | ownership | role |
| --- | --- | --- |
| `production.content_outcomes` | BrainCoach / BGS Orch | channel-specific outcome records linked to content units / executions |
| `production.content_units` | BrainCoach / BGS Orch | planned content units by channel, format, date, KPI, CTA |
| `production.generated_content_assets` | BrainCoach / BGS Orch | generated copy, scripts, and channel assets for content units |
| `production.instagram_comment_inbox_items` | BrainCoach / BGS Orch | classified Instagram comment inbox items for operator review |
| `production.instagram_comment_snapshots` | BrainCoach / BGS Orch | read-only Instagram comment snapshots |
| `production.instagram_media_snapshots` | BrainCoach / BGS Orch | read-only Instagram media metric snapshots |
| `production.market_signals` | BrainCoach / BGS Orch | classified marketing, offer, sales, objection, and risk signals |
| `production.outcomes` | BrainCoach / BGS Orch | generic Instagram production outcome summaries |
| `production.publishing_executions` | BrainCoach / BGS Orch | actual publishing execution records |
| `production.tracker_monitoring_items` | BrainCoach / BGS Orch | monitoring items for Tracker / daily content control loop |
| `production.weekly_content_plans` | BrainCoach / BGS Orch | weekly content plan root object |

Safety:

* No `bgs_core` tables were changed.
* No n8n platform/runtime tables were changed.
* No automatic public action was enabled.

Live registry confirmation:

| table | key | confirmed asset examples | date |
| --- | --- | --- | --- |
| `knowledge_assets` | `source_path` | `DEC-016 BGS Database Boundary: Core vs Orch`, `Research Schema v1 for bgs_orch` | 2026-06-14 |

## BrainCoach-Owned Views

Current BrainCoach-owned views: 2

| view | ownership | role |
| --- | --- | --- |
| `v_qualification_funnel` | BrainCoach | qualification and booking funnel analytics |
| `v_users_by_stage` | BrainCoach | active users by stage analytics |

## n8n Platform Tables

n8n platform tables are not BrainCoach application tables.

Examples observed in the same `public` schema include:

- `agents`
- `agents_messages`
- `agents_threads`
- `agent_execution`
- `agent_execution_threads`
- `agent_registry`
- `chat_hub_agents`
- `chat_hub_messages`
- `chat_hub_sessions`
- `chat_hub_tools`
- `credentials_entity`
- `execution_entity`
- `execution_data`
- `execution_metadata`
- `installed_nodes`
- `installed_packages`
- `instance_ai_messages`
- `instance_ai_threads`
- `migrations`
- `oauth_clients`
- `processed_data`

These tables should be treated as n8n-owned runtime storage.

Do not modify n8n platform tables manually unless the task is explicitly about n8n maintenance, migration, or recovery.

## Naming Rule For New BrainCoach Tables

New BrainCoach tables should be visibly domain-owned.

Preferred names:

- `knowledge_relationship_candidates`
- `knowledge_relationships`
- `research_signals`
- `research_phenomena`
- `trajectory_events`
- `offer_experiments`
- `content_experiments`

Avoid generic names that can collide with platform/runtime tables:

- `agents`
- `users`
- `projects`
- `executions`
- `workflow`
- `credentials`
- `settings`
- `variables`
- `tags`
- `migrations`

If a generic concept is required, prefix or qualify it with the BrainCoach domain:

| weak name | preferred BrainCoach name |
| --- | --- |
| `relationships` | `knowledge_relationships` |
| `signals` | `research_signals` |
| `events` | `trajectory_events` or `research_events` for new domain-specific event tables |
| `profiles` | `user_profiles` or `learning_profiles` |
| `offers` | `offer_experiments` or `offers_sent` |
| `agents` | `braincoach_agents` or agent specs in docs, not runtime tables |

## Schema Inspection Rule

When documenting BrainCoach DB state, filter to the owned table list unless a broader platform audit is needed.

Recommended BrainCoach-only table filter:

```sql
WHERE table_schema = 'public'
  AND table_name IN (
    'clients',
    'content_assets',
    'content_hypotheses',
    'content_metrics',
    'conversation_state',
    'decision_log',
    'events',
    'knowledge_assets',
    'knowledge_events',
    'knowledge_objects',
    'memory_facts',
    'memory_items',
    'messages',
    'observations',
    'offers_and_outcomes',
    'offers_sent',
    'research_signal_candidates',
    'system_decisions',
    'tracker_entries',
    'user_profiles'
  )
```

Recommended BrainCoach-only views filter:

```sql
WHERE table_schema = 'public'
  AND table_name IN (
    'v_qualification_funnel',
    'v_users_by_stage'
  )
```

## New Table Documentation Rule

Every new BrainCoach-owned PostgreSQL table must be documented in the same working session in which it is created.

This is mandatory for both `braincoach_dev` and `bgs_core`.

No database migration is considered complete until repository documentation and live database state are reconciled.

Source of truth order:

1. Live PostgreSQL
2. SQL Migrations
3. Database Canon / Governance Docs
4. System Logs

When sources disagree, Live PostgreSQL has priority.

Required updates:

1. Update `postgres-schema.md`
   Add the table purpose, columns, constraints, foreign keys, indexes, and BrainCoach role.

2. Update `braincoach_owned_tables.md`
   Add the table to the BrainCoach-owned table list and confirm that it is not an n8n platform/runtime table.

3. Add or update a table-specific contract when the table is important for a workflow or system layer.
   Recommended path:

```text
braincoach-docs/07_automation/04_postgres/{table_name}.md
```

4. Add a migration file when the table is created through SQL.
   Recommended path:

```text
braincoach-docs/07_automation/04_postgres/{number}_{migration_name}.sql
```

5. If the table changes architecture boundaries, update:

```text
braincoach-docs/03_knowledge/04_decisions/system_evolution_log.md
```

6. If the table is part of BGS runtime or product evolution, update:

```text
braincoach-docs/05_operations/12_reviews/bgs_milestone_log.md
```

7. Add a final migration review note in the same PostgreSQL folder when live state has been checked:

```text
braincoach-docs/07_automation/04_postgres/{MIGRATION_NAME}_FINAL_REVIEW.md
```

Minimum table contract:

```md
# table_name

Status:
Owner: BrainCoach
Database: braincoach_dev
Schema: public

## Purpose

## Columns

| column | type | required | default | description |
| --- | --- | --- | --- | --- |

## Constraints

## Foreign Keys

## Indexes

## n8n Usage

## BrainCoach Role

## Migration
```

Required validation queries after table creation:

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
  AND table_name = '{table_name}'
ORDER BY ordinal_position;
```

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
  AND tc.table_name = '{table_name}'
ORDER BY tc.constraint_type, tc.constraint_name, kcu.ordinal_position;
```

```sql
SELECT
    schemaname,
    tablename,
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
  AND tablename = '{table_name}'
ORDER BY indexname;
```

## Future Recommendation

Current state is acceptable for MVP work.

For a later hardening stage, consider moving BrainCoach-owned tables into a dedicated schema:

```text
braincoach.*
```

Potential future separation:

```text
public.*      -> n8n platform/runtime tables
braincoach.*  -> BrainCoach application tables
```

Do not perform this migration during active Stage 4 work unless there is a clear operational reason. Stability is more important than schema expansion.
