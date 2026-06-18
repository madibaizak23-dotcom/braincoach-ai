-- =====================================================
-- BrainCoach Seed 010
-- Monday Generator MVP for CPLAN-2026-06-22-W01
-- Date: 2026-06-18
-- Target database: bgs_orch
-- Target schema: production
--
-- Purpose:
--   Insert first generated_content_assets drafts for Monday 2026-06-22.
--
-- Safety:
--   - Does not alter schema.
--   - Does not approve assets.
--   - Does not schedule or publish anything.
--   - Deletes only previous assets created by this exact generator marker.
--
-- Prerequisites:
--   008_bgs_orch_weekly_content_automation_mvp1.sql
--   009_seed_weekly_content_plan_2026_06_22.sql
-- =====================================================

BEGIN;

DELETE FROM production.generated_content_assets
WHERE metadata->>'generator' = 'monday_generator_mvp1'
  AND metadata->>'content_plan_code' = 'CPLAN-2026-06-22-W01'
  AND metadata->>'planned_date' = '2026-06-22';

WITH assets (
    content_unit_code,
    asset_type,
    asset_text,
    asset_payload,
    metadata
) AS (
    VALUES
    (
        'CUNIT-2026-06-22-IG-STORY-01',
        'story_slide',
        $$STORY 1 / Observation

Text:
Лето уже началось.

Репетитор был.
Тренировки были.
Лагерь или английский уже в планах.

Вопрос не в том, сколько вложили.

Вопрос: что из этого уже держится в ребенке?

Visual:
Navigation map of summer season. One route line, checkpoint "June 22", small markers: tutor, camp, sport, English.

Sticker:
Slider: "Насколько понятно, что реально осталось?"

Signal to capture:
Slider reactions and replies about unclear progress.$$,
        $${
          "platform": "Instagram",
          "format": "Story",
          "story_role": "observation",
          "visual_world": "Competitive Trajectory + Navigation",
          "navigation_element": "season checkpoint",
          "cta_type": "soft_reaction",
          "expected_signal": "Replies about already-made investments and unclear remaining progress",
          "qa": {
            "weekly_conversation_preserved": true,
            "research_language_avoided": true,
            "parent_reality_language": true
          }
        }$$::jsonb,
        '{"generator":"monday_generator_mvp1","content_plan_code":"CPLAN-2026-06-22-W01","planned_date":"2026-06-22","asset_version":"draft_v1","day_package":"monday_investment"}'::jsonb
    ),
    (
        'CUNIT-2026-06-22-IG-STORY-02',
        'story_slide',
        $$STORY 2 / Poll

Text:
Если честно, куда этим летом уже больше всего ушли вложения?

Poll options:
1. Репетитор
2. Спорт
3. Английский
4. Лагерь

Small caption:
Можно выбрать не идеальный ответ, а главный по ощущениям.

Visual:
Same season map. Four route branches from one parent decision point.

Signal to capture:
Which purchase category dominates the audience this week.$$,
        $${
          "platform": "Instagram",
          "format": "Story",
          "story_role": "poll",
          "visual_world": "Competitive Trajectory + Navigation",
          "navigation_element": "route branch",
          "poll_options": ["Репетитор", "Спорт", "Английский", "Лагерь"],
          "expected_signal": "Poll votes revealing previous purchase categories",
          "qa": {
            "weekly_conversation_preserved": true,
            "research_language_avoided": true,
            "parent_reality_language": true
          }
        }$$::jsonb,
        '{"generator":"monday_generator_mvp1","content_plan_code":"CPLAN-2026-06-22-W01","planned_date":"2026-06-22","asset_version":"draft_v1","day_package":"monday_investment"}'::jsonb
    ),
    (
        'CUNIT-2026-06-22-IG-REEL-01',
        'reel_script',
        $$IG REEL / Main phenomenon

Topic:
Мы столько вложили... а что реально осталось?

Hook, first 2 seconds:
Если посчитать последние 3 года, вы довольны отдачей?

Script:
Вы могли вложить в ребенка очень много.

Репетиторы.
Секции.
Английский.
Лагеря.
Сборы.
Время.
Нервы.
Дороги.

И главный вопрос летом не в том, были ли вложения.

Они были.

Вопрос другой:
что из этого сейчас держится без вас?

Если убрать расписание, тренера, репетитора, напоминания и родительский контроль, траектория продолжает двигаться?

Или она останавливается?

Вот это и показывает лето.

Не оценки.
Не обещания.
Не планы на сентябрь.

А то, что реально встроилось в ребенка.

CTA:
Напишите в DM одно слово: "вложения".
Разберем, что уже держится само, а что пока держится на внешней системе.

Caption:
Мы столько вложили. Что останется к осени?

Visual:
Navigation dashboard. A summer route line with investment checkpoints behind and a question mark near autumn. Use movement line, coordinates, checkpoints, not space or comics.

Production notes:
Calm direct voice. No expert terminology. Parent reality first.$$,
        $${
          "platform": "Instagram",
          "format": "Reel",
          "asset_role": "main_day_phenomenon",
          "visual_world": "Competitive Trajectory + Navigation",
          "hook": "Если посчитать последние 3 года, вы довольны отдачей?",
          "cta": "Напишите в DM одно слово: \"вложения\".",
          "expected_signal": "DM/comments about investments, tutors, camps, summer loss",
          "primary_kpi": "retention",
          "secondary_kpi": "dm_profile_visits",
          "qa": {
            "weekly_conversation_preserved": true,
            "navigation_universe_visible": true,
            "research_language_avoided": true,
            "parent_response_potential": true
          }
        }$$::jsonb,
        '{"generator":"monday_generator_mvp1","content_plan_code":"CPLAN-2026-06-22-W01","planned_date":"2026-06-22","asset_version":"draft_v1","day_package":"monday_investment"}'::jsonb
    ),
    (
        'CUNIT-2026-06-22-IG-STORY-03',
        'story_slide',
        $$STORY 3 / Insight after Reel

Text:
Самое сложное:

отдача от вложений не всегда видна сразу.

Иногда ребенок вроде "занимался".
Но если снять внешнюю опору, движение пропадает.

Question sticker:
Что сейчас видно по вашему ребенку?

1. Движение есть
2. Держится только с контролем
3. Пока непонятно

Visual:
Route line continues after checkpoint, then becomes dotted where external support disappears.

Signal to capture:
Replies about invisible progress and dependence on control.$$,
        $${
          "platform": "Instagram",
          "format": "Story",
          "story_role": "insight_after_reel",
          "visual_world": "Competitive Trajectory + Navigation",
          "navigation_element": "dotted route after support removal",
          "expected_signal": "Replies about unclear or invisible progress",
          "qa": {
            "weekly_conversation_preserved": true,
            "research_language_avoided": true,
            "parent_reality_language": true
          }
        }$$::jsonb,
        '{"generator":"monday_generator_mvp1","content_plan_code":"CPLAN-2026-06-22-W01","planned_date":"2026-06-22","asset_version":"draft_v1","day_package":"monday_investment"}'::jsonb
    ),
    (
        'CUNIT-2026-06-22-IG-STORY-04',
        'story_slide',
        $$STORY 4 / Evening Question

Text:
Проверочный вопрос на вечер.

Если завтра убрать внешнюю поддержку:

репетитора,
тренера,
напоминания,
родительский контроль,

что исчезнет первым?

Question sticker:
Что исчезнет первым?

Visual:
Navigation fork: "держится само" vs "держится на системе".

Signal to capture:
Replies naming the fragile part of the child's trajectory.$$,
        $${
          "platform": "Instagram",
          "format": "Story",
          "story_role": "question",
          "visual_world": "Competitive Trajectory + Navigation",
          "navigation_element": "fork",
          "expected_signal": "Replies about support disappearing first",
          "qa": {
            "weekly_conversation_preserved": true,
            "research_language_avoided": true,
            "parent_response_potential": true
          }
        }$$::jsonb,
        '{"generator":"monday_generator_mvp1","content_plan_code":"CPLAN-2026-06-22-W01","planned_date":"2026-06-22","asset_version":"draft_v1","day_package":"monday_investment"}'::jsonb
    ),
    (
        'CUNIT-2026-06-22-IG-STORY-05',
        'story_slide',
        $$STORY 5 / CTA

Text:
Если хотите, можно коротко написать в DM:

"что вложили"
и
"что хотите сохранить к осени".

Я посмотрю не с позиции оценок.

А с позиции траектории:
что уже держится само,
а что пока держится на вас.

CTA:
DM: "вложения"

Visual:
Compact route card with two fields: "вложено" and "должно остаться".

Signal to capture:
DM stories with investments and expected outcomes.$$,
        $${
          "platform": "Instagram",
          "format": "Story",
          "story_role": "cta",
          "visual_world": "Competitive Trajectory + Navigation",
          "navigation_element": "route card",
          "cta": "DM: \"вложения\"",
          "expected_signal": "DM stories with investments and expected outcomes",
          "qa": {
            "weekly_conversation_preserved": true,
            "research_language_avoided": true,
            "parent_response_potential": true
          }
        }$$::jsonb,
        '{"generator":"monday_generator_mvp1","content_plan_code":"CPLAN-2026-06-22-W01","planned_date":"2026-06-22","asset_version":"draft_v1","day_package":"monday_investment"}'::jsonb
    ),
    (
        'CUNIT-2026-06-22-THREADS-01',
        'thread_post',
        $$THREADS / Thought lab

Иногда родители покупают не развитие.

Они покупают надежду, что траектория не сорвется.

Репетитор.
Секция.
Английский.
Лагерь.

Все это может быть полезно.

Но летом становится видно другое:

что ребенок уже может удерживать сам,
а что держалось только потому, что вокруг была внешняя система.

Главный вопрос недели:
что из вложенного должно остаться к осени?

И где сейчас риск, что оно просто исчезнет?

Question:
Что из вложенного для вас важнее всего сохранить?$$,
        $${
          "platform": "Threads",
          "format": "Thread",
          "asset_role": "thought_lab",
          "visual_world": "Competitive Trajectory + Navigation",
          "expected_signal": "Replies and reposts around investment anxiety",
          "cta": "Что из вложенного для вас важнее всего сохранить?",
          "qa": {
            "adapted_not_copied": true,
            "weekly_conversation_preserved": true,
            "research_language_avoided": true
          }
        }$$::jsonb,
        '{"generator":"monday_generator_mvp1","content_plan_code":"CPLAN-2026-06-22-W01","planned_date":"2026-06-22","asset_version":"draft_v1","day_package":"monday_investment"}'::jsonb
    ),
    (
        'CUNIT-2026-06-22-FB-01',
        'facebook_post',
        $$FACEBOOK / Parent discussion

Мы столько вложили. Что останется к осени?

Летом у родителей появляется очень неприятный, но честный вопрос.

Не "занимался ли ребенок".
Не "были ли репетиторы".
Не "сколько мы сделали".

А что из этого реально осталось в ребенке.

Потому что можно вложить много:

репетитор,
английский,
спорт,
лагерь,
интенсив,
дороги,
время,
родительский контроль.

Но если снять внешнюю систему, иногда оказывается, что движение держалось не на сформированной способности, а на расписании, взрослом рядом и постоянном напоминании.

Это не значит, что вложения были зря.

Это значит, что нужно увидеть, где они уже стали самостоятельным движением, а где еще требуют переноса внутрь ребенка.

Вопрос недели простой:

Что держится само, а что держится на вас?

Если у вас этим летом уже есть ощущение, что вложений много, а отдача неясна, напишите в комментарии:

что вы уже пробовали
и что хотите сохранить к осени.

Не обязательно подробно. Иногда одного слова достаточно:
"репетитор", "хоккей", "английский", "лагерь", "поступление".$$,
        $${
          "platform": "Facebook",
          "format": "Post",
          "asset_role": "parent_discussion",
          "visual_world": "Competitive Trajectory + Navigation",
          "expected_signal": "Parent comments with detailed context",
          "cta": "Напишите, что уже пробовали и что хотите сохранить к осени.",
          "qa": {
            "adapted_not_copied": true,
            "weekly_conversation_preserved": true,
            "parent_discussion_fit": true,
            "research_language_avoided": true
          }
        }$$::jsonb,
        '{"generator":"monday_generator_mvp1","content_plan_code":"CPLAN-2026-06-22-W01","planned_date":"2026-06-22","asset_version":"draft_v1","day_package":"monday_investment"}'::jsonb
    ),
    (
        'CUNIT-2026-06-22-TG-01',
        'telegram_note',
        $$TELEGRAM / Weekly hub note

Карта недели: инвестиция сделана. Где сейчас траектория?

На этой неделе смотрим не на оценки и не на красивые планы.

Смотрим на один вопрос:

что из вложенного уже держится само,
а что держится на внешней системе?

Почему это важно летом:

1. В июне уже видно, сохраняется ли темп.
2. Без школы и привычного режима проявляется реальная самостоятельность.
3. Репетитор, тренер или лагерь могут помогать, но не всегда оставляют переносимый результат.
4. Родители часто чувствуют тревогу раньше, чем появляются формальные проблемы.

Главный разговор недели:

Мы столько вложили.
Что останется к осени?

Сегодняшний вопрос:

Если убрать внешнюю поддержку, какая часть траектории ребенка продолжит двигаться?

Ответьте одним сообщением:

"держится само: ..."
"держится на нас: ..."

Эти ответы станут картой сигналов недели.$$,
        $${
          "platform": "Telegram",
          "format": "Note",
          "asset_role": "weekly_hub",
          "visual_world": "Competitive Trajectory + Navigation",
          "expected_signal": "Replies and reactions to weekly map",
          "cta": "Ответьте: держится само / держится на нас.",
          "qa": {
            "adapted_not_copied": true,
            "weekly_conversation_preserved": true,
            "depth_channel_fit": true,
            "research_language_avoided": true
          }
        }$$::jsonb,
        '{"generator":"monday_generator_mvp1","content_plan_code":"CPLAN-2026-06-22-W01","planned_date":"2026-06-22","asset_version":"draft_v1","day_package":"monday_investment"}'::jsonb
    ),
    (
        'CUNIT-2026-06-22-TIKTOK-01',
        'short_script',
        $$TIKTOK / Short adaptation

Hook:
Родители, честно: что из вложений реально осталось?

Script:
Вы могли оплатить репетитора.
Секцию.
Английский.
Лагерь.
Интенсив.

Но лето показывает не сумму вложений.

Лето показывает, что ребенок может удержать без внешней системы.

Если убрать тренера, расписание, напоминания и контроль, движение продолжается?

Или всё останавливается?

Вот это и есть главный вопрос:

что из вложенного останется к осени?

CTA:
Напишите одно слово: что вы уже вложили?

Visual:
Fast cuts over navigation route: investment checkpoints -> dotted summer line -> autumn checkpoint.

Production note:
Faster rhythm than Instagram Reel. Keep serious parent tone, not entertainment tone.$$,
        $${
          "platform": "TikTok",
          "format": "Short",
          "asset_role": "fast_hook",
          "visual_world": "Competitive Trajectory + Navigation",
          "hook": "Родители, честно: что из вложений реально осталось?",
          "expected_signal": "Views and comments from broader audience",
          "cta": "Напишите одно слово: что вы уже вложили?",
          "qa": {
            "adapted_not_copied": true,
            "weekly_conversation_preserved": true,
            "platform_pacing_adjusted": true,
            "research_language_avoided": true
          }
        }$$::jsonb,
        '{"generator":"monday_generator_mvp1","content_plan_code":"CPLAN-2026-06-22-W01","planned_date":"2026-06-22","asset_version":"draft_v1","day_package":"monday_investment"}'::jsonb
    ),
    (
        'CUNIT-2026-06-22-YTSHORTS-01',
        'short_script',
        $$YOUTUBE SHORTS / Educational short

Title idea:
Как понять, что вложения в ребенка не превращаются в результат?

Hook:
Есть простой летний тест.

Script:
Если вы много вкладывали в ребенка последние годы, летом можно увидеть важный сигнал.

Не по оценкам.
Не по обещаниям.
Не по планам на сентябрь.

А по тому, что продолжает работать без внешней поддержки.

Спросите себя:

Если убрать репетитора, тренера, расписание и напоминания, ребенок продолжит двигаться?

Если да, часть вложений уже стала его способностью.

Если нет, значит результат пока держится на системе вокруг ребенка.

Это не провал.

Это точка диагностики.

CTA:
Сохраните и проверьте: что у ребенка держится само, а что держится на вас?

Visual:
Clean navigation board: "external support" on left, "internalized ability" on right, route line moving toward autumn.

Production note:
More explanatory than TikTok. Search-friendly and calm.$$,
        $${
          "platform": "YouTube Shorts",
          "format": "Short",
          "asset_role": "educational_short",
          "visual_world": "Competitive Trajectory + Navigation",
          "hook": "Есть простой летний тест.",
          "expected_signal": "Retention and viewed vs swiped",
          "cta": "Сохраните и проверьте: что держится само?",
          "qa": {
            "adapted_not_copied": true,
            "weekly_conversation_preserved": true,
            "search_friendly": true,
            "research_language_avoided": true
          }
        }$$::jsonb,
        '{"generator":"monday_generator_mvp1","content_plan_code":"CPLAN-2026-06-22-W01","planned_date":"2026-06-22","asset_version":"draft_v1","day_package":"monday_investment"}'::jsonb
    )
)
INSERT INTO production.generated_content_assets (
    content_unit_code,
    asset_type,
    asset_text,
    asset_payload,
    voice_check_status,
    approval_status,
    metadata
)
SELECT
    content_unit_code,
    asset_type,
    asset_text,
    asset_payload,
    'pending',
    'pending',
    metadata
