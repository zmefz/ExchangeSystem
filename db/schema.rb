# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171222192048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "coefficents", force: :cascade do |t|
    t.decimal "sell_value", precision: 15, scale: 2, null: false
    t.decimal "buy_value", precision: 15, scale: 2, null: false
    t.bigint "currency_id", null: false
    t.datetime "timestamp_from"
    t.datetime "timestamp_to"
    t.index ["currency_id"], name: "index_coefficents_on_currency_id"
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "amount", precision: 15, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code", null: false
    t.integer "display_count", default: 1
  end

  create_table "sessions", force: :cascade do |t|
    t.string "token"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "amount", null: false
    t.bigint "currency_from_id", null: false
    t.bigint "currency_to_id", null: false
    t.datetime "timestamp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_from_id"], name: "index_transactions_on_currency_from_id"
    t.index ["currency_to_id"], name: "index_transactions_on_currency_to_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "role", default: 1
    t.string "firstname", null: false
    t.string "lastname", null: false
    t.string "passport"
    t.string "password_hash", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "currency_id"
    t.index ["currency_id"], name: "index_users_on_currency_id"
  end

  add_foreign_key "coefficents", "currencies"
  add_foreign_key "sessions", "users"
  add_foreign_key "transactions", "users"
  add_foreign_key "users", "currencies"
end
