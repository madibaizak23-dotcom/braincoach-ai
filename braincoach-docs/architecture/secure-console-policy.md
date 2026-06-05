# Secure Console Policy

## Доступ к консолям

### PostgreSQL Console
🔒 **RESTRICTED**
- Только для read-only запросов
- Никаких DELETE/UPDATE вручную
- Логирование всех запросов
- Доступ через VPN только

### Google Sheets
🟡 **LIMITED**
- Просмотр logs и events
- Ручная проверка данных
- NO прямое редактирование (используй воркфлоу)
- История изменений включена

### n8n Console
🟡 **LIMITED**
- Управление воркфлоу
- Просмотр экзекьюшенов
- NO доступ к сырым credentials

### Telegram Bot Admin
🟡 **LIMITED**
- Просмотр статистики
- Отправка бродкастов
- Управление блокировками

## Password Policy
- Все пароли хранятся в Google Secret Manager
- Ротация каждые 90 дней
- Никогда не делиться в чате/документах
