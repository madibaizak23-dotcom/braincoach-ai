# Walkthrough - BrainCoach AI Workflow Integrations

This walkthrough documents the completed implementations of **session resumption**, **consent tracking**, and the automated **Timeout Watchdog (WF-06)**.

---

## 🛠️ Changes Implemented

### 1. Database Schema Updates (`postgres-schema.md`)
We successfully extended our PostgreSQL database model to support re-engagement tracking and micro-stage continuity:
- `clients.allow_reminders` (BOOLEAN): Consent status.
- `clients.last_nudge_sent_at` (TIMESTAMP): Anti-spam guard timestamp.
- `conversation_state.sub_stage` (VARCHAR): Granular micro-stage inside the funnel.
- `conversation_state.pattern_type` (VARCHAR): Psychological pattern type tracking.

### 2. WF-01: INTAKE Session Resumption
We completely refactored the entry workflow to handle new and existing clients cleanly:
- Replaced separate Find and Create nodes with an atomic **Postgres UPSERT & Get State** node using CTE.
- Added **IF - New Client?** branching node based on the retrieved `sub_stage` value.
- Re-routed existing sessions to bypass keyword-classification, moving directly to **GoogleSheets - qualification_flow** while preserving active context.

### 3. WF-06: TIMEOUT WATCHDOG Re-engagement
We designed and created a fully functioning watchdog workflow (**reactivation-engine.json**):
- **Schedule Trigger (Cron):** Scheduled hourly checking.
- **Postgres Filter:** Queries active qualification clients silent for >24 hours with `allow_reminders = true`.
- **Google Sheets Load:** Loads re-engagement templates from `followups_master`.
- **Gemini Flash Customizer:** Dynamically personalizes the re-engagement message to sound warm, highly professional, and fully supportive (no guilt-tripping).
- **Telegram dispatcher & PG update:** Sends nudge and stamps `last_nudge_sent_at` to lock repeated messaging.

---

## 📊 Verification Outcomes

- **UPSERT Logic:** Verified correct generation of client state and recovery of `sub_stage` context on existing client message.
- **Resumption Routing:** Bypassed keyword loading for returning clients; successfully merged back into the main qualification track.
- **Watchdog Query:** Tested postgres date range criteria; strictly selects users stuck for exactly > 24 hours since `last_message_at`.
