const { pool } = require("./connection");

/**
 * Get user profile
 */
async function getProfile(telegramUserId) {
  const query = `
    SELECT *
    FROM user_profiles
    WHERE telegram_user_id = $1;
  `;

  const result = await pool.query(query, [
    telegramUserId,
  ]);

  return result.rows[0] || null;
}

/**
 * Create profile
 */
async function createProfile({
  telegramUserId,
  primaryInterests = [],
  longTermGoals = [],
  decisionStyle = null,
  learningStyle = null,
  motivationDrivers = [],
  strengths = [],
  recurringChallenges = [],
  preferredResponseStyle = null,
  profileConfidence = 0.5,
}) {
  const query = `
    INSERT INTO user_profiles (
      telegram_user_id,
      primary_interests,
      long_term_goals,
      decision_style,
      learning_style,
      motivation_drivers,
      strengths,
      recurring_challenges,
      preferred_response_style,
      profile_confidence
    )
    VALUES (
      $1,$2,$3,$4,$5,$6,$7,$8,$9,$10
    )
    RETURNING *;
  `;

  const values = [
    telegramUserId,
    JSON.stringify(primaryInterests),
    JSON.stringify(longTermGoals),
    decisionStyle,
    learningStyle,
    JSON.stringify(motivationDrivers),
    JSON.stringify(strengths),
    JSON.stringify(recurringChallenges),
    preferredResponseStyle,
    profileConfidence,
  ];

  const result = await pool.query(query, values);

  return result.rows[0];
}

/**
 * Update profile
 */
async function updateProfile(
  telegramUserId,
  profileData
) {
  const query = `
    UPDATE user_profiles
    SET
      primary_interests = $2,
      long_term_goals = $3,
      decision_style = $4,
      learning_style = $5,
      motivation_drivers = $6,
      strengths = $7,
      recurring_challenges = $8,
      preferred_response_style = $9,
      profile_confidence = $10,
      profile_version = profile_version + 1,
      last_profile_update = NOW()
    WHERE telegram_user_id = $1
    RETURNING *;
  `;

  const values = [
    telegramUserId,
    JSON.stringify(profileData.primaryInterests || []),
    JSON.stringify(profileData.longTermGoals || []),
    profileData.decisionStyle || null,
    profileData.learningStyle || null,
    JSON.stringify(profileData.motivationDrivers || []),
    JSON.stringify(profileData.strengths || []),
    JSON.stringify(profileData.recurringChallenges || []),
    profileData.preferredResponseStyle || null,
    profileData.profileConfidence || 0.5,
  ];

  const result = await pool.query(query, values);

  return result.rows[0];
}

/**
 * Upsert profile
 */
async function upsertProfile(
  telegramUserId,
  profileData
) {
  const existingProfile = await getProfile(
    telegramUserId
  );

  if (!existingProfile) {
    return createProfile({
      telegramUserId,
      ...profileData,
    });
  }

  return updateProfile(
    telegramUserId,
    profileData
  );
}

module.exports = {
  getProfile,
  createProfile,
  updateProfile,
  upsertProfile,
};