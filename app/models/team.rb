class Team < ActiveRecord::Base
  belongs_to :contest
  has_many :pledges
  has_many :reports, :through => :pledges

  def total_impact
    pledges.inject(0) { |total, pledge| total += pledge.total_impact }
  end

  def impact_for_week_starting(week_start)
    pledges.inject(0) { |total, pledge| total += pledge.impact_from_actions( pledge.report_actions.week_starting( week_start )) }
  end

  def weekly_commitment_impact
    pledges.inject(0) { |total, pledge| total += pledge.weekly_commitment_impact }
  end
end
