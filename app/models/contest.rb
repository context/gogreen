class Contest < ActiveRecord::Base
  has_many :teams
  MPG_CARS = Hash[ *(1978...Time.now.year).to_a.map { |a| [ a, 25 ] }]
  MPG_SUVS = Hash[ *(1978...Time.now.year).to_a.map { |a| [ a, 15 ] }]
end
