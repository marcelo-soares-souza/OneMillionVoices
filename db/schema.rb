# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 2023_05_23_172721) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "admin", default: false
    t.string "name"
    t.string "slug"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.bigint "photo_file_size"
    t.datetime "photo_updated_at", precision: nil
    t.text "about"
    t.string "website"
    t.index ["confirmation_token"], name: "index_accounts_on_confirmation_token", unique: true
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_accounts_on_slug", unique: true
  end

  create_table "acknowledges", force: :cascade do |t|
    t.bigint "practice_id", null: false
    t.text "knowledge_source"
    t.text "knowledge_timing"
    t.text "knowledge_products"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "uptake_motivation"
    t.index ["practice_id"], name: "index_acknowledges_on_practice_id"
  end

  create_table "characterises", force: :cascade do |t|
    t.bigint "practice_id", null: false
    t.text "agroecology_principles_addressed"
    t.text "food_system_components_addressed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["practice_id"], name: "index_characterises_on_practice_id"
  end

  create_table "documents", force: :cascade do |t|
    t.text "description"
    t.bigint "practice_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_file_name"
    t.string "file_content_type"
    t.bigint "file_file_size"
    t.datetime "file_updated_at"
    t.bigint "location_id", null: false
    t.bigint "account_id", null: false
    t.index ["account_id"], name: "index_documents_on_account_id"
    t.index ["location_id"], name: "index_documents_on_location_id"
    t.index ["practice_id"], name: "index_documents_on_practice_id"
  end

  create_table "evaluates", force: :cascade do |t|
    t.bigint "practice_id", null: false
    t.text "general_performance_of_practice"
    t.text "unintended_positive_side_effects_of_practice"
    t.text "unintended_negative_side_effect_of_practice"
    t.text "knowledge_and_skills_required_for_practice"
    t.text "labour_required_for_practice"
    t.text "cost_associated_with_practice"
    t.text "system_integrity_requirements"
    t.text "system_integrity_effects"
    t.text "climate_change_vulnerability_effects"
    t.text "time_requirements"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "general_performance_of_practice_details"
    t.text "unintended_positive_side_effects_of_practice_details"
    t.text "unintended_negative_side_effect_of_practice_details"
    t.text "knowledge_and_skills_required_for_practice_details"
    t.text "labour_required_for_practice_details"
    t.text "cost_associated_with_practice_details"
    t.text "system_integrity_requirements_details"
    t.text "system_integrity_effects_details"
    t.text "climate_change_vulnerability_effects_details"
    t.text "time_requirements_details"
    t.index ["practice_id"], name: "index_evaluates_on_practice_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "description"
    t.float "latitude"
    t.float "longitude"
    t.bigint "account_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.bigint "photo_file_size"
    t.datetime "photo_updated_at", precision: nil
    t.string "property_type"
    t.boolean "hide_my_location"
    t.string "country"
    t.string "farm_and_farming_system"
    t.text "agroecology_in_practice"
    t.text "summary_observation"
    t.text "farm_and_farming_system_details"
    t.index ["account_id"], name: "index_locations_on_account_id"
    t.index ["slug"], name: "index_locations_on_slug", unique: true
  end

  create_table "medias", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.bigint "photo_file_size"
    t.datetime "photo_updated_at", precision: nil
    t.bigint "account_id"
    t.bigint "location_id"
    t.bigint "practice_id"
    t.index ["account_id"], name: "index_medias_on_account_id"
    t.index ["location_id"], name: "index_medias_on_location_id"
    t.index ["practice_id"], name: "index_medias_on_practice_id"
  end

  create_table "practices", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "location_id", null: false
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["account_id"], name: "index_practices_on_account_id"
    t.index ["location_id"], name: "index_practices_on_location_id"
    t.index ["slug"], name: "index_practices_on_slug", unique: true
  end

  create_table "what_you_dos", force: :cascade do |t|
    t.bigint "practice_id", null: false
    t.text "summary_description_of_agroecological_practice"
    t.text "type_of_agroecological_practice"
    t.text "problem_that_practice_addresses"
    t.text "practical_implementation_of_the_practice"
    t.text "expected_function_or_effects_of_practice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "where_it_is_realized"
    t.float "land_size"
    t.string "substitution_of_less_ecological_alternative"
    t.index ["practice_id"], name: "index_what_you_dos_on_practice_id"
  end

  add_foreign_key "acknowledges", "practices"
  add_foreign_key "characterises", "practices"
  add_foreign_key "documents", "accounts"
  add_foreign_key "documents", "locations"
  add_foreign_key "documents", "practices"
  add_foreign_key "evaluates", "practices"
  add_foreign_key "locations", "accounts"
  add_foreign_key "medias", "accounts"
  add_foreign_key "medias", "locations"
  add_foreign_key "medias", "practices"
  add_foreign_key "practices", "accounts"
  add_foreign_key "practices", "locations"
  add_foreign_key "what_you_dos", "practices"
end
