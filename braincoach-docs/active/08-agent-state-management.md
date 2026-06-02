# BrainCoach Agent State Management

## Discovery

During Architect v1 testing, a structural issue was identified.

Current flow:

User
↓
Scout
↓
Scout Complete
↓
Architect
↓
User Response
↓
Scout

Example:

Architect:
"По каким предметам не получается добрать баллы?"

User:
"Физика и математика"

Current behavior:

Message returns to Scout.

Expected behavior:

Message should return to Architect.

---

## Root Cause

The system currently has no concept of active conversation owner.

Every incoming message is routed through Scout regardless of which agent asked the previous question.

---

## Required State

conversation_state.active_agent

Possible values:

* scout
* architect
* readiness

---

## Ownership Rules

Default:

active_agent = scout

When Scout Complete Detector returns TRUE:

active_agent = architect

All subsequent messages are routed to Architect.

Architect remains owner until:

* architect_complete = true
  or
* readiness_handoff = true

Then ownership transfers again.

---

## Future Architecture

Telegram Trigger
↓
Agent Router
↓
IF active_agent = scout
↓
Scout Workflow

IF active_agent = architect
↓
Architect Workflow

IF active_agent = readiness
↓
Readiness Workflow

---

## Status

Identified during Architect v1 testing

Not implemented

Priority: High

Target Milestone:

Agent Ownership Layer v1
