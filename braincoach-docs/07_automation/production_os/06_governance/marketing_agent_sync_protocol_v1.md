# Marketing Agent Sync Protocol v1

Status: Active

Date: 2026-06-18

Layer: Production OS / Governance

## Purpose

Define how BrainCoach uses Perplexity research, repository commits, Knowledge Registry sync, and agent teams as one marketing intelligence system.

The goal is to preserve a continuous marketing track:

```text
research
->
weekly strategy
->
production
->
market feedback
->
learning
->
next week
```

## Operating Principle

Agents do not own knowledge.

Agents use synchronized objects.

The source of truth is not the chat, Perplexity thread, or individual bot memory.

The source of truth is the committed repository artifact plus the synchronized Knowledge Registry asset.

## What Becomes Available After Commit

After a relevant change is committed, pushed, and successfully processed by `knowledge_registry_sync_v1`, agents may treat these artifact types as shared operational context:

| Artifact type | Example | Agent use |
| --- | --- | --- |
| Decision | `DEC-028-marketing-intelligence-agent-sync.md` | Governance, routing, permission to use a process |
| Canon / architecture | `production_os/00_production_os_canon_v1.md` | Object flow, system boundaries |
| Protocol | `marketing_agent_sync_protocol_v1.md` | How agents coordinate work |
| Research note | Perplexity summary or research brief | Market insight extraction |
| Marketing brief | Weekly conversation, tension, question | Weekly planning |
| Content plan | Table of posts and formats | Copy, design, production |
| Visual rule | Navigation Universe, weekly visual world | Visual consistency |
| Signal log | DM, comments, objections, metrics | Feedback and next-week planning |
| Review | Daily or weekly intelligence report | Learning and correction |

## What Does Not Become Available Automatically

The following remains unsynced candidate context until written to the repository and synchronized:

* a raw Perplexity conversation that was not summarized into an artifact;
* a chat message that was not converted into a file;
* a local file that was not committed;
* a committed file that was not pushed;
* a pushed file before successful sync;
* a private bot response that is not stored in a source artifact;
* a claim that cannot be traced to a source path.

Agents must label this material as:

```text
local / unsynced / candidate context
```

## Synchronous Team Workflow

The agent team works from one active weekly package.

Recommended package structure:

```text
01 Research Input
02 Week Hypothesis
03 Main Conversation
04 Main Tension
05 Main Question
06 Visual World
07 Content Table
08 Production Tasks
09 Signal Capture Plan
10 Outcome Review
```

Each agent reads the same approved package and writes back into a named artifact.

No agent should continue from private memory when the weekly package has changed.

## Agent Handoff Contract

Every agent output must include:

| Field | Meaning |
| --- | --- |
| `source_paths` | Repository files used as input |
| `input_status` | `synced`, `local_candidate`, or `mixed` |
| `output_artifact` | File or object created / updated |
| `assumptions` | Important assumptions not yet proven |
| `signals_to_capture` | What market response should be watched |
| `next_agent` | Who should use the output next |

## Weekly Marketing Agent Team

### Research Intake Agent

Input:

* Perplexity summaries;
* founder notes;
* competitor observations;
* parent language;
* market examples.

Output:

* Research Inbox item;
* research note;
* source links;
* extracted observations.

### Signal Agent

Input:

* research notes;
* comments;
* DM;
* metrics;
* interviews.

Output:

* market signals;
* repeated parent language;
* objections;
* buying triggers;
* weak / strong signal classification.

### Marketing Strategist Agent

Input:

* research notes;
* signal log;
* current product / offer focus;
* active decisions.

Output:

* hypothesis of the week;
* main conversation;
* main tension;
* main question;
* CTA logic;
* what the week is testing.

### Content Operator Agent

Input:

* approved weekly strategy;
* Production OS canon;
* content format rules.

Output:

* weekly content table;
* post-by-post logic;
* production package.

### Visual Framing Agent

Input:

* Navigation Universe decision;
* weekly secondary world;
* content table.

Output:

* visual recognition elements;
* visual object per post;
* anti-repetition check;
* design brief.

### Copy Agent

Input:

* content table;
* weekly hypothesis;
* visual brief.

Output:

* reel scripts;
* carousel slide copy;
* captions;
* stories.

### Production Coordinator Agent

Input:

* approved copy;
* design brief;
* publishing calendar.

Output:

* task list;
* asset checklist;
* publication checklist;
* release status.

### Feedback Agent

Input:

* published posts;
* comments;
* DM;
* saves;
* shares;
* profile visits;
* replies.

Output:

* signal log;
* daily intelligence report;
* weekly outcome review.

### Knowledge Curator Agent

Input:

* feedback output;
* weekly intelligence report;
* repeated signals.

Output:

* promoted knowledge candidates;
* rejected or parked candidates;
* registry updates;
* next-week recommendations.

## Synchronous Usage Pattern

```text
1. Founder researches in Perplexity.
2. Research Intake Agent converts the research into a repository artifact.
3. Founder approves or edits the artifact.
4. Artifact is committed and pushed.
5. knowledge_registry_sync_v1 registers the change.
6. Agent team loads the latest synchronized weekly package.
7. Marketing Strategist creates the weekly frame.
8. Content Operator creates the content table.
9. Visual Framing Agent applies Navigation Universe and weekly world.
10. Copy Agent and Production Coordinator prepare assets.
11. Feedback Agent captures market response.
12. Knowledge Curator updates memory and next-week inputs.
```

## Approval Gates

Human approval is required before:

* a weekly strategy becomes active;
* a content plan moves into production;
* a weak signal is promoted into a registry;
* a new bot, workflow, form, or human-data system is launched;
* any external-user data collection begins.

## Practical Command For Agents

When starting marketing work, an agent should answer:

```text
What synchronized artifacts am I using?
What is the active weekly package?
What is still local candidate context?
What output artifact am I responsible for?
Which agent uses my output next?
```

## Failure Modes

The workflow is invalid if:

* agents use stale weekly context;
* Perplexity output is copied into prompts but not saved;
* visual rules are reinvented per post;
* production happens before human approval;
* feedback is not written back into Signal Log or Weekly Intelligence;
* agents treat private chat memory as shared knowledge.

## Related

* `braincoach-docs/07_automation/03_n8n/knowledge_registry_sync_v1.md`
* `braincoach-docs/07_automation/08_agent_architecture.md`
* `braincoach-docs/07_automation/production_os/00_production_os_canon_v1.md`
* `braincoach-docs/07_automation/production_os/05_intelligence/weekly_intelligence_report_v1.md`
* `braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-028-marketing-intelligence-agent-sync.md`
