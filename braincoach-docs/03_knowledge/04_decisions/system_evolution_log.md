# System Evolution Log

Status: Active

Purpose:

Chronological record of major architectural decisions, milestones, discoveries, and system transitions within BrainCoach Knowledge OS.

---

## 2026-06-18

### Production Visual Framing Layer Accepted

Status: Accepted

Decision:

`DEC-027 Production Visual Framing Layer`

Objective:

Reduce visual fragmentation risk by introducing a stable master visual framing layer above existing Visual OS worlds.

Outcome:

* Accepted Navigation Universe as BrainCoach Visual Master World.
* Filled `visual_meaning_system.md` with the active visual framing rules.
* Preserved existing visual worlds and visual modes.
* Added recurring recognition elements such as route, path, trajectory line, checkpoint, signal, marker, map, coordinates, dashboard, tracker, and progress path.
* Added weekly production planning rule: Main Conversation, Main Tension, Main Question, Primary Visual World, Master World.

Explicit Non-Action:

* Visual OS was not replaced.
* The 7 Radical Color System was not replaced.
* No new visual worlds were introduced.
* No asset generation was performed.

### Weekly Sprint Accepted

Status: Accepted

Decision:

`DEC-026 Weekly Sprint`

Objective:

Create a weekly planning and reminder specification for tracker-driven personal practice, learning blocks, content production, client work, events, preparation, load checks, free windows, execution feedback, and correction.

Outcome:

* Added Weekly Sprint v1 under `05_operations/14_workflows`.
* Accepted DEC-026 as the governance decision.
* Linked Weekly Sprint from Practice Loop and tracker capture.
* Defined weekly planning as a control loop rather than a task list.
* Included reminders, missed-action recovery, content slots, masterclass preparation, and weekly review.

Explicit Non-Action:

* No actual reminder automation was created.
* No SQL was executed.
* No n8n workflow JSON was changed.

### Practice Loop Accepted

Status: Accepted

Decision:

`DEC-025 Practice Loop`

Objective:

Operationalize BrainCoach foundation stack as a recurring practice for founder self-tracking, client tracking, marketing, offer discovery, product decisions, and agent reasoning.

Outcome:

* Added Practice Loop v1 under `05_operations/14_workflows`.
* Accepted DEC-025 as the governance decision.
* Linked Practice Loop from Thinking OS and tracker capture.
* Defined tracker entries as raw material for DOTU, TOC, TRIZ, Logic Discipline, adaptation patterns / radicals, decision, action, and feedback.
* Added Council Mode: tracker as external working memory and practical method support using Goldratt / TOC, Altshuller / TRIZ, Lobanov / Russian Logic, DOTU, Sociology, and adaptation patterns / radicals.
* Preserved ternary logic states in practice: validated, contradicted, indeterminate.
* Defined adaptation patterns / radicals as diagnostic lenses, not identity labels.

Explicit Non-Action:

* Canon was not changed.
* No SQL was executed.
* No n8n workflow JSON was changed.
* No client-facing heavy theory language was introduced.

### Logic Discipline Practice Accepted

Status: Accepted

Decision:

`DEC-024 Logic Discipline Practice`

Objective:

Make formal logic discipline a mandatory gate for BrainCoach humans and agents so fluent outputs do not bypass valid reasoning.

Outcome:

* Added Logic Discipline Practice v1 under `01_foundation`.
* Accepted DEC-024 as the governance decision.
* Linked Logic Discipline from Thinking OS and Operational Philosophy.
* Established checks for terms, premises, quantifiers, inference, conclusion, contradiction, and reality feedback.
* Required agents to label claims as observed fact, source statement, interpretation, inference, hypothesis, validated knowledge, market signal, or decision.
* Preserved Russian Logic as the primary working foundation candidate for formal reasoning, syllogistic analysis, quantifier discipline, and ternary treatment of unresolved states.
* Added the rule that agents must not collapse unknown, candidate, or indeterminate states into true or false.

Explicit Non-Action:

* Canon was not changed.
* No accepted ontology terms were added.
* The source's polemical or historical claims were not automatically accepted as validated BrainCoach knowledge, but source claims relevant to method were preserved.
* No SQL was executed.
* No migration was approved.
* The full PDF was not imported into the repository.

Artifacts:

* `braincoach-docs/01_foundation/logic_discipline_practice_v1.md`
* `braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-024-logic-discipline-practice.md`
* `braincoach-docs/01_foundation/braincoach_thinking_os_practice_v1.md`
* `braincoach-docs/01_foundation/operational_philosophy.md`

---

### TRIZ Contradiction Practice Accepted

Status: Accepted

Decision:

`DEC-023 TRIZ Contradiction Practice`

Objective:

Make TRIZ a trained BrainCoach practice for contradiction formulation, resource search, separation, inventive option generation, and feedback design.

Outcome:

* Added TRIZ Contradiction Practice v1 under `01_foundation`.
* Accepted DEC-023 as the governance decision.
* Filled `04_domain/triz_guide.md` with a domain-facing application guide.
* Linked TRIZ from Thinking OS, Choice Practice, and Operational Philosophy.
* Established the rule that contradiction is a high-value signal of unresolved design, not a reason to accept weak compromise.

Explicit Non-Action:

* Canon was not changed.
* No accepted ontology terms were added.
* No SQL was executed.
* No migration was approved.
* The full PDF was not imported into the repository.

Artifacts:

* `braincoach-docs/01_foundation/triz_contradiction_practice_v1.md`
* `braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-023-triz-contradiction-practice.md`
* `braincoach-docs/04_domain/triz_guide.md`

---

### Goldratt Choice Practice Accepted

Status: Accepted

Decision:

`DEC-022 Goldratt Choice Practice`

Objective:

Make choice a trained BrainCoach practice for humans and agents, grounded in TOC-style clear thinking rather than preference selection or mass opinion.

Outcome:

* Added Goldratt Choice Practice v1 under `01_foundation`.
* Accepted DEC-022 as the governance decision.
* Linked Choice Practice from Thinking OS and Operational Philosophy.
* Defined choice as Goal -> Current reality -> Constraint -> Conflict / contradiction -> Assumptions -> Invalid assumption -> Better option -> Reality feedback.
* Added an agent output template for choice recommendations.

