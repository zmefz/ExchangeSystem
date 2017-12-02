class CurrencyConverter

  def self.convert(currency_from, currency_to, amount)
    units = amount / currency_from.coefficent.value
    units * currency_to.coefficent.value
  end

end
