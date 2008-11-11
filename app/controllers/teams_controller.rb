class TeamsController < ApplicationController
  make_resourceful do
    actions :show
    before :show do
      @contest = @team.contest
    end
  end
end
