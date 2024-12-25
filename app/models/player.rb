class Player < ApplicationRecord
    belongs_to :weapon, optional: false
    belongs_to :armor, optional: false
    belongs_to :level, optional: false

    has_many :fights, dependent: :destroy
    has_many :player_trinkets, dependent: :destroy

    def bard_buff
        update(used_bard: true)

        points = level.id
        type = %w[def atk hp skills].sample
        if type == "hp"
            points = points * 2 # get twice HP as your level
            update(maxhp: maxhp + points, currenthp: maxhp + points)
            return "Jaskier fiddles a lively tune.<br>Your max HP increases by #{points} and you are healed!"
        elsif type == "atk"
            update(baseatk: baseatk + points)
            return "Jaskier thrashes some heavy metal on his guitar.<br>Your attack increases by #{points}!"
        elsif type == "def"
            update(basedef: basedef + points)
            return "Jaskier slams out a full jam session on his drums.<br>Your defense increases by #{points}!"
        elsif type == "skills"
            # this does not get better with levels
            update(skills: skills + 1, baseskills: baseskills + 1)
            return "Jaskier sings a ballad of wisdom.<br>You can backstab 1 more time per day!"
        end

        # should never get here
        update(currenthp: 1)
        "The impossible happens. You nearly die."
    end

    def increment_hours
        update(hours: hours + 1)
    end

    def day_ended?
        hours >= Setting.daily_hours
    end

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

    def can_afford_trinket?(item)
        gems >= item.cost
    end

    def buy_trinket(item)
        update(gems: gems-item.cost)
        PlayerTrinket.create(player_id: id, trinket_id: item.id)
        increment_hours
    end

    def buy_weapon(item)
        update(gold: gold-item.cost+reimburse_weapon_amount, weapon_id: item.id)
        increment_hours
    end

    def buy_armor(item)
        update(gold: gold-item.cost+reimburse_armor_amount, armor_id: item.id)
        increment_hours
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
        increment_hours
        "You pay him #{target.gold} gold to train you.<br><br>You gain #{target.hp} HP, #{target.atk} Attack, and #{target.def} Defense."
    end

    def can_level?
        exp >= next_level.exp
    end

    def heal
        actual_healing = healing_max
        actual_cost = healing_cost
        update(currenthp: currenthp + actual_healing, gold: gold-actual_cost)
        increment_hours
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
        result = basedef + armor.defense + PlayerTrinket.accumulate(id, "Defense")
    end

    def min_damage
        baseatk + weapon.mindmg + PlayerTrinket.accumulate(id, "Attack")
    end

    def max_damage
        baseatk + weapon.maxdmg + PlayerTrinket.accumulate(id, "Attack")
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

    def roll_gem_chance
        roll_chance(Setting.gem_chance_percentage)
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
