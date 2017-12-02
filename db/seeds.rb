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
    coefficent: 1,
  },
  {
    name: 'Euro',
    coefficent: 0.84,
  },
  {
    name: 'Japanese yen',
    coefficent: 112.11,
  },
  {
    name: 'Canadian dollar',
    coefficent: 1.27,
  },
  {
    name: 'Australian dollar',
    coefficent: 1.31,
  },
]

# Create admin
admin = User.create(firstname: 'Nick', lastname: 'Adams', role: :admin)
admin.password = 'adminpass'
admin.save!

default_currencies.each do |currency_data|
  currency = Currency.create(name: currency_data[:name], amount: default_amount)
  currency.coefficents.create(value: currency_data[:coefficent], currency: currency)
end
