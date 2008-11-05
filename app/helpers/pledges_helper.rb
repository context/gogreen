module PledgesHelper
  def team_options(contest)
    contest.teams.map {|team| [team.name, team.id]}
  end

  def car_type_options 
    [ ['Not sure', 'not_sure'], ["Small (2-door)", 'small'], ["Medium (4-door)", 'med'], ["Large (wagon/minivan)", 'large'], ["Pickup/SUV", 'truck' ]]
  end

  def pledge_options
    (0...5).to_a
  end

  def action_options
    [ [ "None of these ( holiday, sick day, etc )", 'none' ],
      [ "I drove/was driven", 'driving' ]]  + Pledge::COMMITMENTS
  end

  def contest_options
    Contest.all.map { |c| [ c.name, c.id ] }
  end
end
