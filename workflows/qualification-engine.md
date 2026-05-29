# Qualification Engine v3 (n8n LangChain OpenAI)

## Overview

Name: qualification-engine-v3

Purpose: process Telegram messages through BrainCoach AI's frozen production qualification architecture using n8n LangChain OpenAI nodes. This workflow receives Telegram input, loads client state from PostgreSQL, reads Google Sheets configuration, performs classification and emotional analysis with GPT-5.4-NANO, generates the next qualification question with GPT-5.4-MINI, updates PostgreSQL state, logs an event, and responds in Telegram.

Scope: Telegram, PostgreSQL, Google Sheets, Intake Classifier, Emotional Reflection, Qualification Engine.

Excluded: Offer Generator, Booking Engine, Calendar, Followups, Voice, Reactivation.

---

## Key Differences from v2

- **OpenAI Node Type**: Uses `@n8n/n8n-nodes-langchain.openAi` (LangChain) instead of `n8n-nodes-base.openAi` (legacy)
- **typeVersion**: 1.8 (updated from 1)
- **Model Parameter**: Uses `modelId` field for model selection
  - Intake Classifier: `modelId: "gpt-5.4-nano"`
  - Emotional Reflection: `modelId: "gpt-5.4-nano"`
  - Qualification Engine: `modelId: "gpt-5.4-mini"`
- **All workflow logic remains unchanged**

---

## Credentials Used

- Telegram API — existing Telegram bot credentials
- PostgreSQL — existing Postgres connection for BrainCoach DB
- Google Sheets — existing Google Sheets OAuth credential
- OpenAI — existing OpenAI credential for GPT-5.4-NANO and GPT-5.4-MINI

---

## Node-by-Node Flow

1. **Telegram Trigger**
   - Receives incoming Telegram messages.
   - Expected fields: `message.from.id`, `message.text`, `message.chat.id`.

2. **Postgres - Find Client**
   - Queries `clients` by `telegram_user_id`.
   - If found, returns the client row.

3. **IF - Client Exists?**
   - Checks whether a client row exists.
   - If true, continues to Google Sheets reads.
   - If false, creates a new client.

4. **Postgres - Create Client**
   - Inserts a new `clients` row with `current_stage = 'new_lead'` and `total_messages = 0`.
   - Returns the created client.

5. **GoogleSheets - keywords_master**
   - Loads `keywords_master` data from the fixed spreadsheet ID.
   - Used by the intake classifier.

6. **GoogleSheets - qualification_flow**
   - Loads `qualification_flow` data from the fixed spreadsheet ID.
   - Used by the qualification engine.

7. **GoogleSheets - memory_signals**
   - Loads `memory_signals` data from the fixed spreadsheet ID.
   - Used by emotional reflection.

8. **OpenAI - Intake Classifier**
   - Type: `@n8n/n8n-nodes-langchain.openAi` v1.8
   - Model: GPT-5.4-NANO
   - Classifies the incoming message using `keywords_master` and client state.
   - Returns structured JSON only.
   - Outputs: `keyword`, `segment`, `consultation_type`, `intent`, `emotional_driver`, `emotional_state`, `emotional_intensity`, `interaction_type`, `qualification_readiness`, `memory_candidate`, `memory_items`, `confidence`, `next_route`.

9. **OpenAI - Emotional Reflection**
   - Type: `@n8n/n8n-nodes-langchain.openAi` v1.8
   - Model: GPT-5.4-NANO
   - Produces emotional diagnosis from the message and `memory_signals`.
   - Returns JSON only.
   - Outputs: `emotional_state`, `emotional_intensity`, `behavioral_signal`, `tone_adjustment`, `pace_adjustment`, `state_change`, `confidence`.

10. **OpenAI - Qualification Engine**
    - Type: `@n8n/n8n-nodes-langchain.openAi` v1.8
    - Model: GPT-5.4-MINI
    - Reads classifier output, emotional reflection output, `qualification_flow`, and client state.
    - Returns JSON only.
    - Outputs: `qualification_depth`, `pain_detected`, `pain_summary`, `emotional_driver_confirmed`, `desired_outcome`, `consultation_readiness`, `offer_eligibility_signal`, `next_question`, `next_stage`, `memory_updates`, `confidence`.

11. **Postgres - Update Client**
    - Updates the `clients` row with:
      * `current_keyword`
      * `qualification_depth`
      * `emotional_state`
      * `emotional_intensity`
      * `interaction_type`
      * `current_stage`
      * increments `total_messages`
    - Keeps `current_stage` unchanged if `next_stage` is empty.

12. **Postgres - Insert Event**
    - Inserts an `events` row with:
      * `telegram_user_id`
      * `event_name = 'stage_entered'`
      * `event_category = 'qualification'`
      * `old_stage`
      * `new_stage`
      * `keyword`
      * `model_used`
      * `metadata` JSONB containing classifier, emotional, and qualification outputs

13. **Telegram - Send Question**
    - Sends the generated `next_question` text back to the user.

---

## Expected Inputs

- `message.from.id` — Telegram user id
- `message.text` — user text
- `message.chat.id` — Telegram chat id

## Expected Outputs

- Telegram message with the next qualification question.
- Updated `clients` row in PostgreSQL.
- Logged `events` record in PostgreSQL.

## PostgreSQL Updates

The workflow updates the following fields in `clients`:

- `current_keyword`
- `qualification_depth`
- `emotional_state`
- `emotional_intensity`
- `interaction_type`
- `current_stage`
- `total_messages`

It inserts an `events` record with `event_name = 'stage_entered'` and a JSON metadata payload.

## Google Sheets Dependencies

This workflow reads from spreadsheet ID:

`1r7n5E1eU5IKK6RPkK4HHsLxorFpgs66GZQwYhI0fL_I`

Required sheets:

- `keywords_master`
- `qualification_flow`
- `memory_signals`

## Import Instructions

1. Open your n8n instance
2. Select **Workflows** → **Import from URL** or **Import from JSON**
3. Upload or paste `qualification-engine-v3.json`
4. Verify all credentials are properly configured (Telegram, PostgreSQL, Google Sheets, OpenAI)
5. Test trigger by sending a Telegram message to your bot
6. Publish when ready for production

## Notes

- This workflow uses n8n LangChain OpenAI nodes for compatibility with current n8n 2.0+ architecture.
- All three AI nodes (Classifier, Emotional Reflection, Qualification Engine) use LangChain OpenAI with appropriate model IDs.
- Booking and offer logic are intentionally excluded.
- The workflow automatically creates new clients if they don't exist.
