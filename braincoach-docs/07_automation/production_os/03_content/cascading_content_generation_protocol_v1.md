# Cascading Content Generation Protocol v1

Status: Active

Date: 2026-06-18

Layer: Production OS / Content

## Purpose

Prevent context drift in weekly multi-channel content generation.

The protocol defines a staged generation process where each layer is approved before the next layer is generated.

## Core Rule

Do not ask an agent to generate the full weekly package in one flat prompt.

Use staged generation:

```text
Week Intelligence
->
Weekly Strategy
->
Daily Map
->
Channel Matrix
->
Asset Generation
->
Consistency QA
->
Human Approval
```

## Production Cycle Freeze

After a weekly seed is installed into `bgs_orch.production`, the weekly structure is frozen until the end of the week.

Do not change:

* Weekly Strategy Brief;
* main conversation;
* main tension;
* main question;
* Daily Map;
* Channel Matrix;
* scheduler hypothesis;
* `content_plan`;
* `content_units`.

Allowed changes:

* `generated_content_assets`;
* scripts;
* captions;
* story wording;
* visual briefs;
* CTA wording;
* production notes.

Reason:

The weekly seed starts a real test cycle. Changing the structure before the week completes destroys the signal quality.

The question after seed installation is no longer whether the structure can be improved.

The question is what signals the structure collects under stable conditions.

## Stage 1: Week Intelligence

Purpose:

Understand what happened before planning the next week.

Inputs:

* previous weekly plan;
* published content;
* execution status;
* metrics;
* comments;
* DM;
* replies;
* signal log;
* Perplexity or external research notes.

Output:

* what worked;
* what failed;
* repeated signals;
* missed signals;
* strongest channel / format;
* strongest CTA;
* one or two corrections for next week.

Gate:

Do not create a new weekly strategy until Week Intelligence is complete.

## Stage 2: Weekly Strategy

Purpose:

Define one weekly idea.

Required output:

* weekly theme;
* main conversation;
* main tension;
* main question;
* weekly hypothesis;
* what the week is testing;
* visual master world;
* weekly secondary visual world;
* primary CTA logic.

Gate:

Do not create daily topics until Weekly Strategy is approved.

## Stage 3: Daily Map

Purpose:

Turn the weekly idea into seven daily functions.

Recommended weekly arc:

| Day function | Meaning |
| --- | --- |
| Attention | Open the weekly conversation |
| Recognition | Capture parent self-recognition |
| Explanation | Explain the mechanism |
| Tension | Show the cost of inaction |
| Market Signal | Ask what parents already tried |
| Reframe | Change how the problem is understood |
| Review | Collect signals and prepare next week |

Required output per day:

* day;
* daily topic;
* function in weekly arc;
* daily hypothesis;
* expected signal;
* primary CTA;
* visual object.

Gate:

Do not create channel assets until Daily Map is approved.

## Stage 4: Channel Matrix

Purpose:

Define how each daily topic appears in each channel.

Required output per content unit:

* date;
* platform;
* format;
* topic;
* hypothesis;
* publishing window;
* expected signal;
* primary KPI;
* secondary KPI;
* CTA;
* status.

Gate:

Do not write final scripts until Channel Matrix is approved.

## Stage 5: Asset Generation

Purpose:

Generate channel-native assets from the approved matrix.

MVP-1 order:

Generate the first day package before generating the full remaining week.

For `CPLAN-2026-06-22-W01`, the first generation target is:

```text
Monday Generator MVP
```

This package includes the Monday Instagram Reel, five Stories, Threads, Facebook, Telegram, TikTok, and YouTube Shorts assets.

Allowed outputs:

* Instagram Reel script;
* Instagram Story sequence;
* Instagram Carousel;
* Threads post / thread;
* Facebook adapted post;
* Telegram note;
* TikTok opening variation;
* YouTube Shorts educational framing;
* caption;
* CTA;
* production note.

Rule:

Generate by day package, not by isolated asset.

Each day package should include:

```text
daily topic
daily hypothesis
publishing windows
Instagram Reel
Instagram Stories
Threads
Facebook
Telegram
TikTok / Shorts adaptation
signal capture
```

After the first day package is reviewed, generation may scale to the remaining content units.

### Daily Language Variation Rule

The weekly main conversation stays constant.

Daily language must change.

The generator must not repeat the same anchor word across all days just because it belongs to the weekly theme.

Example for `CPLAN-2026-06-22-W01`:

| day | public language focus |
| --- | --- |
| Monday | Мы столько вложили |
| Tuesday | Когда вы впервые начали переживать? |
| Wednesday | Почему одинаковые возможности дают разный результат? |
| Thursday | Что можно потерять этим летом? |
| Friday | Что вы уже пробовали? |
| Saturday | Почему помощь не всегда превращается в движение? |
| Sunday | Где за неделю проявились главные сигналы? |

Monday may use investment language heavily because it opens the week.

Tuesday and later days must not keep repeating `вложения` as the dominant word unless the daily topic requires it.

### Public Language Guardrail

BrainCoach internal language may use words such as `trajectory`, `system`, and `diagnostics`.

Public content should prefer parent-natural words:

* движение;
* прогресс;
* направление;
* результат;
* что держится в ребенке;
* что продолжает работать без внешней поддержки.

Use `траектория` sparingly in public assets.

Avoid making public content sound like an internal framework.

## Stage 6: Consistency QA

Purpose:

Detect drift before human approval.

Checklist:

1. Does every asset preserve the weekly theme?
2. Does every asset fit its daily function?
3. Are CTAs varied but coherent?
4. Are stories not repeating the same question all week?
5. Are Threads and Facebook adapted, not copied?
6. Is Navigation Universe visible?
7. Is the weekly secondary world consistent?
8. Are claims within evidence?
9. Are sensitive child data requests avoided?
10. Is the expected signal clear?
11. Does the day use its own language instead of repeating Monday's anchor words?
12. Are internal words such as `траектория`, `система`, and `диагностика` overused for a public audience?

## Stage 7: Human Approval

Purpose:

Human approves the structure and final assets before production.

Approval may be:

* approve full package;
* approve strategy only;
* approve daily map only;
* request regeneration of one day;
* request regeneration of one channel;
* reject weak CTA / hook / visual brief.

## External AI Use

External models may be used by role.

| Model type | Best use |
| --- | --- |
| Perplexity | Research, sources, market scan, competitor examples |
| Claude | Long-form strategy, coherence, editorial structure |
| ChatGPT | Strategy, generation, QA, adaptation, agent orchestration |
| Russian models | Russian-language nuance, local phrasing, cultural resonance |
| Chinese models | Alternative market logic, commercial angles, short-form tactic critique |

External AI outputs must enter as:

```text
research input
candidate angle
second opinion
critique
```

They must not bypass BrainCoach Knowledge OS or human approval.

## Failure Modes

The process fails if:

* an agent generates 35 stories before the daily map is approved;
* each channel is treated as a separate idea;
* external AI outputs override BrainCoach strategy;
* the first and last assets of the week no longer share one conversation;
* previous week results are ignored;
* QA is skipped.

## Related

* `braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-034-cascading-content-generation.md`
* `braincoach-docs/07_automation/production_os/03_content/weekly_content_generation_mvp1.md`
* `braincoach-docs/07_automation/production_os/04_execution/publishing_scheduler_hypothesis_v1.md`
* `braincoach-docs/07_automation/production_os/06_governance/marketing_agent_sync_protocol_v1.md`
