class Participant
  attr_accessor :first_name, :last_name, :email, :team_id, :car_type, :distance_to_destination,
                :walk_bike, :public_transit, :carpool, :graduation_year, :car_year, :carpool_participants, :password, :password_confirmation
  def new_record?
    true
  end
  MPG_CARS = Hash[ *(1978...Time.now.year).to_a.map { |a| [ a, 25 ] }]
  MPG_SUVS = Hash[ *(1978...Time.now.year).to_a.map { |a| [ a, 15 ] }]
end
