class Monster < ApplicationRecord
    has_many :fights, dependent: :destroy

    def roll_gold
        roll_variance(gold, Setting.gold_variance)
    end

    def roll_exp
        roll_variance(exp, Setting.exp_variance)
    end

    def roll_dmg
        roll_variance(strength, Setting.monster_dmg_variance)
    end

    def roll_hit(player_id)
        base = Setting.monster_hit_percentage
        miss_chance = 100 - base

        if is_boss
            extra_miss_mult = PlayerTrinket.accumulate(player_id, "BossMiss")
            if extra_miss_mult != 0
                miss_chance = (miss_chance * extra_miss_mult).ceil
            end
        end

        total_hit_perc = 100 - miss_chance
        roll_chance(total_hit_perc)
    end
end
