# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  include HoptoadNotifier::Catcher

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '4598f42653c4d6856e6a5f4d00f15081'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  before_filter :set_contest, :set_mailer_base_url
  protected

  def set_contest
    @contest = Contest.find_by_id(params[:contest_id]) if params[:contest_id]
    #@contest ||= Contest.find(:first)
  end

  def set_mailer_base_url
    ActionMailer::Base.default_url_options[:host] = request.host
  end
end
