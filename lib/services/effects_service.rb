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

                value = "No Effect Handler for: #{ename}"
                value = lvl_gold(evalue) if ename == "LvlGold"
                value = lvl_exp(evalue) if ename == "LvlExp"
                value = jewels(evalue) if ename == "Jewels"
                value = currenthp(evalue) if ename == "CurrentHP"
                value = hours(evalue) if ename == "Hours"
                value = enable_flag(evalue) if ename == "Flag"
                value = max_hp(evalue) if ename == "MaxHP"
                value = full_heal(evalue) if ename == "FullHeal"
                value = gain_trinket(evalue) if ename == "Trinket"
                value = lose_trinket(evalue) if ename == "LoseTrinket"

                Rails.logger.error(value) if value == "No Effect Handler for: #{ename}"
                # we store the absolute value to avoid negative numbers in sentances
                value = value.abs if value.is_a?(Integer)
                values.append(value)
            end

            values
        end

        private

        # quantity of random trinkets
        def lose_trinket(value)
            records = PlayerTrinket.where(player_id: @player.id, bought: true).order(Arel.sql("RANDOM()")).limit(value)
            names = records.joins(:trinket).pluck("trinkets.name").join(",")
            records.destroy_all
            names
        end

        def random_trinket
            trinket = Trinket.not_reserved.not_owned(@player.id).not_for_sale(@player.id).order(Arel.sql("RANDOM()")).first
            created = PlayerTrinket.create(trinket_id: trinket.id, player_id: @player.id, bought: true)
            created.trinket.on_obtain(@player)
            created.trinket.name
        end

        def gain_trinket(value)
            return random_trinket if value == "Random"

            records = Trinket.where(name: value)
            if records.blank?
                Rails.logger.error("No trinket named: #{value} in effect handler")
                return 0
            end

            created = PlayerTrinket.create(trinket_id: records.first.id, player_id: @player.id, bought: true)
            created.trinket.on_obtain(@player)
            0
        end

        def full_heal(_value)
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
