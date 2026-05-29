require("dotenv").config();

const {
  createMemory,
  getMemories,
} = require("./memoryRepository");

const { pool } = require("./connection");

async function runTest() {
  try {
    console.log("🚀 Testing Memory Repository...");

    const testUserId = 999999999;

    const memory = await createMemory({
      telegramUserId: testUserId,
      memoryType: "goal",
      memoryCategory: "business",
      memoryContent: "Build BrainCoach AI ecosystem",
      confidence: 0.95,
      source: "test",
    });

    console.log("\n✅ Memory created:");
    console.log(memory);

    const memories = await getMemories(testUserId);

    console.log("\n📚 Retrieved memories:");
    console.log(memories);

    console.log(
      `\n🎉 Test successful. Found ${memories.length} memory item(s).`
    );
  } catch (error) {
    console.error("\n❌ Test failed:");
    console.error(error);
  } finally {
    await pool.end();
  }
}

runTest();