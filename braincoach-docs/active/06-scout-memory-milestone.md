# Scout Memory Milestone v1

Date: 2026-06-02

## Status

Completed

## Objective

Build first working Scout memory loop.

## Implemented

### Scout Context Builder

Determines:

* known_signals
* next_objective

Based on:

* conversation_state
* qualification_signals

---

### Scout Agent

Responsibilities:

* ask one question
* gather missing information
* no consulting
* no recommendations
* no diagnosis

Prompt frozen as:

Scout v1

---

### Scout Extractor

Responsibilities:

Extract structured signals from user message.

Supported fields:

* trigger_event
* visible_problem
* goal
* stakes
* emotional_driver
* cost_of_inaction
* past_attempts
* investment_history
* desired_state
* readiness

---

### Parse Extractor JSON

Converts LLM JSON string into usable object.

---

### Merge Qualification Signals

Merges:

existing qualification_signals

with

new_signals

Ignoring null values.

---

### PostgreSQL Persistence

Table:

conversation_state

Field:

qualification_signals JSONB

Verified working.

Example:

{
"goal": "подготовка к ЕНТ"
}

---

### Verification

Test completed:

Input:

готовиться к ЕНТ

Result:

{
"goal": "подготовка к ЕНТ"
}

Successfully persisted into PostgreSQL.

---

## Current Workflow

Telegram Trigger

↓

Find Client

↓

Save User Message

↓

Scout Context Builder

↓

Scout Agent

↓

Scout Extractor

↓

Parse Extractor JSON

↓

Merge Qualification Signals

↓

Update Conversation State

↓

Save Assistant Message

↓

Telegram Send

---

## Next Milestone

Scout Intelligence Layer

Components:

* Depth Calculator
* Next Objective Selector
* Scout Complete Detection
* Architect Ready Transition
