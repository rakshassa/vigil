class CreateEncounters < ActiveRecord::Migration[8.0]
  def change
    create_table :encounters do |t|
      t.string :message, null: false
      t.jsonb :choice_1, null: true
      t.jsonb :choice_2, null: true
      t.jsonb :choice_3, null: true

      t.timestamps
    end
  end
end
