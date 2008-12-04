require 'rake/testtask'
require 'rake/rdoctask'
require 'tasks/rails'
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
namespace :gogreen do
  task :send_reminders do
    ReportReminderMailer.default_url_options[:host] = 'gogreenfoundation.com'
    pledges_chunk = Pledge.remindable.active.all :limit => 100
    pledges_chunk.each do | pledge | 
      pledge.update_attribute( :last_reminded_at, Time.now ) if ReportReminderMailer.deliver_reminder pledge
    end

  end
end
