# BrainCoach AI — Current Project Status

Last Updated: 2026-05-30

Analysis scope: workflows, scripts, braincoach-docs, prompts, schemas. Read-only review after qualification-engine v4 and v6 attempts.

---

## 1. Repository Structure

```text
braincoach-ai/
├── README.md                          # High-level vision; project tree is outdated
├── package.json                       # npm scripts reference missing deploy/backup scripts
├── .env.example
│
├── architecture/                      # Foundational architecture (mixed RU/EN)
│   ├── system-context.md
│   ├── conversational-memory-layer.md
│   ├── infrastructure-source-of-truth.md   # Partially contradicts newer docs
│   └── secure-console-policy.md
│
├── braincoach-docs/                   # Architecture reviews and n8n guidance
│   ├── architecture-review.md         # Living architecture decisions (2026-05-29)
│   ├── n8n-compatibility-notes.md
│   ├── n8n-node-schema-source-of-truth.md  # UNTRACKED — defines export-based node rules
│   ├── repository-architect-review-2026-05-29.md
│   ├── repository-architect-changelog-2026-05-29.md
│   └── current-project-status.md      # This document
│
├── workflows/
│   ├── qualification-engine.json      # Canonical filename; MODIFIED locally (v4 hardening)
│   ├── qualification-engine.md        # Documents v3; references wrong import filename
│   ├── qualification-engine-v4.json   # UNTRACKED — validation-hardened copy
│   ├── qualification-engine-v4.md     # UNTRACKED — v4 changelog
│   ├── qualification-engine-v6.json   # UNTRACKED — duplicate of v4 (name only differs)
│   ├── offer-engine.json              # Empty shell (0 nodes)
│   ├── reactivation-engine.json       # Empty shell (0 nodes)
│   ├── voice-intake.json              # Empty shell (0 nodes)
│   ├── reference-node-exports/        # Empty directory — expected source of truth missing
│   └── archive/                       # Empty directory
│
├── scripts/
│   └── export-reference-workflows.js  # UNTRACKED — prepared, not run
│
├── prompts/                           # Prompt library by domain (not wired into workflow JSON)
│   ├── intake/                        # intake_classifier, emotional_reflection
│   ├── qualification/                 # qualification_engine + placeholders
│   ├── offer/                         # offer_generator (GPT-4), placeholders
│   ├── booking/                       # booking_engine placeholder
│   ├── memory/                        # extractor, retriever, updater, profile_builder
│   ├── response/                      # short/long reply, qualification_conversation
│   ├── followup/                      # Mostly empty placeholder files
│   └── system/                        # braincoach_system, routing, safety, output formats
│
├── schemas/                           # Authoritative data-model docs (2026-05-29)
│   ├── postgres-schema.md
│   ├── google-sheets-structure.md     # Includes offer_rules (not yet in workflow)
│   ├── stage-map.md
│   └── events-taxonomy.md
│
├── sheets/                            # Legacy per-sheet stubs + old structure doc
│   ├── google-sheets-structure.md     # Old RU schema (chat_history, qualifications, etc.)
│   └── *.md                           # Per-sheet files — mostly empty
│
├── memory/                            # Empty placeholder docs (clients, events, messages, memory_facts)
│
├── agents/                            # Empty directories (diagnostics, offer, qualification, reactivation)
│
├── src/
│   ├── postgres/                      # Working Node.js DB layer (connection, init, repositories)
│   └── gemini/                        # test-gemini.js only
│
└── tests/                             # Empty directory
```

**Git state (2026-05-30):**

| Status | Files |
|--------|-------|
| Modified | `workflows/qualification-engine.json` (+135 / −11 lines — v4 validation layer applied locally) |
| Untracked | `workflows/qualification-engine-v4.json`, `qualification-engine-v4.md`, `qualification-engine-v6.json`, `braincoach-docs/n8n-node-schema-source-of-truth.md`, `scripts/` |
| Last commit | `3c88f29 Establish workflow baselines` |

---

## 2. Current Workflow Versions

### Qualification Engine lineage

| File | Internal name | Nodes | Status |
|------|---------------|-------|--------|
| `workflows/qualification-engine.json` (committed) | `qualification-engine-v3` | 13 | Baseline in git: LangChain OpenAI v1.8, unsafe inline `JSON.parse` |
| `workflows/qualification-engine.json` (working copy) | `qualification-engine-v3` | 18 | Local edit: v4 validation nodes added, not committed |
| `workflows/qualification-engine-v4.json` | `qualification-engine-v4` | 18 | Untracked; functionally identical to working copy except workflow name |
| `workflows/qualification-engine-v6.json` | `qualification-engine-v6` | 18 | Untracked; **byte-for-byte equivalent to v4 except `name` field** — no v6 doc exists |

**What v4 added (documented in `qualification-engine-v4.md`):**

