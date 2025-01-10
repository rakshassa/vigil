class AddFlagsToPlayer < ActiveRecord::Migration[8.0]
  def change
    # managed bit field
    add_column(:players, :flags, :integer, default: 0, null: false)
    # Effective booleans which will be stored on the flags column:
    # t.boolean      :avoided_old_man
  end
end
