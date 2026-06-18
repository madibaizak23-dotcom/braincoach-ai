# DEC-033 Weekly Content Automation Build Order

Date: 2026-06-18

Status: Accepted

## Decision

BrainCoach will build Weekly Content Automation MVP-1 through a staged loop:

```text
Postgres production memory
->
n8n weekly package generation
->
Telegram weekly review
->
daily publishing monitor
->
execution / outcome capture
->
Tracker monitoring
->
weekly correction report
```

## Reason

The first automation should remove the largest production bottlenecks without losing human approval:

* weekly plan scattered across chats;
* reel scripting taking too long;
* story slides built one by one;
* weak channel adaptation for Threads / Facebook / Telegram;
* publishing timing not monitored;
* signals not feeding the next week reliably.

## Boundary

SQL remains draft-only until explicit migration approval.

MVP-1 does not approve autopublishing.

Generated packages go to Telegram for review and approval before execution.

## Related

* `braincoach-docs/07_automation/03_n8n/weekly_content_automation_mvp1_build_plan.md`
* `braincoach-docs/07_automation/04_postgres/draft_weekly_content_automation_mvp1.sql`
* `braincoach-docs/07_automation/production_os/03_content/weekly_content_generation_mvp1.md`
* `braincoach-docs/07_automation/03_n8n/marketing_sales_automation_mvp1.md`
