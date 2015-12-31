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

ActiveRecord::Schema.define(version: 20151231021032) do

  create_table "attendaces", force: true do |t|
    t.integer  "patient_id"
    t.integer  "group_id"
    t.integer  "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendaces", ["group_id"], name: "index_attendaces_on_group_id"
  add_index "attendaces", ["patient_id"], name: "index_attendaces_on_patient_id"

  create_table "groups", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "day"
    t.time     "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.date     "dob"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.integer  "patient_id"
    t.integer  "amount"
    t.string   "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["patient_id"], name: "index_payments_on_patient_id"

end
