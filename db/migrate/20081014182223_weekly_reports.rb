class WeeklyReports < ActiveRecord::Migration
  def self.up
    rename_table 'reports', 'report_actions'
    create_table 'reports' do |t|
      t.datetime 'start'
      t.integer 'pledge_id'
      t.string 'report_code', :size => 20
      t.timestamps
    end
    add_column 'report_actions', 'report_id', :integer
    remove_column 'report_actions', 'pledge_id'
  end

  def self.down
    add_column 'report_actions', 'pledge_id'
    remove_column 'report_actions', 'report_id'
    drop_table 'reports'
    rename_table 'report_actions', 'reports'
  end
end
