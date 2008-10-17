class TellAFriendController < ApplicationController
  def create
    RecruitmentMailer.deliver_tell_a_friend(params.merge(:contest => @contest, :user => current_user))
    flash[:notice] = "Message was sent"
    redirect_to contest_path(@contest)
  end
end
