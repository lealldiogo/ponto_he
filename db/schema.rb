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

ActiveRecord::Schema.define(version: 20191101192434) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "grupos", force: :cascade do |t|
    t.string   "nome"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.float    "valor_he_exce"
    t.date     "inicio_exce"
    t.date     "fim_exce"
    t.boolean  "selec_valor"
    t.boolean  "selec_duplo_trab"
  end

  create_table "membros", force: :cascade do |t|
    t.integer  "grupo_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grupo_id"], name: "index_membros_on_grupo_id", using: :btree
    t.index ["user_id", "grupo_id"], name: "index_membros_on_user_id_and_grupo_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_membros_on_user_id", using: :btree
  end

  create_table "obras", force: :cascade do |t|
    t.string   "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trabalhos", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "obra_id"
    t.float    "valor_he"
    t.date     "data"
    t.time     "entrada"
    t.time     "saida"
    t.string   "status",       default: "Pendente"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "sem_he",       default: false
    t.integer  "veiculo_id"
    t.float    "horas_extras", default: 0.0
    t.index ["obra_id"], name: "index_trabalhos_on_obra_id", using: :btree
    t.index ["user_id"], name: "index_trabalhos_on_user_id", using: :btree
    t.index ["veiculo_id"], name: "index_trabalhos_on_veiculo_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "username"
    t.string   "cargo"
    t.string   "equipe"
    t.string   "apelido"
    t.integer  "salario_cents",          default: 0,     null: false
    t.string   "salario_currency",       default: "BRL", null: false
    t.boolean  "admin",                  default: false, null: false
    t.string   "nome_completo"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  create_table "veiculos", force: :cascade do |t|
    t.string   "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "trabalhos", "obras"
  add_foreign_key "trabalhos", "users"
  add_foreign_key "trabalhos", "veiculos"
end
