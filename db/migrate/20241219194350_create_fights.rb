class CreateFights < ActiveRecord::Migration[8.0]
  def change
    create_table :fights do |t|
      t.references :player, null: false, foreign_key: true
      t.references :monster, null: false, foreign_key: true
      t.boolean :ended, default: false
      t.integer :currenthp, default: 0
      t.string :message

      t.timestamps
    end
  end
end
