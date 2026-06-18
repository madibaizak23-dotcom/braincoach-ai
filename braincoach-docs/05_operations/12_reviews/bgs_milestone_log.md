# BGS Milestone Log

## MILESTONE-001

Date: 2026-06-10

Title:

BGS Administrative Boundary Established

Completed:

* Created bgs_admin
* Created bgs_core
* Created bgs_orch
* Created bgs_analytics
* Established ownership boundary

Status:

Completed

---

## MILESTONE-002

Date: 2026-06-10

Title:

Repository Journal Operational

Completed:

* Connected to bgs_orch
* Created repository_journal
* Verified schema
* Established first orchestration persistence layer

Status:

Completed



## MILESTONE-003

First Agent Registered

✓ agent_registry created
✓ AGENT-004 registered
✓ orchestration layer operational


# MILESTONE-004


## BGS Runtime Bootstrap Completed

Date:

2026-06-10

### Completed

* Deployed bgs-orchestrator-dev
* Connected Cloud SQL
* Connected bgs_orch
* Connected bgs_admin
* Connected Secret Manager
* Validated n8n 2.22.5 runtime
* Resolved Cloud Run health check issue

### Root Cause

Cloud Run expected port 8080.

n8n was configured to listen on 5678.

### Resolution

N8N_PORT updated to 8080.

### Result

First operational BGS runtime successfully deployed.

### Runtime

Service:

bgs-orchestrator-dev

Region:

europe-west3

Status:

Operational

MILESTONE-004 BGS Runtime Bootstrap Completed

Status:
SUCCESS


## MILESTONE-005

First BGS Query Executed

Date:
2026-06-10

Query:
SELECT current_database();

Result:
bgs_orch

Status:
SUCCESS

---

## MILESTONE-006

Title:

GPS MVP-1 Reality Tracker Foundation Applied

Date:

2026-06-12

Completed:

* Live `bgs_core` migration applied manually in Cloud SQL
* `trajectory_domains` created
* `trajectories` created
* `person_roles` created
* `activity_types` created
* `activity_events` created
* `activity_confirmations` created
* `trajectory_entries` created
* `trajectory_domains` seed confirmed: 7 rows
* `activity_types` seed confirmed: 11 rows
* Repository SQL and PostgreSQL docs placed under `braincoach-docs/07_automation/04_postgres`

Safety:

* Existing tables were not altered
* Existing data was not deleted
* Conversation Engine was not changed
* `trajectory_matrix_snapshots` and `gps_reports` were not included in MVP-1

Documentation Rule:

Every future BGS database migration must be documented in the same working session: SQL file, schema docs, owned-table inventory, final review note, and milestone/system log entry.

Formal Rule:

`braincoach-docs/07_automation/04_postgres/migration_governance_rule_v1.md`

Session Outcome:

* Live PostgreSQL `bgs_core` checked
* Real schema reconciled with docs
* GPS Reality Tracker MVP-1 created
* 7 new tables added
* Conversation Engine compatibility preserved
* Reality Tracker and GPS Layer boundary defined
* Migration Governance approach recorded
* Trajectory Architecture formalization started

Status:

SUCCESS

---

## MILESTONE-009

Title:

Research Schema v1 Registered In BGS Orchestration Knowledge Assets

Date:

2026-06-14

Completed:

* Owner manually applied the reviewed `bgs_orch.knowledge_assets` upsert
* `DEC-016 BGS Database Boundary: Core vs Orch` registered as `decision`
* `Research Schema v1 for bgs_orch` registered as `architecture`
* Both assets confirmed with `source_of_truth = 'github'`
* Both assets confirmed with `status = 'active'`

Verification:

The owner ran a live `SELECT` against `bgs_orch.knowledge_assets`; query returned 2 rows matching the expected `source_path` values.

Safety:

* Codex did not run SQL against PostgreSQL
* No database or table was created
* This was a registry upsert into an existing live table

Status:

SUCCESS

---

## MILESTONE-007

Title:

BrainCoach GPS Workflow Migrated To BGS Core GPS MVP-1

Date:

2026-06-13

Completed:

* `BrainCoach GPS MVP-1 — bgs_core adapted.json` imported into n8n
* Owner added required tokens/credentials after import
* Workflow confirmed operational by owner
* Stage 3 workflow logic preserved and PostgreSQL layer adapted to live `bgs_core`
* Legacy export `BrainCoach GPS OS — Stage 3 Complete.json` removed from repository to avoid duplicated source-of-truth workflow exports
* Migration diff-report stored next to the adapted workflow export

Current Export:

`braincoach-docs/07_automation/03_n8n/BrainCoach GPS MVP-1 — bgs_core adapted.json`

Report:

`braincoach-docs/07_automation/03_n8n/BrainCoach GPS MVP-1 — bgs_core adapted.diff-report.md`

Status:

SUCCESS

---

## MILESTONE-008

Title:

BGS Orchestration Knowledge Tables Confirmed

Date:

2026-06-13

Completed:

* Owner executed `CREATE EXTENSION IF NOT EXISTS "pgcrypto"` in `bgs_orch`
* `knowledge_events` table created in `bgs_orch`
* `knowledge_assets` table confirmed existing in `bgs_orch`
* PostgreSQL returned `relation "knowledge_assets" already exists, skipping`
* Repository runtime inventory updated to include `knowledge_events` and `knowledge_assets`

