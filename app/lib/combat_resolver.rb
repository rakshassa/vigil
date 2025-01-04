class CombatResolver
    def initialize(fight)
        @fight = fight
    end

    def attack
        message = "You miss.  How embarrassing.<br>"
        if @fight.player.roll_hit
            message = hit_monster(is_skill: false)
        end

        unless @fight.ended
            message += monster_attack
        end

        @fight.update(message: message)
    end

    def backstab
        skills = @fight.player.skills

        # make sure the player has skill points
        return @fight.update(message: "You have no skill points remaining.<br>") unless skills.positive?

        # resolve the attack
        message = hit_monster(is_skill: true)

        # reduce skill points
        @fight.player.update(skills: skills - 1)

        # if the fight continues, let the monster try to attack
        unless @fight.ended
            message += monster_attack
        end

        @fight.update(message: message)
    end

    def run
        if @fight.player.roll_run
            return @fight.update(message: "You high tail it out of there.<br>", ended: true)
        end

        message = "You turn to flee... your back is exposed!<br>"

        # hit player for damage
        message += hit_player
        @fight.update(message: message)
    end

    def monster_attack
        if @fight.monster.roll_hit(@fight.player_id)
            return hit_player
        end

        "#{@fight.monster.name} misses you completely.<br>"
    end

    def hit_monster(is_skill: false)
        dmg = @fight.player.roll_dmg(is_skill)
        currenthp = @fight.currenthp
        ended = false

        message = "You hit #{@fight.monster.name} for #{dmg} damage.<br>"
        message = "With overwhelming skill, you critically strike #{@fight.monster.name} for #{dmg} damage.<br>" if dmg > @fight.player.max_damage
        message = "You slip behind #{@fight.monster.name} and embed your #{@fight.player.weapon} in his back for #{dmg} damage.<br>" if is_skill

        if currenthp <= dmg
            currenthp = 0
            ended = true
            message = "You massacre the #{@fight.monster.name} for #{dmg} damage.<br>"
            message += @fight.monster.death + "<br>"
            message += loot
        else
            currenthp -= dmg
        end

        @fight.update(currenthp: currenthp, ended: ended)
        message
    end

    def loot
        current_gold = @fight.player.gold
        current_exp = @fight.player.exp
        current_gems = @fight.player.gems

        new_gold = (@fight.monster.roll_gold * (1 + PlayerTrinket.accumulate(@fight.player_id, "GoldLoot"))).floor
        new_exp = (@fight.monster.roll_exp * (1 + PlayerTrinket.accumulate(@fight.player_id, "ExpLoot"))).floor

        # boss always gives a gem
        found_gem = @fight.monster.is_boss ? true : @fight.player.roll_gem_chance
        new_gem = found_gem ? 1 : 0
        gem_msg = found_gem ? "You also found a jewel!<br>" : ""

        @fight.player.update(gold: current_gold + new_gold, exp: current_exp + new_exp, gems: current_gems + new_gem)
        "<br>You find #{new_gold} gold and gain #{new_exp} experience.<br>" + gem_msg
    end

    # assumes the monster has hit the player
    # calculates damage, updates player HP, and returns the fight message
    def hit_player
        dmg = @fight.monster.roll_dmg
        dmg = @fight.player.mitigate_damage(dmg)

        currenthp = @fight.player.currenthp
        @fight.player.update(currenthp: currenthp-dmg)

        message = "#{@fight.monster.name} #{@fight.monster.weapon} for #{dmg} damage.<br>"
        message = "#{@fight.monster.name} bounces off your armor.<br>" if dmg <= 0

        # check if the player died
        if @fight.player.currenthp <= 0
            @fight.update(ended: true)
            message += "You die.<br>"
        end

        message
    end
end
