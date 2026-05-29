const { pool } = require("./connection");

/**
 * Create new memory
 */
async function createMemory({
  telegramUserId,
  memoryType,
  memoryCategory,
  memoryContent,
  confidence = 0.8,
  source = "memory_extractor",
}) {
  const query = `
    INSERT INTO memory_items (
      telegram_user_id,
      memory_type,
      memory_category,
      memory_content,
      confidence,
      source
    )
    VALUES ($1,$2,$3,$4,$5,$6)
    RETURNING *;
  `;

  const values = [
    telegramUserId,
    memoryType,
    memoryCategory,
    memoryContent,
    confidence,
    source,
  ];

  const result = await pool.query(query, values);

  return result.rows[0];
}

/**
 * Get all active memories
 */
async function getMemories(telegramUserId) {
  const query = `
    SELECT *
    FROM memory_items
    WHERE telegram_user_id = $1
    AND is_active = TRUE
    ORDER BY updated_at DESC;
  `;

  const result = await pool.query(query, [telegramUserId]);

  return result.rows;
}

/**
 * Find memory by type
 */
async function getMemoriesByType(
  telegramUserId,
  memoryType
) {
  const query = `
    SELECT *
    FROM memory_items
    WHERE telegram_user_id = $1
    AND memory_type = $2
    AND is_active = TRUE;
  `;

  const result = await pool.query(query, [
    telegramUserId,
    memoryType,
  ]);

  return result.rows;
}

/**
 * Increase observation count
 */
async function incrementObservation(memoryId) {
  const query = `
    UPDATE memory_items
    SET
      observation_count = observation_count + 1,
      last_confirmed_at = NOW(),
      updated_at = NOW()
    WHERE id = $1
    RETURNING *;
  `;

  const result = await pool.query(query, [memoryId]);

  return result.rows[0];
}

/**
 * Soft delete memory
 */
async function deactivateMemory(memoryId) {
  const query = `
    UPDATE memory_items
    SET
      is_active = FALSE,
      updated_at = NOW()
    WHERE id = $1
    RETURNING *;
  `;

  const result = await pool.query(query, [memoryId]);

  return result.rows[0];
}

module.exports = {
  createMemory,
  getMemories,
  getMemoriesByType,
  incrementObservation,
  deactivateMemory,
};