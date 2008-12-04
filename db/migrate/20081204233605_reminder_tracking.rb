class ReminderTracking < ActiveRecord::Migration
  def self.up
    add_column 'pledges', 'last_reminded_at', :datetime
  end

  def self.down
    remove_column 'pledges', 'last_reminded_at'
  end
end
