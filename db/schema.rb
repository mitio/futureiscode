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

ActiveRecord::Schema.define(version: 20150412130358) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name",                              null: false
    t.string   "slug",                              null: false
    t.string   "url"
    t.boolean  "pledged_support",   default: false, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  add_index "companies", ["name"], name: "index_companies_on_name", unique: true, using: :btree
  add_index "companies", ["slug"], name: "index_companies_on_slug", unique: true, using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "speaker_id",                               null: false
    t.integer  "school_id",                                null: false
    t.date     "date",                                     null: false
    t.boolean  "approved",                 default: false, null: false
    t.string   "name"
    t.text     "details"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "cover_image_file_name"
    t.string   "cover_image_content_type"
    t.integer  "cover_image_file_size"
    t.datetime "cover_image_updated_at"
    t.string   "url"
    t.string   "public_email"
  end

  add_index "events", ["approved", "date"], name: "index_events_on_approved_and_date", using: :btree
  add_index "events", ["date"], name: "index_events_on_date", using: :btree

  create_table "municipalities", force: :cascade do |t|
    t.string   "code",       null: false
    t.string   "name",       null: false
    t.integer  "state_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "municipalities", ["code"], name: "index_municipalities_on_code", unique: true, using: :btree
  add_index "municipalities", ["state_id"], name: "index_municipalities_on_state_id", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "name",                                null: false
    t.integer  "town_id",                             null: false
    t.string   "address",                             null: false
    t.string   "contact_name",                        null: false
    t.string   "email",                               null: false
    t.string   "encrypted_password",                  null: false
    t.string   "phone"
    t.boolean  "confirmed_participation"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.text     "dates"
    t.text     "details"
    t.text     "notes"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "schools", ["confirmation_token"], name: "index_schools_on_confirmation_token", unique: true, using: :btree
  add_index "schools", ["confirmed_participation", "name"], name: "index_schools_on_confirmed_participation_and_name", using: :btree
  add_index "schools", ["email"], name: "index_schools_on_email", unique: true, using: :btree
  add_index "schools", ["reset_password_token"], name: "index_schools_on_reset_password_token", unique: true, using: :btree

  create_table "speakers", force: :cascade do |t|
    t.string   "name",                               null: false
    t.integer  "company_id"
    t.string   "other_company"
    t.string   "phone"
    t.string   "email",                              null: false
    t.string   "encrypted_password",                 null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "speakers", ["confirmation_token"], name: "index_speakers_on_confirmation_token", unique: true, using: :btree
  add_index "speakers", ["email"], name: "index_speakers_on_email", unique: true, using: :btree
  add_index "speakers", ["reset_password_token"], name: "index_speakers_on_reset_password_token", unique: true, using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "code",       null: false
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "states", ["code"], name: "index_states_on_code", unique: true, using: :btree

  create_table "towns", force: :cascade do |t|
    t.string   "kind",            null: false
    t.string   "code",            null: false
    t.string   "name",            null: false
    t.integer  "municipality_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "towns", ["code"], name: "index_towns_on_code", unique: true, using: :btree
  add_index "towns", ["municipality_id"], name: "index_towns_on_municipality_id", using: :btree

end
