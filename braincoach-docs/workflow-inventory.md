# BrainCoach Workflow Inventory

Last Updated: 2026-05-30

Scope: entire `workflows/` directory — JSON workflows, companion docs, and subdirectories.

---

## Directory Overview

```text
workflows/
├── qualification-engine.json       # TRACKED — modified locally (v4 hardening applied)
├── qualification-engine.md         # TRACKED — documents v3 (stale vs working copy)
├── qualification-engine-v4.json    # UNTRACKED — validation-hardened fork
├── qualification-engine-v4.md      # UNTRACKED — v4 changelog
├── qualification-engine-v6.json    # UNTRACKED — duplicate of v4 (name only differs)
├── offer-engine.json               # TRACKED — empty stub
├── reactivation-engine.json        # TRACKED — empty stub
├── voice-intake.json               # TRACKED — empty stub
├── archive/                        # Empty
└── reference-node-exports/         # Empty (expected production node exports)
```

**JSON workflows:** 6  
**Companion markdown:** 2  
**Git-tracked workflow JSON:** 4 (qualification, offer, reactivation, voice)

---

## Readiness Score Methodology

Each workflow is scored 0–100 across six criteria:

| Criterion | Weight | What it measures |
|-----------|--------|------------------|
| Graph completeness | 25 | Nodes, connections, end-to-end path |
| Runtime safety | 15 | Error handling, validation, failure paths |
| n8n import compatibility | 20 | Node types/versions vs production schema docs |
| Documentation alignment | 10 | Companion `.md` matches JSON behavior |
| Architecture dependency coverage | 15 | Required integrations present (Sheets, Postgres, prompts) |
| Repo hygiene | 15 | Canonical naming, no duplication, git clarity |

**Score bands:**

| Range | Meaning |
|-------|---------|
| 80–100 | Production-ready or near-ready after import test |
| 60–79 | Implemented but blocked on validation or schema reconciliation |
| 30–59 | Partial / outdated / redundant |
| 0–29 | Stub or placeholder only |

---

## Workflow Inventory

### 1. `qualification-engine.json`

| Field | Value |
|-------|-------|
| **Workflow name (internal)** | `qualification-engine-v3` |
| **Node count** | 18 (working copy) / 13 (last committed on `main`) |
| **Implemented status** | **Fully implemented** in working copy — Telegram intake → Postgres client lookup/create → 3 Google Sheets reads → 3 LangChain OpenAI nodes → 3 JSON validators → conditional Postgres update + event log → Telegram reply or error |
| **Git status** | Modified, not committed (+135 / −11 lines vs `3c88f29`) |
| **Readiness score** | **65 / 100** (working copy) · **52 / 100** (committed baseline) |

**Dependencies:**

| Category | Detail |
|----------|--------|
| **Credentials** | Telegram Bot, Postgres, Google Sheets OAuth, OpenAI |
| **PostgreSQL tables** | `clients` (SELECT, INSERT, UPDATE), `events` (INSERT) |
| **Google Sheets** | Spreadsheet `1r7n5E1eU5IKK6RPkK4HHsLxorFpgs66GZQwYhI0fL_I` — sheets: `keywords_master`, `qualification_flow`, `memory_signals` |
| **AI models** | `gpt-5.4-nano` (Intake Classifier, Emotional Reflection), `gpt-5.4-mini` (Qualification Engine) |
| **Prompts (inline)** | Short system prompts embedded in OpenAI nodes — not loaded from `prompts/` |
| **Events emitted** | `stage_entered` (category: `qualification`) |
| **Excluded (by design)** | Offer engine, booking, followups, voice, reactivation, `offer_rules` sheet |

**Node breakdown (18):**

```text
Telegram Trigger → Postgres Find/Create → Google Sheets (×3)
  → OpenAI Intake + Emotional (parallel) → OpenAI Qualification
  → Validate (×3) → IF All Valid?
    → [true]  Postgres Update → Postgres Insert Event → Telegram Send Question
    → [false] Telegram Send Error
```

