class Team < ActiveRecord::Base
  belongs_to :contest
  has_many :pledges
  has_many :reports, :through => :pledges

  def total_impact
    #pledges.inject(0) { |total, pledge| total += pledge.total_impact }
    pledges.enabled.inject(0) do |pledge_total, p| 
      pledge_total + p.reports.inject(0) do |report_total, r|
        report_total + p.calculate_impact(r.report_actions.inject({}) do |grouped, action| 
          grouped[action.mode_of_transport] ||= 0
          grouped[action.mode_of_transport] += 1
          grouped 
          end.to_a) 
      end
    end
  end

  def impact_for_week_starting(week_start)
    #pledges.inject(0) { |total, pledge| total += pledge.impact_from_actions( pledge.report_actions.week_starting( week_start )) }
    pledges.enabled.inject(0) do |total, pledge| 
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
    pledges.inject(0) { |total, pledge| total += pledge.weekly_commitment_impact }
  end
end
