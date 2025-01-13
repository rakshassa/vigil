class Player < ApplicationRecord
    attr_reader :was_crit

    include FlagShihTzu # https://github.com/pboling/flag_shih_tzu
    # add new flags here (up to 64)
    has_flags 1 => :avoided_old_man,
              2 => :killed_old_man,
              3 => :lost_squirrel,
              4 => :freed_squirrels,
              5 => :obtained_ring_speed,
              6 => :grandma_scared,
              7 => :grandma_happy,
              8 => :burned_house,
              9 => :stephen_bucket,
              10 => :angry_stephen,
              :column => "flags"

    belongs_to :weapon, optional: false
    belongs_to :armor, optional: false
    belongs_to :level, optional: false

    has_many :fights, dependent: :destroy
    has_many :player_trinkets, dependent: :destroy
    has_many :player_potions, dependent: :destroy
    has_many :roads, dependent: :destroy

    def new_day
        update(days: days + 1, hours: 0, used_bard: false, skills: baseskills, currenthp: maxhp)
        populate_shops
    end

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
        hours >= Setting.daily_hours(id)
    end

    def reimburse_weapon_amount
        (weapon.cost/2).ceil
    end

    def reimburse_armor_amount
        (weapon.cost/2).ceil
    end

    def can_afford_weapon?(item)
        gold >= (item.effective_cost(self)-reimburse_weapon_amount)
    end

    def can_afford_armor?(item)
        gold >= (item.effective_cost(self)-reimburse_armor_amount)
    end

    def can_afford_trinket?(item)
        gems >= item.cost
    end

    def can_carry_another_potion?
        player_potions.owned.unused.count < maxpotions
    end

    def can_afford_potion?(item)
        gems >= item.cost
    end

    def buy_potion(item)
        update(gems: gems-item.potion.cost)
        item.update(bought: true)

        increment_hours unless PlayerTrinket.accumulate(id, "AlchemyAction") < 0
    end

    def use_potion(item)
        message = "You drink your #{item.potion.name} potion.<br>"

        # PlayerPotion.consume will set it to used:true
        item.consume
        item.destroy if item.potion.immediate

        message
    end

    def buy_trinket(item)
        update(gems: gems-item.trinket.cost)
        item.update(bought: true)
        item.trinket.on_obtain(self)

        increment_hours unless PlayerTrinket.accumulate(id, "JewelryAction") < 0
    end

    def buy_weapon(item)
        update(gold: gold-item.effective_cost(self)+reimburse_weapon_amount, weapon_id: item.id)
        increment_hours unless PlayerTrinket.accumulate(id, "ShopAction") < 0
    end

    def buy_armor(item)
        update(gold: gold-item.effective_cost(self)+reimburse_armor_amount, armor_id: item.id)
        increment_hours unless PlayerTrinket.accumulate(id, "ShopAction") < 0
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

    def lowhp?
        (currenthp.to_f/maxhp.to_f) < 0.25
    end

    def heal
        actual_healing = healing_max
        actual_cost = healing_cost
        update(currenthp: currenthp + actual_healing, gold: gold-actual_cost)
        increment_hours
    end

    def healing_cost
        paid_healing = healing_max - PlayerTrinket.accumulate(id, "HealFree")
        paid_healing = 0 if paid_healing < 0

        (paid_healing * Setting.heal_cost_per_hp(id)).floor
    end

    def healing_max
        missing_hp = maxhp - currenthp
        max_healing = (gold/Setting.heal_cost_per_hp(id)).floor + PlayerTrinket.accumulate(id, "HealFree")

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
        result = result * Setting.skill_dmg_multiplier(self) if is_skill

        # check for critical hit chance
        if roll_crit_chance
            result *= Setting.player_crit_dmg_multiplier(self)
            @was_crit = true
        else
            @was_crit = false
        end

        result.ceil
    end

    def trigger_auto_crit
        # has the player used a potion that has this effect?
        records = player_potions.used_with_effect("AutoCrit")
        return false if records.blank?

        # this one has been triggered - remove it
        # if there were multiple of the same potion used, only trigger one
        # records.first.destroy
        # this is an array, so we can't just destroy the record
        PlayerPotion.find(records.first.id).destroy
        Rails.logger.info "Triggered Auto Crit"
        true
    end

    def has_auto_crit?
        player_potions.used_with_effect("AutoCrit").present?
    end

    def roll_crit_chance
        return true if trigger_auto_crit

        roll_chance(Setting.player_crit_chance_percentage(self))
    end

    def roll_gem_chance
        roll_chance(Setting.gem_chance_percentage(self))
    end

    def mitigate_damage(base)
        # so far, we have no variance on defense
        # no failure chance on defense (piercing percentage)
        result = base - effective_defense
        return 0 if result < 0

        result
    end

    def roll_hit
        # do not allow missing when auto crit is pending
        return true if has_auto_crit?

        # adjust hit chance by trinkets
        hit_chance = Setting.player_hit_percentage
        miss_chance = 100 - hit_chance
        better = PlayerTrinket.accumulate(id, "Miss_Perc")
        hit_chance += (miss_chance * better).floor if better != 0
        Rails.logger.info "Rolling Player Hit with chance: #{hit_chance}"
        roll_chance(hit_chance)
    end

    def roll_run
        roll_chance(Setting.player_run_percentage(id))
    end

    def self.make_new_thief
        record = Player.create(
          level_id: Level.first.id, maxhp: 15, currenthp: 15, gold: 0, gems: 1, baseatk: 4, basedef: 1,
          skills: 1, baseskills: 1, used_bard: false, maxpotions: 3,
          weapon_id: Weapon.first.id, armor_id: Armor.first.id, days: 0, hours: 0, exp: 0
        )
        record.populate_shops
        record
    end

    def add_jewelry_shop_inventory(qty)
        choices = Trinket.not_reserved.not_owned(id).order(Arel.sql("RANDOM()")).limit(qty)

        choices.each do |trinket|
            PlayerTrinket.create(player_id: id, trinket_id: trinket.id, bought: false)
        end
    end

    def populate_shops
        # clear the shops
        player_trinkets.where(bought: false).destroy_all
        player_potions.where(bought: false).destroy_all

        # repopulate the jeweler with trinkets
        max = Setting.jeweler_inventory(id)
        add_jewelry_shop_inventory(max)

        # repopulate the alchemist with potions
        max = Setting.alchemist_inventory(id)
        choices = Potion.order(Arel.sql("RANDOM()")).limit(max)
        choices.each do |potion|
            PlayerPotion.create(player_id: id, potion_id: potion.id, bought: false)
        end
    end

    def process_encounter_results(result)
        Rails.logger.info "Processing Encounter Result: #{result}"

        # { chance: 70,
        #   message: "He pays you %s gold for your service.",
        #   results: [{name: "LvlGold", value: 0.4}]
        # }

        fmt = result["message"]
        values = Services::EffectsService.new(self).process_effects(result["results"])
        values.insert(0, fmt)

        sprintf(*values)
    end
end
