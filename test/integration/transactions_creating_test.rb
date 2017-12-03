require 'CurrencyConverter'
require 'test_helper'

class TransactionsCreatingTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @currency_from = currencies(:dollar)
    @currency_to = currencies(:euro)
    @user_params = { passport: 'AB3213311', firstname: 'Jenia', lastname: 'Saigak' }
  end

  test "creating transaction" do
    amount = 100
    currency_to_change_amount = CurrencyConverter.convert(@currency_from, @currency_to, amount)

    assert_difference('Transaction.count', 1) do
      post exchanges_url, params: {
        user: @user_params,
        transaction: {
          currency_from_id: @currency_from.id,
          currency_to_id: @currency_to.id,
          amount: amount
        }
      }
    end

    assert JSON.parse(@response.body)["success"]
  end

  test "creating transaction with invalid amount" do
    assert_difference('Transaction.count', 0) do
      post exchanges_url, params: {
        user: @user_params,
        transaction: {
          currency_from_id: @currency_from.id,
          currency_to_id: @currency_to.id,
          amount: 0
        }
      }
    end

    assert_not JSON.parse(@response.body)["success"]
  end

  test "creating too much transactions per period" do
    post exchanges_url, params: {
      user: @user_params,
      transaction: {
        currency_from_id: @currency_from.id,
        currency_to_id: @currency_to.id,
        amount: 999
      }
    }
    assert JSON.parse(@response.body)["success"]

    post exchanges_url, params: {
      user: @user_params,
      transaction: {
        currency_from_id: @currency_from.id,
        currency_to_id: @currency_to.id,
        amount: 999
      }
    }
    assert JSON.parse(@response.body)["success"]

    post exchanges_url, params: {
      user: @user_params,
      transaction: {
        currency_from_id: @currency_from.id,
        currency_to_id: @currency_to.id,
        amount: 999
      }
    }
    assert_not JSON.parse(@response.body)["success"]
  end
end
