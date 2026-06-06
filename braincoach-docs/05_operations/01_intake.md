# Content Factory — Intake Module v1.0

Status: Active

Date: 2026-06-05

---

# Purpose

The Intake Module is the entry point of the Factory.

Its purpose is to ensure that every asset originates from a valid knowledge object.

The Intake Module protects the Factory from producing content without research.

---

# Core Principle

No Knowledge Object

↓

No Production

---

# Position In Factory

Knowledge Object

↓

Intake

↓

Extraction

↓

Asset Design

↓

Generation

↓

Feedback

---

# Responsibility

The Intake Module:

* receives requests
* validates inputs
* normalizes objects
* rejects incomplete objects
* prepares data for Extraction

The Intake Module does NOT:

* research
* generate content
* create hypotheses
* interpret signals

---

# Accepted Input Objects

The Factory accepts only the following object types:

## Signal

A meaningful observation extracted from reality.

Example:

Parents increasingly use AI instead of tutors.

---

## Phenomenon

A validated recurring human pattern.

Example:

Children search for answers but ask fewer questions.

---

## Season

A structured research program.

Example:

Self-Learning Season.

---

## Model

A validated explanatory structure.

Example:

Learnability = Curiosity × Autonomy × Environment

---

# Intake Validation Rules

Every object must satisfy minimum requirements.

---

## Signal Requirements

Required:

* observation
* context
* significance

Validation Question:

Why does this signal matter?

---

## Phenomenon Requirements

Required:

* description
* evidence
* research source

Validation Question:

What makes this pattern recurring?

---

## Season Requirements

Required:

* season name
* strategic objective
* research scope

Validation Question:

What is the season trying to understand?

---

## Model Requirements

Required:

* model name
* explanation
* supporting evidence

Validation Question:

What mechanism does this model explain?

---

# Rejection Rules

The Intake Module must reject:

* content ideas
* random topics
* unsupported opinions
* generic trends
* requests without source objects

Examples:

Rejected:

"Make a reel"

"Create a carousel"

"Give me content ideas"

Accepted:

"Create assets from this phenomenon"

"Adapt this model for distribution"

"Generate content from this signal"

---

# Normalized Object Structure

All accepted objects are converted into a common structure.

Example:

{
"object_type": "phenomenon",
"title": "",
"description": "",
"source": "",
"evidence": "",
"status": "validated"
}

This structure becomes the contract between Intake and Extraction.

---

# Output

The output of Intake is:

Validated Knowledge Object

The output is passed to:

Extraction Module

---

# Success Metric

The Intake Module succeeds when:

* invalid requests are filtered out
* knowledge integrity is preserved
* every generated asset can be traced back to a source object

---

# Operational Principle

The Factory does not create content.

The Factory distributes knowledge.

Knowledge enters through Intake.

