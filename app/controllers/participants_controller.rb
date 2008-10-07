class ParticipantsController < ApplicationController
  def new
    @participant = Participant.new
  end
end
