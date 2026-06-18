# DEC-028 Marketing Intelligence Agent Sync

Date: 2026-06-18

Status: Accepted

## Decision

BrainCoach adopts a Marketing Intelligence Agent Sync protocol.

Perplexity research, founder conversations, market observations, content plans, production outcomes, and signal logs must move through the Knowledge OS before agents treat them as shared operational knowledge.

The repository commit is the knowledge release boundary.

After commit, push, and successful knowledge registry sync, bots and agents may use the committed artifacts as shared context if they can trace the claim to a repository source path.

## Core Architecture

```text
Perplexity research
->
Research Inbox / notes
->
BrainCoach Content Operator
->
Weekly Content OS
->
Human approval
->
Production package
->
Publication
->
Signal Log / metrics / comments / DM
->
Marketing Memory
->
Next weekly strategy
```

## Agent Access Rule

Agents may rely on a BrainCoach marketing claim when all conditions are true:

1. the source artifact exists in the repository;
2. the relevant change is committed;
3. the commit is pushed;
4. `knowledge_registry_sync_v1` has succeeded after that push;
5. the relevant asset path is visible to retrieval or explicit context loading;
6. the agent can cite or name the source artifact it used.

If these conditions are not true, the material remains:

```text
local / unsynced / candidate context
```

and cannot be treated as accepted shared memory.

## Synchronous Agent Team Rule

Agents work synchronously through shared objects, not through private memory.

For weekly marketing work, the active shared object is the Weekly Content OS package:

* research input;
* hypothesis of the week;
* main conversation;
* main tension;
* main question;
* visual master world;
* secondary world of the week;
* content table;
* production tasks;
* signal capture plan;
* outcome review.

Each agent reads the same approved package, writes its output back into the package or a related registry, and leaves a traceable source path.

## Agent Roles

Minimum team:

* Research Intake Agent: turns Perplexity output and founder notes into research notes.
* Signal Agent: extracts market signals, objections, repeated language, and buying triggers.
* Marketing Strategist Agent: creates the weekly conversation, tension, question, and hypothesis.
* Content Operator Agent: creates the content table and production package.
* Visual Framing Agent: enforces Navigation Universe and the weekly visual world.
* Copy Agent: writes reels, carousels, captions, and stories.
* Production Coordinator Agent: converts approved assets into tasks for design, montage, publishing, and review.
* Feedback Agent: captures comments, DM, metrics, and deviations.
* Knowledge Curator Agent: promotes validated learnings into registries or keeps weak signals as candidates.

## Boundary

Perplexity is a research source, not BrainCoach memory.

The bot is an operator, not the source of truth.

Git and the Knowledge Registry are the release and synchronization layer.

Approved knowledge lives in repository artifacts and synchronized registry records.

## Related

* `braincoach-docs/07_automation/03_n8n/knowledge_registry_sync_v1.md`
* `braincoach-docs/07_automation/08_agent_architecture.md`
* `braincoach-docs/07_automation/production_os/00_production_os_canon_v1.md`
* `braincoach-docs/07_automation/production_os/06_governance/marketing_agent_sync_protocol_v1.md`
* `braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-027-production-visual-framing-layer.md`
