class CarpoolData < ActiveRecord::Migration
  def self.up
    add_column :pledges, :carpool_car_type, :string
    add_column :pledges, :carpool_distance, :float
    change_column :pledges, :distance_to_destination, :float
  end

  def self.down
    change_column :pledges, :distance_to_destination, :integer
    remove_column :pledges, :carpool_distance
    remove_column :pledges, :carpool_car_type
  end
end
