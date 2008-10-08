class TeamsController < ApplicationController
  def index
    @teams = [Team.new(:name => '9th graders', :score => 900),
              Team.new(:name => '10th graders', :score => 850)]
  end
end
