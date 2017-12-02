# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
    coefficent: 0.84,
  },
  {
    name: 'Japanese yen',
    code: 'JPY',
    coefficent: 112.11,
  },
  {
    name: 'Canadian dollar',
    code: 'CAD',
    coefficent: 1.27,
  },
  {
    name: 'Belarusian Ruble',
    code: 'BYN',
    coefficent: 2.01,
  },
]

# Create admin
admin = User.create(firstname: 'Nick', lastname: 'Adams', role: :admin)
admin.password = 'adminpass'
admin.save!

default_currencies.each do |currency_data|
  currency = Currency.create(name: currency_data[:name], code: currency_data[:code], amount: default_amount)
  currency.coefficents.create(value: currency_data[:coefficent], currency: currency)
end
