# Runtime Events

## 2026-06-17: bgs-orchestrator-dev stability tuning for editor offline issue

- Trigger: after database readiness recovery, n8n editor still intermittently showed `Offline` shortly after page refresh.
- User-reported behavior:
  - workflow activation/publish/import had to be done within a few seconds after refresh;
  - quick deactivate/activate cycles previously correlated with browser disconnects and temporary `503 Database is not ready`;
  - service usually recovered after several minutes.
- Applied Cloud Run/runtime tuning:
  - revision reached after tuning: `bgs-orchestrator-dev-00010-bhj`;
  - disabled CPU throttling;
  - kept CPU `2` and memory `2Gi`;
  - set request timeout to `3600`;
  - kept min instances `1` and max instances `1`;
  - increased `DB_POSTGRESDB_POOL_SIZE` to `10`;
  - increased `DB_POSTGRESDB_CONNECTION_TIMEOUT` to `300000`;
  - increased `DB_POSTGRESDB_IDLE_CONNECTION_TIMEOUT` to `300000`;
  - set `N8N_RUNNERS_GRANT_TOKEN_TTL=600`;
  - set `N8N_PUSH_BACKEND=sse`.
- Status: candidate stable config. User will work for half a day and report if editor/runtime behavior remains uncomfortable.
- Goal: make the server reliable and predictable enough for normal n8n editing, activation, publishing, import, and upload workflows.

## 2026-06-17: bgs-orchestrator-dev database readiness recovery

- Incident: Cloud Run URL returned `{"code":503,"message":"Database is not ready!"}`.
- Confirmed active databases: `bgs_orch` and `bgs_core`.
- Confirmed `bgs_orch` had valid n8n runtime tables and data:
  - `workflow_entity`: 13 rows.
  - `credentials_entity`: 6 rows.
  - `user`: 1 row.
  - `project`: 1 row.
  - `settings`: 4 rows.
  - `migrations`: 184 rows.
- Confirmed `bgs_core.conversations.chk_conversation_stage` includes `waiting_q5`; Summer Map v1.1 migration was not the root cause.
- Found Cloud Run `DB_POSTGRESDB_HOST` had been changed to public IP `34.185.162.86`.
- Restored Cloud SQL socket host: `/cloudsql/braincoach-n8n-prod:europe-west3:n8n-db-instance`.
- Replaced incorrect n8n env vars:
  - removed `DB_POSTGRESDB_POOLSIZE`
  - removed `DB_POSTGRESDB_TIMEOUT`
  - added `DB_POSTGRESDB_POOL_SIZE`
  - added `DB_POSTGRESDB_CONNECTION_TIMEOUT`
  - added `DB_POSTGRESDB_IDLE_CONNECTION_TIMEOUT`
- Removed deprecated `N8N_RUNNERS_ENABLED`.
- Recommended and applied Cloud Run runtime stabilization:
  - no CPU throttling
  - CPU 2
  - memory 2Gi
  - min instances 1
  - max instances 1
- Result: n8n UI became accessible again and showed the Overview workflows list.
