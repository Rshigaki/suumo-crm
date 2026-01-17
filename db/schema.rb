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

ActiveRecord::Schema[8.1].define(version: 2026_01_17_033852) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "companies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.text "address"
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.string "email"
    t.bigint "media_source_id", null: false
    t.string "name"
    t.string "phone"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["company_id"], name: "index_customers_on_company_id"
    t.index ["media_source_id"], name: "index_customers_on_media_source_id"
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "interactions", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.bigint "customer_id"
    t.datetime "ended_at"
    t.text "memo"
    t.text "minutes"
    t.jsonb "questionnaire_data"
    t.string "recording_url"
    t.datetime "started_at"
    t.integer "status"
    t.text "transcript"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["company_id"], name: "index_interactions_on_company_id"
    t.index ["customer_id"], name: "index_interactions_on_customer_id"
    t.index ["user_id"], name: "index_interactions_on_user_id"
  end

  create_table "media_sources", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_media_sources_on_company_id"
  end

  create_table "point_logs", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.integer "points"
    t.string "reason"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["company_id"], name: "index_point_logs_on_company_id"
    t.index ["user_id"], name: "index_point_logs_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.date "contract_date"
    t.datetime "created_at", null: false
    t.bigint "customer_id", null: false
    t.date "delivery_date"
    t.integer "estimated_amount"
    t.string "name"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["company_id"], name: "index_projects_on_company_id"
    t.index ["customer_id"], name: "index_projects_on_customer_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role"
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "customers", "companies"
  add_foreign_key "customers", "media_sources"
  add_foreign_key "customers", "users"
  add_foreign_key "interactions", "companies"
  add_foreign_key "interactions", "customers"
  add_foreign_key "interactions", "users"
  add_foreign_key "media_sources", "companies"
  add_foreign_key "point_logs", "companies"
  add_foreign_key "point_logs", "users"
  add_foreign_key "projects", "companies"
  add_foreign_key "projects", "customers"
  add_foreign_key "projects", "users"
  add_foreign_key "users", "companies"
end
