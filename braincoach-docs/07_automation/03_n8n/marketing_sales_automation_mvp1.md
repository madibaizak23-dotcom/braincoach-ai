# Marketing & Sales Automation MVP-1

Status: Draft MVP Specification

Date: 2026-06-18

Execution layer: n8n + Telegram operator loop

Storage target: `bgs_orch`

## Purpose

Define the first practical BrainCoach marketing and sales automation MVP.

This MVP turns marketing response into a visible decision loop:

```text
content execution
->
audience response
->
signal classification
->
lead / interview candidate detection
->
human-approved next action
->
sales / discovery outcome
->
next content and offer correction
```

The goal is not to automate sales blindly.

The goal is to build the first control loop that recognizes meaningful market factors, separates them from noise, and routes them into decision contours.

## Full Function Control Frame

| Control element | MVP-1 meaning |
| --- | --- |
| Object of control | BrainCoach marketing-to-sales response loop |
| Goal vector | Discover payment triggers and convert qualified parent interest into interviews / consultations |
| Current state | Content is being published, but signals, comments, DM, and follow-up are not yet systematically routed |
| Deviation | Meaningful market signals can be missed or not converted into next action |
| Environment | Instagram, Facebook, Threads, TikTok, YouTube Shorts, Telegram, Perplexity research, parent replies |
| Control function | Capture, classify, prioritize, recommend, approve, act, measure |
| Feedback | Comments, DM, replies, saves, profile visits, consultation requests, interview acceptance |
| Correction | Next-week content, CTA, offer angle, publishing window, follow-up script |
| Control mode | Human-approved automation, no blind public actions |

## MVP Scope

MVP-1 includes:

* daily Instagram analytics report;
* comment and response intelligence inbox;
* meaningful signal detection;
* lead / interview candidate detection;
* Telegram cards for operator action;
* human-approved manual follow-up;
* sales discovery outcome logging;
* weekly correction report.

MVP-1 does not include:

* automatic public replies;
* automatic Direct messages;
* blind autoposting;
* mass messaging;
* writes to `bgs_core`;
* unapproved SQL migrations;
* medical, psychological, or diagnostic claims.

## Why This MVP First

Current constraint:

```text
Payment Trigger Discovery
```

Publishing more content is a non-constraint if the system still misses:

* buying language;
* objections;
* prior purchases;
* failed attempts;
* last-straw moments;
* consultation readiness;
* interview candidates.

Therefore the first MVP should prioritize intelligence and routing before full publishing automation.

## Input Sources

MVP-1 may ingest:

* Instagram post and reel metrics;
* Instagram comments;
* manual DM summaries;
* Telegram channel replies;
* Facebook comments entered manually or via later API;
* Threads / TikTok / YouTube Shorts notes entered manually at first;
* Perplexity research summaries;
* operator notes after calls or interviews.

## Signal Classes

Each response should be classified into one primary class:

| Class | Meaning | Default action |
| --- | --- | --- |
| `market_signal` | Useful parent language, pain, desire, objection, or repeated phrase | Store and show |
| `payment_trigger` | Mentions money spent, failed solution, urgency, risk, or willingness to pay | High-priority Telegram card |
| `offer_question` | Asks about format, price, result, process, or availability | Human reply recommended |
| `interview_candidate` | Strong case or useful story for offer discovery | Invite manually after approval |
| `consultation_candidate` | Expresses direct need or asks for help | Manual sales follow-up recommended |
| `content_gap` | Shows confusion or missing explanation | Feed next content plan |
| `objection` | Doubt, disagreement, price concern, skepticism | Store and route to offer / copy |
| `noise` | Low-value, vague, irrelevant, spam, or non-actionable | Store low priority or ignore |
| `risk` | Sensitive, minors, health, diagnosis, crisis, legal, reputational | Escalate, no AI action |

Optional labels:

* `trajectory_risk`;
* `investment_not_converting`;
* `external_management_dependency`;
* `tutor_dependency`;
* `summer_regression`;
* `lost_season`;
* `price_question`;
* `prior_purchase`;
* `failed_attempt`;
* `last_straw`;
* `urgent_need`.

## Telegram Operator Card

Each meaningful item should produce a Telegram card:

