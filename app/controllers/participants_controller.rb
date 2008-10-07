class ParticipantsController < ApplicationController
  def new
    @participant = Participant.new
  end

  def show
    render :action => 'thank_you'
  end
end