- Three `Function` validation nodes for Intake, Emotional, and Qualification JSON
- `IF - All Valid?` gate before Postgres writes
- `Telegram - Send Error` fallback on parse failure
- Safe references to `$node["Validate - ..."].json[0].parsed.*` instead of inline `JSON.parse`

**v6 attempt conclusion:** No distinct v6 design. v6 appears to be a renamed v4 copy with no documentation or behavioral changes. The v4 hardening was also applied directly to `qualification-engine.json` in the working tree, creating three redundant copies of the same graph.

### Other workflows

| Workflow | Version field | Implementation |
|----------|---------------|----------------|
| `offer-engine.json` | 1.0 | Stub — `"nodes": []` |
| `reactivation-engine.json` | 1.0 | Stub — `"nodes": []` |
| `voice-intake.json` | 1.0 | Stub — `"nodes": []` |

### Documentation vs filename mismatch

- `workflows/qualification-engine.md` describes **v3** and instructs importing `qualification-engine-v3.json`, but the actual file is `qualification-engine.json`.
- No markdown doc exists for v6.

---

## 3. Files That Appear Obsolete

These files are superseded, empty, duplicated, or misleading and should not drive new work without explicit review:

| File / path | Reason |
|-------------|--------|
| `workflows/qualification-engine-v6.json` | Duplicate of v4; no unique value; no documentation |
| `workflows/qualification-engine-v4.json` | Redundant once v4 changes are consolidated into `qualification-engine.json` |
| `workflows/qualification-engine.md` | Describes pre-v4 v3; wrong import filename; stale after v4 hardening |
| `sheets/google-sheets-structure.md` | Old schema (`chat_history`, `qualifications`, `offers_log`) — replaced by `schemas/google-sheets-structure.md` |
| `sheets/*.md` (per-sheet stubs) | Empty placeholders; content lives in `schemas/google-sheets-structure.md` |
| `memory/*.md` | Empty placeholders; superseded by `schemas/postgres-schema.md` |
| `agents/*` | Empty directories — no implementation |
| `tests/` | Empty — no test suite |
| `workflows/archive/` | Empty |
| `README.md` project tree | References non-existent `docs/`, flat prompt paths, and missing scripts (`deploy-workflow.js`, `update-workflow.js`, `backup-workflows.js`) |
| `architecture/infrastructure-source-of-truth.md` | Says logs belong in Google Sheets; newer architecture puts events in PostgreSQL |
| `prompts/followup/reactivation_generator.md`, `reminder_generator.md` | Empty files |
| `prompts/qualification/objection_detector.md`, `stage_identifier.md` | Empty placeholders |
| `prompts/offer/next_step_generator.md`, `product_matcher.md` | Empty placeholders |

**Note:** Do not delete yet — this is an analysis list. Consolidation should happen after picking a canonical workflow version and running an import test.

---

## 4. Source of Truth — Recommended Hierarchy

Priority order for ongoing development:

### Tier 1 — Runtime state and analytics

| Domain | Source of truth | Location |
|--------|-----------------|----------|
| User state, messages, events, memory | PostgreSQL | `schemas/postgres-schema.md` + `src/postgres/` |
| Stage progression rules | Google Sheets `qualification_flow` | `schemas/google-sheets-structure.md` |
| Offer eligibility (planned) | Google Sheets `offer_rules` | Documented in schemas; **not wired in workflow** |

### Tier 2 — Semantic control and prompts

| Domain | Source of truth | Location |
|--------|-----------------|----------|
| Sheet field definitions | `schemas/google-sheets-structure.md` | Not `sheets/` legacy docs |
| Prompt intent and ownership boundaries | `prompts/**/*.md` | Especially `intake/`, `qualification/`, `booking/` |
| Architecture decisions | `braincoach-docs/architecture-review.md` | Stage ownership, offer rules, booking lifecycle |
| Model routing policy | `braincoach-docs/n8n-compatibility-notes.md` | GPT-5.4-nano / mini / full mapping |

### Tier 3 — n8n orchestration

| Domain | Source of truth | Location |
|--------|-----------------|----------|
| Production node parameter shapes | Exported JSON from live n8n | `workflows/reference-node-exports/` (**empty — must be populated**) |
| Node generation rules | `braincoach-docs/n8n-node-schema-source-of-truth.md` | Mandates export-first workflow generation |
| Active qualification workflow | **One** JSON file after consolidation | Target: `workflows/qualification-engine.json` renamed to v4 internally |

### Tier 4 — Generation only (not business logic)

| Domain | Notes |
|--------|-------|
| LLM outputs | Models classify and generate; they do not own stage transitions or offer decisions |
| Inline workflow prompts | Currently hardcoded in workflow JSON — **drift risk** vs `prompts/` library |

### Known drift between sources

