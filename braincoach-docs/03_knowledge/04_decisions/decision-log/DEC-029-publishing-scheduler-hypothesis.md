# DEC-029 Publishing Scheduler Hypothesis

Date: 2026-06-18

Status: Accepted

## Decision

BrainCoach adopts Publishing Scheduler Hypothesis as the planning layer for channel timing.

External advice about best posting times may be used only as a candidate hypothesis.

The scheduler must compare planned windows, actual publish times, and production outcomes before adapting.

Publishing automation must start with reminders, approval cards, execution recording, and analytics feedback before any autopublishing.

## Reason

BrainCoach is moving from single-channel posting to a multi-channel content operating system across Instagram, Facebook, Threads, TikTok, YouTube Shorts, and Telegram.

Manual planning cannot reliably preserve:

* weekly theme;
* channel adaptation;
* publishing windows;
* human approval;
* timing adherence;
* analytics feedback;
* scheduler learning.

The system needs a scheduling layer that treats publishing time as a hypothesis and learns from BrainCoach-specific outcomes.

## Rules

1. Generic "best time to post" advice is research input, not an operating law.
2. Each content unit should have planned window, actual publish time, and outcome metrics.
3. Scheduler adaptation requires repeated evidence, not one outlier.
4. Automation begins with reminders and approval cards.
5. Autopublishing remains blocked until explicit approval and safety review.
6. Weekly Content Plan is treated as a weekly hypothesis test.
7. The next week is built as a correction of the previous week's data.
8. Each correction should change only one or two parameters at a time: time, hook, format, CTA, topic angle, or visual frame.
9. A result repeated for 2 weeks becomes a candidate working rule.
10. BrainCoach feed should function as a research serial, not as disconnected content.

## Related

* `braincoach-docs/07_automation/production_os/04_execution/publishing_scheduler_hypothesis_v1.md`
* `braincoach-docs/05_operations/14_workflows/weekly_sprint_v1.md`
* `braincoach-docs/07_automation/03_n8n/instagram_analytics_mvp1.md`
* `braincoach-docs/07_automation/03_n8n/instagram_social_automation_mvp2_plan.md`
* `braincoach-docs/07_automation/production_os/04_execution/production_execution.md`
