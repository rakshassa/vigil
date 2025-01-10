Setting.where(name: "gold_variance", value: 0.25).first_or_create
Setting.where(name: "exp_variance", value: 0.25).first_or_create
Setting.where(name: "monster_dmg_variance", value: 0.25).first_or_create
Setting.where(name: "player_hit_percentage", value: 90).first_or_create
Setting.where(name: "monster_hit_percentage", value: 70).first_or_create
Setting.where(name: "player_run_percentage", value: 80).first_or_create
Setting.where(name: "player_crit_chance_percentage", value: 10).first_or_create
Setting.where(name: "player_crit_dmg_multiplier", value: 2.0).first_or_create
Setting.where(name: "skill_dmg_multiplier", value: 3.0).first_or_create
Setting.where(name: "heal_cost_per_hp").first_or_create(value: 5)
Setting.where(name: "daily_hours").first_or_create(value: 24)
Setting.where(name: "weekly_days").first_or_create(value: 7)
Setting.where(name: "gem_chance_percentage").first_or_create(value: 25)
Setting.where(name: "jeweler_inventory").first_or_create(value: 3)
Setting.where(name: "alchemist_inventory").first_or_create(value: 3)
Setting.where(name: "boss_prizes").first_or_create(value: 3)
Setting.where(name: "encounter_monster_chance").first_or_create(value: 75)
