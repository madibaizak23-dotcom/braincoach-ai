# BGS Orch Public Tables Snapshot

Status: Live Snapshot
Date: 2026-06-14
Database: `bgs_orch`
Schema: `public`
Source: owner-provided `information_schema.tables` query output

## Purpose

Record the full live `bgs_orch.public` table inventory so BrainCoach-owned tables can be separated from n8n/runtime tables without guessing.

This is documentation only. No SQL was run by Codex.

## Summary

Total `public` tables confirmed: 97

BrainCoach-owned tables confirmed by live database inspection:

- `knowledge_assets`
- `knowledge_events`
- `repository_journal`

The remaining tables are treated as n8n/platform/runtime tables unless a later decision explicitly assigns BrainCoach ownership.

## Tables

```text
agent_checkpoints
agent_execution
agent_execution_threads
agent_published_version
agent_registry
agents
agents_messages
agents_observation_cursors
agents_observation_locks
agents_observations
agents_resources
agents_threads
ai_builder_temporary_workflow
annotation_tag_entity
auth_identity
auth_provider_sync_history
binary_data
chat_hub_agent_tools
chat_hub_agents
chat_hub_messages
chat_hub_session_tools
chat_hub_sessions
chat_hub_tools
credential_dependency
credentials_entity
data_table
data_table_column
deployment_key
dynamic_credential_entry
dynamic_credential_resolver
dynamic_credential_user_entry
evaluation_collection
evaluation_config
event_destinations
execution_annotation_tags
execution_annotations
execution_data
execution_entity
execution_metadata
folder
folder_tag
insights_by_period
insights_metadata
insights_raw
installed_nodes
installed_packages
instance_ai_iteration_logs
instance_ai_messages
instance_ai_observational_memory
instance_ai_resources
instance_ai_run_snapshots
instance_ai_threads
instance_ai_workflow_snapshots
instance_version_history
invalid_auth_token
knowledge_assets
knowledge_events
mcp_registry_server
migrations
oauth_access_tokens
oauth_authorization_codes
oauth_clients
oauth_refresh_tokens
oauth_user_consents
processed_data
project
project_relation
project_secrets_provider_access
repository_journal
role
role_mapping_rule
role_mapping_rule_project
role_scope
scope
secrets_provider_connection
settings
shared_credentials
shared_workflow
tag_entity
test_case_execution
test_run
token_exchange_jti
trusted_key
trusted_key_source
user
user_api_keys
user_favorites
variables
webhook_entity
workflow_builder_session
workflow_dependency
workflow_entity
workflow_history
workflow_publish_history
workflow_published_version
workflow_statistics
workflows_tags
```

## Notes

- `knowledge_assets` and `knowledge_events` were confirmed by live `\d` output.
- `repository_journal` appears in the live `information_schema.tables` inventory and is treated as BrainCoach-owned orchestration memory.
- `repository_journal` column/index structure still requires separate `\d repository_journal` confirmation before any migration depends on it.
- Custom schemas such as `knowledge`, `research`, `production`, and `agent` do not exist yet.
