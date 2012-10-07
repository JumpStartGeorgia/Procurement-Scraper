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

ActiveRecord::Schema.define(:version => 20121007092508) do

  create_table "bidders", :force => true do |t|
    t.integer  "tender_id"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bidders", ["tender_id", "organization_id"], :name => "index_bidders_on_tender_id_and_organization_id"

  create_table "bids", :force => true do |t|
    t.integer  "bidder_id"
    t.date     "bid_date"
    t.decimal  "value",      :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bids", ["bidder_id", "bid_date", "value"], :name => "index_bids_values"

  create_table "organizations", :force => true do |t|
    t.string   "url_id"
    t.string   "label_id"
    t.string   "name"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organizations", ["label_id", "name"], :name => "index_organizations_on_label_id_and_name"
  add_index "organizations", ["url_id", "name"], :name => "index_organizations_on_url_id_and_name"

  create_table "tender_cpv_classifiers", :force => true do |t|
    t.integer  "tender_id"
    t.string   "cpv_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tender_cpv_classifiers", ["tender_id"], :name => "index_tender_cpv_classifiers_on_tender_id"

  create_table "tenders", :force => true do |t|
    t.integer  "procurring_entity_id"
    t.string   "tender_type"
    t.string   "tender_registration_number"
    t.string   "tender_status"
    t.date     "tender_announcement_date"
    t.date     "bid_start_date"
    t.date     "bid_end_date"
    t.decimal  "estimated_value",            :precision => 11, :scale => 2
    t.boolean  "include_vat"
    t.string   "cpv_code"
    t.integer  "winning_bid_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url_id"
  end

  add_index "tenders", ["estimated_value"], :name => "index_tenders_on_estimated_value"
  add_index "tenders", ["procurring_entity_id"], :name => "index_tenders_on_procurring_entity_id"
  add_index "tenders", ["tender_status"], :name => "index_tenders_on_tender_status"
  add_index "tenders", ["tender_type"], :name => "index_tenders_on_tender_type"
  add_index "tenders", ["url_id"], :name => "index_tenders_on_url_id"
  add_index "tenders", ["winning_bid_id"], :name => "index_tenders_on_winning_bid_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "role",                   :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
