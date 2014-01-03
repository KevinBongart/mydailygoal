class UserMailer < ActionMailer::Base
  include Rails.application.routes.url_helpers

  default from: 'hello@mydailygoal.net'

  def awyea(goal)
    @goal = goal
    @awyea_url = awyea_goal_url(@goal, host: "mydailygoal.net")
    @edit_goal_url = edit_goal_url(@goal, host: "mydailygoal.net")

    if @goal.new_goal?
      subject = "a fresh start"
    elsif @goal.current_streak == 1
      subject = "off to a good start"
    elsif @goal.current_streak > @goal.record_streak
      subject = "#{@goal.current_streak}-day streak, new record!"
    else
      subject = "#{@goal.current_streak}-day streak"
    end

    mail(to: @goal.email, subject: "#{@goal.name}: #{subject}")
  end

  def ohnoes(goal)
    @goal = goal
    @awyea_url = awyea_goal_url(@goal, host: "mydailygoal.net")
    @edit_goal_url = edit_goal_url(@goal, host: "mydailygoal.net")

    mail(to: @goal.email, subject: "#{@goal.name}: a fresh start")
  end
end
