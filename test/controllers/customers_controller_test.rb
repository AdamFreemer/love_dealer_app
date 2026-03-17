require "test_helper"

class CustomersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "redirects unauthenticated user" do
    get customer_path
    assert_redirected_to new_user_session_path
  end

  test "shows profile for logged-in user" do
    sign_in users(:customer)
    get customer_path
    assert_response :success
    assert_select "h1", /Test Customer/
  end
end
