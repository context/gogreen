class TeamsController < ApplicationController
  make_resourceful do
    actions :show
    before :show do
      @contest = @team.contest
    end
  end
  def current_object
    current_model.find(params[:id], :include => {:pledges => {:reports => :report_actions}})
  end
end
