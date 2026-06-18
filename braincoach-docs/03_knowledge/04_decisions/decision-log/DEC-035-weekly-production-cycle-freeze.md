# DEC-035 Weekly Production Cycle Freeze

Date: 2026-06-18

Status: Accepted

## Decision

After a weekly content seed is installed, BrainCoach freezes the weekly structure until the end of that production cycle.

Frozen objects:

* Weekly Strategy Brief;
* main conversation;
* main tension;
* main question;
* Channel Matrix;
* publishing scheduler hypothesis;
* `content_plan`;
* `content_units`.

Allowed changes during the live week:

* `generated_content_assets`;
* texts;
* scripts;
* story wording;
* visual briefs;
* CTA wording;
* production notes.

## Reason

BrainCoach has moved from manual content planning to a production pipeline:

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

If the team changes the weekly structure immediately after seed installation, the system loses the ability to learn from the week.

The purpose of the first live week is not to perfect the matrix.

The purpose is to collect real signals under stable conditions.

## Production Rule

Once a weekly seed is installed:

```text
Do not change the weekly brief, channel matrix, or scheduler until the week is complete.
```

Only the asset layer may be edited before publishing.

## Strategic Observation

BrainCoach has stopped merely planning content.

BrainCoach has started planning a content system.

The new reproducible path is:

```text
Conversation -> Content -> Signal -> Knowledge
```

This closes the missing link between Marketing OS and BrainCoach Knowledge OS.

## Operating Implication

The next implementation step must be `Monday Generator MVP`, not a redesign of the weekly plan.

Generate and review the first day package before scaling generation to the rest of the week.

The first day package must test:

* preservation of the weekly conversation;
* preservation of Navigation Universe;
* avoidance of research / framework language;
* unified channel voice;
* parent response potential.

Before mass generation, the system must also enforce:

```text
Main Conversation stays constant.
Daily language changes.
```

For public content, internal BrainCoach words must be controlled.

Use `trajectory` / `траектория`, `system` / `система`, and `diagnostics` / `диагностика` as internal precision words, not as dominant public vocabulary.

Prefer parent-natural public words:

* движение;
* прогресс;
* направление;
* результат;
* что держится в ребенке;
* что продолжает работать без внешней поддержки.

This prevents a stable weekly theme from becoming repetitive or overly framework-like.

## Boundary

This decision does not approve autopublishing.

It governs weekly production-cycle stability and generation order.

## Related

* `DEC-032-weekly-content-generation-mvp1.md`
* `DEC-033-weekly-content-automation-build-order.md`
* `DEC-034-cascading-content-generation.md`
* `braincoach-docs/07_automation/04_postgres/009_seed_weekly_content_plan_2026_06_22.sql`
* `braincoach-docs/07_automation/production_os/03_content/cascading_content_generation_protocol_v1.md`
* `braincoach-docs/07_automation/03_n8n/weekly_content_automation_mvp1_build_plan.md`
