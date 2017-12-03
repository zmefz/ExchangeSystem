require 'TransactionCreator'

class ExchangesController < ApplicationController

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

end
