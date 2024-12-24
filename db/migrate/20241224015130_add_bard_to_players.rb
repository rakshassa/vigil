class AddBardToPlayers < ActiveRecord::Migration[8.0]
  def change
    add_column(:players, :used_bard, :boolean, default: false)
    add_column(:players, :baseskills, :integer, default: 1)
  end
end
