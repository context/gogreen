class ReportAction < ActiveRecord::Base
  #attr_accessor :monday, :tuesday, :wednesday, :thursday, :friday
  belongs_to :report
  validate :within_reporting_period
  validates_presence_of :action_date

  CO2_IMPACT = {
    :walk_bike => 0,
    :public_transit => 5,
    :carpool => 20
  }

  def within_reporting_period
    if action_date < ( Time.now - GoGreen::Config.reporting_period.days )
      self.errors.add :action_date, "is past the reporting deadline" if self.new_record? or self.changed?
    end
  end
end
