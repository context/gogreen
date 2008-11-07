class ContestHasImageFile < ActiveRecord::Migration
  def self.up
    add_column :contests, :has_image_file, :string
  end

  def self.down
    remove_column :contest, :has_image_file
  end
end
