module ParticipantsHelper
  def team_options
    [["Blue Team", 0], ["Red Team", 1]]
  end
  def car_type_options 
    [["Small", 0], ["Truck/SUV", 1]]
  end

  def pledge_options
    (0..5).to_a
  end
end
