# Runtime Registry

Status: Active

Last updated: 2026-06-17

Purpose:

Record the last confirmed infrastructure state for BrainCoach runtime services so future debugging starts from a verified baseline instead of assumptions.

This document is an operational Knowledge Asset. Update it after every successful infrastructure change that affects Cloud Run, n8n, Cloud SQL, Secret Manager, service accounts, deployment revisions, health checks, or runtime environment variables.

---

## Update Rule

Update this registry when any of the following changes:

- Cloud Run service configuration
- Cloud Run revision or deployment strategy
- Docker image version
- Cloud SQL instance or connection path
- database names or runtime database ownership
- service account or IAM role relevant to runtime access
- Secret Manager reference names
- environment variables
- health check or readiness behavior
- last known-good deployment
- last known-good repository commit

Do not write secret values into this document. Store only Secret Manager resource names.

---

## Current Runtime Snapshot

Snapshot date:

2026-06-17

Snapshot status:

Candidate stable. Under half-day real-world observation.

Observed goal:

Make `bgs-orchestrator-dev` reliable and predictable for n8n editing, activation, publishing, imports, uploads, and workflow execution.

---

## Cloud Project

Project ID:

`braincoach-n8n-prod`

---

## Cloud Run Service

Service:

`bgs-orchestrator-dev`

Region:

`europe-west3`

URL:

`https://bgs-orchestrator-dev-936756379899.europe-west3.run.app`

Service account:

`936756379899-compute@developer.gserviceaccount.com`

Latest candidate-stable revision:

`bgs-orchestrator-dev-00010-bhj`

Last known-good repository branch:

`validate-json`

Last known-good repository commit:

`c559ab79`

---

## Runtime Engine

Platform:

`n8n`

Pinned image:

`docker.io/n8nio/n8n:2.22.5`

Rule:

Do not deploy `latest`. Keep exact n8n image version pinned.

---

## Cloud Run Runtime Configuration

Container HTTP port:

`8080`

Request timeout:

`3600` seconds

CPU:

`2`

Memory:

`2Gi`

Minimum instances:

`1`

Maximum instances:

`1`

CPU throttling:

Disabled

Cloud Run annotation:

`run.googleapis.com/cpu-throttling=false`

Startup CPU boost:

Enabled

Cloud Run annotation:

`run.googleapis.com/startup-cpu-boost=true`

Reason:

n8n is not only a request/response HTTP server. It uses background DB pings, wait tracking, task broker activity, execution cleanup, webhook registration, and editor push state. CPU throttling caused unstable behavior during editor use and activation/publishing operations.

---

## Cloud SQL

Instance connection name:

`braincoach-n8n-prod:europe-west3:n8n-db-instance`

Engine:

PostgreSQL 15

PostgreSQL port:

`5432`

Required Cloud Run connection path:

`/cloudsql/braincoach-n8n-prod:europe-west3:n8n-db-instance`

Do not use as Cloud Run DB host:

`34.185.162.86`

Reason:

The public IP was used during debugging and caused Cloud Run to PostgreSQL timeout behavior. The canonical Cloud Run path is the Cloud SQL connector socket path.

---

## Databases

### bgs_orch

Status:

Active

Purpose:

BGS orchestration runtime database and n8n runtime state.

Runtime user:

`bgs_admin`

Confirmed n8n runtime tables:

- `workflow_entity`
- `credentials_entity`
- `user`
- `project`
- `settings`
- `migrations`
- `execution_entity`

Confirmed counts during 2026-06-17 incident:

- `workflow_entity`: 13
- `credentials_entity`: 6
- `user`: 1
- `project`: 1
- `settings`: 4
- `migrations`: 184
- `execution_entity`: 528

### bgs_core

Status:

Active

Purpose:

Human reality and application data.

Summer Map v1.1 tables:

- `persons`
- `conversations`
- `parent_interviews`
- `interview_responses`
- `conversation_events`
- `messages`

Confirmed condition:

`conversations.chk_conversation_stage` includes `waiting_q5`.

### bgs_analytics

Status:

Active

Purpose:

Analytics layer.

---

## Secret Manager References

Database password:

`bgs-admin-password`

n8n encryption key:

`bgs-n8n-encryption-key`

Rule:

Secret values must not be written into repository files, workflow definitions, or runtime registry documents.

---

## Environment Variables

Current tuned baseline:

```text
N8N_PROTOCOL=https
N8N_PORT=8080
N8N_DIAGNOSTICS_ENABLED=false

DB_TYPE=postgresdb
DB_POSTGRESDB_DATABASE=bgs_orch
DB_POSTGRESDB_USER=bgs_admin
DB_POSTGRESDB_HOST=/cloudsql/braincoach-n8n-prod:europe-west3:n8n-db-instance
DB_POSTGRESDB_PORT=5432
DB_POSTGRESDB_POOL_SIZE=10
DB_POSTGRESDB_CONNECTION_TIMEOUT=300000
DB_POSTGRESDB_IDLE_CONNECTION_TIMEOUT=300000
DB_POSTGRESDB_SCHEMA=public

N8N_RUNNERS_GRANT_TOKEN_TTL=600
N8N_PUSH_BACKEND=sse

N8N_HOST=bgs-orchestrator-dev-936756379899.europe-west3.run.app
WEBHOOK_URL=https://bgs-orchestrator-dev-936756379899.europe-west3.run.app
N8N_EDITOR_BASE_URL=https://bgs-orchestrator-dev-936756379899.europe-west3.run.app
```

