class Armor < ApplicationRecord
    scope :after, ->(item_id) { where("armors.id > ?", item_id) }

    has_many :players, dependent: :destroy

    def effective_cost(player)
        result = (cost * (1 - PlayerTrinket.accumulate(player.id, "ShopDiscount"))).floor
        [0, result].max
    end
end
