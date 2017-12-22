class RelativeCurrenciesCalculator

  def self.calculate(default_currency, default_currency_set = false, amount = 1, reversed = nil)
    result = []

    Currency.active.find_each do |currency|

      calculated_amount = nil
      if default_currency.id == currency.id
        calculated_amount = 1
      else
        if reversed
          calculated_amount = CurrencyConverter.convert_reverse(currency, default_currency, amount)
        else
          calculated_amount = CurrencyConverter.convert(default_currency, currency, amount)
        end
      end

      result.append({
        currency: currency,
        amount:   calculated_amount,
      }) if !default_currency_set || (default_currency_set && !(currency.id == default_currency.id))
    end

    result
  end

end