Secret-backed variables:

```text
DB_POSTGRESDB_PASSWORD -> bgs-admin-password:latest
N8N_ENCRYPTION_KEY -> bgs-n8n-encryption-key:latest
```

Do not use:

```text
DB_POSTGRESDB_POOLSIZE
DB_POSTGRESDB_TIMEOUT
N8N_RUNNERS_ENABLED
```

Reason:

`DB_POSTGRESDB_POOLSIZE` and `DB_POSTGRESDB_TIMEOUT` are not the intended n8n variable names for this setup. `N8N_RUNNERS_ENABLED` logged as deprecated/unneeded in n8n 2.22.5.

---

## Last Incident: Database Readiness And Editor Offline

Date:

2026-06-17

Observed issue:

Cloud Run URL returned:

```json
{"code":503,"message":"Database is not ready!"}
```

Later observed issue:

n8n editor showed `Offline` a few seconds after page refresh. Workflow publish/import/activation worked only in a short window.

Verified not root cause:

- Cloud SQL instance existence
- `bgs_orch` database existence
- `bgs_core` database existence
- `bgs_admin` existence
- password validity
- direct psql access
- `cloudsql.client` service account access
- Secret Manager access
- Summer Map v1.1 `waiting_q5` constraint
- missing n8n workflow tables in `bgs_orch`

Root cause narrowed to:

Cloud Run runtime / n8n database connector / connection path / runtime lifecycle.

Confirmed contributing configuration issue:

`DB_POSTGRESDB_HOST` had been changed to public IP:

```text
34.185.162.86
```

Resolution actions:

- Restored Cloud SQL socket host.
- Replaced incorrect pool/timeout env names with current n8n env names.
- Increased DB pool size from `2` to `10`.
- Increased DB connection and idle timeouts to `300000`.
- Removed deprecated `N8N_RUNNERS_ENABLED`.
- Disabled CPU throttling.
- Set request timeout to `3600`.
- Set `N8N_RUNNERS_GRANT_TOKEN_TTL=600`.
- Set `N8N_PUSH_BACKEND=sse`.

Current result:

n8n UI became accessible again. Candidate stable configuration is under practical observation.

---

## Last Health Evidence

Observed on 2026-06-17:

- n8n UI opened successfully.
- Overview page loaded workflows.
- Visible metrics:
  - Prod executions: `283`
  - Failed prod executions: `8`
  - Failure rate: `2.8%`
  - Average run time: `3.33s`
  - Total workflows: `11`
- Visible workflows included:
  - `BrainCoach Summer Map v1.1 MVP`
  - `test BrainCoach Intelligence Snapshot MVP-1`
  - `BrainCoach Intelligence Monitor MVP-1.1`
  - `BrainCoach GPS MVP-1.1 - Reflection Coach Sandbox`
  - `knowledge_registry_sync_v1`

---

## Recovery Commands

Use these only after checking current state first.

Describe current service:

```bash
gcloud run services describe bgs-orchestrator-dev \
  --region=europe-west3 \
  --format="yaml(spec.template.metadata.annotations,spec.template.spec.serviceAccountName,spec.template.spec.containers[0].env,spec.template.spec.containers[0].resources,spec.template.spec.timeoutSeconds)"
```

Read recent logs:

```bash
gcloud logging read \
'resource.type="cloud_run_revision"
 resource.labels.service_name="bgs-orchestrator-dev"
 resource.labels.location="europe-west3"' \
--limit=80 \
--format="value(timestamp,severity,textPayload)"
```

Restore current candidate stable config:

```bash
gcloud run services update bgs-orchestrator-dev \
  --region=europe-west3 \
  --set-cloudsql-instances=braincoach-n8n-prod:europe-west3:n8n-db-instance \
  --no-cpu-throttling \
  --cpu=2 \
  --memory=2Gi \
  --timeout=3600 \
  --min-instances=1 \
  --max-instances=1 \
  --update-env-vars DB_POSTGRESDB_HOST=/cloudsql/braincoach-n8n-prod:europe-west3:n8n-db-instance,DB_POSTGRESDB_PORT=5432,DB_POSTGRESDB_POOL_SIZE=10,DB_POSTGRESDB_CONNECTION_TIMEOUT=300000,DB_POSTGRESDB_IDLE_CONNECTION_TIMEOUT=300000,DB_POSTGRESDB_SCHEMA=public,N8N_RUNNERS_GRANT_TOKEN_TTL=600,N8N_PUSH_BACKEND=sse
```

---

## Open Observation

The current config should be observed during real n8n editing work. If instability remains, next investigation should focus on:

- n8n task runner behavior in Cloud Run
- editor push/SSE stability through Google Frontend
- Cloud SQL connector latency and Cloud SQL metrics
- Cloud Run CPU and memory metrics during activation/import
- whether n8n should be split into web and worker/process roles before heavier usage
