Markdown
# BrainCoach n8n 2.22.5 Clean Deployment Runbook v2 (PRODUCTION)

## Итоговая боевая архитектура

Google Cloud Run (n8n-v2-postgres)
↓
n8n 2.22.5
↓
Cloud SQL Connector
↓
PostgreSQL (Cloud SQL)


* **Проект:** `braincoach-n8n-prod`
* **Cloud SQL Instance:** `n8n-db-instance`
* **Регион:** `europe-west3`
* **Service Account:** `936756379899-compute@developer.gserviceaccount.com`
* **Боевой URL:** `https://n8n-v2-postgres-936756379899.europe-west3.run.app`

---

## Карта сервисов (Текущий статус)

| Service | Роль / Статус | Действие |
| :--- | :--- | :--- |
| **`n8n-server-firestore`** | v1.93, legacy production | **СТРОГО НЕ ТРОГАТЬ!** |
| **`n8n-v2-clean`** | Экспериментальный архивный сервис | **Можно безопасно удалить** |
| **`n8n-v2-postgres`** | **✅ БОЕВОЙ v2 (Основной)** | **Не изменять без согласования** |

---

## Критические параметры конфигурации (Архитектурные правила)

| Параметр | Значение | Зачем это нужно / Что фиксирует |
| :--- | :--- | :--- |
| **`DB_POSTGRESDB_HOST`** | `/cloudsql/braincoach-n8n-prod:europe-west3:n8n-db-instance` | **Unix socket.** Использование `127.0.0.1` в Cloud Run НЕ работает! |
| **`DB_POSTGRESDB_POOLSIZE`**| `2` | Кардинально снижает риск получить `timeout` при старте контейнера. |
| **`DB_POSTGRESDB_TIMEOUT`** | `120000` | Дает 2 минуты на reconnect базы при сетевых колебаниях. |
| **`--timeout`** | `300` | Выделяет контейнеру Cloud Run честные 5 минут на запуск и проведение миграций. |
| **`--max-instances`** | `1` | **СТРОГО 1.** n8n не умеет масштабироваться горизонтально без настройки Queue Mode (Redis). |

> ⚠️ **Критические грабли с ключом шифрования:** Переменную `N8N_ENCRYPTION_KEY` нельзя переключать или смешивать между `--set-env-vars` и `--set-secrets`. Она должна считываться строго как секрет. Ключ `n8n-v2-encryption-key` зафиксирован (создан 2026-05-31).

---

## Создание чистой базы (Инструкция на случай пересборки)

**Подключение:**
```bash
gcloud sql connect n8n-db-instance \
    --user=postgres \
    --database=postgres
Создание базы и прав (внутри консоли PostgreSQL):

SQL
CREATE DATABASE n8n_v2_clean;
GRANT ALL PRIVILEGES ON DATABASE n8n_v2_clean TO n8n_user;
Проверка отсутствия старых таблиц:

SQL
\c n8n_v2_clean

SELECT current_database();

SELECT COUNT(*) FROM pg_tables WHERE schemaname='public';
Ожидаемый результат для чистой базы: count = 0

Проверка секретов и пользователей перед деплоем
Bash
# Проверка секретов (должны существовать)
gcloud secrets list

# Проверка пользователя n8n_user в Cloud SQL
gcloud sql users list --instance=n8n-db-instance
Команда боевого деплоя (Победившая конфигурация)
Применяется для обновления или восстановления основного боевого сервиса n8n-v2-postgres:

Bash
gcloud run deploy n8n-v2-postgres \
    --image=docker.io/n8nio/n8n:2.22.5 \
    --region=europe-west3 \
    --allow-unauthenticated \
    --service-account=936756379899-compute@developer.gserviceaccount.com \
    --memory=2Gi \
    --cpu=2 \
    --min-instances=1 \
    --max-instances=1 \
    --timeout=300 \
    --port=5678 \
    --add-cloudsql-instances=braincoach-n8n-prod:europe-west3:n8n-db-instance \
    --set-env-vars="N8N_PROTOCOL=https,N8N_PORT=5678,N8N_RUNNERS_ENABLED=false,N8N_DIAGNOSTICS_ENABLED=false,DB_TYPE=postgresdb,DB_POSTGRESDB_DATABASE=n8n_v2_clean,DB_POSTGRESDB_USER=n8n_user,DB_POSTGRESDB_HOST=/cloudsql/braincoach-n8n-prod:europe-west3:n8n-db-instance,DB_POSTGRESDB_PORT=5432,DB_POSTGRESDB_POOLSIZE=2,DB_POSTGRESDB_TIMEOUT=120000" \
    --set-secrets="DB_POSTGRESDB_PASSWORD=postgres-password:latest,N8N_ENCRYPTION_KEY=n8n-v2-encryption-key:latest"
Проверка статуса и логов
Проверить статус ревизии:

Bash
gcloud run services describe n8n-v2-postgres --region=europe-west3
Ожидаемый статус: Ready: True. Активная ревизия: n8n-v2-postgres-00001-wtl (или новее).

Чтение логов контейнера:

Bash
gcloud run services logs read n8n-v2-postgres --region=europe-west3 --limit=100
🚨 Важная особенность при старте:
Если в логах появляется ошибка 503 Database is not ready! — это штатный ответ n8n во время применения миграций. Паниковать не нужно, следует подождать 30–60 секунд.

Успешный маркер в логах:

Initializing n8n process

Migrations in progress -> Finished migration ...

n8n ready on ::, port 5678

Диагностика здоровья PostgreSQL
Если n8n долго держит статус 503, проверьте состояние БД:

SQL
-- Проверить лимиты подключений
SHOW max_connections;

-- Посчитать общее количество активных сессий
SELECT count(*) FROM pg_stat_activity;

-- Посмотреть распределение коннектов по пользователям
SELECT usename, state, count(*)
FROM pg_stat_activity
GROUP BY usename, state
ORDER BY count(*) DESC;
Признаки здорового Production
[x] Сервис n8n-v2-postgres отвечает 200 OK по эндпоинту /healthz/readiness (Внимание: эндпоинта /healthz не существует!).

[x] Количество инстансов в Cloud Run жестко зафиксировано на max-instances=1.

[x] В логах отсутствуют циклические ошибки: Database connection timed out или Connection terminated unexpectedly.