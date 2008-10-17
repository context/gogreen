class RecruitmentMailer < ActionMailer::Base
  def tell_a_friend(options)
    from          GoGreen::Config.email_sender
    subject       "#{options[:user].first_name} wants you to Go Green!"
    recipients    options[:recipients]
    body          :text => options[:body],
                  :contest => options[:contest]
  end
end
