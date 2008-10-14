module PledgesHelper
  def team_options(contest)
    contest.teams.map {|team| [team.name, team.id]}
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
  def action_options
    [ [ "None of these ( holiday, sick day, etc )", 'none' ],
      [ "I drove/was driven", 'driving' ],
      [ "Walking/Biking", 'walk_bike' ],
      [ "Public Transit", 'transit' ],
      [ "Carpooling", 'carpool' ]
    ]
  end
end
