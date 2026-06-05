# DEC-008 Research First Architecture

Status: Accepted

Date: 2026-06-05

## Context

BrainCoach originally operated as a content production system.

The workflow was:

Topic
→ Content
→ Audience

As the Knowledge OS matured, it became clear that content should be the output of research rather than the starting point.

The system required a separation between:

* Events
* Signals
* Phenomena
* Research
* Content

## Decision

BrainCoach adopts a Research First Architecture.

Content is no longer considered a primary object.

Content becomes a distribution layer for research outputs.

Research objects become:

* Signal
* Phenomenon
* Season
* Model

Content Factory consumes research objects and transforms them into media formats.

## Consequences

New foundational concepts introduced:

* Event
* Observation
* Signal
* Phenomenon
* Season
* Model

New registries introduced:

* Signal Dictionary
* Phenomenon Registry
* Season Registry

New operational layer introduced:

* Research Layer

New PostgreSQL architecture introduced:

* signal_feed
* signals
* phenomena
* seasons
* experiments
* outcomes
* models
* interviews

Content is now downstream from research.

## Impact

Knowledge OS transitions from:

Content System

to

Research Operating System

## Status

Accepted
