class CurrencyConverter

  def self.convert(currency_from, currency_to, amount)
    units = currency_to_units(currency_from, amount)
    units_to_currency(currency_to, units)
  end

  private

  def self.currency_to_units(currency, amount)
    amount * currency.buy_value
  end

  def self.units_to_currency(currency, amount)
    amount / currency.sell_value
  end

end
