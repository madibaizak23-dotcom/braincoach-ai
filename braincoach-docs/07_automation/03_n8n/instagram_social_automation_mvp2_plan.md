# Instagram Social Automation MVP-2 Plan

Status: Draft Plan
Date: 2026-06-17
Depends on: `instagram_analytics_mvp1`
Execution layer: n8n
Storage target: `bgs_orch`

## Purpose

Define the staged path after Instagram Analytics MVP-1: first build Instagram Intelligence Inbox MVP-1.5, then build publishing and response assistants.

The bottleneck is not publishing first.

The bottleneck is:

- analytics is easy to miss;
- content decisions are not linked to response data;
- comments and Direct messages contain market signals that are easy to miss;
- replies need BrainCoach voice and judgment;
- unsafe automation can damage trust or trigger platform risk.

## Current Meta Setup Observed

From the provided Meta app screenshots:

- app name: BrainCoach Social Intelligence-IG;
- Instagram tester account is connected;
- tester role is visible in app roles;
- Webhooks section requires the app to be published before notifications can be received;
- permissions visible in setup include:
  - `instagram_business_basic`;
  - `instagram_business_manage_comments`;
  - `instagram_business_manage_messages`;
- app secret was visible in the screenshot and should be reset before production use.

Important:

Do not store Meta app secret in repository files.
Do not paste it into workflow documentation.
Use n8n credentials or environment variables only.

## Automation Principle

Use phased automation.

Phase 1 should automate analytics visibility.
Phase 1.5 should automate comment intelligence visibility.
Phase 2 should automate content drafts.
Phase 3 can automate approved account actions.

Avoid fully automatic public replies and Direct replies until the reply quality, safety rules, opt-out handling, and Meta permission state are tested.

## Phase 1: Daily Analytics, No Write Actions

Status: already drafted as `instagram_analytics_mvp1`.

Goal:

- collect media performance;
- collect comments;
- store snapshots in `bgs_orch.production`;
- send Telegram report every morning.

Telegram report must answer:

- what worked yesterday/today;
- what underperformed;
- repeated comment themes;
- possible market signals;
- recommended next content action.

This is the first live value because it fixes the missed-analytics bottleneck without account risk.

## Phase 1.5: Instagram Intelligence Inbox, No Write Actions

Status: nearest next build.

Detailed spec:

`braincoach-docs/07_automation/03_n8n/instagram_intelligence_inbox_mvp1_5.md`

Goal:

Stop missing analytics and comments before adding publishing automation.

Default behavior:

- collect new comments;
- classify each comment;
- store it in `bgs_orch.production`;
- send a Telegram card for meaningful comments;
- recommend the next human action.

Comment classes:

- signal;
- question;
- interview candidate;
- spam;
- risk.

Rules:

- no public actions;
- no comment replies;
- no Direct message replies;
- no writes to `bgs_core`;
- comments remain production telemetry, not validated human reality.

Required workflow:

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

## Phase 2: Content Publishing Assistant, Human Approval Required

Goal:

Prepare Instagram posts from BrainCoach content plans and send them to Telegram for approval.

Default behavior:

- n8n creates a draft post package;
- Telegram sends preview to operator;
- operator approves, edits, or rejects;
- only approved posts are published.

Required workflow:

```text
TRG_ScheduledContentCheck
->
DB_ReadApprovedContentPlan
->
SYS_FormatInstagramDraft
->
TG_SendApprovalRequest
->
TG_WaitForApproveReject
->
IG_CreateMediaContainer
->
IG_PublishMedia
->
DB_RecordProductionExecution
```

Approval commands:

- `/approve_post <draft_id>`
- `/reject_post <draft_id>`
- `/edit_post <draft_id> <text>`

Rules:

- no autoposting without explicit approval;
- no post if media asset is missing;
- no post if caption has unresolved placeholders;
- no post if CTA is missing;
- no post if BrainCoach voice check fails.

Storage target:

- `production.executions` when approved later;
- `production.outcomes` after analytics collection.

