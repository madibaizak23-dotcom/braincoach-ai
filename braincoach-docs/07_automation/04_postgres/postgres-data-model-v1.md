# PostgreSQL Data Model v1

Status: Active

Date: 2026-06-04

## Governance Layer

### knowledge_objects

Registry of Knowledge Object Types.

Defines what classes of Knowledge Objects exist inside BrainCoach.

Examples:

* Canon
* Ontology
* Registry
* ADR
* Decision
* Research

---

### decision_log

Operational decisions adopted by BrainCoach Governance.

Stores accepted architectural, governance and strategic decisions.

Examples:

* DEC-001
* DEC-002
* DEC-003
* DEC-004

---

## Event Layer

### knowledge_events

Repository change events classified into Knowledge Objects.

Acts as the event stream connecting GitHub activity with Knowledge OS.

Examples:

* version_registry
* ontology
* canon
* decision_log

---

## Knowledge Layer

### knowledge_assets

Concrete Knowledge Objects stored and managed by BrainCoach Knowledge OS.

Represents individual knowledge assets tracked by the system.

Examples:

* ADR-001
* DEC-003
* Knowledge Object Ontology v1
* milestones.md
* releases.md

---

## Marketing Intelligence Layer

### content_hypotheses

Registry of marketing and content hypotheses.

Used to track assumptions about audience behavior, content performance and communication strategies.

Examples:

* Contradiction outperforms explanation
* Questions outperform statements
* Memory content generates higher engagement

---

### content_assets

Registry of content units produced by BrainCoach.

Represents individual content experiments linked to hypotheses.

Examples:

* Carousel
* Reel
* Research Post
* Long-form Article

---

### content_metrics

Performance measurements collected from published content.

Used to evaluate hypotheses and generate marketing insights.

Examples:

* Views
* Average Watch Time
* Saves
* Shares
* Comments
* Followers Gained

---

## Architectural Principle

BrainCoach PostgreSQL serves as the operational memory of the ecosystem.

Knowledge Layer stores what is known.

Marketing Intelligence Layer stores what the market confirms.

Event Layer records how the system evolves over time.

Governance Layer defines what is allowed to become part of the system.
