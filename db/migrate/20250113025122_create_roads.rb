class CreateRoads < ActiveRecord::Migration[8.0]
  def change
    create_table :roads do |t|
      t.references :monster, null: true, foreign_key: true, index: true
      t.references :encounter, null: true, foreign_key: true, index: true
      t.references :player, null: false, foreign_key: true, index: true

      t.timestamps
    end

    add_column(:players, :max_roads, :integer, default: 2, null: false)
    add_column(:encounters, :short_name, :string, null: false, default: "None")
  end
end
