# Infrastructure - Source of Truth

## PostgreSQL как Source of Truth

### Принцип
PostgreSQL - единственный источник правды для всех данных пользователей.

### Данные в PostgreSQL
✅ User profiles
✅ Conversation history
✅ Qualification scores
✅ Offer history
✅ Interaction events
✅ Reactivation status

### Данные НЕ в PostgreSQL
❌ Кэши (кэшируется в n8n временно)
❌ Сессионные данные (живут в памяти during workflow)
❌ Логи (идут в Google Sheets)

### Синхронизация
1. **Write**: PostgreSQL ← n8n (after every LLM call, offer, event)
2. **Read**: PostgreSQL → n8n (at start of workflow)
3. **Verify**: Проверка консистентности каждый час

### Backup Strategy
- PostgreSQL: Daily snapshots to Google Cloud Storage
- Google Sheets: Real-time logs (for audit trail)
