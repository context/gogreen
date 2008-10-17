class AdminController < ApplicationController
  before_filter :login_required

  protected
  def authorized?
    logged_in? && current_user.superuser?
  end

  def access_denied
    flash[:error] = 'You do not have sufficient permission to perform that action'
    redirect_to root_url
  end
end
