class CreateLevels < ActiveRecord::Migration[8.0]
  def change
    create_table :levels do |t|
      t.string :name
      t.integer :exp

      t.timestamps
    end
  end
end
