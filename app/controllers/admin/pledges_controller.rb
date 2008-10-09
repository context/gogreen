class Admin::PledgesController < ApplicationController
  def index
    @pledges = [ 'Martin', 'Catalina', 'Trevor' ]
  end
end
