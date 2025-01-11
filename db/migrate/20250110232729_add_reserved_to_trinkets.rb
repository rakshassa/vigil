class AddReservedToTrinkets < ActiveRecord::Migration[8.0]
  def change
    add_column(:trinkets, :reserved, :boolean, null: false, default: false)
  end
end
