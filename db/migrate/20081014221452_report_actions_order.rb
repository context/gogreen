class ReportActionsOrder < ActiveRecord::Migration
  def self.up
    add_column :report_actions, :position, :integer
  end

  def self.down
    remove_column :report_actions, :position
  end
end
