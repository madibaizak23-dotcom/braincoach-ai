require("dotenv").config();

const { Pool } = require("pg");

const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  ssl: {
    rejectUnauthorized: false,
  },
});

async function initDatabase() {
  const client = await pool.connect();

  try {
    console.log("🚀 Initializing BrainCoach database...");

    // Enable UUID generation
    await client.query(`
      CREATE EXTENSION IF NOT EXISTS pgcrypto;
    `);

    // =========================
    // MEMORY ITEMS
    // =========================

    await client.query(`
      CREATE TABLE IF NOT EXISTS memory_items (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

        telegram_user_id BIGINT NOT NULL,

        memory_type VARCHAR(50) NOT NULL,
        memory_category VARCHAR(50),

        memory_content TEXT NOT NULL,

        confidence NUMERIC(3,2),

        source VARCHAR(50),

        first_observed_at TIMESTAMP DEFAULT NOW(),
        last_confirmed_at TIMESTAMP DEFAULT NOW(),

        observation_count INTEGER DEFAULT 1,

        is_active BOOLEAN DEFAULT TRUE,

        created_at TIMESTAMP DEFAULT NOW(),
        updated_at TIMESTAMP DEFAULT NOW()
      );
    `);

    await client.query(`
      CREATE INDEX IF NOT EXISTS idx_memory_user
      ON memory_items(telegram_user_id);
    `);

    await client.query(`
      CREATE INDEX IF NOT EXISTS idx_memory_type
      ON memory_items(memory_type);
    `);

    await client.query(`
      CREATE INDEX IF NOT EXISTS idx_memory_active
      ON memory_items(is_active);
    `);

    await client.query(`
      CREATE UNIQUE INDEX IF NOT EXISTS idx_memory_unique
      ON memory_items(
        telegram_user_id,
        memory_type,
        memory_content
      );
    `);

    console.log("✅ memory_items created");

    // =========================
    // USER PROFILES
    // =========================

    await client.query(`
      CREATE TABLE IF NOT EXISTS user_profiles (

        telegram_user_id BIGINT PRIMARY KEY,

        profile_version INTEGER DEFAULT 1,

        primary_interests JSONB,

        long_term_goals JSONB,

        decision_style VARCHAR(50),

        learning_style VARCHAR(50),

        motivation_drivers JSONB,

        strengths JSONB,

        recurring_challenges JSONB,

        preferred_response_style VARCHAR(50),

        profile_confidence NUMERIC(3,2),

        last_profile_update TIMESTAMP DEFAULT NOW(),

        created_at TIMESTAMP DEFAULT NOW()
      );
    `);

    await client.query(`
      CREATE INDEX IF NOT EXISTS idx_profile_decision_style
      ON user_profiles(decision_style);
    `);

    await client.query(`
      CREATE INDEX IF NOT EXISTS idx_profile_learning_style
      ON user_profiles(learning_style);
    `);

    await client.query(`
      CREATE INDEX IF NOT EXISTS idx_profile_updated
      ON user_profiles(last_profile_update DESC);
    `);

    console.log("✅ user_profiles created");

    console.log("🎉 BrainCoach database initialized successfully");

  } catch (error) {
    console.error("❌ Database initialization failed");
    console.error(error);
  } finally {
    client.release();
    await pool.end();
  }
}

initDatabase();