class ParticipantsController < ApplicationController
  def new
    @participant = Participant.new
  end

  def create
    render :action => 'thank_you'
  end
end
