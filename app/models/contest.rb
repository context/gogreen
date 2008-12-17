class Contest < ActiveRecord::Base
  has_many :teams
  has_many :pledges, :through => :teams
  validates_presence_of :start
  validates_presence_of :end
  has_image :resize_to => nil, :output_quality => 100, :convert_to => nil

  named_scope :active, :conditions => ["start < ? AND end > ?", Time.now, 1.week.ago]

  def total_impact
    teams.inject(0) { |total, team| total += team.total_impact }
  end

  def impact_for_week_starting(week_start)
    pledges = teams.collect {|team| team.pledges}.flatten.compact
    pledges.inject(0) do |total, pledge| 
      if report = pledge.reports.detect {|r| r.start == week_start }
        total += pledge.calculate_impact(report.report_actions.inject({}) do |grouped, action| 
          grouped[action.mode_of_transport] ||= 0
          grouped[action.mode_of_transport] += 1
          grouped 
          end.to_a) 
      end
      total
    end
#    teams.inject(0) { |total, team| total += team.impact_for_week_starting( week_start ) }
  end

  def weekly_commitment_impact
    teams.inject(0) { |total, team| total += team.weekly_commitment_impact }
  end

  def length_in_weeks
    (( self.end - start ) / 1.week ).to_i
  end

  def weeks
    ( 0...length_in_weeks ).to_a.map { |week_index| ( start + week_index.weeks ).beginning_of_week }
  end

  def started_this_week?
    self.start >= ( Time.now.beginning_of_week - 2.days )
  end

  def ended_last_week?
    self.end <= Time.now.beginning_of_week
  end

  def week_impacts
    Hash[ *weeks.map { |week_start| [ week_start, ( impact_for_week_starting(week_start) || 0.0 ).to_f.round_to(1) ] }.flatten ]
  end
end
