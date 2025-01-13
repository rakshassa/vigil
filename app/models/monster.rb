class Monster < ApplicationRecord
    has_many :fights, dependent: :destroy
    has_many :roads, dependent: :destroy

    def roll_gold
        roll_variance(gold, Setting.gold_variance)
    end

    def roll_exp
        roll_variance(exp, Setting.exp_variance)
    end

    def roll_dmg
        roll_variance(strength, Setting.monster_dmg_variance)
    end

    def trigger_auto_miss(player_id)
        # has the player used a potion that has the auto-miss effect?
        records = PlayerPotion.where(player_id: player_id).used_with_effect("EnemyMiss")
        return false if records.blank?

        # this one has been triggered - remove it
        # if there were multiple of the same potion used, only trigger one
        records.first.destroy
        Rails.logger.info "Triggered Enemy Auto Miss"
        true
    end

    def roll_hit(player_id)
        return false if trigger_auto_miss(player_id)

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
