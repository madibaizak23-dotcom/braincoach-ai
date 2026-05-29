require("dotenv").config();
const { Pool } = require("pg");

const pool = new Pool({
  host: process.env.DB_HOST,
  port: parseInt(process.env.DB_PORT, 10) || 5432,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  ssl: process.env.DB_SSL === "true" ? { rejectUnauthorized: false } : undefined,
  connectionTimeoutMillis: 10000,
  idleTimeoutMillis: 30000,
});

async function testConnection() {
  let client;

  try {
    client = await pool.connect();
    const result = await client.query("SELECT NOW()");
    console.log("✅ PostgreSQL connected");
    console.log(result.rows[0]);
  } catch (error) {
    console.error("❌ PostgreSQL connection error");
    console.error(error);
    process.exitCode = 1;
  } finally {
    if (client) {
      client.release();
    }
  }
}

async function main() {
  await testConnection();
  await pool.end();
}

if (require.main === module) {
  main();
}

module.exports = {
  pool,
  testConnection,
};
