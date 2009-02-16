class Team < ActiveRecord::Base
  belongs_to :contest
  has_many :pledges
  has_many :reports, :through => :pledges

  def total_impact
    reports.valid.sum( :impact ).to_f.round_to(1)
=begin
    pledges.enabled.with_reports.inject(0) do |pledge_total, p| 
      pledge_total + p.reports.inject(0) do |report_total, r|
        report_total + p.calculate_impact(r.report_actions.inject({}) do |grouped, action| 
          grouped[action.mode_of_transport] ||= 0
          grouped[action.mode_of_transport] += 1
          grouped 
          end.to_a) 
      end
    end
=end
  end

  def week_impacts
    return round_values( reports.valid.sum(:impact, :group => 'start' ) )
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
    pledges.inject(0) { |total, pledge| total += pledge.weekly_commitment_impact }
  end

  def round_values( hash_of_floats, decimal_points = 1 )
    Hash[ *hash_of_floats.map { |key, value| [ key, value.to_f.round_to(decimal_points) ] }.flatten ]
  end

end
