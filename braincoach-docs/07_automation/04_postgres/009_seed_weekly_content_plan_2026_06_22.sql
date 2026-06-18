-- =====================================================
-- BrainCoach Seed 009
-- Weekly Content Plan Seed: 2026-06-22 -> 2026-06-28
-- Database: bgs_orch
-- Schema: production
-- Date: 2026-06-18
--
-- Manual install only.
-- Requires:
--   008_bgs_orch_weekly_content_automation_mvp1.sql
--
-- Purpose:
-- Seed the first Weekly Content Automation MVP-1 content matrix.
-- This file inserts the weekly strategy and planned content units only.
-- It does not insert generated scripts/assets yet.
-- =====================================================

INSERT INTO production.weekly_content_plans (
    content_plan_code,
    week_start_date,
    week_end_date,
    weekly_theme,
    main_conversation,
    main_tension,
    main_question,
    weekly_hypothesis,
    visual_master_world,
    weekly_visual_world,
    status,
    source_paths,
    metadata
)
VALUES (
    'CPLAN-2026-06-22-W01',
    '2026-06-22',
    '2026-06-28',
    'Мы столько вложили. Что останется к осени?',
    'Мы столько вложили. Что останется к осени?',
    'Лето показывает разницу между тем, что встроено в ребёнка, и тем, что держалось на внешней системе. Родители продолжают инвестировать время, деньги и усилия, но не понимают: сохраняется прогресс или постепенно исчезает.',
    'Что держится само, а что держится на вас?',
    'Competitive Trajectory Families откликнутся на язык вложений, потери темпа, потери сезона, внешней поддержки и вопроса: конвертируются ли инвестиции в реальный прогресс.',
    'Navigation Universe',
    'Competitive Trajectory + Navigation',
    'draft',
    '["braincoach-docs/07_automation/production_os/03_content/weekly_content_generation_mvp1.md","braincoach-docs/07_automation/production_os/03_content/cascading_content_generation_protocol_v1.md","braincoach-docs/07_automation/production_os/04_execution/publishing_scheduler_hypothesis_v1.md"]'::jsonb,
    '{
      "season": "Summer 2026",
      "status": "Draft v1",
      "primary_audience": "Competitive Trajectory Families",
      "weekly_objective": "Collect parent stories about investments, failed solutions, loss of momentum, summer regression, dependency on external support, and lost opportunities.",
      "primary_cta": "Interviewer",
      "secondary_cta": "GPS Summer Tracker",
      "success_signals": [
        "parent_stories",
        "dm_conversations",
        "interview_starts",
        "previous_purchases_mentioned",
        "last_straw_events"
      ],
      "discovery_targets": [
        "What have parents already paid for?",
        "What stopped working after support disappeared?",
        "What signals made parents worried?",
        "What do parents fear losing most?",
        "What outcomes are they actually trying to buy?"
      ],
      "supporting_visual_worlds": ["Navigation", "Architecture", "Intelligence"],
      "publishing_scheduler_hypothesis": {
        "status": "candidate_weekly_baseline",
        "review_rule": "Use this schedule for one week, then adapt only after comparing planned window, actual publish time, and outcomes.",
        "formats": [
          {
            "format": "Stories 1-2",
            "window": "08:00-10:00",
            "hypothesis": "Утренний контакт и быстрый вход в день.",
            "test": ["replies", "taps_forward_back", "poll_participation"]
          },
          {
            "format": "Reel / Shorts / TikTok",
            "window": "13:00-15:00 or 17:00-18:00",
            "hypothesis": "Главный феномен дня, когда можно зацепить внимание.",
            "test": ["reach", "watch_time", "completion", "shares"]
          },
          {
            "format": "Stories 3",
            "window": "17:00-18:00",
            "hypothesis": "Инсайт после рилса, перевод в диалог.",
            "test": ["replies", "sticker_taps", "profile_visits"]
          },
          {
            "format": "Stories 4-5",
            "window": "20:00-21:30",
            "hypothesis": "Вечерний CTA и DM-окно для родителей.",
            "test": ["dm", "link_clicks", "replies", "exits"]
          },
          {
            "format": "Carousel",
            "window": "10:00-14:00",
            "hypothesis": "Спокойное чтение и сохранения.",
            "test": ["saves_per_100_views", "average_dwell", "shares"]
          },
          {
            "format": "Facebook",
            "window": "19:00-21:00",
            "hypothesis": "Более зрелый родительский разбор.",
            "test": ["comments", "saves", "clicks", "shares"]
          },
          {
            "format": "Telegram",
            "window": "20:00-22:00",
            "hypothesis": "Глубина, итоги, голосовые, вопрос дня.",
            "test": ["reads", "reactions", "replies", "forwards"]
          },
          {
            "format": "Threads",
            "window": "09:00, 14:00, 21:00",
            "hypothesis": "Быстрые тезисы и проверка формулировок.",
            "test": ["replies", "reposts", "profile_clicks", "saves"],
            "mvp_rule": "One primary Threads unit per day is stored in content_units; additional time slots are treated as optional amplification until the workflow is stable."
          }
        ]
      },
      "communication_rule": {
        "use": ["conversations", "questions", "tensions", "parent reality", "stories"],
        "avoid": ["research language", "framework language", "expert terminology", "educational jargon"]
      }
    }'::jsonb
)
ON CONFLICT (content_plan_code) DO UPDATE SET
    week_start_date = EXCLUDED.week_start_date,
    week_end_date = EXCLUDED.week_end_date,
    weekly_theme = EXCLUDED.weekly_theme,
    main_conversation = EXCLUDED.main_conversation,
    main_tension = EXCLUDED.main_tension,
    main_question = EXCLUDED.main_question,
    weekly_hypothesis = EXCLUDED.weekly_hypothesis,
    visual_master_world = EXCLUDED.visual_master_world,
    weekly_visual_world = EXCLUDED.weekly_visual_world,
    status = EXCLUDED.status,
    source_paths = EXCLUDED.source_paths,
    metadata = EXCLUDED.metadata,
    updated_at = now();

