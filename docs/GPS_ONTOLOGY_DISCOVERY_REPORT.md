# GPS Ontology Discovery Report

Date: 2026-06-12
Status: Draft analysis
Prepared for: BrainCoach Knowledge OS / GPS

## Executive Summary

Five GPS hypotheses were checked against the existing BrainCoach repository. None should be promoted automatically to Canon or Registry.

The strongest conclusion is that the session introduces a possible unifying GPS layer around trajectory, desired/current state gap, resonance/dissonance, boundaries, and lifecycle transitions. Most of the concepts already have nearby objects in BrainCoach, but they are distributed across Foundation, Ontology, Research, Intelligence, Operations, GPS, and registries.

Recommended action: keep the session as draft research, then run a second pass to decide whether GPS needs a dedicated ontology extension for `trajectory_state`, `desired_state`, `current_state`, `gap`, `resonance`, `dissonance`, and `trajectory_filter`.

## Discovery Method

Searched repository areas:

- Canon: `braincoach-docs/00_canon`
- Foundation: `braincoach-docs/01_foundation`
- Ontology: `braincoach-docs/02_ontology`
- Knowledge / Research / Intelligence / Registries: `braincoach-docs/03_knowledge`
- Domain knowledge assets: `braincoach-docs/04_domain`
- Operations / GPS workflows / signal validation: `braincoach-docs/05_operations`, `braincoach-docs/07_automation`

Search terms included:

- resonance, dissonance
- desired state, current state, gap
- boundary, boundaries
- trajectory, trajectory_assessment
- Fibonacci, lifecycle, age markers
- Self Learning Capability, Transfer Learning, Constraint Management
- external management dependency
- phenomenon, signal, deviation

## Existing Knowledge Landscape

### Canon / Foundation

Relevant existing foundation:

- Canon contains high-level rules around reality, observation, signal, hypothesis, experiment, action, and results.
- Foundation contains "Systems Are Changeable", "Systems Over Objects", "Learning As Reconfiguration", "Self Learning As The Highest Outcome", "Constraints Before Symptoms", "Transfer Over Performance", and "Direction Matters".
- BKOS defines the learning loop: Signal -> Observation -> Phenomenon -> Hypothesis -> Experiment -> Outcome -> Pattern -> Decision -> Action -> New Signal.

Implication: the new GPS hypotheses are compatible with the current foundation, but they are not Canon-ready because they are still hypotheses.

### Ontology

Relevant existing ontology:

- Hypothesis is already defined as a testable assumption.
- Phenomenon, Observation, Contradiction, Question, Experiment, Outcome, Mechanism, and Season are already defined.
- Development/stuckness terms already include Own Goal, Borrowed Goal, Unconscious Desire, Loss of Measure, Imitation, Relearning, and age development markers.
- Age markers already include 3, 5, 8, 13, 21, 34, 55, and 89+.

Implication: GPS-HYP-005 partially duplicates an existing lifecycle frame and should not create a parallel lifecycle object without reconciliation.

### GPS / BGS

Relevant existing GPS/BGS assets:

- `tracker_capture_v1` currently captures Raw Input -> Observation -> Signal Candidate.
- GPS OS V3 has Tracker, Observation Layer, Signal Extraction Layer, and planned Trajectory Layer.
- `signal_validation_v1` defines validated signals as future input to `trajectory_assessment_v1`.
- System evolution log mentions `trajectory_assessment_v1` and future Trajectory Layer / Personal Knowledge Memory System.

Implication: these hypotheses are most useful as draft inputs for the planned Trajectory Layer, not as immediate registry entries.

### Research / Intelligence

Relevant existing research/intelligence assets:

- `SELF_LEARNING_CAPABILITY` is a core ontology and intelligence object.
- Research Self Learning contains mechanisms: Attention Regulation, Memory Efficiency, Metacognition, Transfer Learning, Constraint Management, Identity Shift.
- Intelligence Self Learning adds Self Regulation and related phenomena/cases.
- External Management Dependency Model defines low Self Learning Capability -> high dependence on external management -> parent burden -> anxiety -> demand for intervention.

Implication: GPS-HYP-002 and GPS-HYP-004 are extensions of existing research and intelligence, not standalone new canonical objects.

### Phenomenon Registry / Library

Relevant existing registry state:

- Phenomenon Registry defines required fields and lifecycle, but the requested objects are hypotheses, not observed phenomena.
- Phenomenon Library already contains related entries such as Borrowed Goal, Unconscious Desire, Thought Without Action, Loss of Measure, and Context Dependency / Transfer issues.

Implication: none of the five objects should be added to Phenomenon Registry yet.

## Object-by-Object Analysis

### GPS-HYP-001 - Resonance vs Dissonance

Already Exists:

No exact ontology object named Resonance/Dissonance was found. However, there are close existing structures:

- Feedback Module measures the gap between expected reality and observed reality.
- Deviation Object stores expected, actual, difference, importance, investigation_required.
- Ontology defines Contradiction as mismatch between observed reality and expectation/model.
- GPS tracker is designed to detect trajectory earlier than visible results.

Related Objects:

- Deviation
- Contradiction
- Signal
- trajectory_assessment_v1
- Feedback Module
- BKOS Reality -> Signals -> Knowledge loop

Candidate Location:

- research
- gps
- ontology, only after validation

Recommendation:

extend

Rationale:

This should extend the existing deviation/contradiction logic into a GPS-specific state model. It is not a duplicate because the desired trajectory framing is new. It is not ready for Canon or Registry.

### GPS-HYP-002 - Desired State to Current State Gap

Already Exists:

Partial. `Desired State` exists in Case Registry and External Management Dependency Model. `Current State` exists in planning and architecture contexts, but no unified GPS object was found for Desired State <-> Current State Gap.

Related Objects:

- Case Registry schema: Initial State, Desired State, Outcome
- External Management Dependency Model
- Self Learning Capability
- trajectory_assessment_v1
- signal_validation_v1
- Proof of Success signals

Candidate Location:

- research
- gps
- intelligence

Recommendation:

extend

Rationale:

This is a strong candidate for the GPS trajectory layer, but it should extend existing case/proof/trajectory schemas instead of creating a separate ontology too early.

### GPS-HYP-003 - Personal Boundaries as Trajectory Filter

Already Exists:

No exact object found. The word "boundaries" appears in system/domain boundary contexts, not as a personal development mechanism. Related ontology terms exist but do not cover this function directly.

Related Objects:

- Constraint Management
- Own Goal
- Borrowed Goal
- Direction Matters
- Loss of Measure
- External Management Dependency
- Self Regulation
- trajectory_assessment_v1

Candidate Location:

- research
- ontology
- gps

Recommendation:

create_new as draft only

Rationale:

This appears genuinely new as a GPS hypothesis. It should not become a phenomenon yet because no source observations/signals are attached. Best next step is a draft research object with validation questions:

- What observable behavior indicates a boundary is retaining desired trajectory?
- What observable behavior indicates a boundary is blocking undesired trajectory?
- How does this differ from Constraint Management or Self Regulation?

### GPS-HYP-004 - Unified Trajectory Model

Already Exists:

Partial. Cross-domain transfer already exists in Self Learning Capability, Research Self Learning, Intelligence Self Learning, and case registry examples across education, sport, work, and self-learning.

Related Objects:

- Self Learning Capability
- Transfer Learning
- Constraint Management
- Self Regulation
- Identity Formation
- Case Registry: sport, education, self-learning cases
- Foundation: Transfer Over Performance

Candidate Location:

- intelligence
- gps
- ontology

Recommendation:

extend

Rationale:

The idea is already present as cross-context transfer, but "Unified Trajectory Model" may be a useful GPS-level synthesis. It should remain an intelligence/research synthesis until repeated trajectory data supports it.

### GPS-HYP-005 - Fibonacci Lifecycle Hypothesis

Already Exists:

Partial. BrainCoach Ontology already contains age development markers:

- 3
- 5
- 8
- 13
- 21
- 34
- 55
- 89+

The new hypothesis uses:

- 3
- 5
- 8
- 13
- 21
- 34
- 54
- 89
- 144

Related Objects:

- Ontology age development markers
- lifecycle
- Season
- trajectory assessment
- development stuckness terms

Candidate Location:

- lifecycle
- ontology
- research

Recommendation:

merge/extend after validation

Rationale:

This should not create a parallel lifecycle model. First reconcile 54 vs existing 55, and clarify whether 144 is symbolic, mathematical, aspirational, or intended as an actual human lifecycle node.

## Recommendations By Action

### Merge

GPS-HYP-005 should merge with the existing age development marker ontology if retained.

### Extend

GPS-HYP-001 should extend Deviation / Contradiction / trajectory logic.

GPS-HYP-002 should extend Desired State / Initial State / Outcome and trajectory assessment.

GPS-HYP-004 should extend Self Learning Capability, Transfer Learning, and cross-domain trajectory intelligence.

### Create New

GPS-HYP-003 may deserve a new draft research object:

`Personal Boundaries as Trajectory Filter`

Do not create it in Canon or Registry yet.

### Reject

No hypothesis should be rejected at this stage. The only caution is GPS-HYP-005, which risks numerological overreach unless grounded in observed developmental transitions.

## Proposed Next Step

Create a future draft GPS ontology extension, not now, with candidate terms:

- desired_state
- current_state
- trajectory_gap
- resonance
- dissonance
- trajectory_filter
- boundary_signal
- lifecycle_transition_node

This should happen only after review and decision logging.

## Guardrail Confirmation

No Canon changes were made.

No Phenomenon Registry changes were made.

No registry objects were created.

No objects were deleted.

This report is analysis and recommendation only.