**Readiness deductions (working copy):**

- Internal name still says `v3` while graph is v4-hardened (−repo hygiene)
- Not import-tested against production n8n (−import compatibility)
- Google Sheets nodes use legacy `sheetId` + `range` at typeVersion 1; production docs require typeVersion 4.6 with `documentId` / `sheetName` (−import compatibility)
- IF nodes use typeVersion 1 legacy boolean conditions; docs require 2.2 (−import compatibility)
- OpenAI `modelId` is plain string; production docs require `__rl` Resource Locator (−import compatibility)
- `workflows/reference-node-exports/` is empty — cannot verify node shapes (−import compatibility)
- `offer_rules` sheet documented in architecture but not read by workflow (−dependency coverage)
- Companion doc `qualification-engine.md` still describes pre-validation v3 (−documentation)

**Committed baseline (13 nodes):** lacks validation nodes and uses unsafe inline `JSON.parse(...)` in Postgres and Telegram expressions — lower runtime safety score.

---

### 2. `qualification-engine-v4.json`

| Field | Value |
|-------|-------|
| **Workflow name (internal)** | `qualification-engine-v4` |
| **Node count** | 18 |
| **Implemented status** | **Fully implemented** — identical graph to working copy of `qualification-engine.json` (verified: same JSON after removing `name` field) |
| **Git status** | Untracked |
| **Readiness score** | **67 / 100** |

**Dependencies:** Same as `qualification-engine.json` working copy (see above).

**Additional documentation:** `qualification-engine-v4.md` describes validation layer, error path, and remaining production risks.

**Score vs canonical file:** +2 for accurate internal version name and companion v4 doc. Otherwise same blockers.

---

### 3. `qualification-engine-v6.json`

| Field | Value |
|-------|-------|
| **Workflow name (internal)** | `qualification-engine-v6` |
| **Node count** | 18 |
| **Implemented status** | **Fully implemented graph** — functionally identical to v4; only the workflow `name` field differs |
| **Git status** | Untracked |
| **Readiness score** | **55 / 100** |

**Dependencies:** Same as v4.

**Notes:** No v6 documentation exists. No behavioral delta from v4 detected. Duplicate creates repo confusion (−15 repo hygiene applied).

---

### 4. `offer-engine.json`

| Field | Value |
|-------|-------|
| **Workflow name (internal)** | `BrainCoach - Offer Engine` |
| **Node count** | 0 |
| **Implemented status** | **Stub only** — metadata and timezone setting; no nodes or connections |
| **Git status** | Tracked (`3c88f29`) |
| **Readiness score** | **8 / 100** |

**Dependencies (planned, not wired):**

| Category | Expected (from architecture) |
|----------|------------------------------|
| **Credentials** | Telegram, Postgres, Google Sheets, OpenAI (not configured) |
| **Google Sheets** | `offers_master`, `offer_rules` |
| **PostgreSQL** | `clients`, `events`, possibly `offers_and_outcomes` |
| **AI models** | GPT-5.4-mini per `n8n-compatibility-notes.md` |
| **Prompts** | `prompts/offer/offer_generator.md` (exists in repo, not connected) |
| **Upstream trigger** | Handoff from qualification at `offer_transition` / `offer` stages |

**Description (RU):** «Генерация и отправка персонализированных предложений»

---

### 5. `reactivation-engine.json`

| Field | Value |
|-------|-------|
| **Workflow name (internal)** | `BrainCoach - Reactivation Engine` |
| **Node count** | 0 |
| **Implemented status** | **Stub only** |
| **Git status** | Tracked |
| **Readiness score** | **8 / 100** |

**Dependencies (planned, not wired):**

