class CreateArmors < ActiveRecord::Migration[8.0]
  def change
    create_table :armors do |t|
      t.string :name
      t.integer :cost
      t.integer :defense

      t.timestamps
    end
  end
end
