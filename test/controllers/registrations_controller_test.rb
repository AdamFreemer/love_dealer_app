require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "creates user without password" do
    assert_difference "User.count", 1 do
      post registrations_path, params: { user: {
        first_name: "Rachel",
        last_name: "Goldman",
        email: "rachel@test.com",
        age: 30,
        gender: "woman",
        seeking: "seeking_man"
      } }
    end

    user = User.find_by(email: "rachel@test.com")
    assert user.present?
    assert user.encrypted_password.blank?
    assert user.intake_token.present?
  end

  test "redirects existing user with password to login" do
    assert_no_difference "User.count" do
      post registrations_path, params: { user: {
        first_name: "Test",
        last_name: "Customer",
        email: users(:customer).email,
        age: 30
      } }
    end
    assert_redirected_to new_user_session_path
  end
end