Explicit Non-Action:

* Canon was not changed.
* No accepted ontology terms were added.
* No SQL was executed.
* No migration was approved.
* The full book was not imported into the repository.

Artifacts:

* `braincoach-docs/01_foundation/goldratt_choice_practice_v1.md`
* `braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-022-goldratt-choice-practice.md`
* `braincoach-docs/01_foundation/braincoach_thinking_os_practice_v1.md`
* `braincoach-docs/01_foundation/operational_philosophy.md`

---

### DOTU And Sociology Foundation Intake Accepted

Status: Accepted

Decision:

`DEC-021 DOTU And Sociology Foundation Intake`

Objective:

Create a governed foundation intake path for DOTU and Sociology source material without changing canon and without moving source terminology directly into ontology or marketing.

Outcome:

* Added DOTU And Sociology Foundation Intake v1 under `01_foundation`.
* Accepted DEC-021 as the governance decision.
* Updated Operational Philosophy with the source intake rule.
* Established top-down movement: Foundation -> Ontology Candidates -> Knowledge / Intelligence Objects -> Signal and Phenomenon Mapping -> Domain Models -> Marketing Translation -> Operations / GPS / Survey / Offer.
* Established the model boundary rule: model is not the world; model is a map with a measure of approximation; terms describe processes, layers, regimes, and mechanisms, not labels for people.

Explicit Non-Action:

* Canon was not changed.
* No accepted ontology terms were added.
* No SQL was executed.
* No migration was approved.
* No books were imported wholesale into the repository.

Artifacts:

* `braincoach-docs/01_foundation/dotu_sociology_foundation_intake_v1.md`
* `braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-021-dotu-sociology-foundation-intake.md`
* `braincoach-docs/01_foundation/operational_philosophy.md`

---

### Thinking OS Adopted As Practice

Status: Accepted

Decision:

`DEC-020 Thinking OS As Practice`

Objective:

Convert BrainCoach Thinking OS v1.0 from a theoretical framework document into the active thinking practice for BrainCoach humans, AI agents, workflows, and reviews.

Outcome:

* Added BrainCoach Thinking OS Practice v1 under `01_foundation`.
* Accepted DEC-020 as the governance decision.
* Updated Operational Philosophy with the Thinking OS practice rule.
* Established the minimum sequence: DOTU Control Frame -> Sociological Context -> Constraint Detection -> Contradiction Detection -> Demand / Payment Trigger -> Signal / Phenomenon -> Decision -> Feedback.
* Reinforced the current cycle rule: do not optimize non-constraints and do not convert a mechanism into an offer without checking payment trigger.

Explicit Non-Action:

* No SQL was executed.
* No migration was approved.
* No n8n workflow export was changed.
* No new repository layer was created.

Artifacts:

* `braincoach-docs/01_foundation/braincoach_thinking_os_practice_v1.md`
* `braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-020-thinking-os-as-practice.md`
* `braincoach-docs/01_foundation/operational_philosophy.md`

---

### Payment Trigger Discovery Priority Accepted

Status: Accepted

Decision:

`DEC-019 Payment Trigger Discovery Priority`

Objective:

Shift the immediate BrainCoach constraint from content production and phenomenon expansion toward validation of the payment trigger.

Accepted Constraint:

```text
Phenomenon
↓
Payment Trigger
↓
Offer
```

Outcome:

* Added Strategy Journal 2026-06-18 as the planning artifact for the shift.
* Updated Offer Discovery v1 with payment-story capture requirements.
* Updated Market Discovery v1 with payment-trigger validation questions.
* Reframed Summer Map as the future universal BrainCoach Discovery Engine.
* Reframed GPS as early visibility into whether family investment converts into real progress.
* Updated marketing/content rules from phenomenon-first to market-pain-first during offer validation.
* Aligned Visual OS as a downstream visual meaning system whose input begins with market pain.
* Added SJ-2026-06-18-002 clarification: Self Learning Capability is a mechanism, while the buyable-result hypothesis is trajectory stability without constant external management.

Explicit Non-Action:

* No SQL was executed.
* No migration was approved.
* No new PostgreSQL table was created.
* No n8n workflow export was changed.

Artifacts:

* `braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-019-payment-trigger-discovery-priority.md`
* `braincoach-docs/05_operations/10_planning/strategy_journal_2026_06_18_payment_trigger.md`
* `braincoach-docs/05_operations/10_planning/offer_discovery_v1.md`
* `braincoach-docs/05_operations/10_planning/market_discovery_v1.md`
* `braincoach-docs/05_operations/13_runtime/summer_map_mvp_v1_state.md`
* `braincoach-docs/04_domain/01 marketing/08_POSITIONING.md`
* `braincoach-docs/04_domain/01 marketing/content_pillars_v2.md`

---

## 2026-06-14

### Production OS Structure Normalization v1 Applied

Status: Applied

Objective:

Package the newly defined Production OS object specifications into a readable canon and normalized documentation structure before further object design.

Outcome:

* Created Production OS Canon v1 as the reading map for the full object flow.
* Created Production OS Structure Normalization v1 with applied directory structure, canonical file names, link migration record, canon membership, and infrastructure boundaries.
* Moved Production OS object specs into domain folders under `braincoach-docs/07_automation/production_os/`.
* Added `README.md` as the Production OS folder index.
* Updated repository links and the reviewed draft live-registry upsert file to canonical paths.
* Reconfirmed that `003_seed_knowledge_assets.sql` must not be used for live knowledge asset registration.

Explicit Non-Action:

* No SQL was executed.
* No migration was approved.
* No live `bgs_orch.knowledge_assets` update was applied.

Artifacts:

* `braincoach-docs/07_automation/production_os/00_production_os_canon_v1.md`
* `braincoach-docs/07_automation/production_os/README.md`
* `braincoach-docs/07_automation/production_os/06_governance/production_os_structure_normalization_v1.md`

---

### Knowledge Update Specification v1 Drafted

Status: Draft

Depends On:

* `DEC-016 BGS Database Boundary: Core vs Orch`
* `DEC-017 BGS Orch Schema Segregation`
* `Season Review Specification v1`

Objective:

