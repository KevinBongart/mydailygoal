desc "This task is called by the Heroku scheduler add-on"
task send_daily_emails: :environment do
  Goal.includes(:user).find_each do |goal|
    UserMailer.daily_email(goal)
  end
end
