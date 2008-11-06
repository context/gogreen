class Pledge < ActiveRecord::Base
  attr_accessor :first_name, :last_name, :email, :password, :password_confirmation
  #               :team_id, :car_type, :distance_to_destination,
  #              :walk_bike, :public_transit, :carpool, :graduation_year, :car_year, :carpool_participants, 
  belongs_to :user
  belongs_to :team
  has_many :reports
  has_many :report_actions, :through => :reports
  validates_inclusion_of :walk_bike, :in => 0..5
  validates_inclusion_of :public_transit, :in => 0..5
  validates_inclusion_of :carpool, :in => 0..5
  validates_associated :user
  validate :validate_mode_total
  validates_uniqueness_of :user_id, :scope => :team_id
  validates_presence_of :distance_to_destination
  validates_numericality_of :distance_to_destination
  validates_presence_of :team_id

  named_scope :active, :include => :team, :conditions => ["teams.contest_id IN (?)", Contest.active.map {|c| c.id}]

  before_create :generate_report_code

  BASELINE_IMPACT_PER_GALLON = 25.3371
  MPG = HashWithIndifferentAccess.new(
    :hybrid => 40,
    :small  => 29,
    :med    => 26,
    :not_sure => 26,
    :large  => 20,
    :truck  => 17  )

  validates_inclusion_of :car_type, :in => MPG.keys

  def destination_round_trip
    distance_to_destination * 2
  end

  def carpool_round_trip
    carpool_distance * 2
  end

  def impact_per_mile
    BASELINE_IMPACT_PER_GALLON * MPG[car_type]
  end
  COMMITMENTS = [
      [ "Walking/Biking", 'walk_bike' ],
      [ "Taking the bus", 'public_transit' ],
      [ "Carpooling", 'carpool' ]
    ]

  def validate_mode_total
    if (walk_bike + public_transit + carpool > 5)
      self.errors.add_to_base("Sum of walk/bike, public transit, and carpool cannot be greater than 5 days.")
    end
  end

  def user_attributes=(attributes)
    build_user(attributes)
  end

  def generate_report_code
    self.report_code = ( ("%04x"*2 ) % ([nil]*2).map { rand(2**16) }).upcase 
  end

  def current_report
    @current ||= reports.find_by_start(Time.now.utc.beginning_of_week)
  end

  def previous_report
    @previous ||= reports.find_by_start(Time.now.utc.beginning_of_week - 1.week)
  end

  def contest
    team && team.contest || Contest.first
  end

  def to_param
    report_code
  end

  def commitments
    Hash[ *COMMITMENTS.map { |(text, attr)| [ attr, send( attr ) ] if send( attr ) > 0 }.compact.flatten ]
  end


  def total_impact
    impact_from_actions report_actions
  end

  def impact_from_actions(report_scope)
    calculate_impact report_scope.count( :group => 'mode_of_transport' )
  end

  def pounds_used_by_carpool
    carpool_round_trip / MPG[carpool_car_type] * BASELINE_IMPACT_PER_GALLON / carpool_participants
  end

  def carpool_participants
    carpool_additional_passengers + 1
  end

  def pounds_used_by_bus
    destination_round_trip * 0.25
  end
  alias :pounds_used_by_public_transit :pounds_used_by_bus

  def pounds_used_by_walk_bike
    0
  end

  def pounds_used_by_none
    0
  end

  def pounds_used_by_driving
    return 0 if car_type.blank?
    ( destination_round_trip || 0 ) / MPG[car_type] * BASELINE_IMPACT_PER_GALLON
  end

  def calculate_impact( action_totals )
    action_totals.inject( 0.0 ) do | total, ( mode_of_transport, qty )|
      total + ( pounds_used_by_driving - send( "pounds_used_by_#{mode_of_transport}" )) * qty
    end
  end

  def impact_for_week_starting( week_start )
    impact_from_actions report_actions.week_starting( week_start )
  end

  def weekly_commitment_impact
    calculate_impact commitments
  end

  CSV_HEADERS = [
    "First Name", "Last Name", "Email", 
    "Team Name", "Contest", "Reports Received", "Total Impact",
    "Days Walk/Bike", "Public Transit Days", "Carpool Days", 
    "Carpool Size", "Car Type", "Daily Distance"
  ]

  def to_csv
    [ user.first_name, user.last_name, user.email,
    team.name, team.contest.name, reports.size, total_impact,
    walk_bike, public_transit, carpool,
    carpool_participants, car_type, distance_to_destination ]
  end

  def contest
    team.contest
  end
end
