# Stage 4 — Analytics & Intelligence Layer

Status: In Progress

Date: 2026-06-09

Prerequisite: Stage 3 Completed (2026-06-09)

---

## Context

Stage 3 delivered the first operational research intake pipeline:

```text
Telegram → Tracker Entry → Observation → Signal Candidate → PostgreSQL
```

The system now captures and stores structured research objects in production. Stage 4 makes this accumulated data useful through analytics, aggregation, and reporting.

Production OS architecture was completed before physical implementation planning.

Closure documents now define the missing bridge between Signal Candidate and Knowledge Asset:

* `braincoach-docs/07_automation/production_os/06_governance/production_os_audit_closure_v1.md`
* `braincoach-docs/07_automation/production_os/06_governance/candidate_promotion_governance_v1.md`
* `braincoach-docs/07_automation/production_os/05_intelligence/signal_aggregation_layer_v1.md`
* `braincoach-docs/07_automation/production_os/05_intelligence/weekly_intelligence_report_v1.md`

---

## Goal

Build the Analytics & Intelligence Layer on top of the Stage 3 intake pipeline. Transform raw signal candidates into aggregated insights, detected patterns, and periodic research reports.

---

## Scope

### 1. Vertex AI Migration

Unify LLM provider strategy across BrainCoach GPS OS workflows.

Current state:

* Mixed provider usage in production (Gemini for transcription/classification, OpenAI for signal extraction in V3)
* No centralized model governance

Target state:

* Vertex AI as primary reasoning and generation provider
* Consistent model selection across Tracker, Observation, and Signal Extraction nodes
* Credential and model configuration documented in workflow specs

Tasks:

* Audit current LLM node usage across BrainCoach GPS OS V3
* Define Vertex AI model mapping (transcription, classification, signal extraction)
* Migrate `SIG_ExtractSignalCandidate` and related LLM nodes
* Validate output quality parity with current production behavior
* Update workflow documentation and export

Constraints:

* Production intake pipeline must remain operational during migration
* Incremental node-by-node migration, not full workflow rewrite

---

### 2. Analytics Layer

Create queryable analytics over research intake data.

Current state:

* Data exists in `tracker_entries`, `observations`, `research_signal_candidates`
* No aggregation views, no analytics queries, no dashboards

Target state:

* SQL views or materialized views for signal volume, type distribution, confidence trends
* User-level and system-level analytics over intake data
* Foundation for weekly report generation

Likely database objects:

* `v_signal_candidates_summary` (view)
* `v_observations_by_period` (view)
* Optional: `analytics_snapshots` table for periodic captures

Tasks:

* Define analytics questions (what do we need to know weekly?)
* Create SQL views over existing BrainCoach-owned tables
* Document views in `postgres-schema.md`
* Validate queries against live production data

Constraints:

* No new BrainCoach tables unless views are insufficient
* Analytics must operate only on BrainCoach-owned tables, not n8n platform tables

---

### 3. Signal Aggregation

Combine individual signal candidates into higher-level signal clusters.

Current state:

* Each observation may produce one or more isolated signal candidates
* No grouping, deduplication, or cross-observation linking

Target state:

* Signal candidates grouped by type, user, time window, and semantic similarity
* Recurring signals identified across multiple observations
* Aggregation output ready for pattern detection and reporting

Tasks:

* Define aggregation rules (by signal_type, by user, by time window)
* Implement deduplication logic for near-duplicate candidates
* Design aggregation output format (JSONB metadata or dedicated table)
* Evaluate whether `research_signals` table is needed or aggregation stays in views

Constraints:

* Do not promote candidates to confirmed signals without explicit review rules
* Aggregation is analytical, not promotional

Architecture reference:

`braincoach-docs/07_automation/production_os/05_intelligence/signal_aggregation_layer_v1.md`

---

### 4. Pattern Detection

Detect recurring behavioral and developmental patterns across accumulated signals.

Current state:

* Individual signal candidates with types like `self_initiation`, `dependence_external`
* No cross-signal pattern analysis

Target state:

* Recurring pattern identification across users and time periods
* Pattern objects linked to Self Learning Capability research framework
* Early deviation detection signals

Tasks:

* Define initial pattern taxonomy aligned with Signal Dictionary v1.0
* Implement pattern detection logic (rule-based first, LLM-assisted second)
* Connect patterns to `signal_registry` and future phenomenon candidates
* Document pattern detection methodology

Constraints:

* Pattern detection must handle classification noise from Stage 3 (research notes misclassified as behavioral signals)
* Signal Taxonomy v2 improvements may run in parallel but should not block initial pattern rules

---

### 5. Weekly Reports

Produce periodic research intelligence summaries from aggregated signal data.

Current state:

* No automated reporting
* No scheduled workflow for research summaries

Target state:

* Weekly report generated from analytics views and aggregated signals
* Report delivered via Telegram or stored as research artifact
* Report format aligned with BrainCoach research operating model

Tasks:

* Define weekly report template (signal volume, top patterns, notable observations, open questions)
* Create n8n scheduled workflow for report generation
* Connect report output to Content Factory intake or research layer
* Validate first report against manually reviewed signal data

