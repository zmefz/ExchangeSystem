require 'TransactionCalculator'

class CurrencyBalance

  def self.validate(transaction)
    transaction_data = TransactionCalculator.calculate(transaction)
    transaction.currency_to.amount > transaction_data[:currency_to_amount]
  end

end