```text
BrainCoach Market Signal

Class: payment_trigger / consultation_candidate / interview_candidate / objection / risk
Priority: low / normal / high / urgent
Channel: Instagram / Facebook / Telegram / manual
Source: post URL, comment id, DM summary, or manual note

Text:
<captured response>

Why it matters:
<short explanation>

Recommended action:
<observe / reply manually / invite to interview / offer consultation / escalate / ignore>

Suggested reply draft:
<optional, human approval required>

Boundary:
No public or Direct reply was sent automatically.
```

## Sales Routing

Sales routing is human-approved.

| Signal class | Route |
| --- | --- |
| `payment_trigger` | Offer Discovery Log + possible interview invite |
| `offer_question` | Manual reply draft + FAQ / offer clarity update |
| `interview_candidate` | Interview candidate list |
| `consultation_candidate` | Consultation follow-up list |
| `objection` | Objection log + content / sales script update |
| `content_gap` | Next content plan |
| `risk` | Manual handling only |

## MVP Workflow Shape

```text
TRG_DailyMarketingScan
->
IG_ReadRecentMediaAndComments
->
MANUAL_ReadOperatorNotes
->
SYS_NormalizeResponses
->
AI_ClassifyMarketResponse
->
SYS_FilterNoiseAndRisk
->
DB_SaveMarketSignal
->
DB_SaveLeadCandidate
->
TG_SendOperatorCard
->
TG_WaitForActionMark
->
DB_RecordActionDecision
->
MANUAL_ExecuteApprovedFollowup
->
DB_RecordSalesDiscoveryOutcome
->
AI_WeeklyCorrectionSummary
```

Early MVP may skip direct API ingestion for non-Instagram channels and use manual input.

## Operator Commands

Initial Telegram commands:

```text
/mark_signal <id>
/mark_noise <id>
/invite_interview <id>
/consult_followup <id>
/handled <id>
/ignore <id>
/risk <id>
/note_outcome <id> <text>
```

No command sends a public reply in MVP-1.

Commands only mark status or create a manual follow-up task.

## Data Objects

Logical objects only. SQL requires separate review.

### production.market_signals

Stores classified market responses.

Candidate fields:

* `signal_id`;
* `source_channel`;
* `source_type`;
* `source_reference`;
* `raw_text`;
* `classification`;
* `secondary_labels`;
* `priority`;
* `why_it_matters`;
* `recommended_action`;
* `status`;
* `created_at`.

### production.lead_candidates

Stores possible interview or consultation candidates.

Candidate fields:

* `lead_candidate_id`;
* `signal_id`;
* `candidate_type`: `interview`, `consultation`, `offer_discovery`;
* `readiness_level`: `low`, `medium`, `high`;
* `reason`;
* `approved_next_action`;
* `status`;
* `created_at`.

### production.sales_discovery_outcomes

Stores follow-up results.

Candidate fields:

* `outcome_id`;
* `lead_candidate_id`;
* `action_taken`;
* `result`;
* `payment_story_detected`;
* `offer_angle`;
* `next_step`;
* `notes`;
* `created_at`.

## Weekly Review Output

The weekly report should answer:

1. Which content produced the strongest market signals?
2. Which channel produced the strongest replies or DM?
3. Which parent phrases repeated?
4. Which payment triggers appeared?
5. Which objections appeared?
6. Which people became interview or consultation candidates?
7. Which offer angle became stronger or weaker?
8. What should change next week: topic, CTA, hook, time, channel, or offer framing?

## Success Criteria

MVP-1 succeeds when:

* meaningful comments / replies are no longer missed;
* every strong signal reaches Telegram;
* interview and consultation candidates are visible;
* payment-trigger language is stored and reviewed weekly;
* next week's content plan uses the captured signals;
* no unsafe public action is automated.

## Build Order

1. Finish or run Instagram Analytics MVP-1.
2. Build Intelligence Inbox MVP-1.5 comment cards.
3. Add market / payment / lead classification labels.
4. Add Telegram action commands.
5. Store action decisions and manual outcomes.
6. Produce weekly marketing-sales correction report.
7. Only after that add approved publishing assistant.

## Related

* `braincoach-docs/07_automation/03_n8n/instagram_analytics_mvp1.md`
* `braincoach-docs/07_automation/03_n8n/instagram_intelligence_inbox_mvp1_5.md`
* `braincoach-docs/07_automation/03_n8n/instagram_social_automation_mvp2_plan.md`
* `braincoach-docs/05_operations/10_planning/offer_discovery_v1.md`
* `braincoach-docs/04_domain/products/offer_angles_v1.md`
* `braincoach-docs/07_automation/06_governance/automation_objective_control_principle_v1.md`
