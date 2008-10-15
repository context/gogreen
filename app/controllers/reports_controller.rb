class ReportsController < ApplicationController
  make_resourceful do
    belongs_to :pledge
    actions :new, :create, :index, :edit, :update
    before :all do
      self.current_user = @pledge.user
    end
    before :new do
      @report.start = Time.now.beginning_of_week
      if @pledge.current_report
        redirect_to edit_pledge_report_path(@pledge, @pledge.current_report)
      end
    end
    before :edit do
      @pledge ||= @report.pledge
    end
    response_for :create do
      flash[:notice] = "Thanks for pitching in"
      redirect_to edit_pledge_report_path( @pledge, @report )
    end
    response_for :update do
      flash[:notice] = "Your report was updated"
      redirect_to edit_pledge_report_path( @pledge, @report )
    end
    response_for :update_failed do
      @report.report_actions.each do |report_action|
        report_action.errors.each { | attr, msg | @report.errors.add_to_base( msg ) }
      end
      render :action => 'edit'
    end
  end

  def parent_object
    Pledge.find_by_report_code params[:pledge_id]
  end
end