## Phase 3: Approved Comment Reply Assistant, Human Approval Required

Goal:

Add controlled replies after MVP-1.5 proves comment visibility and classification quality.

Default behavior:

- read already classified inbox items;
- draft reply only for approved classes;
- send to Telegram for approval;
- operator approves reply or marks no reply.

Required workflow:

```text
TRG_ReadApprovedInboxItems
->
DB_ReadCommentInboxItems
->
AI_DraftReply
->
TG_SendReplyApproval
->
TG_WaitForApproveReject
->
IG_PostCommentReply
->
DB_RecordReplyAction
```

Rules:

- no automatic public replies in early MVP;
- sensitive comments are never auto-replied;
- questions about health, diagnosis, crisis, legal issues, or minors require manual handling;
- reply must be short, human, and not overclaim;
- one approved reply per comment unless manually reopened.

## Phase 4: Direct Message Assistant, Human Approval Required

Goal:

Make Direct messages visible and draft useful responses without pretending the system is a human.

Default behavior:

- receive or poll Direct messages when permissions allow;
- classify intent;
- draft response;
- send approval card to Telegram;
- operator approves reply.

DM classes:

- parent asks for help;
- wants consultation;
- asks price / format;
- gives case details;
- continues previous thread;
- spam;
- sensitive / risky.

Rules:

- no automatic DM replies at first;
- never request sensitive child data automatically;
- never diagnose;
- preserve conversation context in `bgs_orch`, not `bgs_core`;
- promote only validated human-reality facts through a later reviewed process.

## Phase 5: Direct Reply Execution, Human Approval Required

Required workflow:

```text
TRG_ReadApprovedDmDrafts
->
DB_ReadDmInboxItems
->
AI_DraftDmReply
->
TG_SendDmApproval
->
TG_WaitForApproveReject
->
IG_SendDirectReply
->
DB_RecordDmReplyAction
```

## Webhooks Setup Notes

For live webhook delivery:

- app may need to be published;
- callback URL can be an n8n production webhook URL;
- verify token is an arbitrary shared secret set in Meta and n8n;
- verify token should not be an email address;
- webhook signing should be validated before trusting events.

If app publication or review blocks Webhooks, use polling first:

- poll comments every 15-30 minutes;
- poll messages only if API access and permissions allow;
- keep analytics daily.

## Permission Gates

Analytics:

- Instagram Professional account;
- media read fields;
- insights access.

Comments:

- comment read access;
- comment management permission before posting replies.

Direct:

- messaging permission;
- webhook subscription or polling support;
- review may be required beyond tester-only use.

Publishing:

- content publishing permission shown by Meta for the selected Instagram API product;
- media container creation;
- media publish endpoint;
- app review may be required for non-tester production use.

## Recommended Build Order

1. Finish Analytics MVP-1 Telegram report.
2. Import and run analytics workflow with tester token.
3. Add Instagram Intelligence Inbox MVP-1.5.
4. Classify new comments into signal, question, interview candidate, spam, and risk.
5. Send Telegram comment cards.
6. Review first live analytics report and first inbox cards.
7. Reset Meta app secret and store credentials only in n8n.
8. Build Content Publishing Assistant with Telegram approval.
9. Add approved public replies.
10. Add Direct message intake and draft replies.
11. Consider fully automatic actions only after repeated manual approval data proves safety.

## Immediate Next Step

Use the tester account for Analytics MVP-1 and Instagram Intelligence Inbox MVP-1.5 first.

Expected first result:

- daily Telegram report arrives;
- comments are classified and visible without opening Instagram manually;
- content action recommendation is based on yesterday/today performance;
- no public account action is taken.

After the first live report and first comment cards, build the Content Publishing Assistant with Telegram approval.

## Non-Goals For MVP-2

Do not build:

- blind autoposting;
- automatic public replies;
- automatic Direct replies;
- mass messaging;
- scraping outside Meta APIs;
- writes to `bgs_core`;
- SQL migrations without approval.
