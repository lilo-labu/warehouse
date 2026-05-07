require "test_helper"

class AuthorizationTest < ActionDispatch::IntegrationTest
  setup do
    @worker = User.create!(email: "worker@example.com", password: "password123", role: :worker)
  end

  test "worker cannot access new stock movement page" do
    sign_in @worker

    get new_stock_movement_path

    assert_redirected_to root_path
  end
end
