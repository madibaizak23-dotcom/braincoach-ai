# 🧠 BrainCoach AI

Conversational diagnostic ecosystem built on Google Cloud, n8n, PostgreSQL and semantic orchestration.

## 📋 Project Purpose

BrainCoach AI is a stateful, multi-stage conversational system designed to:
1. **Classify & Route** incoming queries using semantic understanding
2. **Qualify** leads through conversational depth progression
3. **Transition** qualified users to premium consultation
4. **Orchestrate** all state and progression through PostgreSQL + Google Sheets

## 🏗️ Core Stack

- **Cloud Infrastructure**: Google Cloud Run (serverless compute)
- **Database**: PostgreSQL Cloud SQL (source of truth)
- **Orchestration**: n8n (workflow engine)
- **Chat Interface**: Telegram Bot (user interaction)
- **Semantic Control**: Google Sheets (non-code orchestration)
- **LLM Models**:
  - **Gemini Flash**: Classification + routing (fast)
  - **GPT Nano**: Light qualification dialog (cheap)
  - **GPT-5.5**: Premium consultation transition (smart)

## 🔄 Workflow Philosophy

**The system is STATEFUL**

Conversation progression is controlled by:
- ✅ **PostgreSQL memory** - persistent user state
- ✅ **Google Sheets orchestration** - rules engine (NOT hardcoded prompts)
- ✅ **Stage transitions** - defined stages with rules

NOT hardcoded prompts or rigid decision trees.

---

## 🗄️ PostgreSQL Schema

### `clients` table
```sql
clients(
  id UUID PRIMARY KEY,
  telegram_user_id INTEGER UNIQUE,
  current_stage VARCHAR,           -- new_lead, q1, q2, q3, offer, booked...
  current_keyword VARCHAR,         -- user's primary keyword
  qualification_depth INTEGER,     -- 0-100 (how deep in qualification)
  consultation_interest FLOAT,     -- 0-1.0 (predicted interest in paid)
  emotional_state VARCHAR,         -- calm, excited, uncertain, frustrated
  interaction_type VARCHAR,        -- voice, text, forwarded
  emotional_intensity FLOAT,       -- 0-1.0 (intensity of emotion)
  created_at TIMESTAMP,
  updated_at TIMESTAMP
)
```

### `messages` table
```sql
messages(
  id UUID PRIMARY KEY,
  telegram_user_id INTEGER,       -- FK to clients
  role VARCHAR,                   -- 'user' or 'assistant'
  content TEXT,                   -- full message
  model_used VARCHAR,             -- which LLM processed this
  intent VARCHAR,                 -- classified intent
  created_at TIMESTAMP
)
```

### `events` table
```sql
events(
  id UUID PRIMARY KEY,
  telegram_user_id INTEGER,       -- FK to clients
  event_name VARCHAR,             -- stage_transition, offer_sent, etc
  stage VARCHAR,                  -- what stage triggered this
  keyword VARCHAR,                -- context keyword
  model_used VARCHAR,             -- Gemini/GPT-4/GPT-35
  created_at TIMESTAMP
)
```

---

## 📊 Google Sheets Structure

### Sheet 1: `keywords_master`
| keyword | segment | intent_hint | qualifying_question | offer_angle | priority |
|---------|---------|-------------|---------------------|------------|----------|
| ai_learning | professional | upskilling | What specific AI skills? | Structured AI course | 1 |
| wellness | consumer | health | Health goals? | Personalized wellness plan | 2 |

### Sheet 2: `qualification_flow`
| keyword | stage | question_type | question | emotional_goal | insight_text | transition_text | next_stage |
|---------|-------|---------------|----------|-----------------|--------------|-----------------|-----------|
| ai_learning | q1 | open | What's your AI experience? | Normalize | Understanding baseline | You sound curious | q2 |
| ai_learning | q2 | probe | Current challenges? | Validate | Identify pain | I hear you | q3 |

### Sheet 3: `offers_master`
| offer_id | keyword | offer_text | CTA | follow_up_days |
|----------|---------|-----------|-----|-----------------|
| offer_1 | ai_learning | "Join our AI Bootcamp" | Book now | [1,3,7] |
| offer_2 | wellness | "Start wellness journey" | Get started | [2,5] |