Safety:

* SQL was executed manually by owner
* Codex did not run database commands
* Existing `knowledge_assets` table was not dropped or recreated

Status:

SUCCESS

---

## MILESTONE-010

Title:

Stage 4 Architecture Consolidation Completed

Date:

2026-06-14

Completed:

* Production OS architecture consolidation completed
* Knowledge production lifecycle defined from Research Season to Knowledge Update
* Database boundaries formalized through DEC-016 and DEC-017
* System marked ready for Stage 4 implementation design

Status:

SUCCESS

---

## MILESTONE-011

Title:

BGS Orch Production MVP-1 Tables Installed

Date:

2026-06-18

Completed:

* Owner manually applied `007_bgs_orch_instagram_analytics_mvp1.sql` in `bgs_orch`
* Owner manually applied `008_bgs_orch_weekly_content_automation_mvp1.sql` in `bgs_orch`
* `production` schema confirmed live
* 11 production tables confirmed
* 37 constraints confirmed
* 9 foreign keys confirmed
* Smoke test inserted one weekly content plan and one linked content unit

Tables:

* `production.instagram_media_snapshots`
* `production.instagram_comment_snapshots`
* `production.instagram_comment_inbox_items`
* `production.outcomes`
* `production.weekly_content_plans`
* `production.content_units`
* `production.generated_content_assets`
* `production.publishing_executions`
* `production.content_outcomes`
* `production.market_signals`
* `production.tracker_monitoring_items`

Safety:

* `bgs_core` was not modified
* n8n platform tables were not modified
* No autopublishing or automatic public replies were enabled

Final Review:

`braincoach-docs/07_automation/04_postgres/BGS_ORCH_PRODUCTION_MVP1_FINAL_REVIEW.md`

Status:

SUCCESS

---

## MILESTONE-012

Title:

First Weekly Content Plan Seed Installed

Date:

2026-06-18

Completed:

* Owner manually applied `009_seed_weekly_content_plan_2026_06_22.sql` in `bgs_orch`
* Weekly plan `CPLAN-2026-06-22-W01` confirmed for 2026-06-22 to 2026-06-28
* Plan status confirmed as `draft`
* 68 content units confirmed
* Platform / format distribution confirmed
* `publishing_scheduler_hypothesis` metadata confirmed as candidate weekly baseline

Package:

* Instagram: 4 Reels, 2 Carousels, 35 Stories
* TikTok: 4 Shorts
* YouTube Shorts: 4 Shorts
* Threads: 7 units
* Facebook: 5 Posts
* Telegram: 7 Notes

Safety:

* No schema changes were made by seed 009
* No autopublishing was enabled
* The plan remains draft until generated assets and human approval exist

Final Review:

`braincoach-docs/07_automation/04_postgres/BGS_ORCH_PRODUCTION_MVP1_FINAL_REVIEW.md`

Status:

SUCCESS

---

## MILESTONE-013

Title:

BrainCoach Content Planning Became Production Pipeline

Date:

2026-06-18

Completed:

* Strategic observation accepted: BrainCoach moved from manual content planning to a content production system
* Production path formalized as `Conversation -> Content -> Signal -> Knowledge`
* Weekly production-cycle freeze adopted
* `DEC-035-weekly-production-cycle-freeze.md` created
* Monday Generator MVP identified as the next implementation step

Pipeline:

```text
Weekly Strategy Brief
->
content_plan
->
content_units
->
generated_content_assets
->
review
->
publishing
->
signal_capture
->
knowledge_update
```

Rule:

After weekly seed installation, do not change Weekly Brief, Channel Matrix, Scheduler, `content_plan`, or `content_units` until the week completes.

Only the asset layer may change during the live week.

Status:

SUCCESS

---

## MILESTONE-014

Title:

First Generated Content Assets Seed Applied

Date:

2026-06-18

Completed:

* Owner manually applied `010_seed_generated_assets_2026_06_22_monday_mvp.sql` in `bgs_orch`
* 11 Monday generated assets inserted into `production.generated_content_assets`
* `monday_generated_assets = 11` confirmed
* `voice_check_status = pending` confirmed for all 11 assets
* `approval_status = pending` confirmed for all 11 assets

Transition confirmed:

```text
content_units
->
generated_content_assets
->
human_review
```

Safety:

* No schema changes were made by seed 010
* No content units were changed
* No generated asset was approved
* No publishing execution was created
* No autopublishing was enabled

Status:

SUCCESS

---

## MILESTONE-015

Title:

First Generated Asset Language Correction Applied

Date:

2026-06-18

Completed:

* Owner manually applied `011_update_monday_generated_assets_public_language_v1.sql` in `bgs_orch`
* 4 Monday generated assets corrected for public-language fit
* `corrected_assets = 4` confirmed
* All 11 Monday generated assets remained `voice_check_status = pending`
* All 11 Monday generated assets remained `approval_status = pending`

Corrected:

* `CUNIT-2026-06-22-IG-REEL-01`
* `CUNIT-2026-06-22-IG-STORY-05`
* `CUNIT-2026-06-22-THREADS-01`
* `CUNIT-2026-06-22-TG-01`

Safety:

* No schema changes were made by seed 011
* No content units were changed
* No weekly structure was changed
* No generated asset was approved
* No autopublishing was enabled

Status:

SUCCESS
