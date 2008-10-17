class ContestsController < ApplicationController
  make_resourceful do
    actions :show
  end
  def index
    redirect_to contest_path( Contest.first )
  end
end
