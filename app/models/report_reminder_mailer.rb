class ReportReminderMailer < ActionMailer::Base

  def reminder( pledge )
    setup_email(pledge.user)
    @recipients       = pledge.user.email
    @subject          = "Go Green - Time to report on your pledge"
    @body[:recipient] = pledge.user.first_name
    @body[:message]   = pledge.contest.email_text
    @body[:weeks_remaining]   = (( pledge.contest.end - Time.now ) / 1.week ).to_i
    @body[:report_url] = new_pledge_report_url( pledge )
    @body[:opt_out_url] = opt_out_url(pledge.user.opt_out_code)
  end

  protected
    def setup_email(pledge)
      @from         = GoGreen::Config.email_sender
      @sent_on      = Time.now
    end
end

