-- Summer Map v1.1
-- Target database: bgs_core
-- Connection:
-- gcloud sql connect n8n-db-instance --user=bgs_admin --database=bgs_core
--
-- Purpose:
-- Allow the new Summer Map Q5 stage in the existing conversations stage machine.

BEGIN;

ALTER TABLE conversations
DROP CONSTRAINT IF EXISTS chk_conversation_stage;

ALTER TABLE conversations
ADD CONSTRAINT chk_conversation_stage
CHECK (
  current_stage IN (
    'new',
    'waiting_q1',
    'waiting_q2',
    'waiting_q3',
    'waiting_q4',
    'waiting_q5',
    'analysis',
    'completed'
  )
);

COMMIT;

-- Verification:
-- SELECT conname, pg_get_constraintdef(oid)
-- FROM pg_constraint
-- WHERE conrelid = 'conversations'::regclass
--   AND conname = 'chk_conversation_stage';
