class CreateMonsters < ActiveRecord::Migration[8.0]
  def change
    create_table :monsters do |t|
      t.string :name
      t.integer :level
      t.integer :strength
      t.integer :exp
      t.integer :hp
      t.integer :gold
      t.string :weapon
      t.string :death

      t.timestamps
    end
  end
end
