class EncounterSelector
    def select(player)
        # TODO: select non-monsters sometimes, too

        # limit to player level
        records = Monster.where(level: player.level.id, is_boss: false)

        # select a random record
        monster = records.order(Arel.sql('RANDOM()')).take

        # store the fight
        start_msg = "You search around the wilderness for a way to become stronger."
        Fight.create(player_id: player.id, monster_id: monster.id, ended: false, currenthp: monster.hp, message: start_msg)
    end

    def boss_fight(player)
        records = Monster.where(level: player.days, is_boss: true)

        # select a random record
        monster = records.order(Arel.sql('RANDOM()')).take

        # store the fight
        start_msg = "You stand before a dangerous foe."
        Fight.create(player_id: player.id, monster_id: monster.id, ended: false, currenthp: monster.hp, message: start_msg)
    end
end
