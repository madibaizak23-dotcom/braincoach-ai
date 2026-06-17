# Instagram Analytics MVP-1 Schema Proposal

Status: Draft Proposal
Date: 2026-06-15
Database: `bgs_orch`
Schema: `production`
Migration: Not approved

## Purpose

Define the draft storage shape for Instagram read-only analytics collection.

This document is a table proposal only.

It does not create SQL.
It does not approve a migration.
It does not touch `bgs_core`.

## Boundary

Instagram content telemetry belongs in `bgs_orch` because it is production-process response memory.

It must not be written to `bgs_core` unless a later reviewed process promotes a response into a validated reality object.

## Proposed Tables

### production.instagram_media_snapshots

Stores one collected snapshot per Instagram media item per collection run.

| column | type | required | description |
| --- | --- | --- | --- |
| `snapshot_id` | uuid | yes | Primary key. |
| `instagram_media_id` | text | yes | Meta Instagram media id. |
| `media_type` | text | no | Instagram media type, such as `IMAGE`, `VIDEO`, `CAROUSEL_ALBUM`. |
| `media_product_type` | text | no | Feed, Reels, Story, or other product surface when returned. |
| `caption` | text | no | Caption text returned by Meta. |
| `permalink` | text | no | Public media permalink when returned. |
| `published_at` | timestamptz | no | Instagram media timestamp. |
| `reach` | integer | no | Reach insight when returned. |
| `views` | integer | no | Views insight when returned. |
| `likes` | integer | no | Like count or likes insight when returned. |
| `comments` | integer | no | Comment count or comments insight when returned. |
| `saves` | integer | no | Saves/saved insight when returned. |
| `shares` | integer | no | Shares insight when returned. |
| `raw_metrics` | jsonb | yes | Full normalized metric map from Meta. |
| `raw_media` | jsonb | yes | Raw media payload from Meta. |
| `collected_at` | timestamptz | yes | Collection timestamp. |

Draft uniqueness:

```text
(instagram_media_id, collected_at)
```

Recommended indexes after approval:

- `instagram_media_snapshots_media_id_collected_at_idx` on `(instagram_media_id, collected_at desc)`
- `instagram_media_snapshots_published_at_idx` on `(published_at desc)`

### production.instagram_comment_snapshots

Stores read-only comment snapshots collected from Instagram media.

| column | type | required | description |
| --- | --- | --- | --- |
| `snapshot_id` | uuid | yes | Primary key. |
| `instagram_comment_id` | text | yes | Meta Instagram comment id. |
| `instagram_media_id` | text | yes | Parent media id. |
| `comment_text` | text | no | Comment body returned by Meta. |
| `author_username` | text | no | Comment author username when returned and allowed. |
| `commented_at` | timestamptz | no | Comment timestamp when returned. |
| `like_count` | integer | no | Comment like count when returned. |
| `raw_comment` | jsonb | yes | Raw comment payload from Meta. |
| `collected_at` | timestamptz | yes | Collection timestamp. |

Draft uniqueness:

```text
(instagram_comment_id, collected_at)
```

Recommended indexes after approval:

- `instagram_comment_snapshots_media_id_collected_at_idx` on `(instagram_media_id, collected_at desc)`
- `instagram_comment_snapshots_comment_id_idx` on `(instagram_comment_id)`

### production.instagram_comment_inbox_items

Stores MVP-1.5 Instagram Intelligence Inbox classification items.

This table is for visibility and triage only.

It does not store approved replies.
It does not trigger public actions.
It does not promote comments into `bgs_core`.

| column | type | required | description |
| --- | --- | --- | --- |
| `inbox_item_id` | uuid | yes | Primary key. |
| `instagram_comment_id` | text | yes | Source comment id. |
| `instagram_media_id` | text | yes | Parent media id. |
| `classification` | text | yes | Primary class: `signal`, `question`, `interview_candidate`, `spam`, or `risk`. |
| `secondary_labels` | jsonb | yes | Optional labels such as `offer_signal`, `content_gap`, `objection`, or `strong_case`. |
| `priority` | text | yes | `low`, `normal`, `high`, or `urgent`. |
| `why_it_matters` | text | no | Short classification rationale for the operator. |
| `recommended_next_action` | text | no | Suggested human action, such as observe, reply manually, ask interview, ignore, or escalate. |
| `telegram_sent_at` | timestamptz | no | When the comment card was sent to Telegram. |
| `status` | text | yes | `new`, `seen`, `handled`, `ignored`, or `escalated`. |
| `raw_classification` | jsonb | yes | Full classifier output. |
| `created_at` | timestamptz | yes | Row creation timestamp. |

Draft uniqueness:

```text
(instagram_comment_id)
```

Recommended indexes after approval:

- `instagram_comment_inbox_items_classification_idx` on `(classification, priority, created_at desc)`
- `instagram_comment_inbox_items_media_id_idx` on `(instagram_media_id, created_at desc)`

### production.outcomes

Stores one production outcome summary per media collection run.

| column | type | required | description |
| --- | --- | --- | --- |
| `outcome_id` | uuid | yes | Primary key. |
| `outcome_code` | text | no | Human-readable outcome reference. |
| `channel` | text | yes | `instagram`. |
| `source_type` | text | yes | `instagram_media`. |
| `source_id` | text | yes | Instagram media id. |
| `source_reference` | text | no | Permalink or source URL. |
| `response_window` | text | no | Collection window label, such as `daily_snapshot`. |
| `raw_metrics` | jsonb | yes | Metrics for the media snapshot. |
| `raw_responses` | jsonb | yes | Comment sample and raw response material. |
| `repeated_phrase_candidates` | jsonb | yes | Draft repeated comment terms or phrases. |
| `response_summary` | text | no | Factual summary, not final signal interpretation. |
| `captured_at` | timestamptz | yes | Outcome creation timestamp. |
| `created_at` | timestamptz | yes | Database row creation timestamp. |

Draft uniqueness:

```text
(channel, source_type, source_id, captured_at)
```

Recommended indexes after approval:

- `outcomes_channel_source_idx` on `(channel, source_type, source_id)`
- `outcomes_captured_at_idx` on `(captured_at desc)`

## n8n Usage

Workflow:

`braincoach-docs/07_automation/03_n8n/instagram_analytics_mvp1.json`

Required writes:

- insert media snapshots into `production.instagram_media_snapshots`
- insert comment snapshots into `production.instagram_comment_snapshots`
- insert comment classifications into `production.instagram_comment_inbox_items`
- insert summarized daily outcomes into `production.outcomes`

Required reads:

- read yesterday/today windows from `production.instagram_media_snapshots`
- read comment windows from `production.instagram_comment_snapshots`
- read classification windows from `production.instagram_comment_inbox_items`
- read outcomes from `production.outcomes`

## Non-Goals

This schema does not support:

- autoposting;
- automatic public replies;
- comment moderation actions;
- writing to `bgs_core`;
- validated signal storage;
- CRM storage.

## Approval Gate

Before production use:

1. Review and approve this table proposal.
2. Create a separate draft SQL migration.
3. Apply only after explicit migration approval.
4. Verify live `bgs_orch.production` schema.
5. Update BrainCoach owned-table documentation and migration logs.
