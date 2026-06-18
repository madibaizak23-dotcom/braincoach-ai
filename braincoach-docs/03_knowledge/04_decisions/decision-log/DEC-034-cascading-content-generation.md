# DEC-034 Cascading Content Generation

Date: 2026-06-18

Status: Accepted

## Decision

BrainCoach adopts Cascading Content Generation as the required process for weekly multi-channel content production.

Agents must not generate all reels, stories, posts, and adaptations in one flat pass.

Generation must proceed through approved intermediate layers:

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

## Reason

Flat generation of 35 stories, reels, Threads, Facebook posts, Telegram notes, and short-video adaptations creates context drift.

By the time an agent reaches later assets, it may forget:

* the original weekly tension;
* the first story sequence;
* the expected signal;
* the CTA logic;
* the visual world;
* the relation to previous weeks.

Cascading generation preserves control and improves quality by approving the structure before producing individual assets.

## Required Gates

Agents may not generate daily assets until these are approved:

1. Week Intelligence: previous week results, signals, and corrections.
2. Weekly Strategy: one idea, main conversation, tension, question, hypothesis.
3. Daily Map: 7 daily topics and their function in the weekly arc.
4. Channel Matrix: channel role, format, publishing window, KPI, expected signal.

Only then may the system generate:

* reels scripts;
* stories;
* Threads;
* Facebook posts;
* Telegram notes;
* TikTok / YouTube Shorts adaptations;
* production checklist.

## AI Model Role Rule

External AI systems may support research, alternative angles, and critique.

They do not become the source of truth.

Source of truth remains:

```text
BrainCoach Knowledge OS
+ approved weekly strategy
+ signal log
+ human approval
```

Model roles:

* Perplexity: research, market scan, source discovery.
* Claude / ChatGPT: strategy, structure, writing, adaptation.
* Russian / Chinese / other models: second-opinion, cultural angle, market contrast, CTA critique.
* BrainCoach agent: final synthesis and voice consistency.

## Boundary

This decision does not approve automatic publishing.

It defines the generation architecture before production.

## Related

* `braincoach-docs/07_automation/production_os/03_content/cascading_content_generation_protocol_v1.md`
* `braincoach-docs/07_automation/production_os/03_content/weekly_content_generation_mvp1.md`
* `braincoach-docs/07_automation/03_n8n/weekly_content_automation_mvp1_build_plan.md`
* `braincoach-docs/07_automation/production_os/06_governance/marketing_agent_sync_protocol_v1.md`
