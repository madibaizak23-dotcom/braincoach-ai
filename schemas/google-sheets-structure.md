# Google Sheets Structure

Version: 1.0

Last Updated: 2026-05-29

Purpose:

Google Sheets is the semantic control center of BrainCoach AI.

Google Sheets owns:

* qualification logic
* semantic routing
* offers
* prompts
* followups
* behavioral signals

Google Sheets does NOT own:

* user state
* memory
* events

Those belong to PostgreSQL.

---

# Spreadsheet Overview

Current Sheets:

* keywords_master
* qualification_flow
* offers_master
* followups_master
* prompts_master
* memory_signals

---

# Sheet: keywords_master

Purpose:

Semantic classification and routing layer.

Used by:

* intake classifier
* qualification engine
* offer engine

Fields:

```text
keyword
segment
intent_hint
emotional_driver
offer_angle
consultation_type
priority
```

Purpose of fields:

keyword
→ primary trigger word

segment
→ classification category

intent_hint
→ expected user problem

emotional_driver
→ dominant emotional motivation behind the problem

offer_angle
→ consultation positioning angle

consultation_type
→ recommended diagnostic format

priority
→ routing priority

---

# Sheet: qualification_flow

Purpose:

State machine for qualification conversations.

Fields:

```text
keyword
stage
question_type
question
emotional_goal
insight_text
transition_text
next_stage
```

Purpose:

Controls multi-step qualification progression.

The workflow should always read this sheet instead of hardcoding qualification logic.

---

# Sheet: offers_master

Purpose:

Consultation offers and conversion logic.

Fields:

```text
offer_id
keyword
offer_text
CTA
```

Purpose:

Maps qualification topics to consultation offers.

---

# Sheet: followups_master

Purpose:

Lead nurturing and reactivation.

Fields:

```text
followup_type
stage
delay
message
trigger
```

Purpose:

Controls automated follow-up sequences.

---

# Sheet: prompts_master

Purpose:

Central prompt registry.

Fields:

```text
prompt_type
system_prompt
```

Purpose:

Store prompt templates outside workflow code.

Examples:

* intake_classifier
* response_generator
* offer_generator
* followup_generator

---

# Sheet: memory_signals

Purpose:

Behavioral intelligence layer.

Fields:

```text
signal_type
meaning
severity
recommended_action
```

Purpose:

Translate behavioral observations into structured signals.

Examples:

* procrastination
* overwhelm
* anxiety
* confusion
* high motivation

---

# Architecture Rule

Google Sheets owns:

* qualification logic
* prompts
* offers
* followups
* behavioral signals

PostgreSQL owns:

* state
* memory
* events

n8n owns:

* orchestration

AI models own:

* generation only

Business logic must never be hardcoded inside prompts.
