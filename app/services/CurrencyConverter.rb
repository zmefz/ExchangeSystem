class CurrencyConverter

  def self.convert(currency_from, currency_to, amount)
    units = currency_to_units(currency_from, amount)
    units_to_currency(currency_to, units)
  end

  def self.convert_reverse(currency_from, currency_to, amount = 1)
    units = currency_to_units_reverse(currency_to, amount)
    units_to_currency_reverse(currency_from, units)
  end

  private

  def self.currency_to_units_reverse(currency, amount)
    (amount * currency.sell_value).ceil(2)
  end

  def self.currency_to_units(currency, amount)
    (amount * currency.buy_value).ceil(2)
  end

  def self.units_to_currency_reverse(currency, amount)
    (amount / currency.buy_value).floor(2)
  end

  def self.units_to_currency(currency, amount)
    (amount / currency.sell_value).floor(2)
  end

end
