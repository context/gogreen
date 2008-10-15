class Contest < ActiveRecord::Base
  MPG_CARS = Hash[ *(1978...Time.now.year).to_a.map { |a| [ a, 25 ] }]
  MPG_SUVS = Hash[ *(1978...Time.now.year).to_a.map { |a| [ a, 15 ] }]

  has_many :teams
  has_many :pledges, :through => :teams

  named_scope :active, :conditions => ["start < :now AND end > :now", {:now => Time.now}]

  def total_impact
    teams.inject(0) { |total, team| total += team.score }
  end
end
