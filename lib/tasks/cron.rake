desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  if Time.now.hour == 12 # run at midnight
    #User.send_reminders
    puts "should be running assignment reminds for today"
  end
end

