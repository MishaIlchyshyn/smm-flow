require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  def valid_params
    {
      user: {
        full_name: "Test User",
        email: "newuser@example.com",
        password: "password123",
        password_confirmation: "password123"
      }
    }
  end

  test "successful registration creates user, agency, and signs in" do
    assert_difference ["User.count", "Agency.count", "Membership.count"], 1 do
      post user_registration_path, params: valid_params
    end

    assert_equal "Test User's agency", Agency.last.name
    assert_redirected_to dashboard_path
    follow_redirect!
    assert_response :success
  end

  test "invalid user params re-renders registration form" do
    bad_params = valid_params
    bad_params[:user][:email] = ""

    assert_no_difference "User.count" do
      post user_registration_path, params: bad_params
    end

    assert_response :unprocessable_entity
  end

  test "duplicate email re-renders registration form" do
    User.create!(full_name: "Existing", email: "newuser@example.com", password: "password123")

    assert_no_difference "User.count" do
      post user_registration_path, params: valid_params
    end

    assert_response :unprocessable_entity
  end
end
