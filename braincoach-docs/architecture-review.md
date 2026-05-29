# BrainCoach Architecture Review

Version: 1.0

Last Updated: 2026-05-29

---

# Purpose

This document tracks:

- architecture decisions
- review findings
- unresolved questions
- future improvements

It serves as the architectural memory of the project.

---

# Accepted Architecture Decisions

## Stage Ownership

Decision:

Qualification Engine owns stage progression.

Intake Classifier does not modify stages.

Intake Classifier responsibilities:

- keyword classification
- segment classification
- intent classification
- emotional classification
- route selection

Qualification Engine responsibilities:

- qualification depth
- stage progression
- next question selection
- consultation readiness

Status:

Implemented

---

## Source of Truth

Google Sheets owns:

- qualification rules
- prompts
- offers
- followups
- signal taxonomy

PostgreSQL owns:

- user state
- stage progression
- memory
- events

n8n owns:

- orchestration

LLMs own:

- classification
- generation

Status:

Implemented

---

## Emotional Analysis

Decision:

Emotional Reflection is responsible only for emotional diagnosis.

It does not:

- qualify
- sell
- book consultations

Status:

Implemented

---

## Qualification Philosophy

Decision:

Qualification follows:

Problem
→ Importance
→ Emotional Driver
→ Consequences
→ Desired Outcome
→ Consultation Readiness

Status:

Implemented

---

# Audit Findings

## Finding 001

Issue:

Old Qualification Engine focused on analysis rather than conversation.

Impact:

High

Resolution:

Qualification Engine V2 created.

Status:

Resolved

---

## Finding 002

Issue:

Intake Classifier and Qualification Engine both attempted stage management.

Impact:

High

Resolution:

Stage ownership assigned to Qualification Engine only.

Status:

Resolved

---

## Finding 003

Issue:

Offer thresholds hardcoded in prompts.

Impact:

Medium

Resolution:

Move offer rules to Google Sheets.

Status:

Planned

---

# Open Questions

## Offer Rules

Question:

Should consultation eligibility be determined entirely from Google Sheets?

Status:

Open

Priority:

High

---

## Reactivation Logic

Question:

Should sleeping leads be reactivated by fixed schedule or behavioral triggers?

Status:

Open

Priority:

Medium

---

# Planned Improvements

## Google Sheets

Planned:

Add sheet:

offer_rules

Fields:

- rule_id
- min_depth
- min_readiness
- required_signal
- offer_type
- priority

Priority:

High

---

## Booking Engine

Planned:

Create:

prompts/booking/booking_engine.md

Priority:

High

---

## Offer Generator

Planned:

Create:

prompts/offer/offer_generator.md

Priority:

High

---

## Funnel Analytics

Planned:

Track events:

- stage_entered
- qualification_completed
- offer_shown
- booking_requested
- booked
- followup_sent
- reactivated

Priority:

Medium

---

# Deferred Decisions

## Multi-channel Support

Future channels:

- Telegram
- Instagram
- WhatsApp
- Web Chat

Current status:

Telegram only

Deferred until MVP completion.

---

# Architecture Health

README.md
Complete

postgres-schema.md
Complete

google-sheets-structure.md
Complete

intake_classifier.md
Complete

emotional_reflection.md
Complete

qualification_engine.md
Complete

offer_generator.md
Not Started

booking_engine.md
Not Started

reactivation_engine.md
Not Started

memory_engine.md
Not Started