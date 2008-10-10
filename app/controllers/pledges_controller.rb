class PledgesController < ApplicationController
  def new
    @pledge = Pledge.new
  end

  def create
    @pledge = Pledge.create params[:pledge]
    self.current_user = @pledge.user
    render :action => 'thank_you'
  end
end
