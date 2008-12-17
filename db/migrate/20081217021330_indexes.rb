class Indexes < ActiveRecord::Migration
  def self.up
    add_index :report_actions, :position, :name => 'index_on_position'
    add_index :report_actions, :report_id, :name => 'index_on_report_id'
    add_index :pledges, :team_id, :name => 'index_on_team_id'
    add_index :pledges, :user_id, :name => 'index_on_user_id'
    add_index :teams, :contest_id, :name => 'index_on_contest_id'
    add_index :reports, :pledge_id, :name => 'index_on_pledge_id'
    add_index :contests, :start, :name => 'index_on_start'
  end

  def self.down
    remove_index :contests, :name => 'index_on_start'
    remove_index :reports, :name => 'index_on_pledge_id'
    remove_index :teams, :name => 'index_on_contest_id'
    remove_index :pledges, :name => 'index_on_user_id'
    remove_index :pledges, :name => 'index_on_team_id'
    remove_index :report_actions, :name => 'index_on_report_id'
    remove_index :report_actions, :name => 'index_on_position'
  end
end
