class PledgesController < ApplicationController
  before_filter :set_contest
  def new
    @pledge = Pledge.new
  end

  def create
    @pledge = Pledge.create(params[:pledge])
    if @pledge.valid?
      self.current_user = @pledge.user
      render :action => 'thank_you'
    else
      render :action => 'new'
    end
  end

  protected

  def set_contest
    @contest ||= Contest.find(:first)
  end
end
