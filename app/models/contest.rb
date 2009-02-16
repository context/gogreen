class Contest < ActiveRecord::Base
  has_many :teams
  has_many :pledges, :through => :teams
  has_many :reports, :through => :pledges
  validates_presence_of :start
  validates_presence_of :end
  has_image :resize_to => nil, :output_quality => 100, :convert_to => nil

  named_scope :active, :conditions => ["start < ? AND end > ?", Time.now, 1.week.ago]

  def total_impact
    reports.valid.sum( :impact ).to_f.round_to(1)
  end
  
  def impacts_by_week_and_team
    { :weeks => week_impacts,
      :teams => team_impacts }
  end
 
  def impact_for_week_starting(week_start)
    reports.valid.sum( :impact, :conditions => [ 'start = ?', week_start ] ).to_f.round_to(1)
=begin
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
=end
  end

  def weekly_commitment_impact
    teams.inject(0) { |total, team| total += team.weekly_commitment_impact }
  end

  def length_in_weeks
    (( self.end - start ) / 1.week ).to_i
  end

  def weeks
    ( 0...length_in_weeks ).to_a.map { |week_index| ( start + week_index.weeks ).beginning_of_week.utc }
  end

  def started_this_week?
    self.start >= ( Time.now.beginning_of_week - 2.days )
  end

  def ended_last_week?
    self.end <= Time.now.beginning_of_week
  end

  def week_impacts
    week_totals = round_values( reports.valid.sum(:impact, :group => 'reports.start' ), 1 )
    round_values( Hash[ *weeks.map { |w| [ w, 0.0] }.flatten ].merge( week_totals ))
  end

  def team_impacts
    round_values reports.valid.sum(:impact, :group => 'teams.id' )
  end
  def round_values( hash_of_floats, decimal_points = 1 )
    Hash[ *hash_of_floats.map { |key, value| [ key, value.to_f.round_to(decimal_points) ] }.flatten ]
  end
end
