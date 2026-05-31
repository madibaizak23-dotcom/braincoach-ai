# n8n-v2 Deployment Plan v1

## Purpose

n8n-v2 is the second-generation BrainCoach automation platform.

Its purpose is not to replace production immediately.
Its purpose is to become the future primary BrainCoach environment through controlled validation and gradual migration.

## Decision

BrainCoach will maintain two parallel environments.

### n8n-prod
- stable production environment
- supports active business operations

### n8n-v2
- next-generation BrainCoach platform
- future production candidate

This decision separates operational stability from architectural evolution.

## Core Principle

Production preserves stability.
n8n-v2 drives evolution.

## Current State

### Environment A

**Name:**  
n8n-prod

**Version:**  
1.93

**Status:**  
Stable Legacy Production

**Purpose:**  
Support active business processes.

**Main Components:**
- Intake Engine v1 Stable
- Telegram Intake
- PostgreSQL Integration
- Event Logging

**Rule:**  
Only critical fixes.
No active development.

## Future State

### Environment B

**Name:**  
n8n-v2

**Version:**  
Modern stable n8n release

**Status:**  
Next Generation Platform

**Purpose:**  
Main development environment for BrainCoach.

**Main Directions:**
- Memory Engine
- RAG Layer
- Social Intelligence
- Content Intelligence
- Influence Intelligence
- Analytics Engine

## Why n8n-v2 Is Needed

Current development inside n8n 1.93 creates friction.

**Observed problems:**
- outdated node behavior
- outdated assumptions from AI assistants
- workflow compatibility issues
- SQL query adjustments
- repeated architecture corrections
- reduced development speed

**Result:**  
More time is spent adapting solutions than building systems.

n8n-v2 removes this constraint.

## Infrastructure Strategy

### Cloud Run Services

**Service 1:**  
n8n-prod

**Purpose:**  
Production environment

**Service 2:**  
n8n-v2

**Purpose:**  
Development and future production candidate

**Principle:**  
Separate runtime environments.
Independent deployment cycles.

### PostgreSQL Strategy

**Recommended approach:**  
Single Cloud SQL Instance

**Example:**  
n8n-db-instance

**Schemas:**
- braincoach_prod
- braincoach_dev

**Purpose:**

#### braincoach_prod
- active workflows
- production data

#### braincoach_dev
- Memory Engine development
- RAG testing
- schema experiments
- workflow prototyping

**Benefits:**
- lower infrastructure complexity
- easier maintenance
- shared backups
- simpler migrations

## Development Lifecycle

Idea  
↓  
Architecture  
↓  
Prototype in n8n-v2  
↓  
Validation  
↓  
Documentation  
↓  
Git Commit  
↓  
Production Promotion

**Rule:**  
No workflow moves directly into production.

## Git Strategy

### Production Workflows
- tagged releases only
- documented exports
- rollback available

### n8n-v2 Workflows
- rapid iteration allowed
- architecture-first development
- promotion only after validation

**Rule:**  
Workflow promotion requires both validation and version control.

## Migration Strategy

### Phase 1 — Infrastructure
- deploy n8n-v2
- connect Cloud SQL
- configure credentials
- configure Git workflow

### Phase 2 — Workflow Validation
- import Intake Engine v1 Stable
- validate PostgreSQL
- validate Telegram
- validate OpenAI integration

### Phase 3 — New Development
- Memory Engine
- Memory Persistence
- Memory Retrieval

### Phase 4 — Intelligence Layer
- RAG
- Content Intelligence
- Social Intelligence

### Phase 5 — Production Readiness
- performance validation
- rollback testing
- operational review

### Phase 6 — Promotion
- n8n-v2 becomes primary production platform.
- n8n-prod becomes legacy rollback environment.

## Governance Rules

### n8n-prod
- stability first
- minimal change
- business continuity

### n8n-v2
- active development
- experimentation
- architecture evolution

**Rule:**  
Never experiment inside production.

## Lessons Learned

Development experience with n8n 1.93 revealed:

- architecture evolves faster than legacy workflow assumptions
- AI assistants often assume newer node behavior
- schema evolution requires isolated testing
- production stability should not depend on experimental development

These lessons directly motivated the creation of n8n-v2.

## Success Criteria

n8n-v2 is considered successful when:
- all critical workflows run successfully
- PostgreSQL integration is validated
- Telegram integration is validated
- rollback procedures are tested
- Memory Engine operates successfully
- RAG architecture is operational
- development velocity increases significantly

## Production Promotion Criteria

n8n-v2 may become the primary platform only after:
- 2–4 weeks of stable operation
- successful workflow migration
- successful PostgreSQL validation
- successful Telegram validation
- successful rollback testing
- documented architecture review

## Strategic Principle

BrainCoach requires two different capabilities.

Production creates trust.
Innovation creates growth.

n8n-prod protects trust.
n8n-v2 enables growth.

Both environments are necessary.
They should not be the same system.