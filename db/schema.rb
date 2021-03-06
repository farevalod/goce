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

ActiveRecord::Schema.define(version: 20160321173058) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "attendaces", force: true do |t|
    t.integer  "patient_id"
    t.integer  "group_id"
    t.integer  "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendaces", ["group_id"], name: "index_attendaces_on_group_id"
  add_index "attendaces", ["patient_id"], name: "index_attendaces_on_patient_id"

  create_table "attendances", force: true do |t|
    t.integer  "patient_id"
    t.integer  "session_id"
    t.integer  "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "justificacion"
  end

  add_index "attendances", ["patient_id"], name: "index_attendances_on_patient_id"
  add_index "attendances", ["session_id"], name: "index_attendances_on_session_id"

  create_table "doctors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "profession"
  end

  create_table "doctors_sessions", force: true do |t|
    t.integer "doctor_id"
    t.integer "session_id"
  end

  add_index "doctors_sessions", ["doctor_id"], name: "index_doctors_sessions_on_doctor_id"
  add_index "doctors_sessions", ["session_id"], name: "index_doctors_sessions_on_session_id"

  create_table "groups", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "day"
    t.time     "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "doctor_id"
    t.integer  "cost"
  end

  add_index "groups", ["doctor_id"], name: "index_groups_on_doctor_id"

  create_table "groups_patients", force: true do |t|
    t.integer "group_id"
    t.integer "patient_id"
  end

  add_index "groups_patients", ["group_id"], name: "index_groups_patients_on_group_id"
  add_index "groups_patients", ["patient_id"], name: "index_groups_patients_on_patient_id"

  create_table "patients", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.date     "dob"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.integer  "initial_weight"
    t.integer  "status"
    t.string   "rut"
    t.integer  "height"
    t.integer  "target"
    t.boolean  "cirugia"
    t.string   "medicamentos"
    t.string   "url_foto_antes"
    t.string   "url_foto_despues"
    t.string   "phone"
    t.string   "address"
  end

  add_index "patients", ["group_id"], name: "index_patients_on_group_id"

  create_table "payments", force: true do |t|
    t.integer  "patient_id"
    t.integer  "amount"
    t.string   "details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "adjustment"
    t.integer  "boleta"
    t.integer  "mes"
  end

  add_index "payments", ["patient_id"], name: "index_payments_on_patient_id"

  create_table "sessions", force: true do |t|
    t.date     "date"
    t.integer  "group_id"
    t.integer  "doctor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["doctor_id"], name: "index_sessions_on_doctor_id"
  add_index "sessions", ["group_id"], name: "index_sessions_on_group_id"

end
