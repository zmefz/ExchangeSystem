class RelativeCurrency

  def initialize(currency, unit_currency)
    @currency = currency
    @unit_currency = unit_currency
    self
  end

  def code
    @currency.code
  end

  def buy_value
    @currency.buy_value / @unit_currency.buy_value
  end

  def sell_value
    @currency.sell_value / @unit_currency.sell_value
  end

end