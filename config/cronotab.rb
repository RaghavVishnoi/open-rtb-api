# cronotab.rb — Crono configuration file
#
# Here you can specify periodic jobs and schedule.
# You can use ActiveJob's jobs from `app/jobs/`
# You can use any class. The only requirement is that
# class should have a method `perform` without arguments.
#
require 'rake'
Rails.app_class.load_tasks

class SendEmail
  def perform
    Rake::Task['user:send_email'].execute
  end
end

Crono.perform(SendEmail).with_options(truncate_log: 5).every 5.seconds