### Sheet 4: `followups_master`
| followup_type | stage | delay | message | trigger |
|---------------|-------|-------|---------|---------|
| soft_reeng | sleeping | 3 | Check in - "Still interested?" | 7_days_inactive |
| offer_follow | offer_sent | 1 | Gentle reminder | offer_not_answered |

---

## 🎯 Stage Map

User progression through defined stages:

```
new_lead
  ↓
q1 (first qualification question)
  ↓
q2 (depth probe)
  ↓
q3 (final qualification)
  ↓
offer_transition (show offer)
  ↓
offer (sent to user)
  ↓
booking_intent (user ready)
  ↓
booked (transaction complete)
  ↓
followup (post-booking engagement)
  ↓
sleeping (inactive 30+ days)
  ↓
reactivated (comeback flow)
```

---

## 🤖 Model Routing

**Gemini Flash** (fast classification)
- Incoming message → intent classification
- Route to right stage
- Fast, cheap

**GPT Nano** (qualification)
- Light dialogue in qualification stages (q1, q2, q3)
- Extract qualification signals
- Generate transition text

**GPT-5.5** (premium)
- Premium consultation conversation
- Complex reasoning for higher-value offers
- Used sparingly (cost control)

---

## 📂 Project Structure

```
braincoach-ai/
├── README.md                      ← You are here
├── .env                          ← Secrets (gitignored)
├── package.json
│
├── prompts/                      ← SYSTEM PROMPTS (not in code)
│   ├── intake_classifier.md      ← Gemini: classify intents
│   ├── qualification_engine.md   ← GPT Nano: depth dialogue
│   ├── offer_generator.md        ← Generate offers from context
│   ├── response_generator.md     ← Natural conversation generation
│   └── emotional_reflection.md   ← Analyze emotional state
│
├── workflows/                    ← n8n workflows (JSON)
│   ├── qualification-engine.json
│   ├── offer-engine.json
│   ├── reactivation-engine.json
│   └── voice-intake.json
│
├── schemas/                      ← Data structure docs
│   ├── postgres-schema.md        ← Full SQL schema
│   ├── google-sheets-structure.md
│   ├── stage-map.md
│   └── events-taxonomy.md
│
├── architecture/                 ← System design
│   ├── system-context.md
│   ├── conversational-memory-layer.md
│   ├── infrastructure-source-of-truth.md
│   └── secure-console-policy.md
│
├── docs/                         ← Operations
│   ├── deployment.md
│   ├── cloud-run.md
│   ├── secret-manager.md
│   └── workflow-guidelines.md
│
└── scripts/                      ← DevOps utilities
    ├── deploy-workflow.js
    ├── update-workflow.js
    └── backup-workflows.js
```

---

## 🚀 Quick Start

1. **Setup**
   ```bash
   cp .env.example .env
   # Fill all credentials
   ```

2. **Deploy to Google Cloud**
   ```bash
   gcloud run deploy braincoach-ai --source .
   ```

3. **Load workflows into n8n**
   ```bash
   node scripts/deploy-workflow.js all
   ```

4. **Activate in n8n UI**
   - Open each workflow
   - Click **Publish** (not Save!)

5. **Send first test message to bot**
   - Observe flow through PostgreSQL + Google Sheets

---

## 📞 Key Flows

### New User Flow
```
User sends message
  ↓ Gemini (classify intent)
  ↓ PostgreSQL (create client record)
  ↓ Google Sheets (read qualification_flow for stage)
  ↓ GPT Nano (generate q1)
  ↓ Send to user
  ↓ Wait for response
  ↓ Loop
```

### Offer Flow
```
User qualified (stage = q3_complete)
  ↓ Google Sheets (read offers_master for keyword)
  ↓ Generate offer message
  ↓ PostgreSQL (stage = offer_transition)
  ↓ Send offer
  ↓ Wait for response
  ↓ Track in events table
```

---

## 🔐 Security

- All secrets in Google Secret Manager (NOT in code)
- PostgreSQL accessed only through n8n with scoped credentials
- Google Sheets read-only for rules, write-only for logs
- Telegram Bot Token rotated monthly

---

*Last updated: 2026-05-28*
