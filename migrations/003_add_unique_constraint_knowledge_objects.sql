ALTER TABLE knowledge_objects
ADD CONSTRAINT uq_knowledge_object_type
UNIQUE (object_type);