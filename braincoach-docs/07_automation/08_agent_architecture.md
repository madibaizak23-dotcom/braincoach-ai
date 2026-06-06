# BrainCoach Automation — Agent Architecture v1.0

Status: Active

Date: 2026-06-06

---

# Purpose

This document defines the role of AI agents within BrainCoach OS.

Agents operate on canonical objects.

Agents belong to domains.

Agents do not own knowledge.

Agents process knowledge.

---

# Core Principle

Objects are primary.

Domains are primary.

Agents are replaceable.

The system must continue functioning even if an individual agent is replaced.

---

# Agent Responsibilities

Agents may:

* observe
* classify
* extract
* analyze
* generate
* recommend

Agents may not:

* redefine ontology
* create governance rules
* alter canonical knowledge without approval

---

# Agent Categories

BrainCoach consists of four primary agent groups:

1. Governance Agents
2. Research Agents
3. Operations Agents
4. Business Agents

---

# Governance Agents

Purpose:

Protect consistency of the system.

---

## Knowledge Curator

Domain:

Governance

Reads:

* Knowledge Objects
* Registries
* Decisions

Creates:

* Registry Updates
* Consistency Reports

Purpose:

Maintain coherence of Knowledge OS.

---

## Governance Auditor

Domain:

Governance

Reads:

* Objects
* Relationships
* States

Creates:

* Audit Reports
* Compliance Findings

Purpose:

Detect architectural drift.

---

# Research Agents

Purpose:

Transform reality into understanding.

---

## Observation Agent

Reads:

* Messages
* Interviews
* Feedback Events
* External Signals

Creates:

* Observations

Purpose:

Capture reality.

---

## Signal Agent

Reads:

* Observations
* Deviations

Creates:

* Signals

Purpose:

Detect meaningful change.

---

## Phenomenon Agent

Reads:

* Signals

Creates:

* Phenomenon Candidates

Purpose:

Identify recurring patterns.

---

## Research Agent

Reads:

* Phenomena
* Interviews
* Experiments

Creates:

* Research Findings

Purpose:

Investigate phenomena.

---

## Model Agent

Reads:

* Research Findings

Creates:

* Models

Purpose:

Generate explanatory structures.

---

## Deviation Agent

Reads:

* Feedback Events
* Expected Outcomes

Creates:

* Deviations

Purpose:

Identify model error.

---

# Operations Agents

Purpose:

Transform knowledge into assets.

---

## Intake Agent

Reads:

* Knowledge Objects

Creates:

* Intake Packages

Purpose:

Prepare inputs for production.

---

## Extraction Agent

Reads:

* Knowledge Objects

Creates:

* Insight Packages

Purpose:

Extract reusable meaning.

---

## Asset Design Agent

Reads:

* Insight Packages

Creates:

* Asset Blueprints

Purpose:

Design distribution formats.

---

## Generation Agent

Reads:

* Asset Blueprints

Creates:

* Generated Assets

Purpose:

Produce content assets.

---

## Feedback Agent

Reads:

* Feedback Events
* Performance Data

Creates:

* Observations
* Deviations

Purpose:

Close the learning loop.

---

# Business Agents

Purpose:

Support user interaction and conversion.

---

## Scout Agent

Reads:

* Messages
* Conversation State

Creates:

* Qualification Signals

Purpose:

Discover user reality.

---

## Architect Agent

Reads:

* Qualification Signals
* User Profile

Creates:

* Recommendations
* Diagnostic Paths

Purpose:

Provide guidance.

---

## Memory Agent

Reads:

* Messages
* Qualification Signals

Creates:

* Memory Items
* User Profile Updates

Purpose:

Maintain continuity.

---

# Agent Communication Rule

Agents communicate through objects.

Agents do not communicate directly.

Example:

Observation Agent

↓

Observation

↓

Signal Agent

↓

Signal

↓

Phenomenon Agent

---

# Agent Ownership Rule

Agents never own data.

Agents create or update objects.

Objects remain owned by domains.

---

# Agent Lifecycle

Input Object

↓

Reasoning

↓

Output Object

↓

Validation

↓

Persistence

Agents are transient.

Objects are persistent.

---

# Future Agent Expansion

New agents should be created only when:

* responsibility is unique
* existing agents cannot reasonably absorb the function
* object ownership remains clear

---

# Anti-Patterns

Do not create agents for every task.

Do not duplicate responsibilities.

Do not allow agents to bypass domain interfaces.

Do not store knowledge inside agents.

Agents should remain replaceable.

---

# Strategic Principle

Governance Agents protect consistency.

Research Agents create understanding.

Operations Agents create assets.

Business Agents create outcomes.

Together they form the operational intelligence layer of BrainCoach OS.
