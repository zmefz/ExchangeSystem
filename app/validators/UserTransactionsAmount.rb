class UserTransactionsAmount

  def self.validate(user, new_transaction)
    daily_transaction_amount(user) + new_transaction.amount < MAX_DAILY_AMOUNT
  end

  private

  def self.daily_transaction_amount(user)
    user.transactions.daily.amount
  end

end
