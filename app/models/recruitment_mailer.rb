class RecruitmentMailer < ActionMailer::Base
  def tell_a_friend(options)
    subject       "Your friend wants you to Go Green!"
    recipients    options[:recipients]
    body          :text => options[:body],
                    :contest => options[:contest]
  end
end
