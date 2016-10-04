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

ActiveRecord::Schema.define(version: 20160922190403) do

  create_table "shares", force: :cascade do |t|
    t.integer  "amount",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "wine_id"
    t.integer  "user_id"
  end

  add_index "shares", ["user_id"], name: "index_shares_on_user_id"
  add_index "shares", ["wine_id"], name: "index_shares_on_wine_id"

  create_table "users", force: :cascade do |t|
    t.string   "name",                null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "email_address",       null: false
    t.string   "mobile_phone_number"
  end

  add_index "users", ["email_address"], name: "index_users_on_email_address", unique: true
  add_index "users", ["mobile_phone_number"], name: "index_users_on_mobile_phone_number", unique: true

  create_table "wines", force: :cascade do |t|
    t.string   "name",         null: false
    t.text     "description"
    t.integer  "bottles",      null: false
    t.integer  "price"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "suggester_id"
  end

end
