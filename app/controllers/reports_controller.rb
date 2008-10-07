class ReportsController < ApplicationController
  def new
    @report = Report.new
  end
end
