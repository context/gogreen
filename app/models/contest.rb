class Contest < ActiveRecord::Base
  has_many :teams
  has_many :pledges, :through => :teams
  validates_presence_of :start
  validates_presence_of :end
  has_image :resize_to => nil, :output_quality => 100, :convert_to => nil

  named_scope :active, :conditions => ["start < ? AND end > ?", Time.now, 1.week.ago]

  def total_impact
    #teams.inject(0) { |total, team| total += team.total_impact }
    #pledges = teams.collect {|team| team.pledges.enabled }.flatten
    pledges.enabled.with_reports.inject(0) do |pledge_total, p| 
      pledge_total + p.reports.inject(0) do |report_total, r|
        report_total + p.calculate_impact(r.report_actions.inject({}) do |grouped, action| 
          grouped[action.mode_of_transport] ||= 0
          grouped[action.mode_of_transport] += 1
          grouped 
          end.to_a) 
      end
    end
  end
  
  def impacts_by_week_and_team
    week_totals = Hash.new(0)
    team_totals = Hash.new(0)
    pledges.enabled.with_reports.each do |pledge|
      pledge.reports.each do |report|
        report_impact = pledge.calculate_impact( report.tally_actions )
        week_totals[report.start]   += report_impact
        team_totals[pledge.team_id] += report_impact
      end
    end
    { :weeks => Hash[ *week_totals.map { |key, value| [ key, value.to_f.round_to(1) ] }.flatten ],
      :teams => Hash[ *team_totals.map { |key, value| [ key, value.to_f.round_to(1) ] }.flatten ] }
  end
 
  def impact_for_week_starting(week_start)
    pledges.enabled.with_reports.inject(0) do |total, pledge| 
      if report = pledge.reports.detect {|r| r.start == week_start }
        total += pledge.calculate_impact(report.report_actions.inject({}) do |grouped, action| 
          grouped[action.mode_of_transport] ||= 0
          grouped[action.mode_of_transport] += 1
          grouped 
          end.to_a) 
      end
      total
    end
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