FROM assets;

COMMIT;

-- =====================================================
-- Verification queries:
--
-- SELECT count(*) AS monday_generated_assets
-- FROM production.generated_content_assets
-- WHERE metadata->>'generator' = 'monday_generator_mvp1'
--   AND metadata->>'content_plan_code' = 'CPLAN-2026-06-22-W01'
--   AND metadata->>'planned_date' = '2026-06-22';
--
-- SELECT
--   g.content_unit_code,
--   u.platform,
--   u.format,
--   g.asset_type,
--   g.voice_check_status,
--   g.approval_status
-- FROM production.generated_content_assets g
-- JOIN production.content_units u
--   ON u.content_unit_code = g.content_unit_code
-- WHERE g.metadata->>'generator' = 'monday_generator_mvp1'
--   AND g.metadata->>'content_plan_code' = 'CPLAN-2026-06-22-W01'
--   AND g.metadata->>'planned_date' = '2026-06-22'
-- ORDER BY u.platform, u.format, g.content_unit_code;
--
-- SELECT
--   g.content_unit_code,
--   left(g.asset_text, 160) AS preview
-- FROM production.generated_content_assets g
-- WHERE g.metadata->>'generator' = 'monday_generator_mvp1'
-- ORDER BY g.content_unit_code;
-- =====================================================
