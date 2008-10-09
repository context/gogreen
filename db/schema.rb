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

ActiveRecord::Schema.define(:version => 20081009014627) do

  create_table "contests", :force => true do |t|
    t.string "name"
  end

  create_table "pledges", :force => true do |t|
    t.integer "user_id",                 :limit => 11
    t.integer "team_id",                 :limit => 11
    t.integer "carpool_participants",    :limit => 11
    t.integer "distance_to_destination", :limit => 11
    t.integer "walk_bike",               :limit => 11
    t.integer "public_transit",          :limit => 11
    t.integer "carpool",                 :limit => 11
    t.string  "car_type"
  end

  create_table "reports", :force => true do |t|
    t.integer  "pledge_id",         :limit => 11
    t.datetime "action_date"
    t.string   "mode_of_transport", :limit => 20
    t.integer  "score",             :limit => 11
  end

  create_table "teams", :force => true do |t|
    t.string  "name"
    t.integer "contest_id", :limit => 11
  end

end
