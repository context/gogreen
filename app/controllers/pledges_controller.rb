class PledgesController < ApplicationController
  def new
    @pledge = Pledge.new
  end

  def create
    render :action => 'thank_you'
  end
end
