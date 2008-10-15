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

  before_create :generate_report_code

  BASELINE_IMPACT_PER_MILE = 20.0
  COMMITMENTS = [
      [ "Walking/Biking", 'walk_bike' ],
      [ "Public Transit", 'public_transit' ],
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
    @current ||= reports.find_by_start(Time.now.beginning_of_week)
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

  def calculate_impact( action_totals )
    action_totals.inject( 0.0 ) do | total, ( mode_of_transport, qty )|
      if mode_of_transport && mode_of_transport == 'carpool'
        total += (( BASELINE_IMPACT_PER_MILE - ( ReportAction::CO2_IMPACT[ mode_of_transport.to_sym ] / ( ( carpool_participants > 0 && carpool_participants ) || 1 ) ) ) * distance_to_destination ) * qty
      elsif mode_of_transport && ReportAction::CO2_IMPACT[ mode_of_transport.to_sym ]
        total += (( BASELINE_IMPACT_PER_MILE - ReportAction::CO2_IMPACT[ mode_of_transport.to_sym ] ) * distance_to_destination ) * qty
      end
      total
    end
  end

  def impact_for_week_starting( week_start )
    impact_from_actions report_actions.week_starting( week_start )
  end

  def weekly_commitment_impact
    calculate_impact commitments
  end

end
