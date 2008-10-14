class Report < ActiveRecord::Base
  #attr_accessor :monday, :tuesday, :wednesday, :thursday, :friday
  belongs_to :pledge
  validate :within_reporting_period
  validates_presence_of :action_date
  validates_uniqueness_of :action_date, :scope => :pledge_id

  def self.create_from_weekly_data( weekly_data, pledge )
    weekly_data.map do |day_index, day_data|
      pledge.reports.create day_data
    end
  end
  
  def within_reporting_period
    if action_date < ( Time.now - GoGreen::Config.reporting_period.days )
      self.errors.add :action_date, "is past the reporting deadline" if self.new_record? or self.changed?
    end
  end
end
