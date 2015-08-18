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

ActiveRecord::Schema.define(version: 20150630000117) do

  create_table "periods", force: :cascade do |t|
    t.string   "symbol"
    t.string   "name"
    t.integer  "time_in_mins"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "quotes", id: false, force: :cascade do |t|
    t.integer  "id",          limit: 8
    t.text     "period"
    t.datetime "time"
    t.date     "date"
    t.decimal  "open"
    t.decimal  "high"
    t.decimal  "low"
    t.decimal  "close"
    t.integer  "volume",      limit: 8
    t.integer  "security_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "quotes", ["security_id"], name: "index_quotes_on_security_id"

  create_table "securities", force: :cascade do |t|
    t.string   "symbol"
    t.string   "name"
    t.string   "exchange"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
