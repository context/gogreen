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
end
