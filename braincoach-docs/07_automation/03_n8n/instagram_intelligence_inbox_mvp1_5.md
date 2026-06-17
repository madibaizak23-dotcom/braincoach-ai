# instagram_intelligence_inbox_mvp1_5

Status: Draft
Date: 2026-06-17
Depends on: `instagram_analytics_mvp1`
Execution layer: n8n
Storage target: `bgs_orch.production`

## Goal

Build Instagram Intelligence Inbox before Publishing Assistant.

The goal is to stop missing analytics and comments.

MVP-1.5 turns Instagram comments into daily visible intelligence without taking any public account action.

## Operating Formula

```text
Metrics + comments + classification + Telegram visibility.
No public actions.
No writes to bgs_core.
Human approval required for every future account action.
```

## Scope

MVP-1.5 includes:

- daily Analytics MVP-1 Telegram report;
- comment visibility;
- new-comment classification;
- Telegram comment cards;
- production telemetry storage in `bgs_orch.production`.

MVP-1.5 does not include:

- autoposting;
- public comment replies;
- Direct message replies;
- automatic DM handling;
- writes to `bgs_core`;
- SQL migration execution without approval.

## Why This Comes Before Publishing

Publishing more content does not solve the current bottleneck if response signals are still missed.

The closest value is:

- comments expose real market language;
- questions reveal unclear offers or missing content;
- interview candidates can be noticed quickly;
- risky comments can be escalated;
- next content can be based on observed response, not guesses.

This matches the BrainCoach principle:

```text
Automation serves knowledge, not the other way around.
```

## Comment Classification

Each new comment should be classified into one primary class:

| class | meaning | action |
| --- | --- | --- |
| `signal` | Parent pain, repeated phrase, objection, or useful market language. | Store and show in Telegram. |
| `question` | User asks something that may need a reply. | Show in Telegram; no automatic reply. |
| `interview_candidate` | Comment suggests the person may be worth inviting to interview. | Show as high-priority Telegram card. |
| `spam` | Irrelevant, promotional, bot-like, or low-value. | Store as low priority. |
| `risk` | Sensitive, medical, legal, crisis, minors, diagnosis, or reputational risk. | Escalate in Telegram; no automatic reply. |

Optional secondary labels:

- `offer_signal`;
- `content_gap`;
- `pricing_question`;
- `strong_case`;
- `objection`;
- `praise`;
- `negative_feedback`.

## Telegram Comment Card

Each relevant new comment should produce a compact Telegram card:

```text
Instagram comment

Class: signal / question / interview_candidate / spam / risk
Priority: low / normal / high / urgent
Post: <caption excerpt or permalink>
Author: <username if available>
Comment: <comment text>

Why it matters:
<one short explanation>

Recommended next action:
<observe / reply manually / ask interview / ignore / escalate>

Boundary:
No auto-reply was sent.
```

## Workflow Shape

```text
TRG_ScheduledCommentScan
->
IG_ListRecentMedia
->
IG_ReadMediaComments
->
SYS_FilterNewComments
->
AI_ClassifyComment
->
DB_SaveCommentSnapshot
->
DB_SaveCommentInboxItem
->
TG_SendCommentCard
```

## Data Storage

Use `bgs_orch.production`, not `bgs_core`.

Existing draft target:

- `production.instagram_comment_snapshots`

Recommended additional draft object:

- `production.instagram_comment_inbox_items`

Draft columns:

| column | type | required | description |
| --- | --- | --- | --- |
| `inbox_item_id` | uuid | yes | Primary key. |
| `instagram_comment_id` | text | yes | Source comment id. |
| `instagram_media_id` | text | yes | Parent media id. |
| `classification` | text | yes | Primary class. |
| `secondary_labels` | jsonb | yes | Optional labels. |
| `priority` | text | yes | `low`, `normal`, `high`, or `urgent`. |
| `why_it_matters` | text | no | Short classification rationale. |
| `recommended_next_action` | text | no | Operator-facing recommendation. |
| `telegram_sent_at` | timestamptz | no | When the card was sent. |
| `status` | text | yes | `new`, `seen`, `handled`, `ignored`, or `escalated`. |
| `raw_classification` | jsonb | yes | Full classifier output. |
| `created_at` | timestamptz | yes | Row creation timestamp. |

This is a proposal only.
It is not a migration.

## Report Additions

Analytics MVP-1 report should add an Inbox section:

- new comments since last run;
- count by class;
- high-priority comments;
- interview candidates;
- risks;
- top repeated phrases.

## Rules

- Do not post Instagram content.
- Do not reply to comments.
- Do not reply to Direct messages.
- Do not write to `bgs_core`.
- Do not treat comments as validated human reality.
- Store comments as production telemetry.
- Every future account action requires human approval.

## Build Order

1. Finish Analytics MVP-1 Telegram report.
2. Add comment classification.
3. Add Telegram comment cards.
4. Add inbox storage proposal to schema docs.
5. Run on tester account.
6. Review first live report and first comment cards.
7. Only then build Content Publishing Assistant with Telegram approval.
