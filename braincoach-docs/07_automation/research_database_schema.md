# Research Database Schema v1.0

Status: Accepted

Date: 2026-06-05

---

# Purpose

Research Database Schema defines the operational PostgreSQL structure used by BrainCoach Research OS.

This document translates research objects into database entities.

The goal is to provide a stable foundation for automation, analytics, content production, and future AI retrieval systems.

---

# Research Architecture

Reality

↓

Signal Feed

↓

Signals

↓

Phenomena

↓

Seasons

↓

Experiments

↓

Outcomes

↓

Models

↓

Content Assets

↓

Performance

---

# Table: signal_feed

Purpose:

Stores raw events collected from reality.

Examples:

* News
* Research papers
* Social posts
* Interviews
* Parent questions
* School events

Core Fields:

```sql
id UUID PRIMARY KEY
title TEXT
source TEXT
event_date DATE
summary TEXT
raw_content TEXT
created_at TIMESTAMP
```

---

# Table: signals

Purpose:

Stores validated observations extracted from signal_feed.

Core Fields:

```sql
id UUID PRIMARY KEY
signal_code VARCHAR(50)
title TEXT
observation TEXT
description TEXT
signal_type VARCHAR(50)
strength VARCHAR(20)
status VARCHAR(50)
first_seen DATE
created_at TIMESTAMP
updated_at TIMESTAMP
```

Lifecycle:

candidate → tracked → validated → archived

---

# Table: signal_links

Purpose:

Links signals to source events.

Core Fields:

```sql
signal_id UUID
signal_feed_id UUID
```

---

# Table: phenomena

Purpose:

Operational mirror of Phenomenon Registry.

Core Fields:

```sql
id UUID PRIMARY KEY
ph_code VARCHAR(50)
title TEXT
description TEXT
observation TEXT
contradiction TEXT
question TEXT
hypothesis TEXT
mechanism TEXT
evidence_level VARCHAR(50)
confidence INTEGER
status VARCHAR(50)
created_at TIMESTAMP
updated_at TIMESTAMP
```

---

# Table: phenomenon_signals

Purpose:

Many-to-many relationship.

A phenomenon may originate from multiple signals.

Core Fields:

```sql
phenomenon_id UUID
signal_id UUID
```

---

# Table: seasons

Purpose:

Research programs.

Core Fields:

```sql
id UUID PRIMARY KEY
season_code VARCHAR(50)
title TEXT
main_question TEXT
core_hypothesis TEXT
reason_for_opening TEXT
status VARCHAR(50)
start_date DATE
end_date DATE
created_at TIMESTAMP
```

Lifecycle:

draft → active → closing → closed → archived

---

# Table: season_phenomena

Purpose:

Links seasons and phenomena.

Core Fields:

```sql
season_id UUID
phenomenon_id UUID
```

---

# Table: experiments

Purpose:

Hypothesis validation layer.

Core Fields:

```sql
id UUID PRIMARY KEY
experiment_code VARCHAR(50)
title TEXT
hypothesis TEXT
method TEXT
status VARCHAR(50)
started_at TIMESTAMP
completed_at TIMESTAMP
```

Lifecycle:

planned → running → completed → archived

---

# Table: outcomes

Purpose:

Stores experiment results.

Core Fields:

```sql
id UUID PRIMARY KEY
experiment_id UUID
result_summary TEXT
finding TEXT
validated BOOLEAN
created_at TIMESTAMP
```

---

# Table: models

Purpose:

Validated explanatory models.

Core Fields:

```sql
id UUID PRIMARY KEY
model_code VARCHAR(50)
title TEXT
formula TEXT
description TEXT
status VARCHAR(50)
created_at TIMESTAMP
```

Lifecycle:

draft → validated → accepted → canonical

---

# Table: interviews

Purpose:

Primary qualitative research source.

Core Fields:

```sql
id UUID PRIMARY KEY
interview_code VARCHAR(50)
participant_type VARCHAR(50)
transcript TEXT
summary TEXT
signals_found JSONB
phenomena_found JSONB
created_at TIMESTAMP
```

Participant Types:

* parent
* student
* teacher
* coach
* expert

---

# Table: content_assets

Purpose:

Stores all content generated from research.

Core Fields:

```sql
id UUID PRIMARY KEY
content_code VARCHAR(50)
content_type VARCHAR(50)
title TEXT
source_object_type VARCHAR(50)
source_object_id UUID
status VARCHAR(50)
published_at TIMESTAMP
created_at TIMESTAMP
```

Content Types:

* reel
* carousel
* stories
* telegram
* thread
* article

---

# Table: content_performance

Purpose:

Stores content outcomes.

Core Fields:

```sql
id UUID PRIMARY KEY
content_id UUID
views INTEGER
reach INTEGER
saves INTEGER
shares INTEGER
comments INTEGER
dms INTEGER
consultations INTEGER
updated_at TIMESTAMP
```

---

# Relationship Map

signal_feed

↓

signals

↓

phenomena

↓

seasons

↓

experiments

↓

outcomes

↓

models

↓

content_assets

↓

content_performance

---

# Governance Rule

All research entities must contain:

* ID
* Status
* Created At
* Updated At

No research object exists without lifecycle tracking.

---

# Future Extensions

Planned:

* embeddings
* pgvector
* semantic search
* agent retrieval
* research recommendations
* phenomenon similarity engine

Not part of v1.0

---

# Strategic Value

This schema turns PostgreSQL into the operational memory of BrainCoach Research OS.

The database no longer stores only conversations.

It stores the evolution of understanding itself.
