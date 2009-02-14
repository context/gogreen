class ReportImpacts < ActiveRecord::Migration
  def self.up
    add_column :reports, :impact, :float
    Report.all.each { |r| r.save }
  end

  def self.down
    remove_column :reports, :impact
  end
end
