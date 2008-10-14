class ReportsController < ApplicationController
  make_resourceful do
    actions :new, :create
    belongs_to :pledge
    before :new, :create do
      @pledge = Pledge.find_by_report_code params[:report_code]
    end
  end
  
end
