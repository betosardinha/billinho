# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_13_192936) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "institutions", force: :cascade do |t|
    t.string "nome"
    t.string "cnpj"
    t.string "tipo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.decimal "valor"
    t.date "dt_vencimento"
    t.bigint "registration_id", null: false
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["registration_id"], name: "index_invoices_on_registration_id"
  end

  create_table "registrations", force: :cascade do |t|
    t.decimal "valor_total"
    t.integer "qd_faturas"
    t.integer "vencimento"
    t.string "curso"
    t.bigint "institution_id", null: false
    t.bigint "student_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["institution_id"], name: "index_registrations_on_institution_id"
    t.index ["student_id"], name: "index_registrations_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "nome"
    t.string "cpf"
    t.date "dt_nasc"
    t.bigint "telefone"
    t.string "genero"
    t.string "pagamento"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "invoices", "registrations"
  add_foreign_key "registrations", "institutions"
  add_foreign_key "registrations", "students"
end
