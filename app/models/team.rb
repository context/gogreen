class Team < ActiveRecord::Base
  belongs_to :contest
  has_many :pledges
  has_many :reports, :through => :pledges

  def score
    pledges.inject(0) do |score, pledge|
      score += pledge.total_impact
    end
  end
end
