class Report < ActiveRecord::Base
  belongs_to :pledge
  has_many :report_actions, :order => 'position ASC'
  validates_uniqueness_of :start, :scope => :pledge_id
  
  named_scope :valid, :include => { :pledge => :user }, :conditions => Pledge.enabled.proxy_options[:conditions] || {}
  before_validation :normalize_start
  def normalize_start
    self.start = start.utc.beginning_of_week
  end

  validate_on_create :timeliness_of_report
  def timeliness_of_report
    if self.start < GoGreen::Config.reporting_period.days.ago
      errors.add_to_base "It is too late to report for that week"
    end
  end
  
  def actions_data=(values)
    values.map do |day_index, action_data|
      if action = report_actions[ day_index.to_i ]
        action.attributes = action_data
      else
        action = report_actions.build action_data.merge(:position => day_index)
      end
    end
  end

  def actions_data
    report_actions
  end

  before_validation :set_action_date
  def set_action_date
    report_actions.each {|r| r.action_date = start + r.position.days}
  end

  before_save :save_actions, :store_impact
  def save_actions
    report_actions.each {|a| a.save! if a.changed?}
  end
  def store_impact
    self.impact = impact
  end

  def tally_actions
    report_actions.count :group => :mode_of_transport
  end

  def impact
    stored_impact = read_attribute(:impact)
    return stored_impact if stored_impact && stored_impact > 0 && report_actions.all? { |ra| !ra.changed? }
    pledge.calculate_impact( tally_actions ) if pledge
  end
end
