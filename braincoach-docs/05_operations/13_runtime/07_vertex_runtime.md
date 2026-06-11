# Vertex Runtime
# Version 1.0

## Purpose

Определяет стандартный механизм взаимодействия BrainCoach OS с Vertex AI.

Vertex AI является основным reasoning engine системы.

Все интеллектуальные решения AGENT-001 проходят через Vertex Runtime.

---

## Runtime Architecture

Agent
↓
Prompt Builder
↓
Vertex Runtime
↓
Gemini Model
↓
Structured Response
↓
Agent Action

---

## Current Model

Provider:

Google Vertex AI

Region:

europe-west3

Model:

gemini-2.5-flash

Status:

Active

---

## Authentication

Authentication Source:

Cloud Run Metadata Server

Method:

IAM Access Token

Reference:

06_authentication.md

---

## Request Flow

Step 1

Agent формирует задачу.

Step 2

Prompt Builder создает запрос.

Step 3

Vertex Runtime получает access token.

Step 4

Vertex Runtime вызывает Gemini.

Step 5

Gemini возвращает ответ.

Step 6

Ответ преобразуется в структуру действий.

---

## Endpoint

POST

https://europe-west3-aiplatform.googleapis.com/v1/projects/braincoach-n8n-prod/locations/europe-west3/publishers/google/models/gemini-2.5-flash:generateContent

---

## Standard Request

```json
{
  "contents": [
    {
      "role": "user",
      "parts": [
        {
          "text": "User instruction"
        }
      ]
    }
  ]
}
```

---

## Standard Response

```json
{
  "candidates": [
    {
      "content": {
        "parts": [
          {
            "text": "Model response"
          }
        ]
      }
    }
  ]
}
```

---

## Agent Runtime Pattern

Input
↓
Reasoning
↓
Decision
↓
Action

Vertex отвечает только за reasoning.

Запись данных выполняют специализированные агенты.

---

## Agent Responsibilities

### AGENT-001

Orchestrator

Responsibilities:

- анализ события
- выбор действия
- вызов подчиненных агентов
- контроль выполнения

Uses:

Vertex Runtime

---

### AGENT-004

Repository Guardian

Does not call Vertex directly.

---

### AGENT-005

Knowledge Registry Manager

Does not call Vertex directly.

---

### AGENT-006

Journal Manager

Does not call Vertex directly.

---

## Current Use Cases

### Registry Decisions

Input:

New asset

Output:

Asset classification

---

### Workflow Analysis

Input:

Workflow event

Output:

Recommended action

---

### Milestone Detection

Input:

Repository event

Output:

Milestone detected true/false

---

## Future Use Cases

### Multi-Agent Routing

Event
↓
AGENT-001
↓
Vertex
↓
Agent Selection
↓
Execution

---

### Knowledge Classification

Document
↓
Vertex
↓
Ontology Mapping
↓
Knowledge Registry

---

### Autonomous Operations

System Event
↓
Vertex
↓
Decision
↓
Workflow Execution

---

## Runtime Principles

Vertex produces decisions.

Agents perform actions.

PostgreSQL stores memory.

Knowledge Assets remain source of truth.

---

## Validation

Date:

2026-06-10

Validation:

Cloud Run
↓
Metadata Server
↓
Access Token
↓
Vertex Endpoint

Status:

Operational

---

## Milestone Reference

MILESTONE-011

Vertex Connectivity Operational

Status:

Completed