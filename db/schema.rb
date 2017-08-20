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

ActiveRecord::Schema.define(version: 20170820204535) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cancellations", force: :cascade do |t|
    t.integer "totalCancelation"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cancellations_on_user_id"
  end

  create_table "email_templates", force: :cascade do |t|
    t.string "subject"
    t.string "body"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "etype"
    t.boolean "active", default: false
    t.index ["user_id"], name: "index_email_templates_on_user_id"
  end

  create_table "failed_charges", force: :cascade do |t|
    t.integer "fcharge"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_failed_charges_on_user_id"
  end

  create_table "riskycustomers", force: :cascade do |t|
    t.string "email"
    t.string "plan"
    t.float "amount"
    t.string "rlevel"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "customerId"
    t.integer "expiryMonth"
    t.integer "expiryYear"
    t.boolean "emailsent"
    t.boolean "recovered"
    t.index ["user_id"], name: "index_riskycustomers_on_user_id"
  end

  create_table "sent_emails", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "riskycustomer_id"
    t.string "etype"
    t.string "content"
    t.string "to"
    t.string "from"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["riskycustomer_id"], name: "index_sent_emails_on_riskycustomer_id"
    t.index ["user_id"], name: "index_sent_emails_on_user_id"
  end

  create_table "sents", force: :cascade do |t|
    t.bigint "user_id"
    t.string "etype"
    t.string "content"
    t.string "to"
    t.string "from"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sents_on_user_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.string "publishable_key"
    t.string "provider"
    t.string "uid"
    t.string "access_code"
    t.string "picture"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cancellations", "users"
  add_foreign_key "email_templates", "users"
  add_foreign_key "failed_charges", "users"
  add_foreign_key "riskycustomers", "users"
  add_foreign_key "sent_emails", "riskycustomers"
  add_foreign_key "sent_emails", "users"
end