WITH units (
    content_unit_code,
    planned_date,
    weekday,
    platform,
    format,
    topic,
    hypothesis,
    publishing_time_label,
    expected_signal,
    primary_kpi,
    secondary_kpi,
    cta,
    source_meaning,
    metadata
) AS (
    VALUES
    -- =====================================================
    -- MONDAY 2026-06-22: Investment
    -- =====================================================
    ('CUNIT-2026-06-22-IG-STORY-01', '2026-06-22'::date, 'Monday', 'Instagram', 'Story', 'Утреннее наблюдение: вложения уже сделаны', 'Родители узнают напряжение вложений без ясной отдачи.', '08:00-10:00', 'Story replies about money, time, effort already invested', 'story_replies', 'poll_votes', 'Ответьте: что вы уже вложили?', 'Day 1 Investment', '{"story_role":"observation","visual_object":"season map checkpoint"}'::jsonb),
    ('CUNIT-2026-06-22-IG-STORY-02', '2026-06-22'::date, 'Monday', 'Instagram', 'Story', 'Опрос: что больше всего вложили?', 'Опрос покажет, какие инвестиции родители считают значимыми.', '08:00-10:00', 'Poll choices reveal purchase categories', 'poll_votes', 'dm_replies', 'Проголосуйте', 'Day 1 Investment', '{"story_role":"poll","poll_options":["репетитор","спорт","английский","лагерь"]}'::jsonb),
    ('CUNIT-2026-06-22-IG-REEL-01', '2026-06-22'::date, 'Monday', 'Instagram', 'Reel', 'Мы столько вложили... а что реально осталось?', 'Родители узнают тревогу о том, конвертировались ли вложения в реальный прогресс.', '13:00-15:00', 'DM / comments about investments, tutors, camps, summer loss', 'retention', 'dm_profile_visits', 'Ответьте в DM', 'Day 1 Investment', '{"visual_object":"navigation map of season investment"}'::jsonb),
    ('CUNIT-2026-06-22-IG-STORY-03', '2026-06-22'::date, 'Monday', 'Instagram', 'Story', 'Инсайт после Reel: отдача не всегда видна сразу', 'После рилса родители дадут уточняющие реакции.', '17:00-18:00', 'Replies about invisible or unclear progress', 'story_replies', 'dm_replies', 'Что видно сейчас?', 'Day 1 Investment', '{"story_role":"insight_after_reel"}'::jsonb),
    ('CUNIT-2026-06-22-IG-STORY-04', '2026-06-22'::date, 'Monday', 'Instagram', 'Story', 'Вопрос: если убрать внешнюю поддержку?', 'Вопрос выявит зависимость результата от внешней системы.', '20:00-21:30', 'Replies about support disappearing', 'story_replies', 'dm_replies', 'Что исчезнет первым?', 'Day 1 Investment', '{"story_role":"question"}'::jsonb),
    ('CUNIT-2026-06-22-IG-STORY-05', '2026-06-22'::date, 'Monday', 'Instagram', 'Story', 'CTA: расскажите вашу историю вложений', 'CTA соберёт первые parent stories.', '20:00-21:30', 'DM stories with investments and expected outcomes', 'dm_conversations', 'interview_candidates', 'Напишите в DM: что вложили и что хотите сохранить?', 'Day 1 Investment', '{"story_role":"cta"}'::jsonb),
    ('CUNIT-2026-06-22-THREADS-01', '2026-06-22'::date, 'Monday', 'Threads', 'Thread', 'Иногда родители покупают не развитие, а надежду, что траектория не сорвётся.', 'Threads проверит короткую формулировку про инвестиции и риск.', '09:00', 'Replies / reposts around investment anxiety', 'replies', 'reposts', 'Что из вложенного должно остаться к осени?', 'Day 1 Investment', '{"adaptation":"thought_lab"}'::jsonb),
    ('CUNIT-2026-06-22-FB-01', '2026-06-22'::date, 'Monday', 'Facebook', 'Post', 'Главный пост недели: что останется к осени?', 'Facebook даст более зрелые родительские комментарии.', '19:00-21:00', 'Parent comments with detailed context', 'comments', 'shares', 'Расскажите, что вы уже пробовали этим летом.', 'Day 1 Investment', '{"adaptation":"parent_discussion"}'::jsonb),
    ('CUNIT-2026-06-22-TG-01', '2026-06-22'::date, 'Monday', 'Telegram', 'Note', 'Карта недели: инвестиция сделана, где траектория сейчас?', 'Telegram даст глубину и подготовит community room.', '20:00-22:00', 'Replies / reactions to weekly map', 'views', 'replies', 'Напишите один риск, который хотите не потерять за лето.', 'Day 1 Investment', '{"adaptation":"weekly_hub"}'::jsonb),
    ('CUNIT-2026-06-22-TIKTOK-01', '2026-06-22'::date, 'Monday', 'TikTok', 'Short', 'Родители, честно: что из вложений реально осталось?', 'TikTok проверит прямой эмоциональный hook.', '13:00-15:00', 'Views / comments from broader audience', 'views', 'comments', 'Напишите, что уже вложили.', 'Day 1 Investment', '{"adaptation":"fast_hook"}'::jsonb),
    ('CUNIT-2026-06-22-YTSHORTS-01', '2026-06-22'::date, 'Monday', 'YouTube Shorts', 'Short', 'Как понять, что вложения в ребёнка не превращаются в результат?', 'YouTube Shorts проверит образовательный search-friendly angle.', '18:00-21:00', 'Retention / viewed vs swiped', 'retention', 'views', 'Сохраните и проверьте свою ситуацию.', 'Day 1 Investment', '{"adaptation":"educational_short"}'::jsonb),

    -- =====================================================
    -- TUESDAY 2026-06-23: First Concern
    -- =====================================================
    ('CUNIT-2026-06-23-IG-STORY-01', '2026-06-23'::date, 'Tuesday', 'Instagram', 'Story', 'Наблюдение: первый сигнал редко про оценки', 'Родители вспомнят момент внутренней тревоги до внешней оценки.', '08:00-10:00', 'Replies about first concern moments', 'story_replies', 'dm_replies', 'Когда вы впервые почувствовали, что что-то идёт не так?', 'Day 2 First Concern', '{"story_role":"observation","visual_object":"route warning signal"}'::jsonb),
    ('CUNIT-2026-06-23-IG-STORY-02', '2026-06-23'::date, 'Tuesday', 'Instagram', 'Story', 'Опрос: что насторожило первым?', 'Опрос выявит основные first concern signals.', '08:00-10:00', 'Poll split by signal type', 'poll_votes', 'story_replies', 'Выберите первый сигнал', 'Day 2 First Concern', '{"story_role":"poll","poll_options":["стал тянуть","нет инициативы","результат исчез","зависит от контроля"]}'::jsonb),
    ('CUNIT-2026-06-23-IG-REEL-01', '2026-06-23'::date, 'Tuesday', 'Instagram', 'Reel', 'Когда вы впервые почувствовали, что что-то идёт не так?', 'Рилс соберёт истории о внутреннем сигнале родителя.', '13:00-15:00', 'Comments / DM with first concern stories', 'retention', 'comments_dm', 'Напишите вашу историю в комментарии или DM', 'Day 2 First Concern', '{"visual_object":"route fork with signal marker"}'::jsonb),
    ('CUNIT-2026-06-23-IG-STORY-03', '2026-06-23'::date, 'Tuesday', 'Instagram', 'Story', 'Инсайт: тревога начинается раньше провала', 'Инсайт помогает родителям назвать слабые сигналы.', '17:00-18:00', 'Replies naming weak signals', 'story_replies', 'dm_replies', 'Какой слабый сигнал вы заметили?', 'Day 2 First Concern', '{"story_role":"insight_after_reel"}'::jsonb),
    ('CUNIT-2026-06-23-IG-STORY-04', '2026-06-23'::date, 'Tuesday', 'Instagram', 'Story', 'Вопрос: что изменилось в темпе?', 'Вопрос переводит ощущение в наблюдаемую динамику.', '20:00-21:30', 'Responses about momentum and consistency', 'story_replies', 'dm_replies', 'Темп вырос, держится или падает?', 'Day 2 First Concern', '{"story_role":"question"}'::jsonb),
    ('CUNIT-2026-06-23-IG-STORY-05', '2026-06-23'::date, 'Tuesday', 'Instagram', 'Story', 'CTA: пришлите первый тревожный сигнал', 'CTA собирает raw signal language.', '20:00-21:30', 'DM with first concern signal', 'dm_conversations', 'signal_candidates', 'Пришлите одну фразу: с чего началась тревога?', 'Day 2 First Concern', '{"story_role":"cta"}'::jsonb),
    ('CUNIT-2026-06-23-THREADS-01', '2026-06-23'::date, 'Tuesday', 'Threads', 'Post', 'Первый сигнал часто не в оценках. Он в ощущении, что усилия перестали превращаться в движение.', 'Threads проверит wording про effort-to-motion.', '14:00', 'Replies / likes around phrase resonance', 'replies', 'likes', 'У вас так было?', 'Day 2 First Concern', '{"adaptation":"thought_lab"}'::jsonb),
    ('CUNIT-2026-06-23-TG-01', '2026-06-23'::date, 'Tuesday', 'Telegram', 'Note', 'Мини-разбор: как отличить слабый сигнал от случайного дня', 'Telegram углубляет first concern without jargon.', '20:00-22:00', 'Replies / reactions about weak signals', 'views', 'replies', 'Запишите один сигнал, который повторялся.', 'Day 2 First Concern', '{"adaptation":"depth"}'::jsonb),
    ('CUNIT-2026-06-23-TIKTOK-01', '2026-06-23'::date, 'Tuesday', 'TikTok', 'Short', 'Не оценки. А момент, когда вы поняли: что-то не конвертируется в результат.', 'TikTok проверит прямой first concern hook.', '19:00-21:00', 'Views / comments', 'views', 'comments', 'Когда вы это почувствовали?', 'Day 2 First Concern', '{"adaptation":"fast_hook"}'::jsonb),
    ('CUNIT-2026-06-23-YTSHORTS-01', '2026-06-23'::date, 'Tuesday', 'YouTube Shorts', 'Short', '3 ранних сигнала, что прогресс ребёнка держится не сам', 'Shorts проверит structured educational angle.', '18:00-21:00', 'Retention / saves', 'retention', 'views', 'Сохраните для проверки летом.', 'Day 2 First Concern', '{"adaptation":"educational_short"}'::jsonb),

    -- =====================================================
    -- WEDNESDAY 2026-06-24: Conversion Problem
    -- =====================================================
    ('CUNIT-2026-06-24-IG-STORY-01', '2026-06-24'::date, 'Wednesday', 'Instagram', 'Story', 'Наблюдение: одинаковые вложения, разные траектории', 'Родители увидят проблему не в сумме вложений, а в конверсии.', '08:00-10:00', 'Replies about siblings / peers / comparable investments', 'story_replies', 'dm_replies', 'Вы видели такую разницу?', 'Day 3 Conversion Problem', '{"story_role":"observation","visual_object":"two trajectories map"}'::jsonb),
    ('CUNIT-2026-06-24-IG-STORY-02', '2026-06-24'::date, 'Wednesday', 'Instagram', 'Story', 'Опрос: где теряется результат?', 'Опрос сегментирует conversion loss points.', '08:00-10:00', 'Poll votes by loss point', 'poll_votes', 'story_replies', 'Где у вас теряется результат?', 'Day 3 Conversion Problem', '{"story_role":"poll","poll_options":["после занятий","без контроля","летом","перед сложностью"]}'::jsonb),
    ('CUNIT-2026-06-24-IG-CAROUSEL-01', '2026-06-24'::date, 'Wednesday', 'Instagram', 'Carousel', 'Почему одинаковые вложения дают разный результат?', 'Carousel даст структуру и saves по механизму конверсии.', '10:00-14:00', 'Saves / shares / comments about conversion', 'saves', 'shares_comments', 'Где у вас теряется результат?', 'Day 3 Conversion Problem', '{"visual_object":"two investment routes diverging"}'::jsonb),
    ('CUNIT-2026-06-24-IG-STORY-03', '2026-06-24'::date, 'Wednesday', 'Instagram', 'Story', 'Инсайт после carousel: важна не только помощь, а перенос', 'Инсайт проверит язык transfer of support.', '17:00-18:00', 'Replies about support not transferring', 'story_replies', 'dm_replies', 'Что не переносится без взрослого?', 'Day 3 Conversion Problem', '{"story_role":"insight_after_carousel"}'::jsonb),
    ('CUNIT-2026-06-24-IG-STORY-04', '2026-06-24'::date, 'Wednesday', 'Instagram', 'Story', 'Вопрос: где ломается конверсия?', 'Вопрос собирает concrete cases.', '20:00-21:30', 'DM / replies with breakdown point', 'story_replies', 'dm_replies', 'Назовите одно место поломки', 'Day 3 Conversion Problem', '{"story_role":"question"}'::jsonb),
    ('CUNIT-2026-06-24-IG-STORY-05', '2026-06-24'::date, 'Wednesday', 'Instagram', 'Story', 'CTA: разбор одной ситуации', 'CTA переводит сильные кейсы в интервью / диагностику.', '20:00-21:30', 'DM requests for situation review', 'dm_conversations', 'interview_candidates', 'Напишите: где именно помощь перестаёт работать?', 'Day 3 Conversion Problem', '{"story_role":"cta"}'::jsonb),
    ('CUNIT-2026-06-24-THREADS-01', '2026-06-24'::date, 'Wednesday', 'Threads', 'Thread', 'Проблема не в том, сколько вложили. Проблема в том, что из вложенного стало способностью ребёнка.', 'Threads проверит concise mechanism wording.', '09:00', 'Replies / reposts around capability transfer', 'replies', 'reposts', 'Что из вложенного стало самостоятельностью?', 'Day 3 Conversion Problem', '{"adaptation":"thought_lab"}'::jsonb),
    ('CUNIT-2026-06-24-FB-01', '2026-06-24'::date, 'Wednesday', 'Facebook', 'Post', 'Почему одинаковые вложения дают разные результаты?', 'FB даст зрелую дискуссию и кейсы.', '19:00-21:00', 'Long comments / shares / parent examples', 'comments', 'shares', 'Где у вас теряется результат?', 'Day 3 Conversion Problem', '{"adaptation":"parent_discussion"}'::jsonb),
    ('CUNIT-2026-06-24-TG-01', '2026-06-24'::date, 'Wednesday', 'Telegram', 'Note', 'Разбор: вложение, помощь, перенос, самостоятельное движение', 'Telegram объяснит механизм глубже.', '20:00-22:00', 'Replies / saves / reactions', 'views', 'replies', 'Отметьте, где у ребёнка начинается самостоятельное движение.', 'Day 3 Conversion Problem', '{"adaptation":"depth"}'::jsonb),

    -- =====================================================
    -- THURSDAY 2026-06-25: Cost Of Delay
    -- =====================================================
    ('CUNIT-2026-06-25-IG-STORY-01', '2026-06-25'::date, 'Thursday', 'Instagram', 'Story', 'Наблюдение: самый дорогой риск летом не деньги', 'Родители распознают стоимость потерянного сезона.', '08:00-10:00', 'Replies about lost time / lost season', 'story_replies', 'dm_replies', 'Что летом дороже денег?', 'Day 4 Cost Of Delay', '{"story_role":"observation","visual_object":"tempo loss tracker"}'::jsonb),
    ('CUNIT-2026-06-25-IG-STORY-02', '2026-06-25'::date, 'Thursday', 'Instagram', 'Story', 'Опрос: что страшнее потерять?', 'Опрос выявит fear hierarchy.', '08:00-10:00', 'Poll split by fear type', 'poll_votes', 'story_replies', 'Выберите главный риск', 'Day 4 Cost Of Delay', '{"story_role":"poll","poll_options":["темп","форму","шанс","место/состав"]}'::jsonb),
    ('CUNIT-2026-06-25-IG-REEL-01', '2026-06-25'::date, 'Thursday', 'Instagram', 'Reel', 'Самый дорогой риск летом — не деньги', 'Рилс усилит urgency через lost season.', '13:00-15:00', 'Saves / shares / DM about losing season', 'retention', 'saves_shares', 'Сохраните и проверьте свой сезон', 'Day 4 Cost Of Delay', '{"visual_object":"trajectory losing speed"}'::jsonb),
    ('CUNIT-2026-06-25-IG-STORY-03', '2026-06-25'::date, 'Thursday', 'Instagram', 'Story', 'Инсайт после Reel: сезон нельзя купить назад', 'Инсайт проверит формулировку cost of delay.', '17:00-18:00', 'Replies about irreversible windows', 'story_replies', 'dm_replies', 'Какой шанс нельзя терять?', 'Day 4 Cost Of Delay', '{"story_role":"insight_after_reel"}'::jsonb),
    ('CUNIT-2026-06-25-IG-STORY-04', '2026-06-25'::date, 'Thursday', 'Instagram', 'Story', 'Вопрос: какой темп уже просел?', 'Вопрос собирает текущую reality check.', '20:00-21:30', 'Replies about visible momentum loss', 'story_replies', 'dm_replies', 'Где просел темп?', 'Day 4 Cost Of Delay', '{"story_role":"question"}'::jsonb),
    ('CUNIT-2026-06-25-IG-STORY-05', '2026-06-25'::date, 'Thursday', 'Instagram', 'Story', 'CTA: летняя проверка траектории', 'CTA переводит urgency в GPS Summer Tracker.', '20:00-21:30', 'DM interest in tracker / diagnostic', 'dm_conversations', 'tracker_interest', 'Напишите «лето», если хотите проверить траекторию', 'Day 4 Cost Of Delay', '{"story_role":"cta"}'::jsonb),
    ('CUNIT-2026-06-25-THREADS-01', '2026-06-25'::date, 'Thursday', 'Threads', 'Post', 'Потерять 50 тысяч неприятно. Потерять сезон иногда дороже.', 'Threads проверит sharp cost framing.', '14:00', 'Replies / reposts / disagreement', 'replies', 'reposts', 'Что для вас дороже сезона?', 'Day 4 Cost Of Delay', '{"adaptation":"thought_lab"}'::jsonb),
    ('CUNIT-2026-06-25-FB-01', '2026-06-25'::date, 'Thursday', 'Facebook', 'Post', 'Почему потеря сезона дороже потери денег', 'FB даст parent discussion around opportunity cost.', '19:00-21:00', 'Comments with lost opportunity stories', 'comments', 'shares', 'Что вы боитесь потерять этим летом?', 'Day 4 Cost Of Delay', '{"adaptation":"parent_discussion"}'::jsonb),
    ('CUNIT-2026-06-25-TG-01', '2026-06-25'::date, 'Thursday', 'Telegram', 'Note', 'Вечерняя карта: где лето съедает темп', 'Telegram углубит daily reflection.', '20:00-22:00', 'Replies / reactions', 'views', 'replies', 'Отметьте один участок, где темп просел.', 'Day 4 Cost Of Delay', '{"adaptation":"depth"}'::jsonb),
    ('CUNIT-2026-06-25-TIKTOK-01', '2026-06-25'::date, 'Thursday', 'TikTok', 'Short', 'Летом можно потерять не деньги. Можно потерять сезон.', 'TikTok проверит urgency hook.', '19:00-21:00', 'Views / comments', 'views', 'comments', 'Что нельзя потерять этим летом?', 'Day 4 Cost Of Delay', '{"adaptation":"fast_hook"}'::jsonb),
    ('CUNIT-2026-06-25-YTSHORTS-01', '2026-06-25'::date, 'Thursday', 'YouTube Shorts', 'Short', 'Почему летняя пауза может стоить дороже репетитора', 'Shorts проверит educational cost-of-delay angle.', '18:00-21:00', 'Retention / viewed vs swiped', 'retention', 'views', 'Сохраните для летней проверки.', 'Day 4 Cost Of Delay', '{"adaptation":"educational_short"}'::jsonb),

    -- =====================================================
    -- FRIDAY 2026-06-26: Attempted Solutions
    -- =====================================================
    ('CUNIT-2026-06-26-IG-STORY-01', '2026-06-26'::date, 'Friday', 'Instagram', 'Story', 'Наблюдение: родители уже что-то купили этим летом', 'Родители назовут already-paid solutions.', '08:00-10:00', 'Replies about purchased solutions', 'story_replies', 'dm_replies', 'Что уже пробовали?', 'Day 5 Attempted Solutions', '{"story_role":"observation","visual_object":"market map of solutions"}'::jsonb),
    ('CUNIT-2026-06-26-IG-STORY-02', '2026-06-26'::date, 'Friday', 'Instagram', 'Story', 'Опрос: что уже купили?', 'Опрос собирает prior purchases.', '08:00-10:00', 'Poll votes by solution category', 'poll_votes', 'story_replies', 'Выберите, что уже было', 'Day 5 Attempted Solutions', '{"story_role":"poll","poll_options":["репетитор","лагерь","секция","английский"]}'::jsonb),
    ('CUNIT-2026-06-26-IG-CAROUSEL-01', '2026-06-26'::date, 'Friday', 'Instagram', 'Carousel', 'Что родители уже пробовали этим летом?', 'Carousel собирает рынок через already bought solutions.', '10:00-14:00', 'Comments / saves / DM about what helped', 'saves', 'comments_dm', 'Что реально помогло?', 'Day 5 Attempted Solutions', '{"visual_object":"investment map"}'::jsonb),
    ('CUNIT-2026-06-26-IG-STORY-03', '2026-06-26'::date, 'Friday', 'Instagram', 'Story', 'Инсайт после carousel: покупка решения не равна движению', 'Инсайт проверит difference between purchase and effect.', '17:00-18:00', 'Replies about solutions without effect', 'story_replies', 'dm_replies', 'Что было, но не дало движения?', 'Day 5 Attempted Solutions', '{"story_role":"insight_after_carousel"}'::jsonb),
    ('CUNIT-2026-06-26-IG-STORY-04', '2026-06-26'::date, 'Friday', 'Instagram', 'Story', 'Вопрос: что реально помогло?', 'Вопрос собирает success / failure split.', '20:00-21:30', 'Replies naming helped / failed solutions', 'story_replies', 'dm_replies', 'Что реально помогло?', 'Day 5 Attempted Solutions', '{"story_role":"question"}'::jsonb),
    ('CUNIT-2026-06-26-IG-STORY-05', '2026-06-26'::date, 'Friday', 'Instagram', 'Story', 'CTA: напишите, что не сработало', 'CTA собирает failed attempts and payment stories.', '20:00-21:30', 'DM with failed attempts', 'dm_conversations', 'payment_trigger_mentions', 'Напишите в DM: что купили, но не сработало?', 'Day 5 Attempted Solutions', '{"story_role":"cta"}'::jsonb),
    ('CUNIT-2026-06-26-THREADS-01', '2026-06-26'::date, 'Friday', 'Threads', 'Post', 'Список купленных решений часто длиннее списка реальных изменений.', 'Threads проверит wording about purchased solutions.', '09:00', 'Replies / reposts', 'replies', 'reposts', 'Что было куплено, но не изменило траекторию?', 'Day 5 Attempted Solutions', '{"adaptation":"thought_lab"}'::jsonb),
    ('CUNIT-2026-06-26-FB-01', '2026-06-26'::date, 'Friday', 'Facebook', 'Post', 'Что родители уже пробовали этим летом?', 'FB даст detailed parent comments about solutions.', '19:00-21:00', 'Comments with prior purchases / failed attempts', 'comments', 'shares', 'Что реально помогло?', 'Day 5 Attempted Solutions', '{"adaptation":"parent_discussion"}'::jsonb),
    ('CUNIT-2026-06-26-TG-01', '2026-06-26'::date, 'Friday', 'Telegram', 'Note', 'Список решений: что купили, что сработало, что не перенеслось', 'Telegram собирает structured reflection.', '20:00-22:00', 'Replies / reactions / notes', 'views', 'replies', 'Разделите: помогло / не помогло / непонятно.', 'Day 5 Attempted Solutions', '{"adaptation":"depth"}'::jsonb),

    -- =====================================================
    -- SATURDAY 2026-06-27: Why Help Does Not Always Transfer
    -- =====================================================
    ('CUNIT-2026-06-27-IG-STORY-01', '2026-06-27'::date, 'Saturday', 'Instagram', 'Story', 'Наблюдение: помощь есть, движения нет', 'Родители узнают paradox of help without movement.', '08:00-10:00', 'Replies about help present but no progress', 'story_replies', 'dm_replies', 'Было так?', 'Day 6 Reframe', '{"story_role":"observation","visual_object":"broken result converter"}'::jsonb),
    ('CUNIT-2026-06-27-IG-STORY-02', '2026-06-27'::date, 'Saturday', 'Instagram', 'Story', 'Опрос: помощь есть, эффект есть?', 'Опрос проверит perceived effect.', '08:00-10:00', 'Poll split by help/effect', 'poll_votes', 'story_replies', 'Помощь дала движение?', 'Day 6 Reframe', '{"story_role":"poll","poll_options":["да","частично","только при контроле","нет"]}'::jsonb),
    ('CUNIT-2026-06-27-IG-REEL-01', '2026-06-27'::date, 'Saturday', 'Instagram', 'Reel', 'Репетитор есть. Лагерь есть. Почему всё равно нет движения?', 'Рилс делает reframe: проблема не в наличии помощи, а в отсутствии эффекта.', '13:00-15:00', 'DM / comments about help not converting', 'retention', 'comments_dm', 'Напишите: какая помощь не дала эффекта?', 'Day 6 Reframe', '{"visual_object":"support inputs without trajectory movement"}'::jsonb),
    ('CUNIT-2026-06-27-IG-STORY-03', '2026-06-27'::date, 'Saturday', 'Instagram', 'Story', 'Инсайт после Reel: эффект должен жить без исполнителя', 'Инсайт проверяет transfer language.', '17:00-18:00', 'Replies about support dependency', 'story_replies', 'dm_replies', 'Что исчезает без помощника?', 'Day 6 Reframe', '{"story_role":"insight_after_reel"}'::jsonb),
    ('CUNIT-2026-06-27-IG-STORY-04', '2026-06-27'::date, 'Saturday', 'Instagram', 'Story', 'Вопрос: где помощь не переносится?', 'Вопрос собирает transfer failure cases.', '20:00-21:30', 'Replies about transfer failure', 'story_replies', 'dm_replies', 'Где помощь не стала навыком?', 'Day 6 Reframe', '{"story_role":"question"}'::jsonb),
    ('CUNIT-2026-06-27-IG-STORY-05', '2026-06-27'::date, 'Saturday', 'Instagram', 'Story', 'CTA: диагностика точки поломки', 'CTA переводит reframe в diagnostic / interview.', '20:00-21:30', 'DM requests / interview candidates', 'dm_conversations', 'interview_candidates', 'Напишите «точка», если хотите найти место поломки', 'Day 6 Reframe', '{"story_role":"cta"}'::jsonb),
    ('CUNIT-2026-06-27-THREADS-01', '2026-06-27'::date, 'Saturday', 'Threads', 'Post', 'Иногда проблема не в отсутствии помощи. Проблема в отсутствии эффекта после помощи.', 'Threads проверит core reframe phrase.', '14:00', 'Replies / reposts', 'replies', 'reposts', 'Какая помощь не стала результатом?', 'Day 6 Reframe', '{"adaptation":"thought_lab"}'::jsonb),
    ('CUNIT-2026-06-27-TG-01', '2026-06-27'::date, 'Saturday', 'Telegram', 'Note', 'Разбор: почему помощь не всегда становится способностью', 'Telegram gives deeper transfer explanation.', '20:00-22:00', 'Replies / reactions', 'views', 'replies', 'Запишите одну помощь, которая не перенеслась.', 'Day 6 Reframe', '{"adaptation":"depth"}'::jsonb),
    ('CUNIT-2026-06-27-TIKTOK-01', '2026-06-27'::date, 'Saturday', 'TikTok', 'Short', 'Репетитор есть. Лагерь есть. А движения нет. Почему?', 'TikTok проверит problem hook.', '13:00-15:00', 'Views / comments', 'views', 'comments', 'Что не сработало у вас?', 'Day 6 Reframe', '{"adaptation":"fast_hook"}'::jsonb),
    ('CUNIT-2026-06-27-YTSHORTS-01', '2026-06-27'::date, 'Saturday', 'YouTube Shorts', 'Short', 'Почему занятия помогают только пока взрослый рядом?', 'Shorts проверит educational transfer angle.', '18:00-21:00', 'Retention / views', 'retention', 'views', 'Проверьте: что ребёнок делает без поддержки?', 'Day 6 Reframe', '{"adaptation":"educational_short"}'::jsonb),

    -- =====================================================
    -- SUNDAY 2026-06-28: Signals And Lessons
    -- =====================================================
    ('CUNIT-2026-06-28-IG-STORY-01', '2026-06-28'::date, 'Sunday', 'Instagram', 'Story', 'Карта недели: где теряется отдача?', 'Story opens weekly review and signal capture.', '10:00-11:30', 'Replies identifying loss points', 'story_replies', 'dm_replies', 'Где у вас теряется отдача?', 'Day 7 Review', '{"story_role":"observation","visual_object":"weekly diagnostic map"}'::jsonb),
    ('CUNIT-2026-06-28-IG-STORY-02', '2026-06-28'::date, 'Sunday', 'Instagram', 'Story', 'Опрос: главный вывод недели', 'Poll captures strongest weekly tension.', '10:00-11:30', 'Poll votes by concern', 'poll_votes', 'story_replies', 'Что стало главным?', 'Day 7 Review', '{"story_role":"poll","poll_options":["вложения","темп","помощь не работает","страх осени"]}'::jsonb),
    ('CUNIT-2026-06-28-IG-STORY-03', '2026-06-28'::date, 'Sunday', 'Instagram', 'Story', 'Скрин / ответ недели', 'Social proof encourages more stories.', '17:00-18:00', 'More replies after public reflection', 'story_replies', 'dm_replies', 'Узнаёте?', 'Day 7 Review', '{"story_role":"insight_after_week"}'::jsonb),
    ('CUNIT-2026-06-28-IG-STORY-04', '2026-06-28'::date, 'Sunday', 'Instagram', 'Story', 'Вопрос: что проверить на следующей неделе?', 'Question feeds next week planning.', '20:00-21:30', 'Replies suggesting next topics', 'story_replies', 'dm_replies', 'Что разобрать дальше?', 'Day 7 Review', '{"story_role":"question"}'::jsonb),
    ('CUNIT-2026-06-28-IG-STORY-05', '2026-06-28'::date, 'Sunday', 'Instagram', 'Story', 'CTA: интервью / GPS Summer Tracker', 'CTA converts weekly signals into next action.', '20:00-21:30', 'DM for interview / tracker', 'dm_conversations', 'interview_starts', 'Напишите «интервью» или «GPS»', 'Day 7 Review', '{"story_role":"cta"}'::jsonb),
    ('CUNIT-2026-06-28-THREADS-01', '2026-06-28'::date, 'Sunday', 'Threads', 'Thread', 'Итог недели: вопрос не в том, сколько вложено. Вопрос в том, что из этого теперь держится без вас.', 'Threads summarizes weekly thesis.', '21:00', 'Replies / reposts / quote resonance', 'replies', 'reposts', 'Что держится без вас?', 'Day 7 Review', '{"adaptation":"weekly_recap"}'::jsonb),
    ('CUNIT-2026-06-28-FB-01', '2026-06-28'::date, 'Sunday', 'Facebook', 'Post', 'Итог недели: где чаще всего теряется отдача от вложений', 'Facebook recap builds trust and discussion.', '19:00-21:00', 'Comments / shares / parent reflection', 'comments', 'shares', 'Что из этой недели было про вашу ситуацию?', 'Day 7 Review', '{"adaptation":"parent_recap"}'::jsonb),
    ('CUNIT-2026-06-28-TG-01', '2026-06-28'::date, 'Sunday', 'Telegram', 'Note', 'Воскресный обзор: сигналы недели и что проверяем дальше', 'Telegram becomes weekly hub and next-week bridge.', '20:00-22:00', 'Replies / reactions / next-week questions', 'views', 'replies', 'Напишите один вопрос для следующей недели.', 'Day 7 Review', '{"adaptation":"weekly_hub_recap"}'::jsonb)
)
INSERT INTO production.content_units (
    content_unit_code,
    content_plan_code,
    planned_date,
    weekday,
    platform,
    format,
    topic,
    hypothesis,
    publishing_time_label,
    expected_signal,
    primary_kpi,
    secondary_kpi,
    cta,
    source_meaning,
    status,
    metadata
)
SELECT
    content_unit_code,
    'CPLAN-2026-06-22-W01',
    planned_date,
    weekday,
    platform,
    format,
    topic,
    hypothesis,
    publishing_time_label,
    expected_signal,
    primary_kpi,
    secondary_kpi,
    cta,
    source_meaning,
    'draft',
    metadata
