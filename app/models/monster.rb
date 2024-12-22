class Monster < ApplicationRecord
    has_many :fights

    def roll_gold
        roll_variance(gold, Setting.gold_variance)
    end

    def roll_exp
        roll_variance(exp, Setting.exp_variance)
    end

    def roll_dmg
        roll_variance(strength, Setting.monster_dmg_variance)
    end

    def roll_hit
        roll_chance(Setting.monster_hit_percentage)
    end
end
