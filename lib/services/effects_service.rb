module Services
    class EffectsService
        def initialize(player)
            @player = player
        end

        # returns an array of values in the order of the effects
        def process_effects(effects)
            values = []
            effects.each do |effect|
                evalue = effect["value"]
                ename = effect["name"]

                value = lvl_gold(evalue) if ename == "LvlGold"
                value = lvl_exp(evalue) if ename == "LvlExp"
                value = jewels(evalue) if ename == "Jewels"
                value = currenthp(evalue) if ename == "CurrentHP"
                value = hours(evalue) if ename == "Hours"
                value = enable_flag(evalue) if ename == "Flag"
                value = max_hp(evalue) if ename == "MaxHP"
                value = full_heal(evalue) if ename == "FullHeal"

                # we store the absolute value to avoid negative numbers in sentances
                values.append(value.abs)
            end

            values
        end

        private

        def full_heal(value)
            @player.update(currenthp: @player.maxhp)
            0
        end

        def max_hp(value)
            value = (@player.maxhp * value).floor
            net = @player.maxhp + value
            net = 1 if net < 1

            currenthp = @player.currenthp
            currenthp = net if currenthp > net
            @player.update(currenthp: currenthp, maxhp: net)

            value
        end

        def lvl_gold(value)
            next_level_cost = @player.next_level.gold
            value = (next_level_cost * value).ceil

            net = @player.gold + value
            net = 0 if net < 0
            @player.update(gold: net)

            value
        end

        def lvl_exp(value)
            next_level_cost = @player.next_level.exp
            value = (next_level_cost * value).ceil

            net = @player.exp + value
            net = 0 if net < 0
            @player.update(exp: net)

            value
        end

        def jewels(value)
            net = @player.gems + value
            net = 0 if net < 0
            @player.update(gems: net)

            value
        end

        def currenthp(value)
            value = (@player.currenthp * value).ceil
            net = @player.currenthp + value
            net = 1 if net < 0
            net = @player.maxhp if net > @player.maxhp
            @player.update(currenthp: net)

            value
        end

        def hours(value)
            net = @player.hours + value
            net = 24 if net > 24
            # allow negative values
            @player.update(hours: net)

            value
        end

        def enable_flag(value)
            current_flags = @player.flags
            net = current_flags | value
            @player.update(flags: net)

            # no value here
            0
        end
    end
end