| Category | Expected |
|----------|----------|
| **Trigger** | Schedule or Postgres query (`clients.current_stage = 'sleeping'`) |
| **Google Sheets** | `followups_master` |
| **PostgreSQL** | `clients`, `events` |
| **AI models** | GPT-5.4-nano for followup copy |
| **Prompts** | `prompts/followup/` (mostly empty placeholders) |
| **Events** | `reactivated`, `followup_sent` |

**Description (RU):** «Переактивация неактивных пользователей через целевые сообщения»

---

### 6. `voice-intake.json`

| Field | Value |
|-------|-------|
| **Workflow name (internal)** | `BrainCoach - Voice Intake` |
| **Node count** | 0 |
| **Implemented status** | **Stub only** |
| **Git status** | Tracked |
| **Readiness score** | **8 / 100** |

**Dependencies (planned, not wired):**

| Category | Expected |
|----------|----------|
| **Trigger** | Telegram voice message |
| **Services** | Audio download, speech-to-text, emotion detection |
| **PostgreSQL** | `clients.interaction_type`, `messages` |
| **Downstream** | Qualification engine (text path) |
| **Settings** | `audioFormat: ogg` (declared in workflow settings only) |

**Description (RU):** «Обработка голосовых сообщений: запись → расшифровка → анализ»

---

## Companion Documentation (non-JSON)

| File | Relates to | Status | Readiness relevance |
|------|------------|--------|---------------------|
| `qualification-engine.md` | `qualification-engine.json` | Tracked; describes **v3** (13 nodes, no validation) | **Stale** — wrong import filename (`qualification-engine-v3.json`), does not cover v4 validation layer |
| `qualification-engine-v4.md` | `qualification-engine-v4.json` | Untracked | **Current** for validation hardening; should be merged/updated when canonical file is consolidated |

---

## Subdirectories

| Path | Contents | Role |
|------|----------|------|
| `workflows/archive/` | Empty | Reserved for retired workflow versions — unused |
| `workflows/reference-node-exports/` | Empty | **Required** by `braincoach-docs/n8n-node-schema-source-of-truth.md` — production node JSON exports for import-safe generation |

---

## Summary Table

| File | Workflow name | Nodes | Implemented | Readiness |
|------|---------------|-------|-------------|-----------|
| `qualification-engine.json` | `qualification-engine-v3` | 18* | Full pipeline | **65** |
| `qualification-engine-v4.json` | `qualification-engine-v4` | 18 | Full pipeline (duplicate) | **67** |
| `qualification-engine-v6.json` | `qualification-engine-v6` | 18 | Full pipeline (duplicate) | **55** |
| `offer-engine.json` | `BrainCoach - Offer Engine` | 0 | Stub | **8** |
| `reactivation-engine.json` | `BrainCoach - Reactivation Engine` | 0 | Stub | **8** |
| `voice-intake.json` | `BrainCoach - Voice Intake` | 0 | Stub | **8** |

\*Working copy. Committed version on `main` has **13 nodes** (readiness **52**).

---

## Determinations

### 1. Canonical source of truth

**Target file:** `workflows/qualification-engine.json`

**Rationale:**

- Already the canonical filename in git, README, and `package.json` deploy scripts
- Working copy already contains the v4 validation hardening (same graph as v4/v6)
- One stable path avoids version sprawl in the repo root

**Required cleanup before it becomes authoritative:**

1. Rename internal workflow name from `qualification-engine-v3` → `qualification-engine-v4` (or drop version suffix)
2. Reconcile node parameter shapes against `workflows/reference-node-exports/` once populated
3. Update `qualification-engine.md` to match the consolidated graph
4. Remove redundant fork files after merge

**Do not treat as canonical:** `qualification-engine-v4.json` or `qualification-engine-v6.json` — these are fork copies, not the established repo path.

---

### 2. Experimental files

| File | Classification | Evidence |
|------|----------------|----------|
| `qualification-engine-v4.json` | Experimental fork | Untracked; created to test validation hardening; content now duplicated in working `qualification-engine.json` |
| `qualification-engine-v6.json` | Experimental / abandoned | No doc, no diff from v4 except `name`; appears to be a rename attempt with no new design |
| `qualification-engine-v4.md` | Experimental companion | Documents v4 fork; useful content but tied to non-canonical filename |