| Area | Documented | Workflow reality |
|------|------------|------------------|
| Prompt models | `prompts/` mostly say Gemini Flash/Pro | Workflow uses GPT-5.4-nano and GPT-5.4-mini inline |
| OpenAI `modelId` | `n8n-node-schema-source-of-truth.md` requires `__rl` Resource Locator | Workflow uses plain strings (`"gpt-5.4-nano"`) |
| Google Sheets node | Docs require typeVersion 4.6, `documentId` / `sheetName` | Workflow uses typeVersion 1, no visible documentId in grep |
| IF node | Docs require typeVersion 2.2 modern conditions | Workflow uses typeVersion 1 legacy boolean conditions |
| Offer rules sheet | In `schemas/google-sheets-structure.md` | Not read by qualification workflow |

---

## 5. Current Blockers

### Critical — blocks production import

1. **Missing production node exports.** `workflows/reference-node-exports/` is empty. `n8n-node-schema-source-of-truth.md` requires exported nodes before generating or validating workflows. `scripts/export-reference-workflows.js` exists but has not been run (needs `N8N_URL` + `N8N_API_KEY`).

2. **Workflow JSON may not match production n8n schema.** Current qualification workflows use node typeVersions and parameter shapes that conflict with documented production requirements (Google Sheets 1 vs 4.6, IF 1 vs 2.2, OpenAI `modelId` format). Import success is unverified.

3. **Three redundant qualification workflow files + uncommitted local changes.** Creates confusion about which version is canonical. v6 adds no value.

### High — blocks feature completeness

4. **`offer_rules` not implemented.** Documented in schemas and architecture reviews; qualification workflow does not read this sheet.

5. **Prompt library not connected to workflow.** Workflow nodes contain shortened inline system prompts. Full prompts in `prompts/` are not referenced. Model names differ (Gemini in prompts vs GPT in workflow).

6. **Missing npm scripts.** `package.json` references `deploy-workflow.js`, `update-workflow.js`, `backup-workflows.js` — none exist. Only `export-reference-workflows.js` was added (untracked).

7. **Other engines are stubs.** Offer, reactivation, and voice workflows have zero nodes. Booking prompt exists but no booking workflow.

### Medium — blocks operational confidence

8. **Validation is shallow.** v4 adds JSON parse checks only — no schema validation of required fields (`next_stage`, `next_question`, etc.). Documented in v4.md remaining risks.

9. **IF node execution ordering risk.** v4.md notes validation nodes feed IF without a Merge node in wait mode — potential race in n8n depending on instance behavior.

10. **Documentation fragmentation.** README, `qualification-engine.md`, architecture folder, and braincoach-docs overlap with conflicting or stale content.

11. **Empty placeholder proliferation.** `memory/`, `sheets/`, `agents/`, many prompt stubs — noise for contributors trying to find real content.

12. **No automated tests.** `tests/` empty; postgres layer has manual test script only.

---

## 6. Recommended Next Step

**Single actionable path — consolidate and validate before building new features:**

### Step 1: Export production node schemas (blocker #1)

```bash
N8N_URL=https://<your-n8n> N8N_API_KEY=<key> node scripts/export-reference-workflows.js --list
N8N_URL=... N8N_API_KEY=... node scripts/export-reference-workflows.js --export <workflow-id>
```

Export at minimum: OpenAI, Google Sheets, IF, Postgres, Telegram nodes into `workflows/reference-node-exports/`.

### Step 2: Reconcile one canonical qualification workflow

1. Pick `workflows/qualification-engine.json` as the single canonical file.
2. Apply v4 validation logic (already in working copy).
3. Update node typeVersions and parameter shapes to match exported production schemas.
4. Rename internal workflow name to `qualification-engine-v4` (or drop version suffix entirely).
5. Archive or delete `qualification-engine-v6.json` — it is a duplicate.
6. Update `qualification-engine.md` to match the consolidated file and correct import filename.

### Step 3: Import test in production n8n

Import the reconciled JSON. Verify:

- All credentials bind correctly
- Telegram trigger fires
- Google Sheets reads return data
- Validation path works on good and malformed AI output
- Postgres update and event insert succeed

### Step 4: Commit the consolidated baseline

Commit only after a successful import test:

- `workflows/qualification-engine.json`
- `workflows/reference-node-exports/*.json`
- `scripts/export-reference-workflows.js`
- `braincoach-docs/n8n-node-schema-source-of-truth.md`
- Updated workflow documentation

### Step 5: Then extend (not before)

1. Wire `offer_rules` sheet read into qualification workflow
2. Replace inline prompts with references to `prompts/` content (or sync via build script)
3. Implement offer-engine workflow stub
4. Add missing deploy/backup scripts or remove dead npm script entries

---

## Summary

The qualification-engine v4 attempt successfully added JSON validation and error handling. The v6 attempt produced no new behavior — only a renamed duplicate. The v4 changes also landed uncommitted in `qualification-engine.json`, leaving three identical graphs under different names.

The repository has strong architecture documentation (2026-05-29 architect review) and schema definitions, but the n8n execution layer is blocked by missing production node exports, unverified import compatibility, and disconnected prompt/schema wiring. The immediate priority is export → reconcile → import test → commit one canonical workflow — not another version fork.
