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

ActiveRecord::Schema[7.0].define(version: 2023_05_16_124455) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agroecological_practices", force: :cascade do |t|
    t.bigint "usuario_id", null: false
    t.bigint "local_id", null: false
    t.text "summary_description"
    t.text "problem_it_address"
    t.text "how_it_is_done"
    t.text "expected_function_effects"
    t.text "principles"
    t.text "general_evaluate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["local_id"], name: "index_agroecological_practices_on_local_id"
    t.index ["usuario_id"], name: "index_agroecological_practices_on_usuario_id"
  end

  create_table "comentarios", force: :cascade do |t|
    t.string "texto"
    t.string "slug"
    t.bigint "experiencia_agroecologica_id"
    t.bigint "usuario_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "agroecological_practice_id", null: false
    t.index ["agroecological_practice_id"], name: "index_comentarios_on_agroecological_practice_id"
    t.index ["experiencia_agroecologica_id"], name: "index_comentarios_on_experiencia_agroecologica_id"
    t.index ["usuario_id"], name: "index_comentarios_on_usuario_id"
  end

  create_table "experiencia_agroecologicas", force: :cascade do |t|
    t.string "nome"
    t.string "slug"
    t.bigint "usuario_id"
    t.bigint "local_id"
    t.bigint "tema_experiencia_agroecologica_id"
    t.text "resumo"
    t.text "observacao"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["local_id"], name: "index_experiencia_agroecologicas_on_local_id"
    t.index ["slug"], name: "index_experiencia_agroecologicas_on_slug", unique: true
    t.index ["tema_experiencia_agroecologica_id"], name: "idx_exp_agroecologicas_on_tema_exp_agroecologica_id"
    t.index ["usuario_id"], name: "index_experiencia_agroecologicas_on_usuario_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "usuario_id"
    t.bigint "experiencia_agroecologica_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["experiencia_agroecologica_id"], name: "index_likes_on_experiencia_agroecologica_id"
    t.index ["usuario_id"], name: "index_likes_on_usuario_id"
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
    t.bigint "experiencia_agroecologica_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "imagem_file_name"
    t.string "imagem_content_type"
    t.bigint "imagem_file_size"
    t.datetime "imagem_updated_at", precision: nil
    t.bigint "usuario_id"
    t.bigint "one_million_voice_id"
    t.bigint "local_id"
    t.bigint "agroecological_practice_id"
    t.index ["agroecological_practice_id"], name: "index_midias_on_agroecological_practice_id"
    t.index ["experiencia_agroecologica_id"], name: "index_midias_on_experiencia_agroecologica_id"
    t.index ["local_id"], name: "index_midias_on_local_id"
    t.index ["one_million_voice_id"], name: "index_midias_on_one_million_voice_id"
    t.index ["slug"], name: "index_midias_on_slug", unique: true
    t.index ["usuario_id"], name: "index_midias_on_usuario_id"
  end

  create_table "one_million_voices", force: :cascade do |t|
    t.text "description"
    t.bigint "local_id", null: false
    t.bigint "usuario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "problem_it_address"
    t.text "how_it_is_done"
    t.text "expected_function_effects"
    t.text "principles"
    t.text "general_evaluate"
    t.index ["local_id"], name: "index_one_million_voices_on_local_id"
    t.index ["usuario_id"], name: "index_one_million_voices_on_usuario_id"
  end

  create_table "tema_experiencia_agroecologicas", force: :cascade do |t|
    t.string "nome"
    t.string "slug"
    t.bigint "usuario_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["slug"], name: "index_tema_experiencia_agroecologicas_on_slug", unique: true
    t.index ["usuario_id"], name: "index_tema_experiencia_agroecologicas_on_usuario_id"
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

  add_foreign_key "agroecological_practices", "locais"
  add_foreign_key "agroecological_practices", "usuarios"
  add_foreign_key "comentarios", "agroecological_practices"
  add_foreign_key "comentarios", "experiencia_agroecologicas"
  add_foreign_key "comentarios", "usuarios"
  add_foreign_key "experiencia_agroecologicas", "locais"
  add_foreign_key "experiencia_agroecologicas", "tema_experiencia_agroecologicas"
  add_foreign_key "experiencia_agroecologicas", "usuarios"
  add_foreign_key "likes", "experiencia_agroecologicas"
  add_foreign_key "likes", "usuarios"
  add_foreign_key "locais", "usuarios"
  add_foreign_key "local_usuarios", "locais"
  add_foreign_key "local_usuarios", "usuarios"
  add_foreign_key "midias", "agroecological_practices"
  add_foreign_key "midias", "experiencia_agroecologicas"
  add_foreign_key "midias", "locais"
  add_foreign_key "midias", "one_million_voices"
  add_foreign_key "midias", "usuarios"
  add_foreign_key "one_million_voices", "locais"
  add_foreign_key "one_million_voices", "usuarios"
  add_foreign_key "tema_experiencia_agroecologicas", "usuarios"
end
