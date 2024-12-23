class AddGoldToLevels < ActiveRecord::Migration[8.0]
  def change
    add_column(:levels, :gold, :integer)
    add_column(:levels, :hp, :integer)
    add_column(:levels, :atk, :integer)
    add_column(:levels, :def, :integer)
  end
end
