class AddImmediateToPotions < ActiveRecord::Migration[8.0]
  def change
    add_column :potions, :immediate, :boolean, default: true, null: false
  end
end