Define the governed process that turns accepted Season Review recommendations into explicit knowledge changes while enforcing the `bgs_orch` / `bgs_core` boundary.

Outcome:

* Knowledge Update defined as the bridge from season review recommendations to Knowledge OS changes.
* Updateable object categories documented: phenomena, patterns, offer signals, prompt library, research questions, knowledge assets, and season registry.
* Creatable candidate objects documented: candidate phenomenon, candidate pattern, candidate offer signal, new season proposal, new research question, prompt improvement candidate, agent evaluation note, knowledge asset update recommendation, future interview target group, and validation task.
* Validation requirements, allowed draft automation, and never-automatic actions documented.
* Boundary documented: no automatic `bgs_core` writes and no live registry updates without reviewed draft upsert approval.

Explicit Non-Action:

* No SQL was executed.
* No migration was approved.
* No table was created.
* No `bgs_core` write or promotion rule was created.

Spec Location:

* `braincoach-docs/07_automation/production_os/05_intelligence/knowledge_update.md`

---

### Season Review Specification v1 Drafted

Status: Draft

Depends On:

* `DEC-016 BGS Database Boundary: Core vs Orch`
* `DEC-017 BGS Orch Schema Segregation`
* `Research Schema v1 for bgs_orch`
* `Signal Capture Specification v1`

Objective:

Define the canonical Season Review object as the season-level review that consolidates Signal Captures into seasonal knowledge.

Outcome:

* Season Review defined as the object that reviews the full Research Season, not one outcome.
* Candidate Consolidation section added.
* Review inputs defined: repeated phrases, objection signals, fear signals, offer signals, strong cases, interview candidates, resonance signals, dissonance signals, and phenomenon candidates.
* Consolidation process documented: grouping, comparison, strengthening, rejection/weakening, and recommendations for Knowledge Update.
* Future physical object `research.reviews` remains draft-only until explicit migration approval.

Explicit Non-Action:

* No SQL was executed.
* No migration was approved.
* No table was created.
* `research.reviews` was not created.

Spec Location:

* `braincoach-docs/07_automation/production_os/05_intelligence/season_review.md`

---

### Signal Capture Specification v1 Drafted

Status: Draft

Depends On:

* `DEC-016 BGS Database Boundary: Core vs Orch`
* `DEC-017 BGS Orch Schema Segregation`
* `Research Schema v1 for bgs_orch`
* `Production Outcome Specification v1`

Objective:

Define the canonical Signal Capture object as the interpretation layer that turns Production Outcomes into structured knowledge candidates.

Outcome:

* Signal Capture defined as the object/process that extracts candidates from raw outcomes.
* Candidate types defined: repeated phrase, objection signal, fear signal, offer signal, strong case, interview candidate, resonance signal, dissonance signal, and phenomenon candidate.
* Boundary documented: Signal Capture does not store raw comments/DMs/metrics and does not create validated reality in `bgs_core`.
* Future physical placement remains unresolved and may belong under `research.*` or `knowledge.*`.

Explicit Non-Action:

* No SQL was executed.
* No migration was approved.
* No table was created.
* No `bgs_core` write or promotion rule was created.

Spec Location:

* `braincoach-docs/07_automation/production_os/05_intelligence/signal_capture.md`

---

### Production Outcome Specification v1 Drafted

Status: Draft

Depends On:

* `DEC-016 BGS Database Boundary: Core vs Orch`
* `DEC-017 BGS Orch Schema Segregation`
* `Research Schema v1 for bgs_orch`
* `Research Season Specification v1`
* `Research Brief Specification v1`
* `Marketing Brief Specification v1`
* `Content Plan Specification v1`
* `Production Execution Specification v1`

Objective:

Define the canonical Production Outcome object as the raw response layer between Production Execution and Signal Capture.

Outcome:

* Production Outcome defined as the object that records what the environment returned after execution.
* Core attributes defined conceptually, not as SQL.
* Relationships documented with `production.executions`, `signal.capture`, `research.reviews`, and `agent.runs`.
* Related concepts linked: Production Execution, Signal Capture, Season Review, Offer Discovery, and Research Schema v1.
* Future physical object `production.outcomes` remains draft-only until explicit migration approval.

Explicit Non-Action:

* No SQL was executed.
* No migration was approved.
* No table was created.
* `production.outcomes` was not created.

Spec Location:

* `braincoach-docs/07_automation/production_os/04_execution/production_outcome.md`

---

### Production Execution Specification v1 Drafted

Status: Draft

Depends On:

* `DEC-016 BGS Database Boundary: Core vs Orch`
* `DEC-017 BGS Orch Schema Segregation`
* `Research Schema v1 for bgs_orch`
* `Research Season Specification v1`
* `Research Brief Specification v1`
* `Marketing Brief Specification v1`
* `Content Plan Specification v1`

Objective:

Define the canonical Production Execution object as the factual record of what actually happened in production.

Outcome:

* Production Execution defined as the object that records published, sent, launched, or completed production actions.
* Core attributes defined conceptually, not as SQL.
* Relationships documented with `content.plans`, `production.outcomes`, `signal.capture`, `research.reviews`, and `agent.runs`.
* Related concepts linked: Research Season, Content Plan, Production Outcomes, Signal Capture, Season Review, and Agent Runs.
* Future physical object `production.executions` remains draft-only until explicit migration approval.

Explicit Non-Action:

* No SQL was executed.
* No migration was approved.
* No table was created.
* `production.executions` was not created.

Spec Location:

* `braincoach-docs/07_automation/production_os/04_execution/production_execution.md`

---

### Content Plan Specification v1 Drafted

Status: Draft

Depends On:

* `DEC-016 BGS Database Boundary: Core vs Orch`
* `DEC-017 BGS Orch Schema Segregation`
* `Research Schema v1 for bgs_orch`
* `Research Season Specification v1`
* `Research Brief Specification v1`
* `Marketing Brief Specification v1`

Objective:

Define the canonical Content Plan object as the bridge between Marketing Brief and Production Execution.

Outcome:

