# Live BGS Core Access Needed

Date: 2026-06-12
Status: Blocked pending live schema access
Scope: Live PostgreSQL schema verification before applying GPS Tracker draft migration

## Current Access Status

Live `bgs_core` verification was not completed because the current Codex environment does not have a usable PostgreSQL access path.

Checked locally:

- `psql` not found.
- `gcloud` not found.
- Cloud SQL Auth Proxy not found.
- `node pg` client not available.
- Cloud SQL host/IP not found in repository.

Safety status:

- No migrations were applied.
- No DDL was executed.
- No `CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `INSERT`, `UPDATE`, or `DELETE` was executed.
- Draft migration remains unapplied: `braincoach-docs/07_automation/04_postgres/draft_004_gps_tracker_foundation.sql`.

## What Is Needed From Owner

Provide one of the following access paths.

### Option A - Direct PostgreSQL Access

Required:

- Cloud SQL public IP or hostname
- Port
- Database: `bgs_core`
- User: `bgs_readonly`
- Password

Allowed use:

- `SELECT`
- `information_schema` queries
- `pg_catalog` queries

### Option B - Cloud SQL Auth Proxy

Required:

- Cloud SQL Auth Proxy connection command
- Local port to use
- Database: `bgs_core`
- User: `bgs_readonly`
- Password

Example shape:

```bash
cloud-sql-proxy PROJECT:REGION:INSTANCE --port 5432
```

### Option C - gcloud Auth

Required:

- `gcloud auth` access
- Project ID
- Instance connection name
- Database: `bgs_core`
- User: `bgs_readonly`
- Password

Example shape:

```bash
gcloud auth login
gcloud config set project PROJECT_ID
gcloud sql instances describe INSTANCE_NAME
```

### Option D - Manual Cloud SQL Studio Run

Run the read-only SQL below manually in Cloud SQL Studio and send the output back.

This is the safest option if local client access is not available.

## Manual Read-Only SQL For Cloud SQL Studio

Run only these read-only queries.

### 1. Current Database And User

```sql
SELECT
    current_database() AS database_name,
    current_user AS current_user,
    session_user AS session_user,
    current_schema() AS current_schema;
```

### 2. Tables List

```sql
SELECT
    table_schema,
    table_name,
    table_type
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;
```

### 3. Existing Core Tables Check

```sql
SELECT
    table_name,
    CASE
        WHEN table_name IN (
            'persons',
            'observations',
            'tracker_entries',
            'conversation_events'
        )
        THEN 'required_existing_table'
        ELSE 'other'
    END AS classification
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name IN (
    'persons',
    'observations',
    'tracker_entries',
    'conversation_events'
  )
ORDER BY table_name;
```

### 4. Existing GPS / Activity / Trajectory Tables Check

```sql
SELECT
    table_name,
    table_type
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name IN (
    'trajectory_domains',
    'trajectories',
    'person_roles',
    'activity_types',
    'activity_events',
    'activity_confirmations',
    'trajectory_entries',
    'trajectory_matrix_snapshots',
    'gps_reports'
  )
ORDER BY table_name;
```

Expected before migration:

- Ideally no rows, unless some GPS tracker tables already exist.
- If any rows appear, draft migration must be reconciled before applying.

### 5. Columns List For Existing Core Tables

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
  AND table_name IN (
    'persons',
    'observations',
    'tracker_entries',
    'conversation_events'
  )
ORDER BY table_name, ordinal_position;
```

### 6. Columns List For Existing GPS Candidate Tables

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
  AND table_name IN (
    'trajectory_domains',
    'trajectories',
    'person_roles',
    'activity_types',
    'activity_events',
    'activity_confirmations',
    'trajectory_entries',
    'trajectory_matrix_snapshots',
    'gps_reports'
  )
ORDER BY table_name, ordinal_position;
```

### 7. Constraints

```sql
SELECT
    tc.table_name,
    tc.constraint_name,
    tc.constraint_type,
    kcu.column_name,
    ccu.table_name AS referenced_table,
    ccu.column_name AS referenced_column
FROM information_schema.table_constraints tc
LEFT JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
   AND tc.table_schema = kcu.table_schema
LEFT JOIN information_schema.constraint_column_usage ccu
    ON tc.constraint_name = ccu.constraint_name
   AND tc.table_schema = ccu.table_schema
WHERE tc.table_schema = 'public'
  AND tc.table_name IN (
    'persons',
    'observations',
    'tracker_entries',
    'conversation_events',
    'trajectory_domains',
    'trajectories',
    'person_roles',
    'activity_types',
    'activity_events',
    'activity_confirmations',
    'trajectory_entries',
    'trajectory_matrix_snapshots',
    'gps_reports'
  )
ORDER BY tc.table_name, tc.constraint_type, tc.constraint_name, kcu.ordinal_position;
```

### 8. Foreign Keys

```sql
SELECT
    tc.table_name,
    tc.constraint_name,
    kcu.column_name,
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
   AND tc.table_schema = kcu.table_schema
JOIN information_schema.constraint_column_usage ccu
    ON ccu.constraint_name = tc.constraint_name
   AND ccu.table_schema = tc.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY'
  AND tc.table_schema = 'public'
  AND tc.table_name IN (
    'persons',
    'observations',
    'tracker_entries',
    'conversation_events',
    'trajectory_domains',
    'trajectories',
    'person_roles',
    'activity_types',
    'activity_events',
    'activity_confirmations',
    'trajectory_entries',
    'trajectory_matrix_snapshots',
    'gps_reports'
  )
ORDER BY tc.table_name, tc.constraint_name, kcu.ordinal_position;
```

### 9. Indexes

```sql
SELECT
    schemaname,
    tablename,
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
  AND tablename IN (
    'persons',
    'observations',
    'tracker_entries',
    'conversation_events',
    'trajectory_domains',
    'trajectories',
    'person_roles',
    'activity_types',
    'activity_events',
    'activity_confirmations',
    'trajectory_entries',
    'trajectory_matrix_snapshots',
    'gps_reports'
  )
ORDER BY tablename, indexname;
```

### 10. Check Constraints Definitions

```sql
SELECT
    conrelid::regclass AS table_name,
    conname AS constraint_name,
    pg_get_constraintdef(oid) AS constraint_definition
FROM pg_constraint
WHERE contype = 'c'
  AND connamespace = 'public'::regnamespace
  AND conrelid::regclass::text IN (
    'persons',
    'observations',
    'tracker_entries',
    'conversation_events',
    'trajectory_domains',
    'trajectories',
    'person_roles',
    'activity_types',
    'activity_events',
    'activity_confirmations',
    'trajectory_entries',
    'trajectory_matrix_snapshots',
    'gps_reports'
  )
ORDER BY table_name::text, constraint_name;
```

## Next Step

Wait for live schema output.

After live output is available:

1. Compare live `persons`, `observations`, `tracker_entries`, and `conversation_events` against draft assumptions.
2. Check whether any GPS/activity/trajectory tables already exist.
3. Revise draft migration if needed.
4. Only apply migration after explicit approval.
