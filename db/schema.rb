# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170213220051) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accesses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "roadshow_id"
    t.datetime "start_access"
    t.datetime "end_access"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["roadshow_id"], name: "index_accesses_on_roadshow_id", using: :btree
    t.index ["user_id"], name: "index_accesses_on_user_id", using: :btree
  end

  create_table "attachinary_files", force: :cascade do |t|
    t.string   "attachinariable_type"
    t.integer  "attachinariable_id"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree
  end

  create_table "charges", force: :cascade do |t|
    t.integer  "amount"
    t.integer  "coupon_id"
    t.integer  "stripe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.string   "code"
    t.integer  "discount_percent"
    t.datetime "expires_at"
    t.string   "description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.float    "price"
    t.boolean  "is_paid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "latestpages", force: :cascade do |t|
    t.integer  "page"
    t.integer  "user_id"
    t.integer  "roadshow_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["roadshow_id"], name: "index_latestpages_on_roadshow_id", using: :btree
    t.index ["user_id"], name: "index_latestpages_on_user_id", using: :btree
  end

  create_table "roadshows", force: :cascade do |t|
    t.string   "company"
    t.string   "url"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "message"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "user_id"
    t.boolean  "start_date_public"
    t.boolean  "end_date_public"
    t.boolean  "download"
    t.boolean  "print"
    t.boolean  "watermark"
    t.integer  "number_of_pages"
    t.boolean  "is_paid"
    t.string   "title_list",        default: [],              array: true
    t.string   "reference_code"
    t.index ["user_id"], name: "index_roadshows_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "accesses", "roadshows"
  add_foreign_key "accesses", "users"
  add_foreign_key "latestpages", "roadshows"
  add_foreign_key "latestpages", "users"
  add_foreign_key "roadshows", "users"
end
