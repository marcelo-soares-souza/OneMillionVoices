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

ActiveRecord::Schema[7.0].define(version: 2023_05_17_132734) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "acknowledges", force: :cascade do |t|
    t.bigint "practice_id", null: false
    t.text "knowledge_source"
    t.text "knowledge_timing"
    t.text "knowledge_products"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["practice_id"], name: "index_evaluates_on_practice_id"
  end

  create_table "locais", force: :cascade do |t|
    t.string "nome"
    t.string "slug"
    t.string "observacao"
    t.float "latitude"
    t.float "longitude"
    t.bigint "usuario_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "imagem_file_name"
    t.string "imagem_content_type"
    t.bigint "imagem_file_size"
    t.datetime "imagem_updated_at", precision: nil
    t.string "tipo"
    t.string "hospedagem"
    t.index ["slug"], name: "index_locais_on_slug", unique: true
    t.index ["usuario_id"], name: "index_locais_on_usuario_id"
  end

  create_table "local_usuarios", force: :cascade do |t|
    t.bigint "local_id"
    t.bigint "usuario_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["local_id"], name: "index_local_usuarios_on_local_id"
    t.index ["usuario_id"], name: "index_local_usuarios_on_usuario_id"
  end

  create_table "midias", force: :cascade do |t|
    t.string "descricao"
    t.string "slug"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "imagem_file_name"
    t.string "imagem_content_type"
    t.bigint "imagem_file_size"
    t.datetime "imagem_updated_at", precision: nil
    t.bigint "usuario_id"
    t.bigint "local_id"
    t.bigint "practice_id"
    t.index ["local_id"], name: "index_midias_on_local_id"
    t.index ["practice_id"], name: "index_midias_on_practice_id"
    t.index ["slug"], name: "index_midias_on_slug", unique: true
    t.index ["usuario_id"], name: "index_midias_on_usuario_id"
  end

  create_table "practices", force: :cascade do |t|
    t.bigint "usuario_id", null: false
    t.bigint "local_id", null: false
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["local_id"], name: "index_practices_on_local_id"
    t.index ["slug"], name: "index_practices_on_slug", unique: true
    t.index ["usuario_id"], name: "index_practices_on_usuario_id"
  end

  create_table "usuarios", force: :cascade do |t|
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
    t.string "nome"
    t.string "slug"
    t.string "imagem_file_name"
    t.string "imagem_content_type"
    t.bigint "imagem_file_size"
    t.datetime "imagem_updated_at", precision: nil
    t.index ["confirmation_token"], name: "index_usuarios_on_confirmation_token", unique: true
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_usuarios_on_slug", unique: true
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
    t.index ["practice_id"], name: "index_what_you_dos_on_practice_id"
  end

  add_foreign_key "acknowledges", "practices"
  add_foreign_key "characterises", "practices"
  add_foreign_key "evaluates", "practices"
  add_foreign_key "locais", "usuarios"
  add_foreign_key "local_usuarios", "locais"
  add_foreign_key "local_usuarios", "usuarios"
  add_foreign_key "midias", "locais"
  add_foreign_key "midias", "practices"
  add_foreign_key "midias", "usuarios"
  add_foreign_key "practices", "locais"
  add_foreign_key "practices", "usuarios"
  add_foreign_key "what_you_dos", "practices"
end
