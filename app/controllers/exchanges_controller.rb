class ExchangesController < ApplicationController

  def create
    @transaction = current_user.transactions.new(transaction_params)

    if @transaction.save
      render json: { success: true }
    else
      render json: { success: false, errors: @transaction.errors, message: @transaction.errors.full_messages }
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:currency_from_id, :currency_to_id, :amount)
  end

end
