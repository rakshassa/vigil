class CreatePlayerTrinkets < ActiveRecord::Migration[8.0]
  def change
    create_table :player_trinkets do |t|
      t.references :trinket, null: false, foreign_key: true, index: true
      t.references :player, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
