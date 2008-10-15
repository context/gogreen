class Pledge < ActiveRecord::Base
  attr_accessor :first_name, :last_name, :email, :password, :password_confirmation
  #               :team_id, :car_type, :distance_to_destination,
  #              :walk_bike, :public_transit, :carpool, :graduation_year, :car_year, :carpool_participants, 
  belongs_to :user
  belongs_to :team
  has_many :reports
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

  def contest
    team && team.contest || Contest.first
  end

  def to_param
    report_code
  end
end
