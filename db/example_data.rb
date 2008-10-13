module FixtureReplacement
  attributes_for :contest do |a|
    
	end

  attributes_for :team do |a|
    
	end

  attributes_for :pledge do |a|
    a.team = default_team
    a.user = default_user
    a.walk_bike = 0
    a.public_transit = 0
    a.carpool = 0
    a.distance_to_destination = 50
	end

  attributes_for :report do |a|
    
	end

  attributes_for :user do |a|
    a.password = 'password'
    a.password_confirmation = 'password'
    a.email = "#{String.random}@example.com"
	end

end