* Content Plan defined as the object that translates a Marketing Brief into a sequence of research artifacts.
* Core attributes defined conceptually, not as SQL.
* Relationships documented with `marketing.briefs`, `production.executions`, `production.outcomes`, `research.reviews`, and `agent.runs`.
* Related concepts linked: Research Season, Research Brief, Marketing Brief, Production Execution, Signal Capture, Season Review, and Offer Discovery.
* Physical schema placement for a future Content Plan object remains unresolved under DEC-017 and may belong under `production.*` or `research.*`.

Explicit Non-Action:

* No SQL was executed.
* No migration was approved.
* No table was created.
* No `content.*` schema was introduced.

Spec Location:

* `braincoach-docs/07_automation/production_os/03_content/content_plan.md`

---

### Marketing Brief Specification v1 Drafted

Status: Draft

Depends On:

* `DEC-016 BGS Database Boundary: Core vs Orch`
* `DEC-017 BGS Orch Schema Segregation`
* `Research Schema v1 for bgs_orch`
* `Research Season Specification v1`
* `Research Brief Specification v1`

Objective:

Define the canonical Marketing Brief object as the bridge between Research Brief and Content Plan.

Outcome:

* Marketing Brief defined as the object that translates a research program into market interaction and signal capture.
* Core attributes defined conceptually, not as SQL.
* Relationships documented with `research.briefs`, `content.plans`, `production.executions`, and `research.reviews`.
* Related concepts linked: Research Season, Research Brief, Offer Discovery, Season Review, Seasonal Phenomena, and Content Plan.
* Physical schema placement for a future `marketing.briefs` object remains unresolved under DEC-017 and requires a later approved decision or migration design.

Explicit Non-Action:

* No SQL was executed.
* No migration was approved.
* No table was created.
* `marketing.briefs` remains future work.

Spec Location:

* `braincoach-docs/07_automation/production_os/02_marketing/marketing_brief.md`

---

### Knowledge Assets Seed Governance Clarified

Status: Active

Objective:

Prevent `003_seed_knowledge_assets.sql` from becoming a mixed live registry update mechanism.

Outcome:

* `003_seed_knowledge_assets.sql` is explicitly treated as historical/dev bootstrap only.
* New spec, decision, and architecture documents must not be registered through this seed.
* Live `bgs_orch.knowledge_assets` updates must use separate reviewed draft upsert files targeting the confirmed live schema.
* Fresh spec/architecture additions were removed from the seed to keep it from drifting into a live registry substitute.

Explicit Non-Action:

* No SQL was executed.
* No live registry update was applied.
* No PostgreSQL schema was changed.

Governance Location:

* `braincoach-docs/07_automation/04_postgres/migration_governance_rule_v1.md`

---

### Research Brief Specification v1 Drafted

Status: Draft

Depends On:

* `DEC-016 BGS Database Boundary: Core vs Orch`
* `DEC-017 BGS Orch Schema Segregation`
* `Research Schema v1 for bgs_orch`
* `Research Season Specification v1`

Objective:

Define the canonical Research Brief object as the bridge between Research Season and Marketing Brief.

Outcome:

* Research Brief defined as the object that translates a season question into a concrete research program.
* Core attributes defined conceptually, not as SQL.
* Relationships documented with `research.seasons`, `marketing.briefs`, `research.reviews`, and `agent.runs`.
* Related concepts linked: Research Season, Research Schema v1, Offer Discovery, Seasonal Phenomena, Marketing Brief, and Agent Runs.

Explicit Non-Action:

* No SQL was executed.
* No migration was approved.
* No table was created.
* `research.briefs` remains future work.

Spec Location:

* `braincoach-docs/07_automation/production_os/01_research/research_brief.md`

---

### Research Season Specification v1 Drafted

Status: Draft

Depends On:

* `DEC-016 BGS Database Boundary: Core vs Orch`
* `DEC-017 BGS Orch Schema Segregation`
* `Research Schema v1 for bgs_orch`

Objective:

Define the canonical Research Season object before drafting `research.seasons` SQL or creating any schema/table.

Outcome:

* Research Season defined as the root object of the Season Intelligence Loop.
* Lifecycle proposed: `draft`, `active`, `completed`, `archived`.
* Core attributes defined conceptually, not as SQL.
* Relationships documented with `research.briefs`, `research.reviews`, `production.executions`, `production.outcomes`, and `agent.runs`.
* Existing Season Registry, Season Review, Seasonal Phenomena, and Season Intelligence Loop concepts linked to avoid terminology conflict.

Explicit Non-Action:

* No SQL was executed.
* No migration was approved.
* No table was created.
* `research.seasons` remains future work.

Spec Location:

* `braincoach-docs/07_automation/production_os/01_research/research_season.md`

---

### BGS Orch Schema Segregation Accepted

Status: Completed

Decision:

`DEC-017 BGS Orch Schema Segregation`

Objective:

Prevent new BrainCoach-owned research, production, and agent-process tables from being added to `bgs_orch.public`, which is already mixed with n8n/runtime tables.

Accepted Rule:

New BrainCoach-owned objects in `bgs_orch` must be created in separate schemas:

* `knowledge.*`
* `research.*`
* `production.*`
* `agent.*`

Boundary:

* `public` remains for n8n/runtime and legacy public tables.
* `knowledge.*` is reserved for knowledge registry, knowledge events, and future knowledge process objects.
* `research.*` is reserved for seasons, briefs, reviews, and research execution memory.
* `production.*` is reserved for executions, outcomes, channel telemetry, and production process memory.
* `agent.*` is reserved for runs, evaluations, prompt versions, and agent performance history.

Migration / Future Work:

* Existing `knowledge_assets`, `knowledge_events`, and `repository_journal` remain in `public` for now.
* Moving existing BrainCoach-owned public tables into `knowledge.*` requires a separate approved migration.
* `research.seasons` must not be created until a separate schema migration is reviewed and approved.
* Any future SQL must be draft-only until explicit approval.

Explicit Non-Action:

* No SQL was executed.
* No schema was created.
* No existing table was moved.
* No production database was modified.

---

### Research Schema v1 for bgs_orch Drafted

Status: Draft

Depends On:

`DEC-016 BGS Database Boundary: Core vs Orch`

Objective:

Define the first architecture-level schema design for storing BrainCoach research-process, production-process, and agent-performance data inside `bgs_orch`.

Scope:

