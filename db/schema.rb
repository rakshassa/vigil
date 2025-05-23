# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_01_13_025122) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "armors", force: :cascade do |t|
    t.string "name"
    t.integer "cost"
    t.integer "defense"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "encounters", force: :cascade do |t|
    t.string "message", null: false
    t.integer "flags_required", default: 0, null: false
    t.integer "skip_on_flags", default: 0, null: false
    t.jsonb "choice_1"
    t.jsonb "choice_2"
    t.jsonb "choice_3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "short_name", default: "None", null: false
  end

  create_table "fights", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "monster_id"
    t.boolean "ended", default: false
    t.integer "currenthp", default: 0
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "encounter_id"
    t.index ["encounter_id"], name: "index_fights_on_encounter_id"
    t.index ["monster_id"], name: "index_fights_on_monster_id"
    t.index ["player_id"], name: "index_fights_on_player_id"
  end

  create_table "levels", force: :cascade do |t|
    t.string "name"
    t.integer "exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "gold"
    t.integer "hp"
    t.integer "atk"
    t.integer "def"
  end

  create_table "monsters", force: :cascade do |t|
    t.string "name"
    t.integer "level"
    t.integer "strength"
    t.integer "exp"
    t.integer "hp"
    t.integer "gold"
    t.string "weapon"
    t.string "death"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_boss", default: false
  end

  create_table "player_potions", force: :cascade do |t|
    t.bigint "potion_id", null: false
    t.bigint "player_id", null: false
    t.boolean "bought", default: false, null: false
    t.boolean "used", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_player_potions_on_player_id"
    t.index ["potion_id"], name: "index_player_potions_on_potion_id"
  end

  create_table "player_trinkets", force: :cascade do |t|
    t.bigint "trinket_id", null: false
    t.bigint "player_id", null: false
    t.boolean "bought", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_player_trinkets_on_player_id"
    t.index ["trinket_id"], name: "index_player_trinkets_on_trinket_id"
  end

  create_table "players", force: :cascade do |t|
    t.bigint "level_id", null: false
    t.integer "maxhp"
    t.integer "currenthp"
    t.integer "gold"
    t.integer "gems", default: 0
    t.integer "baseatk"
    t.integer "basedef"
    t.integer "skills"
    t.bigint "weapon_id"
    t.bigint "armor_id"
    t.integer "days"
    t.integer "hours"
    t.integer "exp", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "used_bard", default: false
    t.integer "baseskills", default: 1
    t.integer "maxpotions", default: 3
    t.integer "flags", default: 0, null: false
    t.integer "max_roads", default: 2, null: false
    t.index ["armor_id"], name: "index_players_on_armor_id"
    t.index ["level_id"], name: "index_players_on_level_id"
    t.index ["weapon_id"], name: "index_players_on_weapon_id"
  end

  create_table "potions", force: :cascade do |t|
    t.string "name"
    t.string "desc"
    t.integer "cost"
    t.string "icon"
    t.jsonb "effects"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "immediate", default: true, null: false
  end

  create_table "roads", force: :cascade do |t|
    t.bigint "monster_id"
    t.bigint "encounter_id"
    t.bigint "player_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["encounter_id"], name: "index_roads_on_encounter_id"
    t.index ["monster_id"], name: "index_roads_on_monster_id"
    t.index ["player_id"], name: "index_roads_on_player_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "name"
    t.float "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trinkets", force: :cascade do |t|
    t.string "name"
    t.string "desc"
    t.integer "cost"
    t.string "icon"
    t.jsonb "effects"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "reserved", default: false, null: false
  end

  create_table "weapons", force: :cascade do |t|
    t.string "name"
    t.integer "cost"
    t.integer "mindmg"
    t.integer "maxdmg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "fights", "encounters"
  add_foreign_key "fights", "monsters"
  add_foreign_key "fights", "players"
  add_foreign_key "player_potions", "players"
  add_foreign_key "player_potions", "potions"
  add_foreign_key "player_trinkets", "players"
  add_foreign_key "player_trinkets", "trinkets"
  add_foreign_key "players", "armors"
  add_foreign_key "players", "levels"
  add_foreign_key "players", "weapons"
  add_foreign_key "roads", "encounters"
  add_foreign_key "roads", "monsters"
  add_foreign_key "roads", "players"
end
