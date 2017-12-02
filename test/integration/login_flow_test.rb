require 'test_helper'

class LoginFlowTest < ActionDispatch::IntegrationTest
  test "login" do

    # Find by passport
    assert_difference('Session.count', 1) {
      post exchanges_url, params: {
        user: {
          passport: 'AB1231212',
        }
      }
      assert_response :ok
    }

    # Find by session
    assert_difference('Session.count', 0) {
      post exchanges_url, headers: { "session-token" => Session.first.token }
      assert_response :ok
    }

    # Create user by user params
    assert_difference('Session.count', 1) {
      assert_difference('User.count', 1) {
        post exchanges_url, params: {
          user: {
            passport: 'AB1231213',
            firstname: 'firstname',
            lastname: 'lastname',
          }
        }
        assert_response :ok
      }
    }
  end

end
