class EncounterSelector
    # returns boolean: success
    def roll_chance(success_percentage)
        chance = Rands.rand(1, 100)
        Rails.logger.info "Rolling 1-100. Got: #{chance}"
        chance < success_percentage
    end

    def select(player)
        return monster_encounter(player) if roll_chance(Setting.encounter_monster_chance)

        non_monster_encounter(player)
    end

    def boss_fight(player)
        records = Monster.where(level: player.days+1, is_boss: true)

        # select a random record
        monster = records.order(Arel.sql("RANDOM()")).take

        # store the fight
        start_msg = "You stand before a dangerous foe."
        boss_hp = monster.hp + PlayerTrinket.accumulate(player.id, "BossHP")
        Fight.create(player_id: player.id, monster_id: monster.id, ended: false, currenthp: boss_hp, message: start_msg)
    end

    private

    def non_monster_encounter(player)
        encounter = Encounter.not_skipped(player.flags).has_all_required(player.flags).order(Arel.sql("RANDOM()")).take
        return monster_encounter(player) if encounter.blank?

        Fight.create(player_id: player.id, encounter_id: encounter.id, ended: false, message: encounter.message)
    end

    def monster_encounter(player)
        # limit to player level and/or day-counter.
        level = [player.level.id, (player.days+1)].max
        records = Monster.where(level: level, is_boss: false)

        # select a random record
        monster = records.order(Arel.sql("RANDOM()")).take

        # store the fight
        start_msg = "You search around the wilderness for a way to become stronger."
        Fight.create(player_id: player.id, monster_id: monster.id, ended: false, currenthp: monster.hp, message: start_msg)
    end
end
