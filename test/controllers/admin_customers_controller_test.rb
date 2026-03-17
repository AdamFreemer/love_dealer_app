require "test_helper"

class AdminCustomersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "non-admin cannot access admin" do
    sign_in users(:customer)
    get admin_customers_path
    assert_redirected_to root_path
  end

  test "admin can view customer list" do
    sign_in users(:admin)
    get admin_customers_path
    assert_response :success
  end

  test "admin can view customer detail" do
    sign_in users(:admin)
    get admin_customer_path(users(:customer))
    assert_response :success
  end

  test "admin can update customer status" do
    sign_in users(:admin)
    patch admin_customer_path(users(:customer)), params: { user: { status: "accepted" } }
    assert_redirected_to admin_customer_path(users(:customer))
    assert_equal "accepted", users(:customer).reload.status
  end
end
