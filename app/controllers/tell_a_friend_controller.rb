class TellAFriendController < ApplicationController
  def create
    RecruitmentMailer.deliver_tell_a_friend(params.merge(:contest => @contest, :host => request.host))
#    redirect_to teams_path
  end
end
