# Signal Registry Specification (Stage 4)

## 1. Purpose
Signal Registry служит «микроскопом» для BrainCoach. Его задача — обеспечить надежное обнаружение повторяющихся человеческих паттернов (сигналов) в потоке родительских наблюдений. Реестр не является целью, он является инструментом для трансформации хаотичных наблюдений в каноническое знание.

## 2. Canonical Signal Object
Канонический сигнал (`Canonical Signal`) — это научная единица системы. Каждый сигнал уникален и имеет жизненный цикл.

### Data Structure
* `id`: UUID (Primary Key)
* `signal_code`: VARCHAR(100) UNIQUE (Напр: `SIG-001-starts-without-reminder`)
* `signal_type`: VARCHAR(50) (Категория из Signal Dictionary)
* `signal_name`: TEXT
* `description`: TEXT (Каноническое определение)
* `signal_status`: VARCHAR(20) (active, candidate, deprecated, merged, archived)
* `dictionary_snapshot_id`: UUID (Версия правил классификации)
* `recurrence_count`: INTEGER (Счетчик подтверждений)
* `first_seen_at`: TIMESTAMP
* `last_seen_at`: TIMESTAMP
* `source_observation_id`: UUID (Генезис: связь с tracker_entries)
* `source_candidate_id`: UUID (Первичная верификация)

## 3. Provenance & Traceability
Система обеспечивает 100% прослеживаемость сигнала:
* `Observation` → `Signal Candidate` → `Canonical Signal`.
* В реестре всегда хранится ссылка на `source_observation_id`, позволяющая развернуть цепочку доказательств до исходного сообщения родителя.

## 4. Merge Logic
Merge — это онтологическая операция схлопывания дубликатов в каноническую форму.
* **Условие:** Разные формулировки = одна закономерность.
* **Действие:**
    1. `research_signal_candidates.status` → `merged`.
    2. `research_signal_candidates.merged_into_signal_code` → `[TARGET_CODE]`.
    3. `signal_registry.recurrence_count` → `+1`.
    4. `signal_registry.last_seen_at` → `NOW()`.

## 5. Governance
* **Approve:** Создание нового канонического сигнала.
* **Merge:** Привязка к существующему каноническому сигналу.
* **Reject:** `status = 'rejected'` (архивирование шума).
* **Governance Rule:** Все изменения в статусах сигналов должны быть обоснованы экспертной оценкой в интерфейсе ревью.

## 6. Schema (PostgreSQL)
```sql
CREATE TABLE signal_registry (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    signal_code VARCHAR(100) UNIQUE NOT NULL,
    signal_type VARCHAR(50) NOT NULL,
    signal_name TEXT NOT NULL,
    description TEXT,
    signal_status VARCHAR(20) DEFAULT 'active',
    dictionary_snapshot_id UUID,
    recurrence_count INTEGER DEFAULT 1,
    first_seen_at TIMESTAMP DEFAULT NOW(),
    last_seen_at TIMESTAMP DEFAULT NOW(),
    source_observation_id UUID REFERENCES tracker_entries(id),
    source_candidate_id UUID,
    created_at TIMESTAMP DEFAULT NOW()
);