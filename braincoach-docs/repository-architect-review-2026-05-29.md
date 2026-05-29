# Repository Architect Review 2026-05-29

## 1. Executive Summary

This review documents the architecture alignment pass completed on 2026-05-29 for BrainCoach AI. The work preserved existing BrainCoach-specific qualification logic while enforcing clear separation of responsibilities across Google Sheets, PostgreSQL, n8n, and LLMs. Key outcomes include formalizing offer rules in Google Sheets, adding booking lifecycle documentation, and ensuring the intake classifier no longer owns stage progression.

## 2. Files Modified

- `README.md`
- `braincoach-ai/braincoach-docs/architecture-review.md`
- `braincoach-ai/schemas/postgres-schema.md`
- `braincoach-ai/schemas/google-sheets-structure.md`
- `braincoach-ai/prompts/intake/intake_classifier.md`
- `braincoach-ai/prompts/qualification/qualification_engine.md`
- `braincoach-ai/prompts/booking/booking_engine.md`

## 3. Architectural Decisions Applied

- Maintained Google Sheets as the semantic control center.
- Kept PostgreSQL as the source of truth for state, memory, and events.
- Preserved n8n as the orchestration layer.
- Restricted LLMs to classification and generation responsibilities.
- Ensured Intake Classifier does not own stage progression.
- Ensured Qualification Engine owns qualification depth, stage progression, and consultation readiness.
- Introduced offer_rules as a new authoritative decision layer for offer eligibility.
- Added booking lifecycle stages and documented handoff behavior.

## 4. New Components Added

- `braincoach-ai/prompts/booking/booking_engine.md`

## 5. Google Sheets Changes

- Added `offer_rules` to the supported sheet list.
- Extended `qualification_flow` with `transition_condition` and `fallback_stage`.
- Extended `offers_master` with `offer_type` and `priority`.
- Documented `offer_rules` with fields: `rule_id`, `keyword`, `min_depth`, `min_readiness`, `required_signal`, `offer_type`, `priority`.

## 6. PostgreSQL Changes

- Updated `braincoach-ai/schemas/postgres-schema.md` to include `booking_requested` as a supported `clients.current_stage` value.
- Documented that funnel analytics should be captured via `events` rather than adding analytics fields to `clients`.

## 7. Prompt Changes

- `braincoach-ai/prompts/intake/intake_classifier.md`
  - Removed stage progression responsibility from the intake classifier.
  - Kept intake classifier focused on keyword, segment, intent, emotional classification, readiness, memory candidates, and route selection.
- `braincoach-ai/prompts/qualification/qualification_engine.md`
  - Added reference to `offer_rules` and preserved the qualification conversation workflow.
  - Added booking lifecycle stage definitions (`booking_intent`, `booking_requested`, `booked`).
  - Reinforced that offer thresholds must not be hardcoded in prompt logic.
- `braincoach-ai/prompts/booking/booking_engine.md`
  - Created a booking workflow prompt placeholder focused on booking confirmation and scheduling handoff.

## 8. New Workflow Stages

- `booking_intent`
- `booking_requested`
- `booked`

## 9. New Event Types

- `stage_entered`
- `qualification_completed`
- `offer_shown`
- `booking_requested`
- `booked`
- `followup_sent`
- `reactivated`

## 10. Open Questions

- Should consultation eligibility be determined entirely from Google Sheets via `offer_rules`?
- Should sleeping leads be reactivated by fixed schedule or behavioral triggers?

## 11. Recommended Next Steps

1. Implement the `offer_rules` sheet in Google Sheets and wire it into the qualification workflow.
2. Add runtime validation and caching for Google Sheets rule data to prevent production instability.
3. Build the booking workflow in n8n and connect `booking_engine` to the booking lifecycle.
4. Capture funnel events in PostgreSQL `events` using the newly documented event types.
5. Expand `offers_master` and `offer_rules` with concrete offer routing rules for BrainCoach consultation logic.
