# BGS Runtime Stack v1

## Status

Approved

## Purpose

Зафиксировать технологический стек первого поколения BGS Runtime.

Документ отвечает на вопрос:

На каком стеке строится BGS Orchestration Layer?

---

# Design Principle

Runtime должен быть:

* reproducible
* versioned
* replaceable
* observable

Каждый компонент должен иметь зафиксированную версию или стратегию версионирования.

---

# Cloud Platform

Provider:

Google Cloud Platform

Project:

braincoach-n8n-prod

Status:

Active

---

# Runtime Layer

## Service

Name:

bgs-orchestrator-dev

Status:

planned

Purpose:

Validation runtime for BGS agents.

Rule:

All new runtime experiments start in DEV.

Production deployment is forbidden until validation is completed.

---

## Future Production Runtime

Name:

bgs-orchestrator

Status:

planned

Activation Condition:

Successful DEV validation.

---

# Workflow Engine

## Platform

n8n

Status:

Approved

Role:

Agent orchestration runtime.

---

## Version Strategy

Rule:

Never deploy latest.

Always pin exact version.

Example:

n8nio/n8n:X.Y.Z

Version must be recorded before deployment.

---

# Database Layer

## Platform

Cloud SQL PostgreSQL

Status:

Operational

Instance:

n8n-db-instance

---

## BGS Databases

bgs_core

Purpose:

Knowledge Layer

Owner:

bgs_admin

---

bgs_orch

Purpose:

Orchestration Layer

Owner:

bgs_admin

---

bgs_analytics

Purpose:

Analytics Layer

Owner:

bgs_admin

---

# Secrets Layer

## Platform

Google Secret Manager

Status:

Approved

Purpose:

Credential isolation.

Rule:

No secrets inside workflow definitions.

No secrets inside repositories.

---

# AI Layer

## Primary Provider

Vertex AI

Status:

Approved

Role:

Agent reasoning and generation.

---

## Model Access

Through Google Cloud.

No direct API keys stored inside workflows.

---

# Repository Layer

## Platform

GitHub

Status:

Approved

Purpose:

Source code and architecture source.

---

# Observability Layer

## Initial Scope

Cloud Run Logs

Cloud SQL Monitoring

Execution Logs

---

## Future Scope

Telemetry

Agent Health Monitoring

Runtime Dashboards

---

# Validation Checklist

Before Production Runtime

Required:

* Runtime starts successfully
* Cloud SQL connection succeeds
* Secret Manager access succeeds
* Workflow execution succeeds
* Runtime survives restart
* Runtime survives redeploy
* AGENT-004 executes successfully

Only after all checks pass:

bgs-orchestrator-dev

↓

bgs-orchestrator

---

# Forbidden

Do Not:

* deploy latest versions
* mix legacy runtime and BGS runtime
* store secrets in workflows
* deploy directly to production
* introduce untracked infrastructure

---

# Current Approved Stack

Cloud Run

↓

n8n (Pinned Version)

↓

Cloud SQL PostgreSQL

↓

Secret Manager

↓

Vertex AI

↓

GitHub

---

# Success Criteria

BGS Runtime can be recreated from documentation and infrastructure definitions without relying on historical knowledge.

Result:

Reproducible BGS Runtime.


Workflow Engine

Platform:
n8n

Pinned Version:
2.22.5

Container:
docker.io/n8nio/n8n:2.22.5

Status:
Approved