* `research.seasons`
* `research.briefs`
* `research.executions`
* `research.reviews`
* `production.executions`
* `production.outcomes`
* `agent.runs`
* `agent.evaluations`
* `agent.prompt_versions`

Boundary:

* `bgs_orch` stores process memory.
* `bgs_core` stores validated reality objects.

Explicit Non-Action:

* No new database was created.
* No SQL migration was approved.
* `bgs_core` was not modified.
* No final table DDL was defined.

Spec Location:

* `braincoach-docs/07_automation/research_schema_v1_bgs_orch.md`

Live Registry Confirmation:

Owner manually applied the `bgs_orch.knowledge_assets` upsert after review. Verification query returned two active assets:

* `DEC-016 BGS Database Boundary: Core vs Orch` — `decision`, `github`, `active`
* `Research Schema v1 for bgs_orch` — `architecture`, `github`, `active`

Codex did not run the SQL against PostgreSQL.

---

### BGS Database Boundary Accepted

Status: Completed

Decision:

`DEC-016 BGS Database Boundary: Core vs Orch`

Objective:

Formalize the canonical database boundary between `bgs_core` and `bgs_orch` before adding Season Research OS / Production OS objects.

Accepted Boundary:

* `bgs_core` = human reality data.
* `bgs_orch` = knowledge, research process, production telemetry.

Boundary Rule:

* `bgs_core` answers: what is happening with people?
* `bgs_orch` answers: how BrainCoach collects, processes, analyzes and turns reality into knowledge.

Implementation Rule:

Season Research OS / Production OS objects should be added to `bgs_orch`, preferably under separate schemas:

* `knowledge.*`
* `research.*`
* `production.*`
* `agent.*`

Explicit Non-Action:

* No new database is created at this stage.
* Season production telemetry, agent evaluation, and prompt-performance data must not be added to `bgs_core`.

Knowledge Asset:

* `braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-016-bgs-database-boundary-core-vs-orch.md`

Repository Documentation Updated:

* `braincoach-docs/03_knowledge/04_decisions/decision-log/decision_log.md`
* `braincoach-docs/07_automation/06_storage_architecture.md`
* `braincoach-docs/03_knowledge/system_snapshot.md`
* `braincoach-docs/07_automation/04_postgres/002_seed_decisions.sql`
* `braincoach-docs/07_automation/04_postgres/003_seed_knowledge_assets.sql`

---

## 2026-06-13

### BGS Orchestration Knowledge Tables Confirmed

Status: Completed

Objective:

Confirm the live `bgs_orch` persistence tables needed for Knowledge OS repository event tracking and asset registry synchronization.

Applied Manually In `bgs_orch` By Owner:

```sql
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE IF NOT EXISTS knowledge_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_type TEXT NOT NULL,
    repository TEXT NOT NULL,
    branch TEXT NOT NULL,
    commit_id TEXT NOT NULL,
    event_timestamp TIMESTAMPTZ,
    object_type TEXT,
    metadata JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS knowledge_assets (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    object_type TEXT NOT NULL,
    object_name TEXT NOT NULL,
    object_path TEXT NOT NULL UNIQUE,
    version TEXT DEFAULT 'v1',
    status TEXT DEFAULT 'active',
    first_seen TIMESTAMPTZ DEFAULT NOW(),
    last_updated TIMESTAMPTZ DEFAULT NOW(),
    metadata JSONB
);
```

Live Result:

* `pgcrypto` extension confirmed.
* `knowledge_events` table created.
* `knowledge_assets` already existed; PostgreSQL returned `relation "knowledge_assets" already exists, skipping`.

Safety Confirmation:

* SQL was executed manually by owner, not by Codex.
* `knowledge_assets` was not recreated or dropped.
* No existing data deletion was reported.

Repository Documentation Updated:

* `braincoach-docs/05_operations/13_runtime/03_inventory.md`
* `braincoach-docs/05_operations/12_reviews/bgs_milestone_log.md`
* `braincoach-docs/03_knowledge/03_registries/repository_journal.md`

---

## 2026-06-13

### BrainCoach GPS Workflow Migration Completed

Status: Completed

Objective:

Migrate the Stage 3 BrainCoach GPS OS workflow export to the live `bgs_core` GPS MVP-1 persistence model without rebuilding the workflow from scratch.

Completed:

* `BrainCoach GPS MVP-1 — bgs_core adapted.json` imported successfully into n8n.
* Required Telegram and voice intake flow preserved.
* Conversation Engine preserved through `conversations` and `messages`.
* PostgreSQL layer migrated from old Stage 3 fields to live `bgs_core` tables.
* Token/credential configuration completed by owner after import.
* Workflow execution confirmed operational by owner.
* Legacy export `BrainCoach GPS OS — Stage 3 Complete.json` removed from repository to avoid duplication.

Current Workflow Export:

* `braincoach-docs/07_automation/03_n8n/BrainCoach GPS MVP-1 — bgs_core adapted.json`

Migration Report:

* `braincoach-docs/07_automation/03_n8n/BrainCoach GPS MVP-1 — bgs_core adapted.diff-report.md`

Safety Confirmation:

* No database migration was run by Codex.
* No new tables were created by this workflow adaptation.
* Existing Conversation Engine architecture was not removed.

---

## 2026-06-12

### GPS MVP-1 Reality Tracker Migration Applied

Status: Completed

Objective:

Create the first live `bgs_core` foundation for GPS Daily Tracker without changing the existing Conversation Engine.

Applied Manually In Cloud SQL:

* `004_gps_reality_tracker_mvp1.sql`

Live Tables Confirmed:

* `trajectory_domains`
* `trajectories`
* `person_roles`
* `activity_types`
* `activity_events`
* `activity_confirmations`
* `trajectory_entries`

Seed Data Confirmed:

* `trajectory_domains`: 7 rows
* `activity_types`: 11 rows

Repository Documentation Location:

* `braincoach-docs/07_automation/04_postgres/004_gps_reality_tracker_mvp1.sql`
* `braincoach-docs/07_automation/04_postgres/GPS_MVP1_MIGRATION_FINAL_REVIEW.md`
* `braincoach-docs/07_automation/04_postgres/postgres-schema.md`
* `braincoach-docs/07_automation/04_postgres/braincoach_owned_tables.md`

Safety Confirmation:

