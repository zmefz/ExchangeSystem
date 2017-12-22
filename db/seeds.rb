profit = 0.05
default_amount = 10_000
default_currencies = [
  {
    name: 'US Dollar',
    code: 'USD',
    display_count: 1,
    coefficent: 1,
  },
  {
    name: 'Euro',
    code: 'EUR',
    display_count: 1,
    coefficent: 1.18,
  },
  {
    name: 'Belarusian Ruble',
    code: 'BYN',
    display_count: 1,
    coefficent: 0.49,
  },
  {
    name: 'Israel Shekel',
    code: 'ILS',
    display_count: 1,
    coefficent: 0.57,
  },
  {
    name: 'Russian Rouble',
    code: 'RUB',
    display_count: 100,
    coefficent: 0.03,
  },
]

# Create admin
admin = User.create(firstname: 'Nick', lastname: 'Adams', role: :admin)
admin.password = 'adminpass'
admin.save!

default_currencies.each do |currency_data|
  currency = Currency.create({
    name: currency_data[:name],
    code: currency_data[:code],
    amount: default_amount,
    display_count: currency_data[:display_count]
  })

  currency.coefficents.create(
    sell_value: currency_data[:coefficent],
    buy_value: currency_data[:coefficent] * (1 - profit),
    currency: currency
  )
end
