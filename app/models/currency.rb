class Currency < ApplicationRecord

  has_many :users
  has_many :coefficents

  validate :one_active_coefficent_present
  validates :code, presence: true

  def active_coefficents
    coefficents.active
  end

  def one_active_coefficent_present
    self.active_coefficents.count == 1
  end

  def coefficent
    active_coefficents.take
  end

  def increase(value)
    self.update(amount: self.amount + value)
  end

  def decrease(value)
    self.update(amount: self.amount - value)
  end

end