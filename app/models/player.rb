class Player < ApplicationRecord
    belongs_to :weapon, optional: false
    belongs_to :armor, optional: false
    belongs_to :level, optional: false

    has_many :fights, dependent: :destroy

    def reimburse_weapon_amount
        (weapon.cost/2).ceil
    end

    def reimburse_armor_amount
        (weapon.cost/2).ceil
    end

    def can_afford_weapon?(item)
        gold >= (item.cost-reimburse_weapon_amount)
    end

    def can_afford_armor?(item)
        gold >= (item.cost-reimburse_armor_amount)
    end

    def buy_weapon(item)
        update(gold: gold-item.cost+reimburse_weapon_amount, weapon_id: item.id)
    end

    def buy_armor(item)
        update(gold: gold-item.cost+reimburse_armor_amount, armor_id: item.id)
    end

    # levels up the player - includes more HP, atk, def, and costs gold
    # returns message
    def level_up
        target = next_level
        new_gold = gold - target.gold
        new_hp = maxhp + target.hp
        new_atk = baseatk + target.atk
        new_def = basedef + target.def

        update(gold: new_gold, maxhp: new_hp, currenthp: new_hp, baseatk: new_atk, basedef: new_def, level_id: target.id)

        "You pay him #{target.gold} gold to train you.<br><br>You gain #{target.hp} HP, #{target.atk} Attack, and #{target.def} Defense."
    end

    def can_level?
        exp >= next_level.exp
    end

    def heal
        actual_healing = healing_max
        actual_cost = healing_cost
        update(currenthp: currenthp + actual_healing, gold: gold-actual_cost)
    end

    def healing_cost
        missing_hp = maxhp - currenthp
        max_healing = (gold/Setting.heal_cost_per_hp).floor

        actual_healing = [missing_hp, max_healing].min

        (actual_healing * Setting.heal_cost_per_hp).floor
    end

    def healing_max
        missing_hp = maxhp - currenthp
        max_healing = (gold/Setting.heal_cost_per_hp).floor

        [missing_hp, max_healing].min
    end

    def is_dead?
        currenthp <= 0
    end

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
