class CombatResolver
    def initialize(fight)
        @fight = fight
    end

    def attack
        message = "You miss.  How embarrassing."
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
        return @fight.update(message: 'You have no skill points remaining.  ') unless skills.positive?

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
            @fight.update(message: 'You high tail it out of there.  ', ended: true)
        else
            message = 'You turn to flee... your back is exposed!  '

            # hit player for damage
            message += hit_player
            @fight.update(message: message)
        end
    end

    def monster_attack
        if @fight.monster.roll_hit
            return hit_player
        end

        "#{@fight.monster.name} misses you completely.  "
    end

    def hit_monster(is_skill: false)
        dmg = @fight.player.roll_dmg(is_skill)
        currenthp = @fight.currenthp
        ended = false

        message = "You hit #{@fight.monster.name} for #{dmg} damage.  "

        if currenthp < dmg
            currenthp = 0
            ended = true
            message = "You massacre the #{@fight.monster.name} for #{dmg} damage.  "
            message += @fight.monster.death
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

        new_gold = @fight.monster.gold
        new_exp = @fight.monster.exp

        # TODO: chance of finding a gem

        @fight.player.update(gold: current_gold + new_gold, exp: current_exp + new_exp)
        "You find #{new_gold} gold and gain #{new_exp} experience.  "
    end

    # assumes the monster has hit the player
    # calculates damage, updates player HP, and returns the fight message
    def hit_player
        dmg = @fight.monster.roll_dmg
        dmg = @fight.player.mitigate_damage(dmg)

        currenthp = @fight.player.currenthp
        @fight.player.update(currenthp: currenthp-dmg)

        message = "#{@fight.monster.name} hits you for #{dmg} damage.  "

        # check if the player died
        if @fight.player.currenthp <= 0
            @fight.update(ended: true)
            message += "You die.  "
        end

        message
    end
end
