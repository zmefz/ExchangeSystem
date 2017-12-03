class CurrenciesController < ApplicationController

  skip_before_action :require_user!
  before_action :require_currency!, only: [:update]
  before_action :current_currency, only: [:update]
  before_action :require_admin!, only: [:update]

  def index
    @currencies = Currency.active.all
  end

  def update
    update_params = {
      sell_value: currency_params[:sell_value],
      buy_value:  currency_params[:buy_value],
    }

    if current_currency.update(update_params)
      render json: { success: true }
    else
      render json: { success: false, error: current_currency.errors, message: current_currency.errors.full_messages }
    end
  end

  private

  def require_currency!
    current_currency.present?
  end

  def currency_params
    params.require(:currency).permit([ :code, :sell_value, :buy_value ])
  end

  def current_currency
    @_current_currency ||= Currency.find_by(code: currency_params[:code])
  end

end
