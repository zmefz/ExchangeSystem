require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @login_headers = { "session-token" => sessions(:one).token }
  end

  test "should get index" do
    get users_url, headers: @login_headers
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count', 1) do
      post users_url, headers: @login_headers, params: {
        user: {
          firstname: 'firstname',
          lastname: 'lastname',
          passport: 'AB32132132',
        }
      }
    end

    assert_response :created
  end

  test "should show user" do
    get user_url(@user), headers: @login_headers
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: {
      user: {
        firstname: @user.firstname + 'additional_part',
        lastname: @user.lastname + 'additional_part',
      }
    }

    assert_response :ok
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user), headers: @login_headers
    end

    assert_response :ok
  end
end
