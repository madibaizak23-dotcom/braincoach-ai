# PostgreSQL Research Layer v1.0

Status: Accepted

Date: 2026-06-05

---

# Purpose

Research Layer is the operational memory of the BrainCoach research system.

It stores observations, signals, phenomena, seasons, experiments, outcomes and content relationships.

If GitHub stores stable knowledge, PostgreSQL stores active research activity.

---

# Position in Knowledge OS

Knowledge Layer

↓

Research Layer

↓

Content Layer

↓

Audience Feedback

↓

Research Layer

The system continuously learns through interaction with reality.

---

# Core Principle

GitHub stores meaning.

PostgreSQL stores activity.

Research objects may originate in PostgreSQL and later become canonical knowledge in GitHub.

---

# Research Pipeline

Reality

↓

Events

↓

Signals

↓

Phenomena

↓

Experiments

↓

Outcomes

↓

Models

↓

Content

↓

Audience

↓

New Signals

---

# Table: signal_feed

## Purpose

Stores raw observations collected from reality before interpretation.

## Examples

* ENT started
* University admissions opened
* OpenAI released a new model
* Switzerland reached the World Championship final

## Lifecycle

observed → archived

---

# Table: signals

## Purpose

Stores meaningful signals extracted from events.

Signals represent potentially important changes, anomalies or emerging patterns.

## Examples

* Parents increasingly replace tutors with AI
* Students rely on answer generation more than problem solving
* Self-learning behaviors are appearing earlier than expected

## Lifecycle

candidate → tracked → validated → archived

---

# Table: phenomena

## Purpose

Operational mirror of Phenomenon Registry.

Stores recurring human patterns selected for investigation.

## Examples

* Children search for answers but ask fewer questions
* High-performing students increasingly learn outside school systems

## Lifecycle

candidate → observed → tested → canonical

---

# Table: seasons

## Purpose

Stores active research programs.

A season groups multiple phenomena into one investigation.

## Examples

* Self Learning
* Attention Under Pressure
* Parent Dependence vs Autonomy

## Lifecycle

draft → active → closing → closed → archived

---

# Table: experiments

## Purpose

Stores deliberate attempts to validate or invalidate hypotheses.

## Lifecycle

planned → running → completed → archived

---

# Table: outcomes

## Purpose

Stores results produced by experiments.

Outcomes determine whether hypotheses become mechanisms.

## Lifecycle

observed → validated → archived

---

# Table: models

## Purpose

Stores validated explanatory models emerging from research.

Models explain mechanisms behind observed phenomena.

## Examples

Learnability = Curiosity × Autonomy × Environment

## Lifecycle

draft → validated → accepted → canonical

---

# Table: interviews

## Purpose

Stores qualitative research collected from parents, students, teachers and experts.

Interviews are one of the primary sources of new phenomena.

## Lifecycle

collected → analyzed → linked → archived

---

# Table: content_assets

## Purpose

Stores content generated from research objects.

Content is always linked back to a Signal, Phenomenon, Season or Model.

## Examples

* Reel
* Carousel
* Stories
* Telegram Post
* Thread

## Lifecycle

draft → published → archived

---

# Table: content_performance

## Purpose

Stores content outcomes.

Allows research to be connected with audience response.

## Metrics

* Views
* Reach
* Saves
* Shares
* Comments
* DMs
* Consultations
* Interviews Generated

---

# Research Object Relationships

Signal Feed

↓

Signal

↓

Phenomenon

↓

Season

↓

Experiment

↓

Outcome

↓

Model

↓

Content Asset

↓

Performance

---

# Governance Rule

Every operational research object must have:

* ID
* Status
* Owner
* Created At
* Updated At

Objects without lifecycle tracking are invalid.

---

# Source of Truth Rule

GitHub owns:

* Canon
* Ontology
* Registries
* Knowledge Objects

PostgreSQL owns:

* Events
* Signals
* Phenomena Instances
* Experiments
* Outcomes
* Interviews
* Content Performance

---

# Strategic Value

Research Layer transforms BrainCoach from a content production system into a continuously learning research system.

Reality generates signals.

Signals generate phenomena.

Phenomena generate models.

Models generate content.

Content generates new observations.

The system becomes more accurate through use.
