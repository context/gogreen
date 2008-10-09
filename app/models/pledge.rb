class Pledge < ActiveRecord::Base
  attr_accessor :first_name, :last_name, :email, :password, :password_confirmation
  #               :team_id, :car_type, :distance_to_destination,
  #              :walk_bike, :public_transit, :carpool, :graduation_year, :car_year, :carpool_participants, 
  #belongs_to :user
  belongs_to :team
  has_many :reports
end
