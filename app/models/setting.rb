class Setting < ApplicationRecord
    def self.gold_variance
        Setting.where(name: 'gold_variance').first_or_create(value: 0.25).value
    end

    def self.exp_variance
        Setting.where(name: 'exp_variance').first_or_create(value: 0.25).value
    end

    def self.monster_dmg_variance
        Setting.where(name: 'monster_dmg_variance').first_or_create(value: 0.25).value
    end

    def self.player_hit_percentage
        Setting.where(name: 'player_hit_percentage').first_or_create(value: 80).value
    end

    def self.monster_hit_percentage
        Setting.where(name: 'monster_hit_percentage').first_or_create(value: 80).value
    end

    def self.player_run_percentage
        Setting.where(name: 'player_run_percentage').first_or_create(value: 80).value
    end

    def self.player_crit_chance_percentage
        Setting.where(name: 'player_crit_chance_percentage').first_or_create(value: 10).value
    end

    def self.player_crit_dmg_multiplier
        Setting.where(name: 'player_crit_dmg_multiplier').first_or_create(value: 2.0).value
    end

    def self.skill_dmg_multiplier
        Setting.where(name: 'skill_dmg_multiplier').first_or_create(value: 3.0).value
    end
end
