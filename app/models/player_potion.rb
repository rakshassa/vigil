class PlayerPotion < ApplicationRecord
  scope :not_owned, ->(player_id) { where(player_id: player_id, bought: false) }
  scope :owned, -> { where(bought: true) }
  scope :unused, -> { where(used: false) }

  scope :used_with_effect, ->(effect_name) {
    query =
    "select player_potions.* from player_potions \
     INNER JOIN potions ON potions.id = player_potions.potion_id, jsonb_to_recordset(potions.effects) as eff(name text) \
     where eff.name=? AND player_potions.used IS TRUE
    "
    find_by_sql([query, effect_name])
  }

  belongs_to :potion
  belongs_to :player

  def consume
    update(used: true)
    potion.consume(player)
  end
end
