class ContestAttributes < ActiveRecord::Migration
  def self.up
    add_column :contests, :permalink, :string
    add_column :contests, :start, :datetime
    add_column :contests, :end, :datetime
    add_column :contests, :distance_question_text, :string
    add_column :contests, :email_text, :text
    add_column :contests, :intro_text, :text
    add_column :contests, :tell_a_friend_default, :text
  end

  def self.down
    remove_column :contests, :tell_a_friend_default
    remove_column :contests, :intro_text
    remove_column :contests, :email_text
    remove_column :contests, :distance_question_text
    remove_column :contests, :end
    remove_column :contests, :start
    remove_column :contests, :permalink
  end
end
