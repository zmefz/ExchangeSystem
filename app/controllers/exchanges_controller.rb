require 'TransactionCreator'

class ExchangesController < ApplicationController

  skip_before_action :require_admin!, only: [:create]

  def index
    render json: { success: true, data: get_transactions_data }, status: :ok
  end

  def show
    render json: { success: true, data: get_transaction_data(current_transaction) }, status: :ok
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

  def current_transaction
    Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:currency_from_code, :currency_to_code, :amount)
  end

  def transactions
    Transaction
      .where(params[:time_from] && "timestamp > ?", params[:time_from])
      .where(params[:time_to] && "timestamp < ?", params[:time_to])
      .where(params[:user_id] && "user_id = ?", params[:user_id])
      .where(params[:amount_from] && "amount > ?", params[:amount_from])
      .where(params[:amount_to] && "amount < ?", params[:amount_to])
      .where(params[:currency_from_id] && "currency_from_id = ?", params[:currency_from_id])
      .where(params[:currency_to_id] && "currency_to_id = ?", params[:currency_to_id])
  end

  def get_transactions_data
    {
      transactions: transactions.all.map { |transaction| get_transaction_data(transaction) },
      count:  transactions.count,
      amount: transactions.amount,
      daily_amount: transactions.daily.amount,
      most_popular: {
        currency_from: largest_hash_key(transactions.group(:currency_from_id).count(:currency_from_id)),
        currency_to:   largest_hash_key(transactions.group(:currency_to_id).count(:currency_to_id)),
      }
    }
  end

  def get_transaction_data(transaction)
    {
      user_id:  transaction.user_id,
      amount:   transaction.amount,
      currency_from:  currency_data(transaction.currency_from),
      currency_to:    currency_data(transaction.currency_to),
      timestamp: transaction.timestamp,
    }
  end

  def currency_data(currency)
    {
      id:   currency.id,
      name: currency.name,
      code: currency.code,
    }
  end

  def largest_hash_key(hash)
    result = hash.max_by{|k,v| v}
    result[0] if result.present?
  end

end