* Existing tables were not altered.
* Existing data was not deleted.
* `conversation_events`, `conversations`, and `messages` were not changed.
* GPS matrix/report tables were not created in MVP-1.

Repository / Database Alignment:

The live `bgs_core` state and repository PostgreSQL documentation are now aligned for GPS MVP-1 Reality Tracker.

New Governance Rule:

Every future database migration must update the migration SQL, schema documentation, owned-table inventory, and system/milestone logs in the same working session. No migration is considered complete until repository documentation and live database state are reconciled.

Formal Rule:

`braincoach-docs/07_automation/04_postgres/migration_governance_rule_v1.md`

Session Outcome:

* Live PostgreSQL `bgs_core` checked.
* Live schema reconciled with repository documentation.
* GPS Reality Tracker MVP-1 created.
* Seven new Reality Tracker tables added.
* Conversation Engine compatibility preserved.
* Boundary clarified between Reality Tracker and later GPS Layer.
* Migration Governance approach formalized.
* Trajectory Architecture formalization started.

---

2026-06-09
Stage 3 Completed
BrainCoach GPS OS V3 Production Baseline


# sprint_log_2026_06_10

## status

completed

---

## milestone

BGS Core MVP Foundation Completed

---

## completed

✓ DEC-014 BGS Core MVP v1

✓ bgs_core_schema_v1

✓ 001_bgs_core_bootstrap.sql

✓ bgs_core physical database created

✓ 10 core tables created

✓ 002_seed_decisions.sql

✓ decisions registry seeded

✓ 003_seed_knowledge_assets.sql

✓ knowledge assets seeded

✓ parent_interview_questions_registry

✓ parent_interview_bot_mvp

✓ observation_extraction_v1

✓ research_signal_generation_v1

✓ signal_validation_v1

---

## major outcome

Впервые сформирован полный исследовательский контур Brain Growth System.

---

## resulting flow

parent

↓

parent_interview

↓

interview_responses

↓

observations

↓

research_signal_candidates

↓

validated_signals

---

## architecture achievements

Создан первый production-ready контур bgs_core

Создан первый knowledge registry

Создан первый decisions registry

Зафиксирован source of truth для исследовательного контура

Подготовлена база для Parent Interview Bot

Подготовлена база для будущего BrainCoach GPS

---

## key insight

Фокус спринта был смещен с инфраструктуры на модель данных.

Основным результатом является не создание таблиц, а создание первого непрерывного потока знаний внутри BGS.

---

## next milestone

trajectory_assessment_v1

Цель:

преобразование validated_signals в профиль развития человека.

---

## sprint result

BGS перешел от проектирования архитектуры к созданию первой рабочей knowledge system.


## 2026-06-09

### Stage 3 — Observation & Signal Extraction Pipeline Completed

Status: Completed

Objective:

Build the first operational research intake pipeline from Telegram capture through signal candidate staging.

Scope Realignment:

Stage 3 originally deferred from Stage 2 as Knowledge Relationships. Actual delivery focused on executable research intake because the system required a working observation-to-signal path before graph construction could produce meaningful edges.

Implemented:

* Telegram Tracker operational in production
* Observation Layer operational (`observations` populated from tracker entries)
* Signal Extraction Layer operational (`SIG_*` nodes in BrainCoach GPS OS V3)
* `research_signal_candidates` receiving live data
* BrainCoach GPS OS V3 deployed as the Stage 3 production workflow; superseded by `BrainCoach GPS MVP-1 — bgs_core adapted` on 2026-06-13

Validated Pipeline:

Telegram (text / voice)

↓

Tracker Entry

↓

Observation

↓

Signal Candidate

↓

PostgreSQL persistence

Validated Capabilities:

* signal classification
* confidence scoring
* evidence extraction
* metadata jsonb storage
* relational links (entry → observation → candidate)

First Validated Signal Categories:

* self_initiation
* dependence_external

Decisions:

* candidate staging before signal promotion — no direct observation-to-signal promotion
* incremental workflow evolution — intake path preserved, signal layer added
* BrainCoach GPS OS V3 as production baseline
* classification noise tracked for Signal Taxonomy v2, no architectural change in Stage 3

Known Limitation:

Research notes and parent reflections can currently be misclassified as behavioral signals.

Deferred to Stage 4:

* Vertex AI Migration
* Analytics Layer
* Signal Aggregation
* Pattern Detection
* Weekly Reports
* Knowledge relationship discovery
* signal candidate promotion workflow

Outcome:

BrainCoach transitioned from registry-aware documentation architecture to operational research intake. The system can now transform live Telegram input into structured research objects and staged signal candidates.

Next Stage:

Stage 4 — Analytics & Intelligence Layer

Goals:

* unify LLM provider strategy through Vertex AI
* aggregate signal candidates into analyzable datasets
* detect recurring patterns across observations
* produce weekly research reports
* prepare foundation for knowledge graph edges

## 2026-06-05

### DEC-005 Adopted

Major Discovery:

SELF_LEARNING_CAPABILITY accepted as a central research object and long-term development direction.

Impact:

Shifted system focus from content production toward learning systems and knowledge acquisition.

---

## 2026-06-06

### Database Governance Formalized

Status: Completed

Artifacts Added:

* postgres-schema.md
* braincoach_owned_tables.md

Outcome:

Explicit separation established between:

* BrainCoach application data
* n8n runtime infrastructure

Database ownership boundaries documented.

Future graph architecture will operate exclusively on BrainCoach-owned objects.

---


## 2026-06-08

### Tracker Layer MVP Started

Status: Completed

Objective:

Create the first persistent memory layer for BrainCoach Tracker.

Implemented:

* tracker_entries table
* user-linked note storage
* timestamped entries
* entry types
* tag support

First Recorded Insight:

"Интервью является первым узлом траектории"

Outcome:

BrainCoach can now persist observations, ideas, hypotheses and insights independently of chat history.

Significance:

This is the first operational component of the future Trajectory Layer and Personal Knowledge Memory System.

### Signal Candidate Staging Table Added

Status: Completed

Objective:

Create a safe staging layer between observations and confirmed signals.

Implemented:

* research_signal_candidates table
* confidence scoring field
* candidate lifecycle status
* source links to observations and tracker_entries
* BrainCoach-owned table documentation

