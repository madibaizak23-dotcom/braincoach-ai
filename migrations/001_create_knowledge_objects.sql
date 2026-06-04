CREATE TABLE knowledge_objects (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    object_type VARCHAR(100) NOT NULL,
    class VARCHAR(50) NOT NULL,

    owner VARCHAR(100) NOT NULL,

    source_of_truth VARCHAR(100) NOT NULL,

    lifecycle VARCHAR(255),

    status VARCHAR(50) NOT NULL,

    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);