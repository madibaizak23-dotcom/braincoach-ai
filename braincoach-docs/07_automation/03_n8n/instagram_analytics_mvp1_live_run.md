# instagram_analytics_mvp1_live_run

Status: Draft Runbook
Date: 2026-06-17
Target workflow: `instagram_analytics_mvp1_dry_run`
Execution layer: n8n 2.22.5

Current live dry-run workflow:

- workflow name: `instagram_analytics_webhook_dry_run`;
- workflow id: `JWy7pHntxkgEVagk`;
- status: active schedule/webhook dry-run;
- storage mode: no database writes until DDL is explicitly approved.

## Goal

Run Instagram Analytics MVP-1 live against the Instagram tester account without database writes.

The first live run is dry-run/read-only until the `bgs_orch.production` schema DDL is explicitly approved and applied.

## Boundaries

- Use tester Instagram account only.
- Use Meta Instagram Graph API.
- Credentials only via n8n credentials or environment variables.
- Do not write app secret, access token, or credential values to repo/docs/logs.
- No public Instagram actions.
- No comment publishing.
- No reply publishing.
- No Direct message replies.
- No `bgs_core` writes.
- No SQL migration without approval.

## Dry-Run Workflow

Import:

`braincoach-docs/07_automation/03_n8n/instagram_analytics_mvp1_dry_run.json`

Live import status:

- imported into n8n on 2026-06-17;
- workflow name: `instagram_analytics_mvp1_dry_run`;
- workflow id: `7vi5kH5YxfsXgccK`;
- imported state: inactive;
- API activation attempt returned `403 Forbidden`, so activation/manual execution should be done from n8n UI or with an API key that has workflow activation permission.

Dry-run behavior:

- reads recent Instagram media;
- reads media insights;
- reads comments;
- aggregates yesterday/today performance;
- sends one Telegram report;
- performs no Postgres writes.

## First Successful Scheduled Dry Run

Date observed: 2026-06-18.

Trigger: daily schedule.

Outcome:

- Telegram report delivered successfully.
- Window: yesterday + today.
- Media collected: 1.
- Media with insights: 1.
- Comment rows read: 0.
- Likes: 0.
- Comments: 0.
- Saves: 0.
- Reach: 112.
- Views: 124.

Operational notes:

- The report included top content, best performer, underperformed content, repeated comment themes, possible market signals, and recommended next content action.
- MarkdownV2 escaping was required for Telegram delivery after an earlier `can't parse entities` error.
- Boundary confirmed in the delivered report: dry-run/read-only, no DB writes, no public Instagram actions, no comments/replies publishing, no `bgs_core` writes.

## Required Runtime Configuration

Environment variables in n8n runtime:

| variable | value source |
| --- | --- |
| `BRAINCOACH_IG_USER_ID` | Instagram tester account id. |
| `META_IG_ACCESS_TOKEN` | n8n env/secret only; never repository. |
| `BRAINCOACH_TELEGRAM_CHAT_ID` | n8n env/secret only. |

n8n credential:

- Telegram credential for `TG_SendInstagramDryRunReport`.

## Manual Live Dry Run

1. Import `instagram_analytics_mvp1_dry_run.json` into n8n.
2. Attach the Telegram credential to `TG_SendInstagramDryRunReport`.
3. Confirm env vars exist in Cloud Run/n8n runtime.
4. Execute `TRG_ManualRun`.
5. Confirm Telegram report arrives.
6. Confirm report footer says:

```text
Boundary: dry-run/read-only. No DB writes. No public Instagram actions. No comments/replies publishing. No bgs_core writes.
```

## Expected Telegram Sections

- media collected;
- comment rows read;
- top content;
- what performed best;
- what underperformed;
- repeated comment themes;
- possible market signals;
- recommended next content action.

## After Successful Dry Run

Only after explicit SQL approval:

1. Apply reviewed DDL to `bgs_orch.production`.
2. Import or activate the storage-enabled workflow:

```text
braincoach-docs/07_automation/03_n8n/instagram_analytics_mvp1.json
```

3. Run manual test.
4. Verify rows in:

- `production.instagram_media_snapshots`;
- `production.instagram_comment_snapshots`;
- `production.instagram_comment_inbox_items`;
- `production.outcomes`.

## Do Not Do

- Do not paste app secret into n8n workflow nodes.
- Do not paste access token into workflow JSON.
- Do not commit local env files.
- Do not enable Instagram publishing nodes.
- Do not enable comment reply nodes.
- Do not connect this workflow to `bgs_core`.
