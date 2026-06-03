require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  def valid_params
    {
      user: {
        full_name: "Test User",
        email: "newuser@example.com",
        password: "password123",
        password_confirmation: "password123",
        agency_name: "Test Agency",
        agency_timezone: "Eastern Time (US & Canada)"
      }
    }
  end

  test "successful registration creates user, agency, and signs in" do
    assert_difference ["User.count", "Agency.count", "Membership.count"], 1 do
      post user_registration_path, params: valid_params
    end

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

  test "invalid agency params re-renders registration form with agency errors" do
    bad_params = valid_params
    bad_params[:user][:agency_name] = ""

    assert_no_difference ["User.count", "Agency.count"] do
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
