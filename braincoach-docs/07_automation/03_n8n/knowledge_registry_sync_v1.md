# knowledge_registry_sync_v1

Status: Active Sync Workflow

Date: 2026-06-18

Layer: 07_automation / 03_n8n

Source workflow:

`braincoach-docs/07_automation/03_n8n/knowledge_registry_sync_v1.json`

Related:

* `braincoach-docs/03_knowledge/system_snapshot.md`
* `braincoach-docs/05_operations/14_workflows/practice_loop_v1.md`
* `braincoach-docs/05_operations/14_workflows/weekly_sprint_v1.md`
* `braincoach-docs/07_automation/03_n8n/tracker_practice_loop_n8n_note_v1.md`

---

## Purpose

`knowledge_registry_sync_v1` synchronizes GitHub repository changes into the BrainCoach Knowledge Registry.

It lets agents rely on prepared repository knowledge after the relevant commit has been pushed and the n8n execution has succeeded.

This turns morning preparation work into operational context for later agents.

## Current Flow

Observed n8n flow:

```text
GitHub Trigger
->
Knowledge Event Parser
->
Knowledge Event Store
->
Extract Assets
->
Knowledge Asset Store
```

The workflow writes:

* repository event metadata into `knowledge_events`;
* changed repository asset paths into `knowledge_assets`.

## Agent Reliance Rule

Agents may rely on prepared documents when all conditions are true:

1. the relevant files are committed;
2. the commit is pushed to GitHub;
3. `knowledge_registry_sync_v1` has a successful execution after that push;
4. the relevant source paths are stored or updated in `knowledge_assets`;
5. the agent can trace the working claim to a repository source path.

If these conditions are not true, the agent must treat the material as:

```text
local / unsynced / candidate context
```

not as synced operational knowledge.

## Practical Meaning

When the founder prepares strategy, practice rules, content logic, Weekly Sprint rules, or n8n notes in the morning and pushes them:

```text
Morning preparation
->
Git commit
->
Git push
->
n8n sync success
->
knowledge_events / knowledge_assets updated
->
agents can use the prepared material later
```

This supports a daily operating rhythm:

```text
prepare knowledge
->
sync
->
use in tracker / agents / content / planning
->
capture feedback
->
update knowledge again
```

## Screenshot Observation

On 2026-06-18, the n8n executions screen showed a successful execution for the GitHub-triggered knowledge registry workflow.

This supports the operational interpretation that pushed repository updates can become available to the Knowledge Registry and later agent workflows.

The screenshot itself is not treated as the source of knowledge.

It is operational evidence that the sync workflow is running.

## Boundary

This workflow does not prove that every agent has loaded every synced document into its immediate prompt context.

It proves that the repository update can be registered as a knowledge event and asset update.

Agents still need retrieval, prompt routing, or explicit context loading to use the relevant assets during a task.

## Failure Modes

Agents must not assume synced knowledge if:

* the commit was not pushed;
* the n8n execution failed;
* the workflow ran before the relevant commit;
* the asset path was not extracted;
* the workflow registered only event metadata but not the specific asset;
* the agent has no retrieval path to the asset content.

## Future Improvement

Future n8n / agent work should add:

* latest successful sync timestamp checks;
* branch awareness;
* asset retrieval by `source_path`;
* explicit "loaded knowledge assets" list in agent responses;
* warning when local workspace changes are not yet synced;
* a command to ask: "what new knowledge became available after the last push?"
