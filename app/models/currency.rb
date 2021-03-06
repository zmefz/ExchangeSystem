class Currency < ApplicationRecord

  has_many :users
  has_many :coefficents

  validate :one_active_coefficent_present
  validates :display_count, presence: true
  validates :code, presence: true

  delegate :buy_value, to: :coefficent
  delegate :sell_value, to: :coefficent

  scope :active, -> () { Coefficent.active.currencies }

  def get_sell_value(default_currency)
    CurrencyConverter.convert_reverse(default_currency, self, self.display_count)
  end

  def get_buy_value(default_currency)
    CurrencyConverter.convert(self, default_currency, self.display_count)
  end

  def active_coefficents
    coefficents.active
  end

  def one_active_coefficent_present
    self.active_coefficents.count == 1
  end

  def coefficent
    active_coefficents.take
  end

end
