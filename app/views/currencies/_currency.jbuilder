json.id currency.id
json.name currency.name
json.code currency.code
json.sale currency.get_sell_value(@default_currency)
json.purchase currency.get_buy_value(@default_currency)
