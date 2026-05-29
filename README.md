# 🧠 BrainCoach AI

AI-powered conversational diagnostic ecosystem built on Google Cloud, n8n, PostgreSQL and semantic orchestration.

---

# 📋 Project Purpose

BrainCoach AI is a stateful, multi-stage conversational system designed to:

1. Classify and route incoming user messages
2. Qualify leads through guided conversational progression
3. Diagnose cognitive and educational bottlenecks
4. Transition qualified users into premium consultations
5. Maintain long-term conversational memory
6. Automate nurturing and reactivation workflows

BrainCoach AI is NOT a generic chatbot.

BrainCoach AI is a stateful conversational qualification and diagnostic system.

---

# 🏗 Core Stack

## Infrastructure

* Google Cloud Platform
* Cloud Run
* Cloud SQL PostgreSQL
* Secret Manager
* Cloud Storage

## Orchestration

* n8n

## User Interface

* Telegram Bot

## Semantic Control Layer

* Google Sheets

## AI Models

### Gemini Flash

Purpose:

* classification
* routing
* keyword detection
* intent detection
* emotional tagging

### GPT Nano

Purpose:

* qualification dialogue
* emotional reflection
* guided questioning
* conversation progression

### Premium Models

GPT-5.5 / Gemini Pro

Purpose:

* consultation transition
* premium insights
* offer generation
* conversion conversations

---

# 🔄 Workflow Philosophy

The system is STATEFUL.

Conversation progression is controlled by:

* PostgreSQL memory
* Google Sheets orchestration
* stage transitions
* event tracking

NOT hardcoded prompts.

The AI should always operate through memory, state and orchestration.

---

# 🧠 Conversational Philosophy

The system should:

* surface cognitive pain
* deepen emotional relevance
* create awareness
* reveal hidden mechanisms
* guide qualification
* naturally transition toward diagnostics

Never aggressively sell.

The consultation should feel:

* logical
* premium
* expert-driven
* psychologically safe
* insight-driven

---

# 🧠 Conversational Memory Layer

BrainCoach AI operates as a conversational memory system.

Every interaction updates user state.

The system must remember:

* current stage
* qualification progress
* emotional state
* interaction history
* consultation readiness

Purpose:

Prevent repetitive conversations and create progressive qualification.

---

# 🗄 PostgreSQL Memory Layer

Database Role:

Source of truth for user state and conversational memory.

---

## clients

Stores:

```sql
telegram_user_id
username
first_name

current_stage
current_keyword

qualification_depth

consultation_interest

emotional_state

interaction_type

emotional_intensity

first_seen_at
last_interaction_at

created_at
updated_at
```

Purpose:

Conversation state management.

---

## messages

Stores:

```sql
message_id
telegram_user_id

role

content

created_at
```

Purpose:

Conversation history.

---

## events

Stores:

```sql
event_id

event_name

stage

keyword

model_used

created_at
```

Purpose:

Analytics and qualification tracking.

---

## memory_facts

Stores:

```sql
signal_type
meaning
severity
recommended_action
```

Purpose:

Long-term personalization.

---

## offers_and_outcomes

Stores:

```sql
offers
responses
outcomes
conversion signals
```

Purpose:

Offer analytics.

---

# ⚡ Event Driven Architecture

BrainCoach AI is event-driven.

Typical events:

```text
message_received

qualification_started

qualification_progress

pain_detected

offer_transition

offer_shown

booking_interest

consultation_requested

followup_sent

reactivation_triggered
```

Events are persisted inside PostgreSQL.

---

# 📊 Google Sheets Semantic Layer

Google Sheets acts as:

Semantic Control Center

Purpose:

Control conversational logic without modifying workflows.

---

## keywords_master

Fields:

```text
keyword
segment
intent_hint
qualifying_question
offer_angle
priority
```

Purpose:

Incoming intent classification.

---

## qualification_flow

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

Multi-step qualification progression.

---

## offers_master

Fields:

```text
offer_id
keyword
offer_text
CTA
```

Purpose:

Consultation offers.

---

## followups_master

Fields:

```text
followup_type
stage
delay
message
trigger
```

Purpose:

Lead nurturing and reactivation.

---

## prompts_master

Fields:

```text
prompt_type
system_prompt
tone
usage_context
```

Purpose:

Central AI behavior control.

---

## memory_signals

Fields:

```text
signal_type
meaning
severity
recommended_action
```

Purpose:

Behavioral intelligence layer.

---

# 🎯 Stage Map

Current planned progression:

```text
new_lead

q1

q2

q3

offer_transition

offer

booking_intent

booked

followup

sleeping

reactivated
```

The workflow should always route users according to current_stage.

---

# 🎤 Voice Architecture

Supported interaction types:

```text
text

voice

mixed
```

Voice workflow:

```text
Telegram Voice Message
↓
Download Audio
↓
Speech To Text
↓
Emotion Detection
↓
Emotional Intensity Scoring
↓
Qualification Flow
```

Voice users often demonstrate higher emotional engagement and should be tracked separately.

---

# 🤖 Model Routing

## Gemini Flash

Responsibilities:

* keyword classification
* routing
* stage detection
* emotional tagging

---

## GPT Nano

Responsibilities:

* qualification dialogue
* emotional reflection
* insight generation
* conversational progression

---

## GPT-5.5 / Gemini Pro

Responsibilities:

* consultation transition
* premium reasoning
* offer generation
* objection handling

Use only when higher reasoning quality is required.

---

# 📂 Project Structure

```text
braincoach-ai/

README.md

prompts/
├── intake_classifier.md
├── qualification_engine.md
├── offer_generator.md
├── response_generator.md
└── emotional_reflection.md

workflows/
├── qualification-engine.json
├── offer-engine.json
├── reactivation-engine.json
└── voice-intake.json

schemas/
├── postgres-schema.md
├── google-sheets-structure.md
├── stage-map.md
└── events-taxonomy.md

architecture/
├── system-context.md
├── conversational-memory-layer.md
├── infrastructure-source-of-truth.md
└── secure-console-policy.md

docs/
├── deployment.md
├── cloud-run.md
├── secret-manager.md
└── workflow-guidelines.md

scripts/
├── deploy-workflow.js
├── update-workflow.js
└── backup-workflows.js
```

---

# 🏛 Source of Truth Hierarchy

Priority order:

## 1. PostgreSQL

Source of truth for:

* user state
* memory
* progression
* events

---

## 2. Google Sheets

Source of truth for:

* qualification logic
* offers
* prompts
* followups

---

## 3. n8n

Source of truth for:

* orchestration
* execution flow
* integrations

---

## 4. AI Models

Purpose:

Generation only.

Models do not own business logic.

Business logic belongs to PostgreSQL and Google Sheets.

---

# 🔐 Security Principles

* All secrets live in Google Secret Manager
* No secrets inside workflows
* No secrets inside source code
* PostgreSQL access through managed credentials
* HTTPS only
* Least privilege access

---

# 🚀 Long-Term Vision

BrainCoach AI evolves into:

* AI CRM
* conversational intelligence platform
* cognitive diagnostics system
* educational performance ecosystem
* consultation qualification engine
* behavioral analytics system
* AI-native operating system

The goal is not to build a chatbot.

The goal is to build an intelligent conversational ecosystem.
