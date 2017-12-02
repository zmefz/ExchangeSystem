class Session < ApplicationRecord
  belongs_to :user

  before_save :generate_token
  before_validation :token, presence: true, unique: true
  before_validation :user, presence: true

  def generate_token
    self.token = SecureRandom.hex(6)
  end

end