Outcome:

Tracker can now evolve from raw observation capture toward signal detection without immediately promoting every observation into a formal signal.

Significance:

This is the first database object supporting the future path:

Observation

↓

Signal Candidate

↓

Signal

↓

Deviation

↓

Phenomenon


## 2026-06-07

### Stage 2 — Full Repository Registry Completed

Status: Completed

Objective:

Populate knowledge_assets with the complete inventory of BrainCoach Knowledge OS.

Implemented:

* Full repository scan workflow
* GitHub API repository tree extraction
* Repository-wide asset classification
* PostgreSQL registry synchronization
* object_path based upsert strategy

Registry Cleanup:

* Legacy path duplicates removed
* Historical folder naming inconsistencies reconciled
* Repository registry normalized

Results:

* 104 active Knowledge Objects synchronized
* 104 unique object paths validated
* Full repository inventory established
* knowledge_assets became repository-wide source of truth

Registry Coverage:

* Canon
* Foundation
* Ontology
* Research
* Intelligence
* Registries
* Decisions
* Domains
* Operations
* Automation

Outcome:

BrainCoach Knowledge Registry transitioned from event-based discovery to full repository awareness.

Current Synchronization Model:

GitHub Repository

↓

Full Repository Registry

↓

knowledge_assets

↓

Future Relationship Layer

Next Stage:

Stage 3 — Knowledge Relationships

Goals:

* relationship extraction
* object graph construction
* dependency mapping
* semantic navigation layer

Result:

BrainCoach Knowledge OS now maintains a complete authoritative registry of repository knowledge assets.

2026-06-07

DEC-007 Accepted

Offer Discovery Layer introduced.

Reason:

Stage 2 Full Repository Registry completed.

Knowledge production is no longer the primary bottleneck.

Current constraint shifted to:

Knowledge → Offer → Revenue

Outcome:

Offer Discovery becomes a formal layer between Knowledge and Business.

### Content Factory Formalized

Status: Completed

Content Factory transformed from a content planning framework into a production operating system.

Modules Introduced:

* 01 Intake
* 02 Extraction
* 03 Asset Design
* 04 Generation
* 05 Feedback

Outcome:

Content production became a repeatable operational process rather than a collection of isolated activities.

---

### Deviation Introduced as a First-Class Object

Status: Accepted

New Learning Flow:

Observation

↓

Deviation

↓

Signal

↓

Phenomenon

Outcome:

Deviation recognized as the primary mechanism for detecting learning opportunities and generating research directions.

---

### Butterfly Principle Added to Foundation Layer

Status: Accepted

Purpose:

Formalize weak signals, small changes, and early deviations as valid research inputs.

Outcome:

Weak signals become explicit targets for observation and investigation.

---

### Automation Layer Formalized

Status: Completed

Documents Introduced:

* 01 Knowledge Objects
* 02 Object Relationships
* 03 Object States
* 04 PostgreSQL Mapping
* 05 Domain Architecture
* 06 Storage Architecture
* 07 Domain Interfaces
* 08 Agent Architecture

Outcome:

Automation architecture separated from conceptual architecture and became an independent system layer.

---

### Domain Model Consolidated

Status: Completed

Core Domains:

* Governance
* Research
* Business
* Operations

Outcome:

Domain boundaries became explicit and reusable across future system extensions.

---

### Storage Architecture Consolidated

Status: Completed

Responsibilities:

GitHub

* Knowledge storage

PostgreSQL

* Operational storage

pgvector

* Retrieval and semantic search

n8n

* Orchestration

Vertex AI

* Reasoning and generation

Outcome:

Infrastructure responsibilities clearly separated and documented.

---

### Stage 1 — Knowledge Registry Foundation Completed

Status: Completed

Objective:

Create the foundational synchronization layer between GitHub and the BrainCoach Knowledge Registry.

Implemented Architecture:

GitHub Push

↓

Webhook

↓

Knowledge Event Parser

↓

knowledge_events

↓

Extract Assets

↓

knowledge_assets

Achievements:

* GitHub webhook operational
* Automatic event registration
* Automatic asset discovery
* Multi-file processing validated
* Asset classification validated
* Metadata persistence validated
* UNIQUE(object_path) constraint implemented
* Insert-or-Update behavior validated
* Duplicate asset creation prevented

Registry Components:

* knowledge_events
* knowledge_assets

Synchronization Mode:

GitHub → PostgreSQL

Conflict Resolution:

object_path based upsert

Current Registry State:

* knowledge_events active
* knowledge_assets active
* Incremental synchronization active

Outcome:

BrainCoach Knowledge OS now maintains a continuously updated registry of discovered knowledge assets.

Next Stage:

Stage 2 — Full Repository Sync

Goal:

Populate knowledge_assets with the complete repository inventory rather than only recently modified objects.

Expected Result:

knowledge_assets becomes the authoritative registry of all BrainCoach Knowledge Objects.

---


## Current Strategic Direction

BrainCoach Evolution Path:

Content System

↓

Research Operating System

↓

Knowledge Production System

↓

Signal Detection and Learning System

↓

Analytics and Intelligence Layer

Current Stage: Stage 4 Planned

Long-Term Goal:

Create a self-improving knowledge ecosystem capable of detecting signals, generating research, producing knowledge assets, and continuously expanding its own understanding of the world.

---

### BrainCoach GPS MVP-1.1 Reflection Coach Promoted

Date: 2026-06-15

Status: Production

Objective:

Promote the Reflection Coach reply layer from sandbox testing into the active BrainCoach GPS workflow while preserving the existing GPS capture and persistence pipeline.

Production workflow:

`BrainCoach GPS MVP-1.1 — Reflection Coach GPS Publish`

Production export:

`braincoach-docs/07_automation/03_n8n/BrainCoach GPS MVP-1.1 — Reflection Coach GPS Publish.json`

Production note:

`braincoach-docs/07_automation/03_n8n/BrainCoach GPS MVP-1.1 — Reflection Coach GPS Publish.md`

Pipeline preserved:

```text
Telegram
-> tracker_entries
-> observations
-> research_signal_candidates
-> PostgreSQL
```

Change:

