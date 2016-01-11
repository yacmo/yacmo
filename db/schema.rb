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

ActiveRecord::Schema.define(version: 20160111080300) do

  create_table "message_histories", force: :cascade do |t|
    t.integer  "leaders_id",             null: false
    t.integer  "user_id",                null: false
    t.text     "message"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "achievement_categories"
    t.integer  "achievement_level"
  end

  create_table "user_data_histories", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "steps",       null: false
    t.float    "weight"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.date     "date",        null: false
    t.integer  "steps_goal"
    t.float    "weight_goal"
  end

  add_index "user_data_histories", ["date", "user_id"], name: "user_data_histories_unique_in", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "user_name",              default: "", null: false
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "consumer_key"
    t.string   "consumer_secret"
    t.string   "token"
    t.string   "secret"
    t.string   "fitgem_user_id"
    t.float    "start_weight"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
