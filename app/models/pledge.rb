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

  def validate_mode_total
    if (walk_bike + public_transit + carpool > 5)
      self.errors.add_to_base("Sum of walk/bike, public transit, and carpool cannot be greater than 5 days.")
    end
  end

  def user_attributes=(attributes)
    build_user(attributes)
  end

end
