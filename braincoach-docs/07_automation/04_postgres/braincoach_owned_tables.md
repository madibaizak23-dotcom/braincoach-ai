# BrainCoach Owned Tables

Status: Active DBA Rule
Last Updated: 2026-06-08
Database: `braincoach_dev`
Schema: `public`

## Purpose

This document separates BrainCoach-owned application tables from n8n platform tables that currently share the same PostgreSQL `public` schema.

Reason:

- BrainCoach tables store product, research, memory, registry, and business state.
- n8n platform tables store workflow engine state, credentials, executions, agents, users, projects, tags, and internal runtime metadata.
- Both sets currently appear in `pg_indexes`, `information_schema`, and schema inspection queries.

DBA rule:

BrainCoach documentation should list BrainCoach-owned tables separately from n8n platform tables unless the task is specifically about n8n infrastructure.

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

## BrainCoach-Owned Views

Current BrainCoach-owned views: 2

| view | ownership | role |
| --- | --- | --- |
| `v_qualification_funnel` | BrainCoach | qualification and booking funnel analytics |
| `v_users_by_stage` | BrainCoach | active users by stage analytics |

## n8n Platform Tables

n8n platform tables are not BrainCoach application tables.

Examples observed in the same `public` schema:

- `workflow_entity`
- `workflow_history`
- `workflow_statistics`
- `workflow_dependency`
- `webhook_entity`
- `credentials_entity`
- `execution_entity`
- `execution_data`
- `execution_metadata`
- `project`
- `project_relation`
- `user`
- `tag_entity`
- `variables`
- `agents`
- `agents_messages`
- `agents_threads`
- `agent_execution`
- `agent_execution_threads`

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
migrations/{number}_create_{table_name}.sql
```

5. If the table changes architecture boundaries, update:

```text
braincoach-docs/03_knowledge/04_decisions/system_evolution_log.md
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

Do not perform this migration during active Stage 3 discovery unless there is a clear operational reason. Stability is more important than schema expansion.
