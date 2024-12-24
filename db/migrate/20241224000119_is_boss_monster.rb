class IsBossMonster < ActiveRecord::Migration[8.0]
  def change
    add_column(:monsters, :is_boss, :boolean, default: false)
  end
end