The committed **v3 baseline** inside git history (`qualification-engine.json` at `HEAD`, 13 nodes) is a **superseded experiment baseline** — replaced locally but not yet committed.

---

### 3. Obsolete candidates

Safe to archive or delete **after** canonical consolidation and successful n8n import test:

| File | Reason |
|------|--------|
| `qualification-engine-v6.json` | Zero unique value; pure duplicate of v4 |
| `qualification-engine-v4.json` | Redundant once v4 graph is committed to `qualification-engine.json` |
| `qualification-engine.md` (as-is) | Describes obsolete v3 graph; wrong import instructions |
| Committed v3 graph (git history) | Superseded by v4 validation layer — keep in git history only |

**Not obsolete (keep as placeholders):**

| File | Reason |
|------|--------|
| `offer-engine.json` | Planned engine — stub marks intentional future work |
| `reactivation-engine.json` | Same |
| `voice-intake.json` | Same |

**Not obsolete but empty and must be populated:**

| Path | Reason |
|------|--------|
| `workflows/reference-node-exports/` | Required production schema source — currently missing |

---

### 4. Files that should not be committed

| File | Recommendation | Reason |
|------|----------------|--------|
| `qualification-engine-v6.json` | **Do not commit** | Duplicate; adds confusion with no new behavior |
| `qualification-engine-v4.json` | **Do not commit separately** | Merge into `qualification-engine.json` instead of maintaining two identical JSON files |
| `qualification-engine.json` (current working copy) | **Do not commit yet** | Not import-verified; node schemas may not match production n8n |
| `workflows/reference-node-exports/*` | **Do not commit until exported from production** | Must come from live n8n instance per schema source-of-truth rules — not AI-generated |

**Should commit (after consolidation + import test):**

| File | When |
|------|------|
| `qualification-engine.json` | After rename, schema reconciliation, and successful import |
| `qualification-engine.md` | Updated to match consolidated workflow |
| `qualification-engine-v4.md` | Optional — merge into `qualification-engine.md` or rename to drop version suffix |
| Stub workflows (`offer`, `reactivation`, `voice`) | Already tracked; safe to keep as placeholders |

---

## Qualification Engine Version Matrix

| Version | Location | Nodes | Validation | Same graph as v4? | In git? |
|---------|----------|-------|------------|-------------------|---------|
| v3 (committed) | `qualification-engine.json` @ `HEAD` | 13 | No | No | Yes |
| v3→v4 (working) | `qualification-engine.json` (local) | 18 | Yes | Yes | Modified |
| v4 | `qualification-engine-v4.json` | 18 | Yes | Yes | Untracked |
| v6 | `qualification-engine-v6.json` | 18 | Yes | Yes (name only) | Untracked |

**Conclusion:** Three files on disk contain the same v4-hardened graph. Only the filename and internal `name` field differ. v6 is not a distinct version.

---

## Recommended Next Actions

1. Export production nodes into `workflows/reference-node-exports/` using `scripts/export-reference-workflows.js`
2. Reconcile `qualification-engine.json` node schemas against exports
3. Import-test in production n8n
4. Commit single canonical `qualification-engine.json` + updated `qualification-engine.md`
5. Delete or move to `workflows/archive/`: `qualification-engine-v4.json`, `qualification-engine-v6.json`
6. Begin implementation inside existing stub files rather than creating new qualification forks

---

## Cross-References

- `braincoach-docs/current-project-status.md` — repository-wide status and blockers
- `braincoach-docs/n8n-node-schema-source-of-truth.md` — production node export requirements
- `braincoach-docs/n8n-compatibility-notes.md` — model and OpenAI node rules
- `workflows/qualification-engine-v4.md` — validation hardening changelog