* Added `TRK_BuildReflectionReply` after `TRK_GetEntryCount`.
* Replaced static save replies with compact rotating GPS responses.
* Added confirmation, short question, mission, rare GPS signal question, and milestone response types.
* Corrected Telegram voice routing so `TG_Trigger` routes through `VOI_CheckVoice` before `VOI_GetFile`.

Database impact:

* No schema changes.
* No new tables.
* Existing `tracker_entries` count query reused.

Outcome:

MVP-1.1 is active as the current GPS production workflow. The primary pilot KPI is whether Reflection Coach increases observation volume per user by 20-30% compared with MVP-1.

---

### BGS Orch Production MVP-1 Tables Installed

Date: 2026-06-18

Status: Applied Manually By Owner

Objective:

Create the first live `bgs_orch.production` persistence layer for marketing/content automation, Instagram telemetry, production outcomes, market signals, and tracker monitoring.

Applied migrations:

* `braincoach-docs/07_automation/04_postgres/007_bgs_orch_instagram_analytics_mvp1.sql`
* `braincoach-docs/07_automation/04_postgres/008_bgs_orch_weekly_content_automation_mvp1.sql`

Live verification:

* `current_database = bgs_orch`
* `current_user = bgs_admin`
* 11 `production` tables confirmed
* 37 constraints confirmed
* 9 foreign keys confirmed
* Smoke test confirmed `weekly_content_plans -> content_units`

Database impact:

* New `production` schema active in `bgs_orch`
* No `bgs_core` changes
* No n8n platform/runtime table changes

System impact:

BrainCoach now has live production-process memory for:

```text
weekly content plan
->
content units
->
generated assets
->
publishing executions
->
outcomes
->
market signals
->
tracker monitoring
```

Final review:

`braincoach-docs/07_automation/04_postgres/BGS_ORCH_PRODUCTION_MVP1_FINAL_REVIEW.md`

Next step:

Build `Weekly Package Generator MVP-1` in n8n against `bgs_orch.production`.

---

### First Weekly Content Plan Seed Installed

Date: 2026-06-18

Status: Applied Manually By Owner

Objective:

Load the first operational weekly content plan into `bgs_orch.production` for the week of 2026-06-22 to 2026-06-28.

Applied seed:

* `braincoach-docs/07_automation/04_postgres/009_seed_weekly_content_plan_2026_06_22.sql`

Live verification:

* `CPLAN-2026-06-22-W01` confirmed
* status = `draft`
* 68 `content_units` confirmed
* platform / format distribution confirmed
* `publishing_scheduler_hypothesis` metadata confirmed

Content package shape:

```text
Instagram: 4 Reels, 2 Carousels, 35 Stories
TikTok: 4 Shorts
YouTube Shorts: 4 Shorts
Threads: 7 units
Facebook: 5 Posts
Telegram: 7 Notes
```

System impact:

BrainCoach now has a live weekly content plan object that agents and n8n workflows can use as the source of truth for generation, approval, publishing monitoring, signal capture, and weekly correction.

Next step:

Generate the first day package into `generated_content_assets`, then connect n8n to read from `content_units` and write generated draft assets.

---

### Content Planning Shifted To Production Pipeline

Date: 2026-06-18

Status: Accepted Strategic Observation

Observation:

BrainCoach has stopped merely planning content.

BrainCoach has started planning a content system.

Previous state:

```text
Idea of the week
->
discussion
->
manual content
```

New state:

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

System meaning:

This creates the missing operational link between:

```text
Research OS
->
Production OS
->
Knowledge OS
```

Production rule:

After weekly seed installation, BrainCoach must not change the Weekly Brief, Channel Matrix, Scheduler, `content_plan`, or `content_units` until the week completes.

Only `generated_content_assets`, text, visuals, CTA, and production notes may be edited during the live week.

Next step:

Build `Monday Generator MVP` for the first 11 Monday assets and review consistency before scaling generation to the remaining 57 weekly units.

Related decision:

`braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-035-weekly-production-cycle-freeze.md`

---

### Monday Generator MVP Applied For Pilot Review

Date: 2026-06-18

Status: Applied Manually By Owner, Approved For Pilot Review, Not Published

Observation:

Seed `010_seed_generated_assets_2026_06_22_monday_mvp.sql` is the first object that completes:

```text
content_unit
->
generated_asset
->
human_review
```

It is not a template and not a schema migration.

It is the first generated asset package produced from structured production data.

Live installation:

```text
BEGIN
DELETE 0
INSERT 0 11
COMMIT
```

Verification:

```text
monday_generated_assets = 11
voice_check_status = pending
approval_status = pending
assets = 11
```

Safety:

No asset was approved, scheduled, or published.

Guardrail before mass generation:

```text
Main Conversation stays constant.
Daily language changes.
```

Monday may use investment language heavily because it opens the weekly conversation.

Tuesday and later generators must avoid repeating `вложения` as the dominant word.

Public-language correction:

Use `траектория` sparingly in public content.

Prefer:

* движение;
* прогресс;
* направление;
* результат;
* что держится в ребенке.

Next step:

Apply seed 010 manually, send the 11 Monday assets into Telegram Review, capture human corrections, and only then start Tuesday Generator.

---

### Monday Public-Language Correction Applied

Date: 2026-06-18

Status: Applied Manually By Owner

Objective:

Apply the first human-review correction to generated content assets without changing the weekly plan or content units.

Applied seed:

* `braincoach-docs/07_automation/04_postgres/011_update_monday_generated_assets_public_language_v1.sql`

Live verification:

```text
corrected_assets = 4
voice_check_status = pending
approval_status = pending
assets = 11
```

Corrected assets:

* `CUNIT-2026-06-22-IG-REEL-01`
* `CUNIT-2026-06-22-IG-STORY-05`
* `CUNIT-2026-06-22-THREADS-01`
* `CUNIT-2026-06-22-TG-01`

Meaning:

The system completed its first controlled correction inside the asset layer:

```text
generated_content_assets
->
human language review
->
corrected generated_content_assets
```

Weekly freeze remained intact:

* no Weekly Brief changes;
* no Channel Matrix changes;
* no scheduler changes;
* no `content_units` changes.

Next step:

Build Telegram Review MVP to move assets from SQL inspection into operator review.
