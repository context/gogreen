class ReminderEmailsController < ApplicationController
  def show
    @message = @contest.email_text
    @report_url = new_pledge_report_url( Pledge.first )
    @opt_out_url = opt_out_url(Pledge.first.user.opt_out_code)
    render :template => 'report_reminder_mailer/reminder.text.html.haml'
  end
end
