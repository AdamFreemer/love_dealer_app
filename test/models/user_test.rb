require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid without password when encrypted_password is blank" do
    user = User.new(email: "new@test.com", first_name: "Test", last_name: "User")
    assert user.valid?
  end

  test "full_name returns first and last name" do
    user = users(:customer)
    assert_equal "Test Customer", user.full_name
  end

  test "has services through user_services" do
    user = users(:customer)
    assert_includes user.services, services(:matchmaking)
  end
end
