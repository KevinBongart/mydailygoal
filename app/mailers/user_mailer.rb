class UserMailer < ActionMailer::Base
  include Rails.application.routes.url_helpers

  default from: 'hello@streakapp.com'

  def awyea(goal)
    @goal = goal
    @user = goal.user
    @awyea_url = awyea_goal_url(@goal, host: "streakapp.herokuapp.com")
    @edit_goal_url = edit_goal_url(@goal, host: "streakapp.herokuapp.com")

    subject = @goal.new_goal? ? "a fresh start" : "#{@goal.current_streak}-day streak"

    mail(to: @user.email, subject: "#{@goal.name}: #{subject}")
  end

  def ohnoes(goal)
    @goal = goal
    @user = goal.user
    @awyea_url = awyea_goal_url(@goal, host: "streakapp.herokuapp.com")
    @edit_goal_url = edit_goal_url(@goal, host: "streakapp.herokuapp.com")

    mail(to: @user.email, subject: "#{@goal.name}: a fresh start")
  end
end
