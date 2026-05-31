# BrainCoach Documentation Index

Purpose:

This document explains how AI agents should navigate the BrainCoach repository.

Read this file before reading any other documentation.

---

## Reading Order

### Step 1

Read:

active/00-project-journal.md

Purpose:

Understand current state of the project.

---

### Step 2

Read:

active/01-source-of-truth.md

Purpose:

Understand which documents are authoritative.

---

### Step 3

Read:

active/02-tooling-playbook.md

Purpose:

Understand development workflow.

---

### Step 4

Read:

active/03-customer-intelligence-platform-v1.md

Purpose:

Understand system vision.

---

### Step 5

Read:

active/04-qualification-engine.md

Purpose:

Understand current production workflow.

---

### Step 6

Read:

active/05-braincoach-database-bootstrap.md

Purpose:

Understand PostgreSQL structure.

---

## Folder Meanings

### active/

Current production and development truth.

Agents should prioritize these files.

---

### future/

Future architecture.

Not implemented.

Do not assume existence.

---

### archive/

Historical information.

Do not use for implementation decisions.

Use only for historical context.

---

### agents/

Agent-specific instructions and operating procedures.

---

## Development Principle

Current priority:

Content
→ Intake
→ Qualification
→ Memory
→ Consultation
→ Analytics

Do not introduce:

* Redis
* Vector DB
* Multi-Agent systems
* RAG

unless explicitly required by the active milestone.

---

## Source of Truth Priority

1. Git repository state
2. Project Journal
3. Source of Truth document
4. Active documentation
5. Future documentation
6. Archive

If documents conflict:

Git state wins.
