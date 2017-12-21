class RelativeCurrenciesCalculator

  def self.calculate(default_currency, amount = 1)
    result = []

    Currency.active.find_each do |currency|
      result.append({
        currency: currency,
        amount:   CurrencyConverter.convert(default_currency, currency, amount)
      })
    end

    result
  end

end
