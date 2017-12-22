class RelativeCurrenciesCalculator

  def self.calculate(default_currency, default_currency_set = false, amount = 1)
    result = []

    Currency.active.find_each do |currency|

      calculated_amount = nil
      if default_currency.id == currency.id
        calculated_amount = 1
      else
        calculated_amount = CurrencyConverter.convert(default_currency, currency, amount)
      end

      result.append({
        currency: currency,
        amount:   calculated_amount,
      }) if !default_currency_set || (default_currency_set && !(currency.id == default_currency.id))
    end

    result
  end

end
