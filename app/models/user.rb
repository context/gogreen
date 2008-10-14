require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  #validates_presence_of     :login
  #validates_length_of       :login,    :within => 3..40
  #validates_uniqueness_of   :login
  #validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  before_create :create_opt_out_code
  def create_opt_out_code
    self.opt_out_code = ( ("%04x"*2 ) % ([nil]*2).map { rand(2**16) }).upcase 
  end
  
  has_many :pledges
  has_many :teams, :through => :pledges

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :first_name, :last_name



  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

=begin
  def login
    email
  end

  def login=(value)
    self.email = value
    #write_attribute :login, (value ? value.downcase : nil)
  end
=end

  def email
    read_attribute :email
  end
  def email=(value)
    write_attribute :login, (value ? value.downcase : nil)
    write_attribute :email, (value ? value.downcase : nil)
  end
  alias :login  :email
  alias :login= :email=


  protected
    


end
