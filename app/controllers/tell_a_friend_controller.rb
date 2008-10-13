class TellAFriendController < ApplicationController
  def create
    @contest = Contest.find(params[:contest_id]) if params[:contest_id]
    @contest ||= Contest.find(:first)

    RecruitmentMailer.deliver_tell_a_friend(params.merge(:contest => @contest, :host => request.host))
#    redirect_to teams_path
  end
end
