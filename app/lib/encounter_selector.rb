class EncounterSelector
    # returns boolean: success
    def roll_chance(success_percentage)
        chance = Rands.rand(1, 100)
        Rails.logger.info "Rolling 1-100. Got: #{chance}"
        chance < success_percentage
    end

    # Create player.max_roads Road records.
    # These are a mix between monsters and encounters based on Setting.encounter_monster_chance
    def select(player)
        player.max_roads.times do
            if roll_chance(Setting.encounter_monster_chance)
                monster_encounter(player)
            else
                non_monster_encounter(player)
            end
        end
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

        Road.create(player_id: player.id, encounter_id: encounter.id)
    end

    def monster_encounter(player)
        # limit to player level and/or day-counter.
        level = [player.level.id, (player.days+1)].max
        records = Monster.where(level: level, is_boss: false)

        # select a random record
        monster = records.order(Arel.sql("RANDOM()")).take
        Road.create(player_id: player.id, monster_id: monster.id)
    end
end
