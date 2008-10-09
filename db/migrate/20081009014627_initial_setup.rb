class InitialSetup < ActiveRecord::Migration
  def self.up
    create_table :contests do |t|
      t.string :name
    end
    create_table :teams do |t|
      t.string :name
      t.integer :contest_id
    end
    create_table :pledges do |t|
      t.integer :user_id, :team_id, :carpool_participants, :distance_to_destination
      t.integer :walk_bike, :public_transit, :carpool
      t.string :car_type
    end
    create_table :reports do |t|
      t.integer :pledge_id
      t.datetime :action_date
      t.string :mode_of_transport, :limit => 20
      t.integer :score
    end
  end

  def self.down
    drop_table :reports
    drop_table :pledges
    drop_table :teams
    drop_table :contests
  end
end
