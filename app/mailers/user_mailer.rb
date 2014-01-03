class UserMailer < ActionMailer::Base
  include Rails.application.routes.url_helpers

  default from: 'hello@streakapp.com'

  def daily_email(goal)
    @goal = goal
    @user = goal.user
    @url  = awyea_goal_url(@goal, host: "streakapp.herokuapp.com")
    mail(to: @user.email, subject: "#{@goal.name}: day #{@goal.current_streak}")
  end
end
