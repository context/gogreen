class PledgesController < ApplicationController
  make_resourceful do
    actions :new, :create
    before :create do 
      if @pledge.valid? and !@pledge.pledge_details_confirmed
        @pledge.awaiting_confirmation = true
        render 'new'
      end
    end
    response_for :create do 
      self.current_user = @pledge.user
      flash[:notice] = "Thanks for pledging"
      redirect_to team_path( @pledge.team )
    end
    belongs_to :team

  end
end
