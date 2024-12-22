class Player < ApplicationRecord
    belongs_to :weapon, optional: false
    belongs_to :armor, optional: false
    belongs_to :level, optional: false

    def next_level
        next_level_id = level.id + 1
        return Level.last if next_level_id >= Level.last.id

        Level.where(id: level.id+1).first
    end

    def effective_defense
        basedef + armor.defense
    end

    def min_damage
        baseatk + weapon.mindmg
    end

    def max_damage
        baseatk + weapon.maxdmg
    end

    def roll_dmg(is_skill)
        # base damage with weapon
        result = Rands.rand(min_damage, max_damage)

        # modify for skill damage
        result = result * Setting.skill_dmg_multiplier if is_skill

        # check for critical hit chance
        result *= Setting.player_crit_dmg_multiplier if roll_crit_chance

        result.ceil
    end

    def roll_crit_chance
        roll_chance(Setting.player_crit_chance_percentage)
    end

    def mitigate_damage(base)
        # so far, we have no variance on defense
        # no failure chance on defense (piercing percentage)
        result = base - effective_defense
        return 0 if result < 0

        result
    end

    def roll_hit
        roll_chance(Setting.player_hit_percentage)
    end

    def roll_run
        roll_chance(Setting.player_run_percentage)
    end
end
