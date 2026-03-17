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

ActiveRecord::Schema[8.1].define(version: 2026_03_17_003518) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "services", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.text "notes"
    t.datetime "updated_at", null: false
  end

  create_table "user_services", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "service_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["service_id"], name: "index_user_services_on_service_id"
    t.index ["user_id"], name: "index_user_services_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "about"
    t.boolean "admin", default: false
    t.text "admin_notes"
    t.integer "age"
    t.boolean "agrees_to_consultation", default: false
    t.boolean "agrees_to_no_guarantee", default: false
    t.integer "alcohol_use"
    t.text "comfort_lifestyle"
    t.datetime "created_at", null: false
    t.text "cultural_values"
    t.string "email", default: "", null: false
    t.text "emotional_availability"
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.integer "gender"
    t.text "grief_or_loss"
    t.string "intake_token"
    t.integer "interest_level"
    t.boolean "jewish", default: false
    t.string "jewish_identity"
    t.string "last_name"
    t.integer "life_stage"
    t.string "location"
    t.text "luxury_relationship"
    t.integer "marijuana_use"
    t.integer "neurodivergent"
    t.text "neurodivergent_details"
    t.integer "open_to_relocating"
    t.integer "open_to_zoom_consultation"
    t.text "partner_goals"
    t.string "phone"
    t.integer "political_view"
    t.text "relationship_patterns"
    t.text "relationship_qualities"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "seeking"
    t.integer "smoking"
    t.integer "status", default: 0
    t.text "upbringing"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["intake_token"], name: "index_users_on_intake_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "user_services", "services"
  add_foreign_key "user_services", "users"
end
