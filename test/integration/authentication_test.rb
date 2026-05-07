require "test_helper"

class AuthenticationTest < ActionDispatch::IntegrationTest
  test "unauthenticated user is redirected from warehouses index" do
    get warehouses_path

    assert_redirected_to new_user_session_path
  end
end
