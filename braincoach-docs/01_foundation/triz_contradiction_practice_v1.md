# TRIZ Contradiction Practice v1

Status: Active Practice

Date: 2026-06-18

Layer: 01_foundation

Source:

* `C:\Users\indir\OneDrive\Dokumenty\ДОТУ\teoriya_resheniya_izobretatelskih_zadach.pdf`
* `C:\Users\indir\OneDrive\Dokumenty\ДОТУ\teoriya_resheniya_izobretatelskih_zadach-сжатый.pdf`

Related:

* `braincoach-docs/01_foundation/braincoach_thinking_os_practice_v1.md`
* `braincoach-docs/01_foundation/goldratt_choice_practice_v1.md`
* `braincoach-docs/02_ontology/02_ontology.md`
* `braincoach-docs/04_domain/triz_guide.md`
* `braincoach-docs/03_knowledge/04_decisions/decision-log/DEC-023-triz-contradiction-practice.md`

---

## Purpose

BrainCoach needs TRIZ as a disciplined practice for resolving contradictions and generating stronger options.

The purpose is not to copy TRIZ into BrainCoach mechanically.

The purpose is to train humans and agents to stop choosing between bad tradeoffs too early.

TRIZ strengthens BrainCoach by helping agents:

* formulate non-standard tasks;
* detect contradictions;
* separate contradictions by time, space, level, function, or condition;
* identify available resources;
* search for stronger solutions;
* avoid premature compromise;
* turn harmful effects into useful signals where possible.

## Core Principle

A contradiction is not a failure of thinking.

A contradiction is a high-value signal.

It shows where the current model, system, offer, process, or intervention is not yet well designed.

BrainCoach should treat contradictions as:

```text
signal of unresolved design
not reason to choose a weak compromise
```

## BrainCoach TRIZ Frame

When a system is stuck, ask:

```text
What do we want to improve?
↓
What worsens when we improve it?
↓
What contradiction is revealed?
↓
At what level does the contradiction live?
↓
What resources already exist in the system?
↓
Can the contradiction be separated?
↓
What stronger option becomes possible?
↓
What reality feedback will test it?
```

## Relationship To Thinking OS

Thinking OS asks agents to detect contradiction.

TRIZ gives agents a practice for working with contradiction after it is detected.

Thinking OS:

```text
Contradiction Detection
```

TRIZ:

```text
Contradiction Formulation
↓
Resource Search
↓
Separation / Resolution
↓
Inventive Option
↓
Experiment
```

## Relationship To Choice Practice

Goldratt Choice Practice asks agents to find the hidden assumption behind a conflict.

TRIZ adds a solution-generation discipline:

```text
Conflict / contradiction
↓
Assumptions
↓
Resources
↓
Separation principle
↓
Inventive option
↓
Feedback
```

## TRIZ Agent Protocol

When an agent encounters a contradiction, it must answer:

1. What is the desired improvement?
2. What gets worse if we improve it directly?
3. Is this a technical, social, learning, market, operational, or communication contradiction?
4. Which level contains the contradiction: object, relationship, environment, process, goal, incentive, language, or timing?
5. What resources already exist in the system?
6. Can the contradiction be separated by time?
7. Can it be separated by space?
8. Can it be separated by level?
9. Can it be separated by role or function?
10. Can the harmful effect become a useful signal?
11. What stronger option avoids the weak tradeoff?
12. What experiment or feedback can test the option?

## Output Template

```md
## TRIZ Contradiction

Desired improvement:

Worsening effect:

Contradiction:

Contradiction type:

System level:

Available resources:

Possible separation:
- time:
- space:
- level:
- role / function:
- condition:

Harmful effect as signal:

Inventive option:

Expected signal:

Feedback window:

Correction rule:
```

## BrainCoach Current Examples

### GPS Value Contradiction

```text
We need GPS data to prove value.
But parents do not enter GPS until they see value.
```

Weak compromise:

```text
Push GPS harder.
```

Stronger TRIZ direction:

```text
Sell / offer the 14-day Trajectory Review.
Use GPS as the data collection mechanism.
```

### Content vs Payment Trigger

```text
We need content to test market language.
But content production can distract from payment trigger discovery.
```

TRIZ direction:

```text
Produce only content that tests a payment-trigger hypothesis.
Treat conversion and payment stories as feedback.
```

### Parent Control vs Child Self-Control

```text
Parent wants progress.
Parent control can create progress.
But too much parent control prevents self-control from forming.
```

TRIZ direction:

```text
Separate by time and function.
Parent provides external structure for observation.
GPS / review detects where control can be transferred.
Child gradually receives control where signals show readiness.
```

## Anti-Noise Rule

TRIZ should not be reduced to brainstorming.

BrainCoach must not accept the most common idea as the strongest solution.

The strongest solution is the one that:

* resolves the contradiction more deeply;
* uses existing resources;
* preserves the desired improvement without the worsening effect;
* produces observable feedback from reality.

