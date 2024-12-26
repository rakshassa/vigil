class Setting < ApplicationRecord
    def self.gold_variance
        Setting.where(name: "gold_variance").first_or_create(value: 0.25).value
    end

    def self.exp_variance
        Setting.where(name: "exp_variance").first_or_create(value: 0.25).value
    end

    def self.monster_dmg_variance
        Setting.where(name: "monster_dmg_variance").first_or_create(value: 0.25).value
    end

    def self.player_hit_percentage
        Setting.where(name: "player_hit_percentage").first_or_create(value: 90).value
    end

    def self.monster_hit_percentage
        Setting.where(name: "monster_hit_percentage").first_or_create(value: 70).value
    end

    def self.player_run_percentage(player_id)
        value = Setting.where(name: "player_run_percentage").first_or_create(value: 80).value
        value += PlayerTrinket.accumulate(player_id, "RunChance")
        value.floor
    end

    def self.player_crit_chance_percentage(player_id)
        base = Setting.where(name: "player_crit_chance_percentage").first_or_create(value: 10).value
        result = base + PlayerTrinket.accumulate(player_id, "CritChance")
        result = 0 if result < 0

        result.floor
    end

    def self.player_crit_dmg_multiplier(player_id)
        base = Setting.where(name: "player_crit_dmg_multiplier").first_or_create(value: 2.0).value
        result = base + PlayerTrinket.accumulate(player_id, "CritDmg")
        result = 0 if result < 0

        result.floor
    end

    def self.skill_dmg_multiplier(player_id)
        base = Setting.where(name: "skill_dmg_multiplier").first_or_create(value: 2.5).value
        result = base + PlayerTrinket.accumulate(player_id, "SkillDmg")
        result = 0 if result < 0

        result.floor
    end

    def self.heal_cost_per_hp(player_id)
        base = Setting.where(name: "heal_cost_per_hp").first_or_create(value: 5).value
        result = base + PlayerTrinket.accumulate(player_id, "HealPrice")
        result = 0 if result < 0

        result.floor
    end

    def self.daily_hours
        Setting.where(name: "daily_hours").first_or_create(value: 24).value
    end

    def self.weekly_days
        Setting.where(name: "weekly_days").first_or_create(value: 7).value
    end

    def self.gem_chance_percentage(player_id)
        base = Setting.where(name: "gem_chance_percentage").first_or_create(value: 25).value
        result = base + PlayerTrinket.accumulate(player_id, "GemFind")
        result = 0 if result < 0

        result.floor
    end

    def self.jeweler_inventory(player_id)
        base = Setting.where(name: "jeweler_inventory").first_or_create(value: 3).value
        result = base + PlayerTrinket.accumulate(player_id, "JewelryMax")
        result = 0 if result < 0

        result.floor
    end
end
