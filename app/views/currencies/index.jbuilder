json.currencies @currencies do |currency_with_amount|
  json.set! :currency do
    json.partial! 'currencies/currency', currency: currency_with_amount[:currency]
  end
  json.amount currency_with_amount[:amount]
end
