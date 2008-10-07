class Admin::ParticipantsController < ApplicationController
  def index
    @participants = [ 'Martin', 'Catalina', 'Trevor' ]
  end
end
