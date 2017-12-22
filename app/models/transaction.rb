require 'UserTransactionsAmount'
require 'TransactionCalculator'
require 'CurrencyBalance'

class Transaction < ApplicationRecord
  belongs_to :user

  belongs_to :currency_from, class_name: 'Currency', validate: true
  belongs_to :currency_to, class_name: 'Currency', validate: true

  validates_presence_of :user, :amount, :currency_from, :currency_to, :timestamp

  validates :amount, format: { :with => /\A\d+(?:\.\d{0,2})?\z/ }

  validates :amount, numericality: {
    greater_than_or_equal_to: MIN_TRANSACTION_AMOUNT,
    less_than_or_equal_to:    MAX_TRANSACTION_AMOUNT
  }

  validate :user_transactions_sum
  validate :currency_balance

  scope :daily, -> () { where('timestamp > ?', Date.today.to_time) }
  scope :amount, -> () { sum(:amount) }

  before_validation :set_timestamp

  def user_transactions_sum
    unless UserTransactionsAmount.validate(self.user, self)
      @errors[:user] << "eceeded daily limit"
    end
  end

  def currency_balance
    unless CurrencyBalance.validate(self)
      @errors[:currency_to] << "not enough money at bank"
    end
  end

  def set_timestamp
    self.timestamp = Time.zone.now
  end

end
