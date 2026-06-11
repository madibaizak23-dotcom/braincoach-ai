# Authentication Runtime
# Version 1.0

## Purpose

Определяет стандартный механизм аутентификации BrainCoach OS для доступа к сервисам Google Cloud.

Основной принцип:

Не использовать API Keys и Service Account JSON внутри системы.

Использовать IAM-аутентификацию через Cloud Run Service Account.

---

## Architecture

Cloud Run
↓
Service Account
↓
Metadata Server
↓
Access Token
↓
Google APIs

---

## Runtime Identity

Cloud Run Service:

bgs-orchestrator-dev

Service Account:

936756379899-compute@developer.gserviceaccount.com

---

## Current IAM Roles

roles/aiplatform.user

roles/cloudsql.client

roles/datastore.user

roles/secretmanager.secretAccessor

---

## Authentication Flow

### Step 1

Workflow запускается внутри Cloud Run.

### Step 2

Cloud Run предоставляет временный access token через Metadata Server.

### Step 3

Workflow получает токен.

Request:

GET

http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token

Header:

Metadata-Flavor: Google

---

### Response Example

```json
{
  "access_token": "...",
  "expires_in": 3599,
  "token_type": "Bearer"
}
```

---

## Vertex AI Access

Endpoint:

https://europe-west3-aiplatform.googleapis.com

Authorization Header:

Authorization: Bearer ACCESS_TOKEN

---

## Supported Services

Current:

- Vertex AI
- Cloud SQL
- Secret Manager
- Firestore

Planned:

- Cloud Storage
- BigQuery
- Pub/Sub
- Google Drive
- Google Sheets
- Google Calendar

---

## Security Principles

### Allowed

IAM Authentication

Cloud Run Service Account

Short-Lived Access Tokens

Metadata Server

### Forbidden

Gemini API Keys

Service Account JSON Files

Private Keys stored in n8n

Hardcoded Credentials

---

## Validation

Date:

2026-06-10

Validation Method:

n8n HTTP Request Node

Query:

GET metadata token endpoint

Result:

SUCCESS

Access token successfully returned by Metadata Server.

---

## Milestone Reference

MILESTONE-011

Vertex Connectivity Operational

Status:

Completed