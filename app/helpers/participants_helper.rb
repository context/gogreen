module ParticipantsHelper
  def team_options
    [["Mcallister Academy", 0], ["Red Team", 1]]
  end
  def car_type_options 
    [ ['Not sure', ''], ["Small", 'small'], ["Truck/SUV", 'truck' ]]
  end
  def car_year_options 
    [ [ 'Not sure', '' ], *(1970...Time.now.year).to_a  ]
  end

  def graduation_year_options
    (Time.now.year...7.years.from_now.year).to_a
  end
  def pledge_options
    (0...5).to_a
  end
end
