# Weekly Content Generation MVP-1

Status: Draft MVP Specification

Date: 2026-06-18

Layer: Production OS / Content

## Purpose

Define the first practical generation workflow for BrainCoach weekly content production.

The goal is to reduce manual bottlenecks while preserving research logic, channel adaptation, BrainCoach voice, and signal capture.

This MVP turns one approved weekly theme into a complete multi-channel production package:

```text
weekly theme
->
weekly content table with time windows
->
daily reels scripts
->
daily story sequences
->
Threads adaptations
->
Facebook adaptations
->
Telegram adaptations
->
production checklist
->
signal capture plan
```

## Current Bottlenecks

Observed manual bottlenecks:

| Bottleneck | Current cost | MVP response |
| --- | --- | --- |
| Research scattered across Perplexity, Claude, ChatGPT | Context fragmentation | Research Intake artifact |
| Reel script created manually per day | Up to 2 hours per reel | Reel Script Pack Agent |
| Stories created one slide at a time | High daily friction | Story Sequence Agent |
| Threads and Facebook receive raw copies | Brand and channel mismatch | Channel Adaptation Agent |
| Weekly theme not always connected to outcomes | Weak learning loop | Signal Capture Plan |
| Posting time not tied to hypothesis | Hard to learn from results | Publishing Scheduler Hypothesis |

## Production Principle

Do not create separate content for each channel from scratch.

Create one weekly meaning system and adapt it by channel.

```text
One weekly conversation
->
many channel-native expressions
```

Meaning remains stable.

Expression changes by channel.

## Input Requirements

The generation workflow requires:

* weekly theme;
* main conversation;
* main tension;
* main question;
* hypothesis of the week;
* visual master world;
* weekly secondary visual world;
* channel list;
* publishing windows;
* expected signals;
* primary and secondary KPI;
* CTA logic.

If the weekly theme is not approved, generation should not start.

## Output Package

The MVP should produce one folder or artifact package per week:

```text
weekly_strategy.md
content_matrix.md
reels_scripts.md
stories_sequences.md
threads_adaptations.md
facebook_adaptations.md
telegram_adaptations.md
visual_brief.md
production_checklist.md
signal_capture_plan.md
weekly_review_template.md
```

## Weekly Content Matrix

Each row should contain:

| Field | Meaning |
| --- | --- |
| `date` | Calendar date |
| `weekday` | Day of week |
| `platform` | Instagram, Threads, Facebook, TikTok, YouTube Shorts, Telegram |
| `format` | Reel, Story, Carousel, thread, post, short, Telegram note |
| `topic` | Unit topic |
| `hypothesis` | What this unit tests |
| `publishing_time` | Planned window |
| `expected_signal` | What should appear in response |
| `primary_kpi` | Main metric |
| `secondary_kpi` | Supporting metric |
| `cta` | Requested action |
| `source_meaning` | Link to weekly strategy / signal |
| `status` | draft, approved, scheduled, published, reviewed |

## Agent Roles

### Weekly Strategist Agent

Creates:

* weekly theme;
* main conversation;
* main tension;
* main question;
* weekly hypothesis;
* what the week is testing.

### Scheduler Agent

Creates:

* publishing windows;
* KPI per unit;
* expected signal;
* next-week measurement fields.

### Reel Script Agent

Creates one script per daily reel:

* hook;
* spoken script;
* scene direction;
* on-screen text;
* caption;
* CTA;
* retention note;
* visual direction.

Target:

Reduce reel scripting from 2 hours to 10-20 minutes of human review and recording preparation.

### Story Sequence Agent

Creates five-story daily sequences:

```text
Story 1 - observation
Story 2 - poll
Story 3 - insight after reel
Story 4 - question
Story 5 - CTA
```

Each story should include:

* slide text;
* sticker / poll / question suggestion;
* visual note;
* expected signal;
* CTA or interaction.

Target:

Stop writing stories one slide at a time.

### Channel Adaptation Agent

Adapts approved daily meaning into:

* Threads post or thread;
* Facebook parent-facing post;
* Telegram deeper note;
* TikTok opening variation;
* YouTube Shorts educational framing.

Rule:

Do not copy-paste raw Instagram content into every channel.

Each channel needs adapted expression while preserving the same meaning.

### Visual Framing Agent

Applies:

* Navigation Universe;
* weekly secondary visual world;
* visual recognition elements;
* anti-repetition rule;
* visual object per post.

### Production Coordinator Agent

Creates:

* daily shooting checklist;
* design checklist;
* publishing checklist;
* missing asset list;
* approval status;
* fallback plan.

### Feedback Agent

Captures:

* reach;
* retention;
* saves;
* replies;
* DM;
* comments;
* profile visits;
* qualitative signals;
* decision for next week.

## Daily Generation Template

Each day should be generated as one package:

```text
Day:
Weekly theme:
Daily topic:
Daily hypothesis:
Publishing windows:

Instagram Reel:
- hook
- script
- on-screen text
- caption
- CTA
- visual direction

Instagram Stories:
- Story 1 observation
- Story 2 poll
- Story 3 insight after reel
- Story 4 question
- Story 5 CTA

Threads:
- short post
- optional thread

Facebook:
- adapted parent-facing post

Telegram:
- deeper note or evening recap

Signal capture:
- expected signal
- primary KPI
- secondary KPI
- what to log
```

## Channel Adaptation Rules

| Channel | Adaptation rule |
| --- | --- |
| Instagram Reel | Emotional entry, phenomenon, short spoken insight |
| Instagram Stories | Dialogue, poll, question, CTA, DM capture |
| Instagram Carousel | Structure, mechanism, saves |
| Threads | Sharp thought, wording test, discussion trigger |
| Facebook | Mature parent-facing explanation, case, question |
| TikTok | Faster hook, more direct language |
| YouTube Shorts | Clear educational framing, searchable question |
| Telegram | Depth, reflection, voice note, recap, community room |

## Quality Gates

Before production, the package must pass:

1. Weekly theme is clear.
2. Every asset traces to the same weekly conversation.
3. Each channel has adapted expression, not raw copy.
4. Every unit has a publishing window.
5. Every unit has expected signal and KPI.
6. Every CTA is explicit.
7. Visual world is assigned.
8. No asset makes claims stronger than evidence.
9. No sensitive child data is requested publicly.
10. Human approval is recorded before publishing automation.

## First MVP Run

Recommended first run:

Weekly theme:

```text
Мы столько вложили. Что останется к осени?
```

Weekly visual world:

```text
Competitive Trajectory + Navigation
```

Deliverables:

* 7 daily packages;
* 4-5 reels scripts;
* 35 stories;
* 7 Threads adaptations;
* 3-4 Facebook adaptations;
* 5-7 Telegram notes or recaps;
* 1 weekly signal capture sheet.

## Success Criteria

MVP-1 succeeds if:

* one weekly package can be generated from one approved strategy;
* reel scripting time drops materially;
* stories are produced as daily sequences, not individual improvisations;
* Threads / Facebook / Telegram stop receiving raw copies;
* each content unit has a signal-capture purpose;
* weekly review can tell what to keep, modify, or drop.

## Related

* `braincoach-docs/05_operations/content_factory.md`
* `braincoach-docs/05_operations/04_generation.md`
* `braincoach-docs/07_automation/production_os/03_content/content_plan.md`
* `braincoach-docs/07_automation/production_os/04_execution/publishing_scheduler_hypothesis_v1.md`
* `braincoach-docs/07_automation/production_os/06_governance/marketing_agent_sync_protocol_v1.md`
* `braincoach-docs/07_automation/03_n8n/marketing_sales_automation_mvp1.md`
