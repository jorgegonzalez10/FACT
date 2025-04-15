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

ActiveRecord::Schema[7.1].define(version: 2025_04_09_220107) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.bigint "company_id"
    t.string "rfc"
    t.string "fiscal_name"
    t.string "fiscal_number"
    t.string "certifcate"
    t.string "cfdi"
    t.integer "postal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "phone"
    t.string "email"
    t.index ["company_id"], name: "index_clients_on_company_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "rfc"
    t.string "name"
    t.string "fiscal_number"
    t.integer "postal"
    t.string "certificate"
    t.string "location"
    t.date "time_date"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "detail_invoices", force: :cascade do |t|
    t.bigint "invoice_id", null: false
    t.string "product_number"
    t.integer "amount"
    t.string "unit"
    t.text "description"
    t.float "unit_value"
    t.float "total_value"
    t.float "taxes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_detail_invoices_on_invoice_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "client_id", null: false
    t.string "payment_type"
    t.string "payment_method"
    t.float "sub_total"
    t.float "taxes"
    t.float "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_invoices_on_client_id"
    t.index ["company_id"], name: "index_invoices_on_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "clients", "companies"
  add_foreign_key "companies", "users"
  add_foreign_key "detail_invoices", "invoices"
  add_foreign_key "invoices", "clients"
  add_foreign_key "invoices", "companies"
end





company1 = Company.create!(
  name: "Facturas del Norte S.A.",
  rfc: "FNRT920101AAA",
  fiscal_number: 123456789,
  postal: 12345,
  certificate: "CERT123",
  location: "Monterrey, NL",
  time_date: Date.today,
  user: user
)

company2 = Company.create!(
  name: "Grupo Contable del Sur",
  rfc: "GCSU950202BBB",
  fiscal_number: 987654321,
  postal: 54321,
  certificate: "CERT456",
  location: "Mérida, Yucatán",
  time_date: Date.today,
  user: user
)

# Distribuir los 15 clientes entre ambas compañías
clients = Client.all.shuffle
half = clients.size / 2

clients[0...half].each { |client| client.update!(company: company1) }
clients[half..].each { |client| client.update!(company: company2) }

# Crear facturas aleatorias para cada cliente
payment_types = ["PUE", "PPD"]
payment_methods = ["03 - Transferencia electrónica", "01 - Efectivo", "04 - Tarjeta de crédito"]

clients.each do |client|
  rand(2..5).times do
    created_at = rand(Date.new(2024, 10, 1)..Date.today).to_datetime
    sub_total = rand(1000..10000)
    taxes = (sub_total * 0.16).round(2)
    total = (sub_total + taxes).round(2)

    Invoice.create!(
      company: client.company,
      client: client,
      payment_type: payment_types.sample,
      payment_method: payment_methods.sample,
      sub_total: sub_total,
      taxes: taxes,
      total: total,
      created_at: created_at,
      updated_at: created_at
    )
  end
end
