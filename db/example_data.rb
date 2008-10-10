module FixtureReplacement
  attributes_for :contest do |a|
    
	end

  attributes_for :team do |a|
    
	end

  attributes_for :pledge do |a|
    a.user = default_user
    
	end

  attributes_for :report do |a|
    
	end

  attributes_for :user do |a|
    a.password = 'password'
    a.password_confirmation = 'password'
    a.email = "#{String.random}@example.com"
	end

end
