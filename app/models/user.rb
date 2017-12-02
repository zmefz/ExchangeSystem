require 'bcrypt'

class User < ApplicationRecord
  include BCrypt

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :password_hash, presence: true

  has_many :sessions, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_one :currency

  enum role: [ :admin, :user ]

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end
