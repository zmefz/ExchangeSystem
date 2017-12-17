require 'TransactionCreator'

class ExchangesController < ApplicationController

  skip_before_action :require_admin!, only: [:create]

  def index
    render json: { success: true, data: get_transactions_data }, status: :ok
  end

  def create
    transaction_creator = TransactionCreator.new(current_user)
    transaction_creator.perform(transaction_params)

    @transaction = transaction_creator.transaction
    @transaction_data = transaction_creator.transaction_data

    if @transaction.save
      render json: { success: true, data: @transaction_data }
    else
      render json: { success: false, errors: @transaction.errors, message: @transaction.errors.full_messages }
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:currency_from_code, :currency_to_code, :amount)
  end

  def transactions
    Transaction
  end

  def get_transactions_data
    {
      count:  transactions.count,
      amount: transactions.amount,
      daily_amount: transactions.daily.amount,
      most_popular: {
        currency_from: largest_hash_key(transactions.group(:currency_from_id).count(:currency_from_id)),
        currency_to:   largest_hash_key(transactions.group(:currency_to_id).count(:currency_to_id)),
      }
    }
  end

  def largest_hash_key(hash)
    hash.max_by{|k,v| v} [0]
  end

end
