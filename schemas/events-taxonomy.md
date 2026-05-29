# Events Taxonomy

**Purpose**: Classify all system events for analytics, auditing, and trigger decisions.

All events logged to PostgreSQL `events` table.

---

## Event Categories

### 1. Classification Events
Triggered when system classifies incoming content.

```
classification.intent_detected
  metadata: {intent, confidence, keyword, model_used}
  trigger: Intake classifier runs
  action: Route to appropriate stage

classification.unclear
  metadata: {ambiguity_reason, alternative_intents}
  trigger: Confidence < 0.6
  action: Ask clarifying question

classification.keyword_assigned
  metadata: {keyword, segment, confidence}
  trigger: Successful classification
  action: Store in clients.current_keyword

classification.spam_detected
  metadata: {spam_score, pattern}
  trigger: Message looks like spam
  action: Flag for review, don't respond
```

---

### 2. Qualification Events
Triggered during qualification flow (q1, q2, q3).

```
qualification.started
  metadata: {stage: 'q1', timestamp}
  trigger: New user or re-engagement
  action: Send first qualification question

qualification.question_asked
  metadata: {stage, question_type, question_id}
  trigger: Question sent to user
  action: Set timeout for response

qualification.answer_received
  metadata: {stage, signal_strength, signals}
  trigger: User response received
  action: Extract signals, decide next stage

qualification.depth_increased
  metadata: {old_depth, new_depth, delta}
  trigger: Qualification score improved
  action: Continue to next stage

qualification.signal_pain_point
  metadata: {pain_point, intensity, keyword}
  trigger: Identified pain point in response
  action: Store for offer personalization

qualification.signal_emotional
  metadata: {emotional_state, intensity, triggers}
  trigger: Emotional signal detected
  action: Update clients.emotional_state

qualification.stage_completed
  metadata: {stage: 'q3', qualification_depth, signals_collected}
  trigger: All qualification questions answered
  action: Move to offer_transition

qualification.disqualified
  metadata: {reason, stage}
  trigger: User shows poor fit
  action: Move to sleeping, schedule followup
```

---

### 3. Offer Events
Triggered when offers are generated and sent.

```
offer.generated
  metadata: {offer_id, keyword, personalization_elements}
  trigger: Qualification complete → offer_transition stage
  action: Prepare offer message

offer.sent
  metadata: {offer_id, offer_text, cta_type}
  trigger: Offer message delivered via Telegram
  action: Log in offers_sent table, set response timer

offer.preview_shown
  metadata: {offer_id, preview_elements}
  trigger: User asks for details before deciding
  action: Send offer details

offer.accepted
  metadata: {offer_id, response_text, confidence}
  trigger: User indicates positive response
  action: Move to booking_intent stage

offer.objection_raised
  metadata: {offer_id, objection_type, objection_text}
  trigger: User raises concern ("but...", "price?")
  action: Handle objection, stay on offer stage

offer.rejected
  metadata: {offer_id, rejection_reason}
  trigger: User says no / not interested
  action: Move to sleeping, log for future offers

offer.expired
  metadata: {offer_id, days_shown}
  trigger: Offer unanswered for 7+ days
  action: Move to sleeping, schedule reactivation

offer.price_inquired
  metadata: {offer_id}
  trigger: User asks about price before deciding
  action: Provide pricing, ask if still interested
```

---

### 4. Stage Transition Events
Triggered when user moves between stages.

```
stage.transition
  metadata: {old_stage, new_stage, reason, transition_time}
  trigger: Any stage change
  action: Log for funnel analysis, audit trail

stage.progressed
  metadata: {from_stage, to_stage, signals}
  trigger: Forward transition (q1 → q2)
  action: Update clients.current_stage

stage.regressed
  metadata: {from_stage, to_stage, reason}
  trigger: Backward transition (q3 → q2 for simplification)
  action: Update clients.current_stage, adjust approach

stage.time_exceeded
  metadata: {stage, time_exceeded_by_days}
  trigger: User spent too long in stage
  action: Escalate, offer support, or move to sleeping
```

---

### 5. Engagement Events
Triggered by user interactions.

