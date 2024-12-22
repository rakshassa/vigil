class CreatePlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :players do |t|
      t.references :level, null: false, foreign_key: true, index: true
      t.integer :maxhp
      t.integer :currenthp
      t.integer :gold
      t.integer :gems, default: 0
      t.integer :baseatk
      t.integer :basedef
      t.integer :skills
      t.references :weapon, null: true, foreign_key: true, index: true
      t.references :armor, null: true, foreign_key: true, index: true
      t.integer :days
      t.integer :hours
      t.integer :exp, default: 0

      t.timestamps
    end
  end
end
