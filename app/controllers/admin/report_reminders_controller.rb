class Admin::ReportRemindersController < AdminController
  def create
    @pledge = Pledge.find_by_report_code params[:pledge_id] 
    ReportReminderMailer.deliver_reminder( @pledge )
    flash[:notice] = "Report link sent"
    redirect_to admin_pledges_path and return
  end
end
