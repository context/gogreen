class ReportKey < ActiveRecord::Migration
  def self.up
    add_column 'pledges', 'report_code', :string, :size => 40
  end

  def self.down
    remove_column 'pledges', 'report_code'
  end
end
