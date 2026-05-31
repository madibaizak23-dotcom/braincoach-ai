# RAG Architecture v1

## Purpose

The Retrieval-Augmented Generation (RAG) Layer is responsible for providing contextual intelligence to BrainCoach AI.

Its purpose is not to replace reasoning.
Its purpose is to provide relevant context, memory, and knowledge before reasoning occurs.

## Core Principle

Retrieve first.
Reason second.

## Architectural Role

Customer Intelligence Platform transforms:

Signals -> Memory -> Understanding

The RAG Layer provides:

Knowledge -> Context -> Intelligence

RAG acts as the bridge between:
- customer memory
- project knowledge
- methodology
- analytics
- conversational reasoning

## Core Principle

Not all information should be sent to the model.

The system should retrieve only the most relevant information for the current task.

**Goal:**
- Maximum relevance.
- Minimum context noise.

## Knowledge Domains

BrainCoach knowledge is divided into four domains.

### Domain 1 — Customer Memory

**Purpose:**  
Remember the individual.

**Sources:**
- clients
- memory_facts
- messages
- events
- qualification history

**Questions:**
- What happened previously?
- What concerns were expressed?
- What goals were identified?
- What stage is the person in?

**Output:**  
Personal Context

### Domain 2 — BrainCoach Methodology

**Purpose:**  
Remember how BrainCoach works.

**Sources:**
- qualification methodology
- consultation methodology
- emotional qualification framework
- cognitive diagnostic framework
- operating principles

**Questions:**
- How should the conversation progress?
- What qualification stage applies?
- What insight should be delivered?

**Output:**  
Methodological Context

### Domain 3 — Project Knowledge

**Purpose:**  
Remember how the system itself works.

**Sources:**
- architecture documents
- project journal
- playbooks
- operating procedures
- design decisions

**Questions:**
- Why was a decision made?
- What architecture is currently active?
- What is the approved process?

**Output:**  
Project Context

### Domain 4 — Content Intelligence

**Purpose:**  
Remember what the audience is telling us.

**Sources:**
- content signals
- trend observations
- social intelligence
- influencer monitoring
- content performance

**Questions:**
- What topics are emerging?
- What themes resonate?
- What should be created next?

**Output:**  
Content Context

## Source of Truth Hierarchy

Not all sources are equal.

**Priority order:**
1. PostgreSQL operational memory
2. Approved architecture documents
3. Approved methodology documents
4. Versioned project artifacts
5. Research documents
6. External knowledge

**Rule:**  
Closer sources override more distant sources.

## Knowledge Ownership

Operational Memory
Owner: PostgreSQL

Methodology
Owner: Approved methodology documents

Architecture
Owner: Approved architecture documents

Project Decisions
Owner: Versioned project artifacts

External Research
Owner: Research repositories

Rule:

Every knowledge domain must have a clear owner.

## Retrieval Principles

### Relevance First

Retrieve information related to:
- current user
- current topic
- current objective

### Freshness Matters

Recent events should receive additional weight.

The system should prefer:
- recent interactions
- current architecture
- latest approved methodology

### Minimize Noise

More context is not better.

The objective is:
- Relevant context only.

## Retrieval Types

### Personal Retrieval

**Focus:**  
Individual user memory.

**Examples:**
- previous conversations
- emotional signals
- qualification state
- goals

### Methodological Retrieval

**Focus:**  
BrainCoach frameworks.

**Examples:**
- qualification stages
- consultation logic
- diagnostic methods

### Project Retrieval

**Focus:**  
Internal system knowledge.

**Examples:**
- architecture
- workflows
- playbooks
- standards

### Content Retrieval

**Focus:**  
Audience intelligence.

**Examples:**
- trends
- content opportunities
- social signals
- recurring questions

## Context Assembly

Before reasoning begins:
1. Identify objective.
2. Select relevant retrieval domains.
3. Retrieve context.
4. Rank relevance.
5. Build context package.
6. Send context to reasoning layer.

**Goal:**  
The model should receive context,
not raw storage.

## Data Classification

The RAG Layer should distinguish:

### Facts
Stable information.

**Examples:**
- customer goals
- architecture decisions
- methodology

### Signals
Observed events.

**Examples:**
- comments
- reactions
- interactions

### Hypotheses
Probabilistic interpretations.

**Examples:**
- behavioral tendencies
- communication preferences
- readiness estimates

**Rule:**  
Hypotheses must never be treated as facts.

## Future Expansion

Future integrations may include:
- Notion
- knowledge repositories
- research archives
- social intelligence datasets
- content intelligence datasets

All future sources must respect:
**Source of Truth Hierarchy.**

## Strategic Principle

BrainCoach should not remember everything.
BrainCoach should remember what is useful.

The objective of RAG is not maximum memory.
The objective of RAG is maximum relevance.