FROM units
ON CONFLICT (content_unit_code) DO UPDATE SET
    content_plan_code = EXCLUDED.content_plan_code,
    planned_date = EXCLUDED.planned_date,
    weekday = EXCLUDED.weekday,
    platform = EXCLUDED.platform,
    format = EXCLUDED.format,
    topic = EXCLUDED.topic,
    hypothesis = EXCLUDED.hypothesis,
    publishing_time_label = EXCLUDED.publishing_time_label,
    expected_signal = EXCLUDED.expected_signal,
    primary_kpi = EXCLUDED.primary_kpi,
    secondary_kpi = EXCLUDED.secondary_kpi,
    cta = EXCLUDED.cta,
    source_meaning = EXCLUDED.source_meaning,
    status = EXCLUDED.status,
    metadata = EXCLUDED.metadata,
    updated_at = now();

-- =====================================================
-- Verification queries:
--
-- SELECT content_plan_code, week_start_date, week_end_date, weekly_theme, status
-- FROM production.weekly_content_plans
-- WHERE content_plan_code = 'CPLAN-2026-06-22-W01';
--
-- SELECT platform, format, count(*) AS units
-- FROM production.content_units
-- WHERE content_plan_code = 'CPLAN-2026-06-22-W01'
-- GROUP BY platform, format
-- ORDER BY platform, format;
--
-- SELECT planned_date, platform, format, topic, publishing_time_label
-- FROM production.content_units
-- WHERE content_plan_code = 'CPLAN-2026-06-22-W01'
-- ORDER BY planned_date, platform, format, content_unit_code;
-- =====================================================
