class PledgesController < ApplicationController
  def new
    @pledge = Pledge.new
  end

  def create
    @pledge = Pledge.create(params[:pledge])
    if @pledge.valid?
      self.current_user = @pledge.user
    else
      render :action => 'new'
    end
  end

end
