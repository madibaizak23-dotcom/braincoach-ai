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
* offer_rules
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
transition_condition
fallback_stage
next_stage
```

Purpose:

Controls multi-step qualification progression.

The workflow should always read this sheet instead of hardcoding qualification logic.

`transition_condition` defines rule-based requirements for moving to the next stage.
`fallback_stage` defines the safe path when the user response does not match the expected qualification branch.

---

# Sheet: offers_master

Purpose:

Consultation offers and conversion logic.

Fields:

```text
offer_id
keyword
offer_text
offer_type
priority
CTA
```

Purpose:

Maps qualification topics to consultation offers.

`offer_type` supports productized offer categories.
`priority` supports offer selection when multiple matches exist.

---

# Sheet: offer_rules

Purpose:

Offer eligibility rules for the qualification and offer generation engines.

Fields:

```text
rule_id
keyword
min_depth
min_readiness
required_signal
offer_type
priority
```

Purpose:

Defines the conditions under which a given offer should be considered or presented.

`required_signal` may reference emotional or behavioral signals from `memory_signals`.
`min_depth` and `min_readiness` are evaluated at runtime by the qualification workflow.

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
