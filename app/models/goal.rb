class Goal < ActiveRecord::Base
  belongs_to :user

  before_create :assign_token

  def to_param
    "#{token}-#{name.parameterize}"
  end

  private

  def assign_token
    self.token = SecureRandom.hex(4) until unique_token?
  end

  def unique_token?
    self.token.present? && Goal.where(token: self.token).empty?
  end
end
