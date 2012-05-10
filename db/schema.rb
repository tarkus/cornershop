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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120510074232) do

  create_table "loan_histories", :force => true do |t|
    t.integer  "user_id"
    t.integer  "media_id"
    t.date     "rent_start"
    t.date     "rent_estimated"
    t.date     "rent_effective"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "loan_histories", ["media_id"], :name => "index_loan_histories_on_media_id"
  add_index "loan_histories", ["rent_effective"], :name => "index_loan_histories_on_rent_effective"
  add_index "loan_histories", ["rent_start"], :name => "index_loan_histories_on_rent_start"
  add_index "loan_histories", ["user_id"], :name => "index_loan_histories_on_user_id"

  create_table "media", :force => true do |t|
    t.string   "title"
    t.string   "media_type"
    t.integer  "year"
    t.string   "language"
    t.string   "producer"
    t.string   "artist"
    t.string   "cast"
    t.string   "location"
    t.integer  "availability"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "media", ["cast"], :name => "index_media_on_cast"
  add_index "media", ["title"], :name => "index_media_on_title"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "team"
    t.string   "position"
    t.string   "phone"
    t.string   "nationality"
    t.integer  "rental_count"
    t.integer  "overdue_count"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["overdue_count"], :name => "index_users_on_overdue_count"
  add_index "users", ["rental_count"], :name => "index_users_on_rental_count"
  add_index "users", ["surname"], :name => "index_users_on_surname"

end
