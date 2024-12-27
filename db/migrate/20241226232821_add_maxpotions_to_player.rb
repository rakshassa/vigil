class AddMaxpotionsToPlayer < ActiveRecord::Migration[8.0]
  def change
    add_column(:players, :maxpotions, :integer, default: 3)
  end
end
