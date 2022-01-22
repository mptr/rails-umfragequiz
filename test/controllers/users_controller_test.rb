require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should require token" do
    get users_url, as: :json
    assert_response 403

    get users_url, as: :json, headers:{"HTTP_AUTHORIZATION" => generate_token_for(@user)}
    assert_response :success
  end

  test "should show user" do
    get user_url(@user), as: :json
    assert_response 403

    get users_url(@user), as: :json, headers:{"HTTP_AUTHORIZATION" => generate_token_for(@user)}
    assert_response :success
  end

### standard tests

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: @user.email, username: @user.username } }, as: :json, headers:{"HTTP_AUTHORIZATION" => generate_token_for(@user)}
    end

    assert_response 201
  end

  test "should update user" do
    patch user_url(@user), params: { user: { email: @user.email, username: @user.username } }, as: :json, headers:{"HTTP_AUTHORIZATION" => generate_token_for(@user)}
    assert_response 200
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user), as: :json, headers:{"HTTP_AUTHORIZATION" => generate_token_for(@user)}
    end

    assert_response 204
  end
end
