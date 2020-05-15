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

ActiveRecord::Schema.define(version: 2020_05_15_024236) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", id: :serial, force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_id", null: false
    t.string "resource_type", null: false
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "clients", id: :serial, force: :cascade do |t|
    t.string "ruc"
    t.text "razon"
    t.text "direccion"
    t.text "obs"
    t.integer "tipo", default: 1
    t.integer "origen", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "details", id: :serial, force: :cascade do |t|
    t.text "descripcion"
    t.float "cantidad"
    t.float "precio"
    t.float "monto"
    t.integer "item_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id"
    t.index ["item_id"], name: "index_details_on_item_id"
    t.index ["product_id"], name: "index_details_on_product_id"
    t.index ["user_id"], name: "index_details_on_user_id"
  end

  create_table "formulas", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "material"
    t.float "cantidad"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "descripcion"
    t.string "indicacion"
    t.integer "orden"
    t.index ["product_id"], name: "index_formulas_on_product_id"
    t.index ["user_id"], name: "index_formulas_on_user_id"
  end

  create_table "items", id: :serial, force: :cascade do |t|
    t.date "pfecha"
    t.string "serie"
    t.string "nfactu"
    t.integer "client_id", default: 881
    t.float "subtotal"
    t.integer "origen"
    t.date "mmes"
    t.integer "moneda", default: 1
    t.float "tc", default: 0.0
    t.integer "user_id", default: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "empresa"
    t.integer "sele"
    t.integer "sele1"
    t.string "sele2"
    t.string "sele3"
    t.string "ruc"
    t.string "razon"
    t.string "detalle"
    t.string "razon2"
    t.integer "nuevo", default: 1
    t.float "monto"
    t.index ["client_id"], name: "index_items_on_client_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "parameters", id: :serial, force: :cascade do |t|
    t.integer "empresa"
    t.integer "origen"
    t.date "mes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sele"
    t.integer "sele1"
    t.string "sele2"
    t.string "sele3"
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
    t.float "precio"
    t.integer "moneda"
    t.integer "unidad"
    t.integer "client_id"
    t.string "material"
    t.float "lote"
    t.integer "proceso"
    t.integer "equivalente"
    t.float "conversion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "peso"
    t.boolean "activo", default: true
    t.integer "user_id"
    t.index ["client_id"], name: "index_products_on_client_id"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.string "permission_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.integer "categoria", default: 1
    t.integer "empresa"
    t.integer "periodo"
    t.integer "sele"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "clients", "users"
  add_foreign_key "details", "items"
  add_foreign_key "details", "products"
  add_foreign_key "details", "users"
  add_foreign_key "formulas", "products"
  add_foreign_key "formulas", "users"
  add_foreign_key "items", "clients"
  add_foreign_key "items", "users"
  add_foreign_key "products", "clients"
  add_foreign_key "products", "users"
end
