profit = 0.05
default_amount = 10_000
default_currencies = [
  {
    name: 'US Dollar',
    code: 'USD',
    coefficent: 1,
  },
  {
    name: 'Euro',
    code: 'EUR',
    coefficent: 1.18,
  },
  {
    name: 'Belarusian Ruble',
    code: 'BYN',
    coefficent: 0.49,
  },
]

# Create admin
admin = User.create(firstname: 'Nick', lastname: 'Adams', role: :admin)
admin.password = 'adminpass'
admin.save!

default_currencies.each do |currency_data|
  currency = Currency.create(name: currency_data[:name], code: currency_data[:code], amount: default_amount)
  currency.coefficents.create(
    sell_value: currency_data[:coefficent],
    buy_value: currency_data[:coefficent] + profit,
    currency: currency
  )
end
