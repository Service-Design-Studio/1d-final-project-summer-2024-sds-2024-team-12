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


ActiveRecord::Schema[7.0].define(version: 2024_07_24_014945) do
  create_table "promptpays", force: :cascade do |t|
    t.string "phone_number"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
  
  create_table "recipients", force: :cascade do |t|
    t.string "country"
    t.string "account_details"
    t.string "full_name"
    t.string "registered_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scheduled_transactions", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.text "start_date", null: false
    t.string "frequency", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "shortcuts", force: :cascade do |t|
    t.string "nickname"
    t.string "recipient_name"
    t.decimal "amount", precision: 10, scale: 2
    t.integer "user_id", null: false
    t.string "widget_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_shortcuts_on_user_id"
  end

  create_table "suggestions", force: :cascade do |t|
    t.string "suggestion_type"
    t.text "content"
    t.string "link_url"
    t.boolean "user_dismissed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string "name"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "user_actions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "action"
    t.integer "count"
    t.string "controller"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_actions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "phone", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "scheduled_transactions", "users"
  add_foreign_key "scheduled_transactions", "users"
  add_foreign_key "shortcuts", "users"
  add_foreign_key "user_actions", "users"
end
