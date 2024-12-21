class Player < ApplicationRecord
    belongs_to :weapon, optional: false
    belongs_to :armor, optional: false

    def effective_defense
        basedef + armor.defense
    end

    def min_damage
        baseatk + weapon.mindmg
    end

    def max_damage
        baseatk + weapon.maxdmg
    end

    def roll_damage(is_skill)
        # base damage with weapon
        result = Rands.rand(min_damage, max_damage)

        # modify for skill damage
        result = result * 3 if is_skill

        # check for critical hit chance
        is_crit = Rands.rand(1,100) < 10
        result *= 2 if is_crit

        result
    end
end
