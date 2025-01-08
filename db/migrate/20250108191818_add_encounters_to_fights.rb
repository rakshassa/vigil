class AddEncountersToFights < ActiveRecord::Migration[8.0]
  def change
    add_reference(:fights, :encounter, index: true, null: true, foreign_key: true)
    change_column_null(:fights, :monster_id, true)
  end
end
