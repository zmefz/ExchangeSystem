require 'test_helper'

class CurrenciesControllerTest < ActionDispatch::IntegrationTest
  test "the truth" do
    get currencies_url
    assert_response :ok
  end
end
