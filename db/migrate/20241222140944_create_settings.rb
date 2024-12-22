class CreateSettings < ActiveRecord::Migration[8.0]
  def change
    create_table :settings do |t|
      t.string :name
      t.float :value

      t.timestamps
    end
  end
end
