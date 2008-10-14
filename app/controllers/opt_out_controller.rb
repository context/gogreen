class OptOutController < ApplicationController
  def create
    user = User.find_by_opt_out_code(params[:code])
    user.update_attribute(:receive_email, false)
  end
end
