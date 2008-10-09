class Team < ActiveRecord::Base
  belongs_to :contest
  has_many :pledges
  has_many :reports, :through => :pledges

  def score
    reports.sum :score
  end
end
