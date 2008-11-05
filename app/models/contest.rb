class Contest < ActiveRecord::Base
  has_many :teams
  has_many :pledges, :through => :teams
  validates_presence_of :start
  validates_presence_of :end

  named_scope :active, :conditions => ["start < ? AND end > ?", Time.now, 1.week.ago]

  def total_impact
    teams.inject(0) { |total, team| total += team.total_impact }
  end

  def impact_for_week_starting(week_start)
    teams.inject(0) { |total, team| total += team.impact_for_week_starting( week_start ) }
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

end
