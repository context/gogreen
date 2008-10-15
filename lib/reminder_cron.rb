class ReminderCron
  def self.send_reminders
    Contest.active.find(:all, :include => {:pledges => :user}).each do |c|
      c.pledges.each do |p|
        unless p.user.receive_email == false
          ReportReminderMailer.deliver_reminder(p)
        end
      end
    end
  end
end
