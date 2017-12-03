class TransactionCreator

  attr_reader :transaction, :transaction_data

  def initialize(user)
    @user = user
  end

  def perform(options)
    currency_from_code, currency_to_code, amount = options.values_at(:currency_from_code, :currency_to_code, :amount)
    @currency_from = find_currency(currency_from_code)
    @currency_to   = find_currency(currency_to_code)
    @amount        = amount

    Transaction.transaction do
      create_transaction

      Currency.transaction do
        increase_currency_from
        decrease_currency_to
      end
    end
  end

  def transaction_data
    @transaction_data ||= TransactionCalculator.calculate(@transaction)
  end

  private

  def create_transaction
    @transaction = @user.transactions.new({
      currency_from: @currency_from,
      currency_to:   @currency_to,
      amount:        @amount,
    })

    unless @transaction.save
      raise ArgumentError(@transaction.errors.full_messages)
    end
  end

  def increase_currency_from
    @currency_from.update(amount: @currency_from.amount + transaction_data[:currency_from_amount])
  end

  def decrease_currency_to
    @currency_to.update(amount: @currency_to.amount - transaction_data[:currency_to_amount])
  end

  def find_currency(code)
    Currency.find_by(code: code)
  end

end
