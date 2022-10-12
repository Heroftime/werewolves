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

ActiveRecord::Schema[7.0].define(version: 2022_10_11_105206) do
  create_table "battle_logs", force: :cascade do |t|
    t.integer "battle_id", null: false
    t.text "log"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["battle_id"], name: "index_battle_logs_on_battle_id"
  end

  create_table "battles", force: :cascade do |t|
    t.integer "initiator_id", null: false
    t.integer "opponent_id", null: false
    t.string "status"
    t.integer "winner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["initiator_id"], name: "index_battles_on_initiator_id"
    t.index ["opponent_id"], name: "index_battles_on_opponent_id"
    t.index ["winner_id"], name: "index_battles_on_winner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number"
    t.string "name"
    t.integer "amount_of_gold"
    t.integer "attack_value"
    t.integer "hit_points"
    t.integer "luck_value"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "battle_logs", "battles"
  add_foreign_key "battles", "users", column: "initiator_id"
  add_foreign_key "battles", "users", column: "opponent_id"
  add_foreign_key "battles", "users", column: "winner_id"
end
