class RelativeCurrenciesCalculator

  def self.calculate(default_currency, amount = 1)
    result = []

    Currency.active.find_each do |currency|
      result.append({
        currency: currency,
        amount:   CurrencyConverter.convert(currency, default_currency, amount)
      }) unless currency.id == default_currency.id
    end

    result
  end

end
