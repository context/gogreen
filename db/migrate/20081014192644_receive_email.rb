class ReceiveEmail < ActiveRecord::Migration
  def self.up
    add_column :users, :receive_email, :boolean
    add_column :users, :opt_out_code, :string
    User.all.each {|u| u.create_opt_out_code; u.save}
  end

  def self.down
    remove_column :users, :opt_out_code
    remove_column :users, :receive_email
  end
end