```
engagement.message_received
  metadata: {message_type: 'text|voice', length, model_used}
  trigger: User sends message
  action: Process, classify, route

engagement.message_read
  metadata: {message_id, read_at}
  trigger: User read bot's message (if available in Telegram API)
  action: Track engagement, adjust timing

engagement.link_clicked
  metadata: {link_id, link_text, target_url}
  trigger: User clicked embedded link
  action: Track intent, funnel stage

engagement.cta_clicked
  metadata: {cta_text, cta_id}
  trigger: User clicked CTA button
  action: Execute action (open form, book call, etc)

engagement.unsubscribe
  metadata: {reason_if_provided}
  trigger: User opts out
  action: Set current_stage = 'unsubscribed', hard stop

engagement.timeout
  metadata: {stage, expected_response_time}
  trigger: User doesn't respond within timeout
  action: Send reminder or move to sleeping
```

---

### 6. Reactivation Events
Triggered by inactive user re-engagement flow.

```
reactivation.started
  metadata: {days_inactive, trigger_type: 'scheduled|manual'}
  trigger: Scheduled job finds sleeping users
  action: Send reactivation message

reactivation.message_sent
  metadata: {followup_type, message_id}
  trigger: Reactivation message delivered
  action: Set response timer

reactivation.responded
  metadata: {response_text, interest_signal}
  trigger: Sleeping user responds
  action: Move to reactivated stage, route to q1

reactivation.re_engaged
  metadata: {previous_stage, new_path}
  trigger: User continues conversation
  action: Track as successful reactivation

reactivation.permanently_unsubscribed
  metadata: {reason}
  trigger: User says "stop" or "unsubscribe"
  action: Hard stop, honor preference
```

---

### 7. Error & System Events
Triggered by system issues.

```
system.error
  metadata: {error_type, error_message, stage}
  trigger: Workflow execution error
  action: Log, notify admin, retry if appropriate

system.timeout
  metadata: {component, timeout_seconds}
  trigger: External API timeout
  action: Retry, fall back, log

system.model_switched
  metadata: {attempted_model, fallback_model, reason}
  trigger: Primary model unavailable
  action: Use fallback (e.g., Gemini → GPT)

system.rate_limited
  metadata: {component, limit_type}
  trigger: Hit API rate limit
  action: Queue for later, notify

system.database_error
  metadata: {query_type, error}
  trigger: PostgreSQL error
  action: Retry, alert, fall back to cache

workflow.execution_started
  metadata: {workflow_id, workflow_name, trigger_type}
  trigger: n8n workflow starts
  action: Audit log

workflow.execution_completed
  metadata: {workflow_id, execution_time_ms, status}
  trigger: n8n workflow finishes
  action: Log performance, check success
```

---

## Event Analytics Queries

```sql
-- Funnel analysis
SELECT 
  'new_lead' as stage, COUNT(*) FROM events WHERE stage='new_lead'
UNION
SELECT 'q1', COUNT(*) FROM events WHERE stage='q1'
UNION
SELECT 'offer', COUNT(*) FROM events WHERE stage='offer'
UNION
SELECT 'booked', COUNT(*) FROM events WHERE stage='booked'
ORDER BY stage;

-- Conversion rate
SELECT 
  COUNT(CASE WHEN event_name='offer.sent' THEN 1 END) as offers_sent,
  COUNT(CASE WHEN event_name='offer.accepted' THEN 1 END) as offers_accepted,
  ROUND(100.0 * COUNT(CASE WHEN event_name='offer.accepted' THEN 1 END) / 
    NULLIF(COUNT(CASE WHEN event_name='offer.sent' THEN 1 END), 0), 2) as acceptance_rate
FROM events;

-- Most common pain points
SELECT 
  metadata->>'pain_point' as pain_point,
  COUNT(*) as frequency
FROM events
WHERE event_name='qualification.signal_pain_point'
GROUP BY metadata->>'pain_point'
ORDER BY frequency DESC
LIMIT 10;

-- Reactivation success
SELECT 
  COUNT(CASE WHEN event_name='reactivation.started' THEN 1 END) as sent,
  COUNT(CASE WHEN event_name='reactivation.responded' THEN 1 END) as responded,
  ROUND(100.0 * COUNT(CASE WHEN event_name='reactivation.responded' THEN 1 END) / 
    NULLIF(COUNT(CASE WHEN event_name='reactivation.started' THEN 1 END), 0), 2) as response_rate
FROM events
WHERE created_at > NOW() - INTERVAL '30 days';
```

---

## Real-Time Event Stream

Events can be published to:
- **Google Cloud Pub/Sub** for real-time dashboards
- **Google BigQuery** for analysis
- **Slack webhook** for alerts on critical events

