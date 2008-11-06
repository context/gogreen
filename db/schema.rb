# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081103202924) do

  create_table "contests", :force => true do |t|
    t.string   "name"
    t.string   "permalink"
    t.datetime "start"
    t.datetime "end"
    t.string   "distance_question_text"
    t.text     "email_text"
    t.text     "intro_text"
    t.text     "tell_a_friend_default"
  end

  create_table "pledges", :force => true do |t|
    t.integer "user_id"
    t.integer "team_id"
    t.integer "carpool_additional_passengers"
    t.float   "distance_to_destination"
    t.integer "walk_bike",                     :default => 0
    t.integer "public_transit",                :default => 0
    t.integer "carpool",                       :default => 0
    t.string  "car_type"
    t.string  "report_code"
    t.string  "carpool_car_type"
    t.float   "carpool_distance"
  end

  create_table "report_actions", :force => true do |t|
    t.datetime "action_date"
    t.string   "mode_of_transport", :limit => 20
    t.integer  "score"
    t.integer  "report_id"
    t.integer  "position"
  end

  create_table "reports", :force => true do |t|
    t.datetime "start"
    t.integer  "pledge_id"
    t.string   "report_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.string  "name"
    t.integer "contest_id"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 100
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "receive_email"
    t.string   "opt_out_code"
    t.boolean  "superuser"
    t.boolean  "disabled"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
