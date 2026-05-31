# BrainCoach AI Project Journal

## 2026-05-31

Architecture Foundation Completed

Artifacts created:

- tooling-playbook.md
- customer-intelligence-platform-v1.md
- rag-architecture-v1.md
- n8n-v2-deployment-plan.md

Key decisions:

- PostgreSQL remains operational source of truth
- n8n-prod remains stable legacy production
- n8n-v2 becomes next-generation platform
- BrainCoach architecture organized around:
  Signals → Memory → Understanding → Prediction → Influence → Action

Next milestone:

Deploy n8n-v2 and begin Memory Engine design.

## 2026-05-30

### Milestone

BrainCoach Intake Engine v1 Stable

### What was completed

* Rebuilt Qualification Engine architecture
* Added JSON validation layer
* Fixed OpenAI output parsing
* Fixed Telegram response routing
* Implemented PostgreSQL client updates
* Implemented event logging
* Created workflow export
* Validated workflow import into fresh n8n workflow
* Created historical archive of Cursor-generated v3 workflow

### Key Decisions

* Google Sheets remains behavioral control layer
* Qualification Engine uses Intake + Emotional outputs
* Validation required before state updates
* Events stored separately from client state
* Stable workflow exports stored in reference-node-exports

### Lessons Learned

* n8n 1.93 requires Merge synchronization before multi-branch validation
* OpenAI node output format differs from original assumptions
* Validation layer dramatically improves reliability
* Export + import verification should be mandatory before releases

### Production Status

Intake Engine v1 Stable

Commit:
920a0e6

Tag:
intake-engine-v1-stable

Status:
Production Stable

### Next Milestone

Memory Engine v1

Goal:

Persist memory_updates into long-term client memory and use memory in future qualification flows.
