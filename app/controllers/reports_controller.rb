class ReportsController < ApplicationController
  before_filter :login_required
  make_resourceful do
    belongs_to :pledge
    actions :new, :create, :index
    before :all do
      self.current_user = @pledge.user
    end
    before :new do
      if (previous_week? && @pledge.previous_report) || (!previous_week? && @pledge.current_report)
        flash[:notice] = 'You already reported for that week'
        redirect_to team_path(@pledge.team )
      end
      @report.start = previous_week? ? 1.week.ago.utc.beginning_of_week : Time.now.utc.beginning_of_week
    end
    response_for :create_fails do
      if @report.errors.on(:start) # || @report.errors indicates reporting period problem
        flash[:notice] = 'You already reported for that week'
      elsif @report.report_actions.any? {|action| !action.errors.empty?}
        flash[:notice] = 'You can only report on actions taken this or last week'
      end
      redirect_to team_path( @pledge.team )
    end
    response_for :create do
      flash[:notice] = "Thanks for pitching in"
      redirect_to contest_team_path( @pledge.team.contest, @pledge.team )
    end
  end

  protected

  helper_method :previous_week?

  def previous_week?
    params[:week] == "previous"
  end

  def parent_object
    Pledge.find_by_report_code params[:pledge_id]
  end
end
