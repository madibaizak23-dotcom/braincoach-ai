# Monday Generator MVP-1 Applied Review

Status: Applied Manually By Owner, Approved For Pilot Review, Not Published

Date: 2026-06-18

Database target: `bgs_orch`

Schema target: `production`

Seed file:

`braincoach-docs/07_automation/04_postgres/010_seed_generated_assets_2026_06_22_monday_mvp.sql`

## Installation Confirmation

Owner applied:

```text
\i 010_seed_generated_assets_2026_06_22_monday_mvp.sql
```

Result:

```text
BEGIN
DELETE 0
INSERT 0 11
COMMIT
```

Confirmed asset count:

```text
monday_generated_assets = 11
```

Confirmed safety state:

```text
voice_check_status = pending
approval_status   = pending
assets            = 11
```

Interpretation:

The seed successfully created 11 generated draft assets. It did not approve, schedule, or publish content.

## Purpose

Prepare the first `generated_content_assets` package for Monday 2026-06-22 under weekly plan:

```text
CPLAN-2026-06-22-W01
Мы столько вложили. Что останется к осени?
```

This is the first operational test of:

```text
content_units
->
generated_content_assets
->
review
```

## Package Scope

The seed inserts 11 draft assets:

| content unit | asset type |
| --- | --- |
| `CUNIT-2026-06-22-IG-STORY-01` | `story_slide` |
| `CUNIT-2026-06-22-IG-STORY-02` | `story_slide` |
| `CUNIT-2026-06-22-IG-REEL-01` | `reel_script` |
| `CUNIT-2026-06-22-IG-STORY-03` | `story_slide` |
| `CUNIT-2026-06-22-IG-STORY-04` | `story_slide` |
| `CUNIT-2026-06-22-IG-STORY-05` | `story_slide` |
| `CUNIT-2026-06-22-THREADS-01` | `thread_post` |
| `CUNIT-2026-06-22-FB-01` | `facebook_post` |
| `CUNIT-2026-06-22-TG-01` | `telegram_note` |
| `CUNIT-2026-06-22-TIKTOK-01` | `short_script` |
| `CUNIT-2026-06-22-YTSHORTS-01` | `short_script` |

## Safety

The seed:

* does not alter schema;
* does not update `content_units`;
* does not approve assets;
* does not schedule publishing;
* does not publish anything;
* deletes only previous generated assets with:

```text
metadata.generator = monday_generator_mvp1
metadata.content_plan_code = CPLAN-2026-06-22-W01
metadata.planned_date = 2026-06-22
```

## Review Status

All inserted assets use:

```text
voice_check_status = pending
approval_status   = pending
```

The package must be reviewed for:

* preservation of the weekly conversation;
* Navigation Universe visibility;
* avoidance of research / framework language;
* channel-native adaptation;
* parent response potential.

Pilot review verdict:

```text
Approved for pilot review.
Do not publish automatically.
Do not generate Tuesday until Monday assets pass human review or corrections are captured.
```

## Pre-Mass-Generation Corrections

Before generating Tuesday and the rest of the week, the generator must follow two additional rules.

Rule 1:

```text
Main Conversation stays constant.
Daily language changes.
```

For `CPLAN-2026-06-22-W01`, this means:

| day | daily language focus |
| --- | --- |
| Monday | Мы столько вложили |
| Tuesday | Когда вы впервые начали переживать? |
| Wednesday | Почему одинаковые возможности дают разный результат? |
| Thursday | Что можно потерять этим летом? |
| Friday | Что вы уже пробовали? |
| Saturday | Почему помощь не всегда превращается в движение? |
| Sunday | Где за неделю проявились главные сигналы? |

Rule 2:

Use `trajectory` as an internal BrainCoach word, not as the dominant public word.

Preferred public language:

* движение;
* прогресс;
* направление;
* результат;
* что держится в ребенке;
* что продолжает работать без внешней поддержки.

Avoid overusing:

* траектория;
* вложения;
* система;
* диагностика.

The Monday package may keep stronger investment language because Monday opens the weekly conversation. Later days must breathe through their own daily question.

## Preview Review Correction

Owner-provided preview confirmed that assets were inserted and readable in UTF-8.

The preview also showed that some public-facing assets still overused internal language:

* `траектория`;
* `внешняя система`;
* movement phrased too much as an internal BrainCoach concept.

Applied correction seed:

`braincoach-docs/07_automation/04_postgres/011_update_monday_generated_assets_public_language_v1.sql`

Owner applied the correction manually in Cloud SQL.

Confirmed:

```text
corrected_assets = 4
voice_check_status = pending
approval_status = pending
assets = 11
```

Scope:

* `CUNIT-2026-06-22-IG-REEL-01`
* `CUNIT-2026-06-22-IG-STORY-05`
* `CUNIT-2026-06-22-THREADS-01`
* `CUNIT-2026-06-22-TG-01`

Correction:

* reduce public use of `траектория`;
* replace with `движение`, `прогресс`, `внешняя поддержка`;
* keep weekly conversation intact;
* keep all statuses pending.

This correction remains within the approved asset layer and does not change `content_units` or weekly structure.

## Next Step

Send Monday assets to Telegram Review:

```text
generated_content_assets
->
Telegram Review
->
Human Corrections / Approval
```

Do not start Tuesday Generator until Monday review decisions are captured.
