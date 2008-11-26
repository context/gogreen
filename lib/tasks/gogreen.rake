require 'rake/testtask'
require 'rake/rdoctask'
require 'tasks/rails'
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
namespace :gogreen do
  task :send_reminders do
    ReportReminderMailer.default_url_options[:host] = 'gogreenfoundation.com'
    Contest.active.each do |contest|
      contest.teams.each do |team|
        team.pledges.each do |pledge|
          ReportReminderMailer.deliver_reminder pledge
        end
      end
    end
  end
end
