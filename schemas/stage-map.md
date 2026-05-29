# User Stage Map

**Purpose**: Define all possible stages in user journey and transition rules.

---

## Stage Definitions

| Stage | Name | Entry Condition | Goal | Duration | Next Stages | Exit Condition |
|-------|------|-----------------|------|----------|------------|-----------------|
| **new_lead** | New Lead | First message received | Initial classification | 1 message | q1, unclear | Classification complete |
| **q1** | First Qualification | Classification done | Baseline + validation | 1-2 messages | q2 | Answer received + emotional baseline set |
| **q2** | Depth Probe | q1 answer received | Identify pain points | 2-4 messages | q3, offer_transition | Pain points identified |
| **q3** | Final Qualification | q2 answer received | Assess commitment + fit | 1-2 messages | offer_transition | Commitment level assessed |
| **offer_transition** | Offer Intro | q3 complete | Warm offer introduction | 1 message | offer, rejected | User shown offer |
| **offer** | Active Offer | Offer sent | Wait for response | 3-7 days | booking_intent, rejected, sleeping | User responds |
| **booking_intent** | Intent to Book | User asks how to proceed | Lower friction for booking | 1 day | booked | Booking completed or declined |
| **booked** | Booking Complete | Payment/subscription received | Post-booking engagement | ongoing | followup, sleeping | Subscription active |
| **followup** | Post-Booking | User booked | Maximize engagement | 7-14 days | sleeping, reactivated | Transition to passive engagement |
| **sleeping** | Inactive | 30+ days without contact | Await re-engagement trigger | unlimited | reactivated | Responds to reactivation message |
| **reactivated** | Re-engaged | Response to reactivation flow | Bring user back | 2-4 messages | q1, offer, booked | Clear intent or exit |
| **unsubscribed** | Opt-out | User requests removal | Respect preference | permanent | (none) | Hard stop |

---

## Stage Transition Flow Diagram

```
new_lead (all users start here)
    │
    ├─→ [classify intent]
    │
    ├─→ unclear (ask clarifying Q)
    │   └─→ new_lead (retry classification)
    │
    └─→ q1 (first qualification Q)
        ├─ [no response, 24h]
        │  └─→ sleeping (send reminder)
        │
        └─→ [response received]
            ├─ [emotional_state = resistant]
            │  └─→ q1 (soften approach, re-ask)
            │
            └─→ q2 (probe deeper)
                ├─ [still uncertain]
                │  └─→ q1 (back-track, simplify)
                │
                ├─ [high qualification signals]
                │  └─→ offer_transition (skip q3, move fast)
                │
                └─→ q3 (final qualification)
                    ├─ [low signals]
                    │  └─→ sleeping (nurture later)
                    │
                    └─→ offer_transition
                        └─→ offer (show offer)
                            ├─ [accept]
                            │  └─→ booking_intent
                            │      └─→ booked
                            │          └─→ followup
                            │              └─→ sleeping (if inactive)
                            │
                            ├─ [ask questions]
                            │  └─→ offer (clarify, stay on stage)
                            │
                            └─ [reject / no response, 7 days]
                               └─→ sleeping (nurture track)
```

---

## Transition Rules (PostgreSQL + Google Sheets)

### new_lead → q1
```
Condition: First message classified + intent determined
Action: Load q1 from qualification_flow sheet
Tone: Warm, validating
Rule: ALWAYS qualify, never assume they're not interested
```

### q1 → q2
```
Condition: User answers q1 + qualification_signals > threshold
Action: Store signals, update qualification_depth
Tone: Acknowledge, build on their answer
Rule: Reference what they said specifically
```

### q2 → q3
```
Condition: User answers q2 + pain points identified
Action: Extract pain points to PostgreSQL
Tone: Empathetic, ready to help
Rule: If high qualification_depth, consider skipping to offer_transition
```

### q3 → offer_transition
```
Condition: User answers q3 + consultation_interest > 0.7
Action: Load offer from offers_master
Tone: Celebratory, permission-giving
Rule: "Based on everything you've shared..." personalize
```

### offer_transition → offer
```
Condition: Offer message sent
Action: Log in offers_sent table
Tone: Consultative, not salesy
Rule: Soft CTA only (no pushy button)
```

### offer → booking_intent
```
Condition: User shows positive signal (asks "how", "yes", etc)
Action: Provide booking link + remove friction
Tone: Helpful, facilitate flow
Rule: ONE step at a time
```

### booking_intent → booked
```
Condition: Payment received OR subscription active
Action: Update clients.current_stage = 'booked'
Tone: Congratulatory
Rule: Begin onboarding sequence
```

### booked → followup
```
Condition: 3-7 days post-booking
Action: Check in, ask for feedback
Tone: Genuine interest in their experience
Rule: Soft touch, not pushy
```

### followup → sleeping
```
Condition: 30+ days no interaction
Action: Move to sleeping stage automatically
Tone: N/A (system action)
Rule: Set up reactivation trigger
```

### sleeping → reactivated
```
Condition: User responds to reactivation message
Action: Route back to q1 or continuation based on context
Tone: Warm "welcome back"
Rule: Lower barrier for re-engagement than first contact
```

---

## Stage Metadata (stored in PostgreSQL)

Each stage tracks:
- `stage_entry_time`: When user entered this stage
- `stage_duration`: How long they've been here
- `messages_in_stage`: Number of exchanges
- `qualification_depth`: 0-100 score within stage
- `stage_signals`: Extracted data points
- `next_stage_readiness`: Probability they'll move to next stage

---

## Timing Rules

| Stage | Min Time | Max Time | Auto-Transition |
|-------|----------|----------|-----------------|
| new_lead | 1 min | 1 day | No |
| q1 | 5 min | 3 days | If no response → sleeping |
| q2 | 5 min | 3 days | If no response → sleeping |
| q3 | 5 min | 3 days | If no response → sleeping |
| offer_transition | 1 min | 1 day | No |
| offer | 30 min | 7 days | If no response → sleeping |
| booking_intent | 5 min | 1 day | No |
| booked | 1 day | ∞ | No (until 30d inactive) |
| followup | 1 day | 14 days | Auto → sleeping if 14d+ |
| sleeping | 1 day | ∞ | No (until reactivation) |

---

## Backward Transitions (Edge Cases)

Some transitions go backward if needed:

```
q3 + resistant_signal → q2 (simplify, re-probe)
q2 + overwhelmed → q1 (back up, reset)
offer_transition + objection → q3 (handle objection)
offer + objection → offer_transition (re-frame)
sleeping + reactivation_response → q1 (treat as new engagement)
```

These are handled by emotional_reflection.md prompt and n8n IF logic.

