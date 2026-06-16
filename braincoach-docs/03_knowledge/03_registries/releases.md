# BrainCoach Releases

## Release 1.0

Title:
BrainCoach Knowledge OS Foundation

Date:
2026-06-03

Status:
Released

Components:

* Canon v1.0
* Ontology v1.0
* Phenomenon Registry v1.0
* Season Registry v1.0
* BrainCoach Knowledge OS v1.0

Related:

* DEC-001
* DEC-002
* ADR-001

## Release 1.1

Title:
BrainCoach Summer Map MVP v1

Date:
2026-06-12

Status:
MVP Ready

Components:

* Telegram Summer Map interview flow
* n8n workflow export: `braincoach-docs/07_automation/03_n8n/BrainCoach Summer Map v1 MVP.json`
* BGS Core persistence through existing tables
* Summer GPS offer transition

Scope:

* MVP launch for the first 150 Brigantina families
* Completion Rate tracking
* Share Rate tracking
* GPS Click Rate tracking
* Application conversion handoff to BrainCoach GPS

Related:

* `braincoach-docs/05_operations/12_reviews/summer_map_mvp_v1_test_report.md`
* `braincoach-docs/05_operations/13_runtime/summer_map_mvp_v1_state.md`

## Release 1.1.1

Title:
Summer Map Interview to GPS Conversion Optimization

Date:
2026-06-16

Status:
MVP Ready

Reason:

20 completed interviews produced 0 observed transitions into BrainCoach GPS.

Components:

* Five-question Summer Map interview
* Behavioural Q4 replacing abstract ownership question
* Future-projection Q5
* Short completion message positioning GPS as ongoing observation
* Single visible GPS CTA
* `gps_cta_shown` and `gps_cta_clicked` funnel events

Related:

* `braincoach-docs/07_automation/03_n8n/BrainCoach Summer Map v1 MVP.json`
* `braincoach-docs/05_operations/13_runtime/summer_map_mvp_v1_state.md`
