class Report < ActiveRecord::Base
  belongs_to :pledge
  has_many :report_actions, :order => 'position ASC'
  validates_uniqueness_of :start, :scope => :pledge_id
  
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

  before_save :save_actions
  def save_actions
    report_actions.each {|a| a.save! if a.changed?}
  end
end
