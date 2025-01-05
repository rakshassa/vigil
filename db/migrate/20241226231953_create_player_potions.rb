class CreatePlayerPotions < ActiveRecord::Migration[8.0]
  def change
    create_table :player_potions do |t|
      t.references :potion, null: false, foreign_key: true, index: true
      t.references :player, null: false, foreign_key: true, index: true
      t.boolean :bought, default: false, null: false
      t.boolean :used, default: false, null: false

      t.timestamps
    end
  end
end
