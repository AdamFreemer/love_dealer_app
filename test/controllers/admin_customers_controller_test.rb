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

  test "admin can soft delete a customer" do
    sign_in users(:admin)
    customer = users(:customer)
    delete admin_customer_path(customer)
    assert_redirected_to admin_customers_path
    assert customer.reload.deleted_at.present?
  end

  test "admin can batch delete customers" do
    sign_in users(:admin)
    customer = users(:customer)
    passwordless = users(:passwordless)
    delete batch_destroy_admin_customers_path, params: { customer_ids: [ customer.id, passwordless.id ] }
    assert_redirected_to admin_customers_path
    assert customer.reload.deleted_at.present?
    assert passwordless.reload.deleted_at.present?
  end

  test "soft deleted customers are hidden from index" do
    sign_in users(:admin)
    users(:customer).soft_delete!
    get admin_customers_path
    assert_response :success
    assert_no_match users(:customer).full_name, response.body
  end
end
