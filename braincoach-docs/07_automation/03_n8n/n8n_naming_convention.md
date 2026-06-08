# n8n_naming_convention

## Workflows

snake_case

example:
tracker_capture_v1
qualification_engine_v2

## Nodes

PREFIX_ActionObject

examples:

TG_Trigger

SYS_LoadContext
SYS_BuildInputContext
SYS_RouteInput

VOI_CheckVoice
VOI_GetFile
VOI_Transcribe
VOI_NormalizeTranscript

TRK_SaveEntry
TRK_GetRecentEntries

MEM_LoadMemory
MEM_SaveMemory

AI_Extractor
AI_Responder

## Postgres Tables

snake_case

examples:

clients
conversation_state
tracker_entries
messages
events

## Variables

snake_case

examples:

current_stage
sub_stage
pattern_type
qualification_signals