Constraints:

* Reports must be based on real accumulated data, not synthetic examples
* First reports may be internal-only until quality is validated

Architecture reference:

`braincoach-docs/07_automation/production_os/05_intelligence/weekly_intelligence_report_v1.md`

---

### 6. Candidate Promotion Governance

Govern movement from signal candidates and knowledge candidates toward accepted knowledge or validated reality.

Current state:

* `research_signal_candidates` receives live data
* Production OS defines Signal Capture, Season Review, and Knowledge Update
* Promotion rules are now defined architecturally but not implemented

Target state:

* Manual-first review path from captured candidate to accepted candidate
* Explicit validation requirement before any `bgs_core` promotion
* No automatic phenomenon validation
* No automatic offer approval

Architecture reference:

`braincoach-docs/07_automation/production_os/06_governance/candidate_promotion_governance_v1.md`

Constraints:

* No automatic writes to `bgs_core`
* No live registry updates without reviewed draft upsert approval
* No SQL or table design is approved by this planning document

---

## Carried Over from Stage 3

These items were originally planned for Stage 3 and remain relevant:

* Knowledge relationship discovery (`knowledge_relationship_candidates`, `knowledge_relationships`)
* Signal candidate review and promotion workflow (candidate → accepted → promoted)
* Signal Taxonomy v2 (reduce classification noise)
* Registry reconciliation (delete/rename detection in knowledge_assets)
* Semantic indexing for knowledge_assets

Priority in Stage 4:

Knowledge relationships and signal promotion are secondary to analytics and reporting unless they directly unblock pattern detection.

Recommended order:

1. Vertex AI Migration
2. Analytics Layer (views)
3. Signal Aggregation
4. Pattern Detection
5. Weekly Reports
6. Candidate Promotion Governance implementation
7. Signal promotion workflow
8. Knowledge relationships (if capacity allows)

---

## Decisions Required

| Decision | Options | Recommendation |
| --- | --- | --- |
| LLM provider | Vertex AI only vs. hybrid | Vertex AI primary, document exceptions |
| Aggregation storage | Views only vs. new table | Start with views, add table if needed |
| Report delivery | Telegram vs. GitHub artifact vs. both | Telegram for operator, GitHub for archive |
| Pattern detection | Rule-based vs. LLM-assisted | Rule-based first, LLM for ambiguous cases |
| Signal promotion | Manual review vs. automated threshold | Manual review until taxonomy v2 stabilizes |
| Candidate promotion governance | automatic vs. manual-first | manual-first, no `bgs_core` writes without approval |

---

## Success Criteria

Stage 4 is complete when:

1. BrainCoach GPS OS runs on Vertex AI for all LLM nodes
2. Analytics views provide signal volume, type, and confidence metrics
3. Signal candidates are aggregated and deduplicated across observations
4. At least one recurring pattern is detected from production data
5. First weekly report is generated from real accumulated signals
6. Candidate promotion workflow is implemented as manual-first governance
7. Documentation is synchronized across Knowledge OS

---

ARCHITECTURAL HYPOTHESIS

Primary entity of BrainCoach GPS:

Development Profile

Definition:

A Development Profile represents a person whose developmental trajectory is being observed, measured, and analyzed over time.

A Development Profile may contain:

* observations
* signals
* phenomena
* assessments
* trainer feedback
* parent feedback
* self-reports
* performance metrics
* trajectory events

Users interact with the system.

Development Profiles are the objects being developed and analyzed.

Relationship:

User
↓
Development Profile
↓
Development Data


## Dependencies

| Dependency | Source | Status |
| --- | --- | --- |
| Production intake pipeline | Stage 3 | Complete |
| research_signal_candidates data | Stage 3 | Accumulating |
| PostgreSQL schema documentation | Stage 3 | Current |
| BrainCoach GPS MVP-1 — bgs_core adapted | GPS MVP-1 workflow migration | Production |
| Signal Dictionary v1.0 | Milestone 3 | Available |
| Vertex AI credentials | Infrastructure | To be configured |

---

## Risks

* **Classification noise** — Stage 3 misclassifications may produce false patterns. Mitigation: Signal Taxonomy v2 in parallel, confidence thresholds in aggregation.
* **Insufficient data volume** — Pattern detection requires enough signal candidates. Mitigation: start with user-level aggregation, expand as data grows.
* **Migration regression** — Vertex AI migration may change extraction quality. Mitigation: side-by-side validation before cutover.
* **Scope creep** — Knowledge graph work may compete with analytics. Mitigation: strict priority order, analytics first.

---

## Documentation Deliverables

When Stage 4 completes, update:

* `05_operations/reviews/stage_4_completion_report.md`
* `03_knowledge/04_decisions/system_evolution_log.md`
* `03_knowledge/system_snapshot.md`
* `07_automation/04_postgres/postgres-schema.md`
* `07_automation/03_n8n/BrainCoach_GPS_OS_v1.md`
* Relevant workflow specs in `07_automation/02_workflows/`

