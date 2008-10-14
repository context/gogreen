class ReportsController < ApplicationController
  make_resourceful do
    belongs_to :pledge
    actions :new, :create, :index
    before :new do
      @pledge = parent_objects.first
      @report = @pledge.reports.build
    end
  end

  def parent_object
    Pledge.find_by_report_code params[:report_code]
  end

  def parent_name
    @parent_name = :pledge if params[:report_code] && !params[:report_code].blank?
    super
  end


  def create
    load_parent_object
    reports =  Report.create_from_weekly_data params[:report][:weekly_data], @pledge
    if reports.all?(&:valid?)
      flash[:notice] = "Thanks for pitching in"
      redirect_to team_path( @pledge.team )
    else
      reports.each do |rep|
        rep.errors.each { | attr, msg | @report.errors.add( attr, msg ) }
      end
      render :action => 'new'
    end
  end
  
end
