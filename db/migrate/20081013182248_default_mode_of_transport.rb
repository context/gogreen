class DefaultModeOfTransport < ActiveRecord::Migration
  def self.up
    change_column_default :pledges, :walk_bike, 0
    change_column_default :pledges, :carpool, 0
    change_column_default :pledges, :public_transit, 0
  end

  def self.down
    change_column_default :pledges, :public_transit
    change_column_default :pledges, :carpool
    change_column_default :pledges, :walk_bike
  end
end
