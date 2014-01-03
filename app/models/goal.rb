class Goal < ActiveRecord::Base
  belongs_to :user

  before_create :assign_token

  def to_param
    "#{token}-#{name.parameterize}"
  end

  def success!
    return if success_since_last_email?

    self.increment(:current_streak)
    self.record_streak = [current_streak, record_streak].max
    self.last_success_at = Time.now
    self.save
  end

  def send_daily_email
    if new_goal? || success_since_last_email?
      UserMailer.awyea(self).deliver
    else
      reset_streak!
      UserMailer.ohnoes(self).deliver
    end

    self.update_attributes(last_email_sent_at: Time.now)
  end

  def new_goal?
    last_success_at.nil? && last_email_sent_at.nil?
  end

  private

  def success_since_last_email?
    last_success_at && last_email_sent_at && last_success_at > last_email_sent_at
  end

  def reset_streak!
    self.update_attributes(current_streak: 0)
  end

  def assign_token
    self.token = SecureRandom.hex(4) until unique_token?
  end

  def unique_token?
    self.token.present? && Goal.where(token: self.token).empty?
  end
end
