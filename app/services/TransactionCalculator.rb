require 'CurrencyConverter'

class TransactionCalculator

  def self.calculate(transaction)
    currency_to_amount = CurrencyConverter.convert(transaction.currency_from, transaction.currency_to, transaction.amount)

    return {
      currency_from_amount: transaction.amount,
      currency_to_amount:   currency_to_amount,
    }
  end

end