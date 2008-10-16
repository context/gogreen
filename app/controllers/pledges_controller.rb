class PledgesController < ApplicationController
  make_resourceful do
    actions :new, :create
    response_for :create do 
      self.current_user = @pledge.user
      flash[:notice] = "Thanks for pledging"
      redirect_to team_path( @pledge.team )
    end
  end
end
