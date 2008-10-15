class ReportsController < ApplicationController
  make_resourceful do
    belongs_to :pledge
    actions :new, :create, :index
    before :all do
      self.current_user = @pledge.user
    end
    before :new do
      if (previous_week? && @pledge.previous_report) || @pledge.current_report
        flash[:notice] = 'You already reported for that week'
        redirect_to pledge_path(@pledge)
      end
      @report.start = previous_week? ? 1.week.ago.utc.beginning_of_week : Time.now.utc.beginning_of_week
    end
    response_for :create_fails do
      if @report.errors.on(:start) # || @report.errors indicates reporting period problem
        flash[:notice] = 'You already reported for that week'
        redirect_to pledge_path(@pledge)
      end
    end
    response_for :create do
      flash[:notice] = "Thanks for pitching in"
      redirect_to pledge_path( @pledge )
    end
  end

  protected

  def previous_week?
    params[:week] == "previous"
  end

  def parent_object
    Pledge.find_by_report_code params[:pledge_id]
  end
end
