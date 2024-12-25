class CreateTrinkets < ActiveRecord::Migration[8.0]
  def change
    create_table :trinkets do |t|
      t.string :name
      t.string :desc
      t.integer :cost
      t.string :effects

      t.timestamps
    end
  end
end
