# GPS Ontology Candidates v1

Status: Draft Candidates
Layer: 02_ontology
Object Type: Ontology Candidate Set
Date: 2026-06-12

## Purpose

Hold candidate GPS ontology terms before they are accepted into BrainCoach Ontology.

This file is not accepted ontology. It is a staging document for terms that may later be promoted through a decision process.

## Governance Rule

Terms in this file must not be treated as canonical definitions.

Promotion requires:

- supporting research
- compatibility check with existing Ontology
- duplicate check
- Decision Log entry
- explicit update to accepted ontology

## Candidate Terms

### desired_state

Draft Definition:

The state, direction, or outcome a person or system is trying to move toward.

Related Existing Objects:

- Case Registry Desired State
- External Management Dependency Model
- trajectory_assessment_v1

Open Questions:

- Is desired_state declared by the person, inferred by the system, or both?
- Can desired_state be borrowed or externally imposed?

### current_state

Draft Definition:

The observable current condition of the person or system, based on behavior, signals, observations, and outcomes.

Related Existing Objects:

- Case Registry Initial State
- observations
- research_signal_candidates
- signal_validation_v1

Open Questions:

- Which observations are enough to represent current_state?
- How often should current_state be revised?

### trajectory_gap

Draft Definition:

The difference between desired_state and current_state.

Related Existing Objects:

- Deviation
- Contradiction
- Case Registry
- trajectory_assessment_v1

Open Questions:

- Is trajectory_gap a metric, a qualitative assessment, or both?
- How is it different from Deviation?

### resonance

Draft Definition:

A trajectory condition where desired direction and observed reality are sufficiently aligned to sustain motion.

Related Existing Objects:

- proof of success signals
- reduced external management
- Self Learning Capability

Open Questions:

- What signals indicate resonance?
- Does resonance require visible progress or only alignment?

### dissonance

Draft Definition:

A trajectory condition where desired direction and observed reality remain persistently misaligned.

Related Existing Objects:

- Deviation
- Contradiction
- trajectory_gap

Open Questions:

- How long must a mismatch persist before it is dissonance?
- Is dissonance always negative, or can it trigger development?

### trajectory_filter

Draft Definition:

A mechanism that preserves desired movement and blocks undesired movement from shaping the trajectory.

Related Existing Objects:

- Personal Boundaries as Trajectory Filter
- Constraint Management
- Self Regulation
- Own Goal
- Borrowed Goal

Open Questions:

- What is the difference between a healthy filter and avoidance?
- Is this a mechanism, signal category, or assessment dimension?

### boundary_signal

Draft Definition:

An observation or signal that indicates a personal boundary is shaping trajectory.

Related Existing Objects:

- tracker observations
- research_signal_candidates
- signal_validation_v1

Open Questions:

- What behavior indicates boundary formation?
- What behavior indicates boundary collapse?

### lifecycle_transition_node

Draft Definition:

A possible age-linked or stage-linked transition marker where developmental reconfiguration is more likely.

Related Existing Objects:

- BrainCoach Ontology age development markers
- lifecycle
- Season

Open Questions:

- Should this align with 55 or 54?
- Is 144 a symbolic marker or a practical lifecycle node?
- How can transition nodes be validated without becoming diagnostic labels?

## Terms Not Ready For Accepted Ontology

None of these terms should be moved into `02_ontology.md` until a decision is made.

## Related Draft Research

- `braincoach-docs/03_knowledge/01_research/gps_trajectory_hypotheses_v1.md`
- `braincoach-docs/03_knowledge/02_intelligence/gps_trajectory_intelligence_v1.md`

