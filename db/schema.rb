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

ActiveRecord::Schema.define(version: 20200309181315) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
  end

  create_table "locations", force: :cascade do |t|
    t.bigint "place_id"
    t.string "direction"
    t.string "status", default: "reserved", null: false
    t.bigint "responsible_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "schedule_id"
    t.index ["place_id"], name: "index_locations_on_place_id"
    t.index ["responsible_id"], name: "index_locations_on_responsible_id"
    t.index ["schedule_id"], name: "index_locations_on_schedule_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "identifier"
    t.date "birthday"
    t.string "email"
    t.string "gender"
    t.string "phone"
    t.string "cellphone"
    t.string "status"
    t.bigint "invited_by_id"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.boolean "is_joining", default: false, null: false
    t.index ["invited_by_id"], name: "index_people_on_invited_by_id"
  end

  create_table "places", force: :cascade do |t|
    t.bigint "city_id"
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.string "address"
    t.string "status", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_places_on_city_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.date "day"
    t.string "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kind", null: false
    t.boolean "enabled", default: true, null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string "name", null: false
    t.string "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "locations", "people", column: "responsible_id"
  add_foreign_key "locations", "places"
  add_foreign_key "locations", "schedules"
  add_foreign_key "places", "cities"
end
