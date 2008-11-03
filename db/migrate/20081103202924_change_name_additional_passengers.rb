class ChangeNameAdditionalPassengers < ActiveRecord::Migration
  def self.up
    rename_column :pledges, :carpool_participants, :carpool_additional_passengers
  end

  def self.down
    rename_column :pledges, :carpool_additional_passengers, :carpool_participants
  end
end
