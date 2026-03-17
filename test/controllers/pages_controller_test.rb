require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "home page renders" do
    get root_path
    assert_response :success
    assert_select "h1", /Meaningful connections/
  end
end
