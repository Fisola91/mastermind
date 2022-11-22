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

ActiveRecord::Schema[7.0].define(version: 2022_11_21_162940) do
  create_table "attempts", force: :cascade do |t|
    t.text "values"
    t.integer "player_id", null: false
    t.integer "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_attempts_on_game_id"
    t.index ["player_id"], name: "index_attempts_on_player_id"
  end

  create_table "codebreakers", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_codebreakers_on_game_id"
    t.index ["player_id"], name: "index_codebreakers_on_player_id"
  end

  create_table "codemakers", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_codemakers_on_game_id"
    t.index ["player_id"], name: "index_codemakers_on_player_id"
  end

  create_table "games", force: :cascade do |t|
    t.text "passcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "valid_colors", force: :cascade do |t|
    t.text "colors"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "attempts", "games"
  add_foreign_key "attempts", "players"
  add_foreign_key "codebreakers", "games"
  add_foreign_key "codebreakers", "players"
  add_foreign_key "codemakers", "games"
  add_foreign_key "codemakers", "players"
end
