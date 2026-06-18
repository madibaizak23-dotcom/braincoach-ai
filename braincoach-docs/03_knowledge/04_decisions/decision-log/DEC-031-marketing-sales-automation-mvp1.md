# DEC-031 Marketing & Sales Automation MVP-1

Date: 2026-06-18

Status: Accepted

## Decision

BrainCoach proceeds to the first Marketing & Sales Automation MVP.

MVP-1 will not start with blind publishing or automatic replies.

It will start with intelligence and routing:

```text
content response
->
signal classification
->
noise filtering
->
payment trigger / lead candidate detection
->
Telegram operator decision
->
manual follow-up
->
sales discovery outcome
->
weekly correction
```

## Reason

The current constraint is Payment Trigger Discovery.

The first automation advantage should come from recognizing meaningful factors, separating them from noise, and routing them into content, offer, and sales decisions.

Publishing automation comes after the system can reliably capture and interpret response.

## Boundaries

MVP-1 does not allow:

* automatic public replies;
* automatic Direct messages;
* blind autoposting;
* mass messaging;
* writes to `bgs_core`;
* unapproved SQL migrations;
* diagnostic or medical claims.

## Success Criteria

MVP-1 is successful when:

* meaningful market signals are visible in Telegram;
* payment-trigger language is captured;
* interview and consultation candidates are not missed;
* follow-up outcomes are recorded;
* weekly content and offer planning use the captured signals.

## Related

* `braincoach-docs/07_automation/03_n8n/marketing_sales_automation_mvp1.md`
* `braincoach-docs/07_automation/03_n8n/instagram_intelligence_inbox_mvp1_5.md`
* `braincoach-docs/07_automation/03_n8n/instagram_social_automation_mvp2_plan.md`
* `braincoach-docs/05_operations/10_planning/offer_discovery_v1.md`
* `braincoach-docs/07_automation/06_governance/automation_objective_control_principle_v1.md`
