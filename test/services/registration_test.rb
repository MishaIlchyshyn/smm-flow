require "test_helper"

class RegistrationTest < ActiveSupport::TestCase
  def valid_user_params
    {
      first_name: "Jane", last_name: "Doe",
      email: "jane@example.com",
      password: "password123",
      password_confirmation: "password123"
    }
  end

  test "creates user and agency on success" do
    service = Registration.new(user_params: valid_user_params).call

    assert service.success?
    assert service.user.persisted?
    assert service.agency.persisted?
    assert_equal service.agency, service.user.agency
  end

  test "each registration gets its own agency" do
    first = Registration.new(user_params: valid_user_params).call
    second = Registration.new(user_params: valid_user_params.merge(email: "jane2@example.com")).call

    assert second.success?
    assert_not_equal first.agency, second.agency
  end

  test "exposes user and agency via readers after successful call" do
    service = Registration.new(user_params: valid_user_params).call

    assert_equal "jane@example.com", service.user.email
    assert_equal service.user.agency, service.agency
  end

  test "returns failure and rolls back all records when user is invalid" do
    assert_no_difference ["User.count", "Agency.count"] do
      service = Registration.new(user_params: valid_user_params.merge(email: "not-an-email")).call

      assert_not service.success?
    end
  end

  test "returns user errors when user params are invalid" do
    service = Registration.new(user_params: valid_user_params.merge(email: "")).call

    assert_not service.success?
    assert service.user.errors[:email].any?
  end
end
