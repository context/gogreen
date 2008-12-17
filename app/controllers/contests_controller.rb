class ContestsController < ApplicationController
  make_resourceful do
    actions :show
  end
  def index
    flash.keep
    unless Contest.active.empty?
      redirect_to contest_path( Contest.active.first )
    else
      redirect_to contest_path( Contest.first )
    end
  end
  def current_object
    current_model.find(params[:id], :include => {:teams => {:pledges => {:reports => :report_actions}}})
  end
end
