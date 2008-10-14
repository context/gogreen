class Report < ActiveRecord::Base
  belongs_to :pledge
  has_many :report_actions
  validates_uniqueness_of :start, :scope => :pledge_id
  
  def actions_data=(values)
    values.map do |day_index, action_data|
      if action = report_actions.find_by_action_date( action_data[:action_date] )
        action.attributes = action_data
        action
      else
        report_actions.build action_data
      end
    end
  end
  def actions_data
    report_actions.all :order => 'action_date ASC'
  end
end
