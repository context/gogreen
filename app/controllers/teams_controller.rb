class TeamsController < ApplicationController
  def index
    @teams = [Team.new(:name => '9th graders'),
              Team.new(:name => '10th graders')]
  end
end
