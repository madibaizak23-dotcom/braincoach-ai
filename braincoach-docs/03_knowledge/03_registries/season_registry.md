# BrainCoach Season Registry v1.1

## Status

Accepted

## Date

2026-06-05

---

# Purpose

Season Registry stores BrainCoach research seasons.

A season unites signals, phenomena, questions, hypotheses, experiments, and outcomes around a single research program.

If Phenomenon Registry stores units of knowledge, Season Registry stores the research programs that generate knowledge.

---

# Role of a Season

* A season defines one research focus.
* A season limits the range of questions.
* A season maintains coherence across observations, signals, phenomena, and conclusions.
* A season lives longer than individual content pieces and shorter than the entire system.
* A season transforms isolated phenomena into a structured investigation.
* A season accumulates evidence until a meaningful cognitive shift becomes possible.

---

# Principles

* One season = one major research question or one major research line.
* Every season must be formulated as a question about humans.
* A season is not a content theme.
* A season begins with reality signals.
* A season ends with a validated mechanism, refined hypothesis, or new model.
* A season must have a beginning, scope, investigation process, and closure.
* A season must not continue indefinitely.
* A season must contribute to understanding people.

---

# Research Flow

Signal

↓

Phenomenon

↓

Question

↓

Hypothesis

↓

Experiment

↓

Outcome

↓

Mechanism

↓

Cognitive Shift

↓

Model

---

# Required Fields

Every season record must contain:

* Season-ID
* Title
* Reason for Opening
* Main Question
* Core Hypothesis
* Scope
* Source Signals
* Included Phenomena
* Included Experiments
* Start Date
* End Date
* Status
* Evidence Summary
* Key Outcomes
* Key Mechanisms
* Cognitive Shift
* Canonical Impact
* Next Season

---

# Fields

## Season-ID

Unique season identifier.

Example:

SEASON-001

---

## Title

Short season name.

---

## Reason for Opening

Why the season was created.

What recurring observation, signal cluster, contradiction, or risk triggered the investigation?

---

## Main Question

The primary research question.

Must be formulated as a question about humans.

Example:

Why do some children become self-learners while others remain dependent on external control?

---

## Core Hypothesis

The central hypothesis being tested.

---

## Scope

Defines boundaries.

What belongs inside the season and what does not.

---

## Source Signals

Signals that initiated the season.

Links to Signal Dictionary.

---

## Included Phenomena

List of phenomena investigated within the season.

Links to Phenomenon Registry.

---

## Included Experiments

List of experiments conducted within the season.

---

## Start Date

Date the season started.

---

## End Date

Date the season ended.

---

## Status

Allowed values:

* draft
* active
* closing
* closed
* archived

---

## Evidence Summary

Overall strength of findings.

Allowed values:

* weak
* moderate
* strong

---

## Key Outcomes

Most important results produced during the season.

---

## Key Mechanisms

Mechanisms validated, refined, or rejected.

---

## Cognitive Shift

The new understanding produced by the season.

One sentence only.

---

## Canonical Impact

Impact on higher knowledge layers.

Allowed values:

* none
* knowledge_update
* ontology_update
* canon_candidate

---

## Next Season

The next research direction emerging from current findings.

---

# Lifecycle

draft

↓

active

↓

closing

↓

closed

↓

archived

---

# Rules

* Do not confuse a season with a content calendar.
* Do not open a season without a main question.
* Do not open a season without supporting signals.
* Do not close a season without a cognitive shift.
* Do not create a season that does not improve understanding of people.
* Do not repeat a season without new research value.
* Every season must contain at least one phenomenon.
* Every season should ideally produce at least one model candidate.

---

# Strategic Value

Season Registry creates continuity in research.

It groups signals and phenomena into coherent programs rather than isolated observations.

Over time it becomes the map of BrainCoach's long-term investigation into human learning, adaptation, performance, and development.

The goal is not to collect seasons.

The goal is to accumulate understanding across time.

---

# Minimal Record Template

```md
Season-ID:

Title:

Reason for Opening:

Main Question:

Core Hypothesis:

Scope:

Source Signals:

Included Phenomena:

Included Experiments:

Start Date:

End Date:

Status:

Evidence Summary:

Key Outcomes:

Key Mechanisms:

Cognitive Shift:

Canonical Impact:

Next Season:
```
