class CurrenciesController < ApplicationController

  skip_before_action :require_user!

  def index
    @currencies = Currency.all
  end

end
