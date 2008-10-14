class ReportsController < ApplicationController
  make_resourceful do
    belongs_to :pledge
    actions :new, :create
    before :new, :create do
      @pledge = Pledge.find_by_report_code params[:report_code]
      @report = @pledge.reports.build
    end
  end

  def index
    @pledge = Pledge.find_by_report_code params[:report_code]
    @weekly_reports = Report.weekly
  end

  def create
    before :create
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
  
  def distill_errors_to_singular( invalid_items, result_item )
    result_item.recipients = invalid_items.map { |m| m.recipients }.join(', ')
    invalid_recipients = []
    invalid_items.each do |invalid_item|
      invalid_item.errors.each do |attr, msg| 
        ( invalid_recipients << invalid_item.recipients ) and next if attr.to_sym == :recipient_id
        result_item.errors.add attr, msg
      end
    end
    result_item.errors.add( :recipients, "couldn't send to: " + invalid_recipients.join(', ') ) unless invalid_recipients.empty?
    result_item
  end
end
