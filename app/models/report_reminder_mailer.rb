class ReportReminderMailer < ActionMailer::Base

  def reminder( pledge )
    setup_email(pledge.user)
    @recipients       = pledge.user.email
    @subject          = "Go Green - Time to report on your pledge"
    @body[:recipient] = pledge.user.first_name
    @body[:message]   = pledge.contest.email_text
    @body[:weeks_remaining]   = (( pledge.contest.end - Time.now ) / 1.week ).to_i
    @body[:report_url] = new_report_url( :report_code => pledge.report_code )
    @body[:opt_out_url] = opt_out_url
  end

  protected
    def setup_email(pledge)
      @from         = GoGreen::Config.email_sender
      @sent_on      = Time.now
    end
end

