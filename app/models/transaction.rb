class Transaction < ApplicationRecord
  belongs_to :user

  belongs_to :currency_from, class_name: 'Currency', validate: true
  belongs_to :currency_to, class_name: 'Currency', validate: true

  validate_presence_of :user, :amount, :currency_from, :currency_to, :timestamp
end
