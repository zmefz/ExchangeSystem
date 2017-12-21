class RelativeCurrenciesCalculator

  def self.calculate(default_currency, default_currency_set = false, amount = 1)
    result = []

    Currency.active.find_each do |currency|
      result.append({
        currency: currency,
        amount:   CurrencyConverter.convert(default_currency, currency, amount)
      }) if !default_currency_set || (default_currency_set && !(currency.id == default_currency.id))
    end

    result
  end

end
