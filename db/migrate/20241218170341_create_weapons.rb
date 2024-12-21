class CreateWeapons < ActiveRecord::Migration[8.0]
  def change
    create_table :weapons do |t|
      t.string :name
      t.integer :cost
      t.integer :mindmg
      t.integer :maxdmg

      t.timestamps
    end
  end
end
