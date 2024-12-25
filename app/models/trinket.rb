class Trinket < ApplicationRecord

    scope :not_owned, -> (player_id) {
        owned = PlayerTrinket.where(player_id: player_id).select(:trinket_id)

        where.not(id: owned)
    }
    has_many :player_trinkets, dependent: :destroy
end
