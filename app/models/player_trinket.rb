class PlayerTrinket < ApplicationRecord
  scope :not_owned, ->(player_id) { where(player_id: player_id, bought: false) }
  scope :owned, -> { where(bought: true) }

  belongs_to :trinket
  belongs_to :player

  def self.accumulate(player_id, effect_name)
    sum = 0
    PlayerTrinket.joins(:trinket).where(player_id: player_id, bought: true).find_each do |ptrinket|
      effects = ptrinket.trinket.effects
      effects.each do |effect|
        sum += effect["value"] if effect["name"] == effect_name
      end
    end

    sum
  end
end
