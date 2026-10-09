require "test_helper"

class RegistrationTest < ActiveSupport::TestCase
  def valid_user_params
    {
      full_name: "Jane Doe",
      email: "jane@example.com",
      password: "password123",
      password_confirmation: "password123"
    }
  end

  test "creates user, agency, and owner membership on success" do
    service = Registration.new(user_params: valid_user_params).call

    assert service.success?
    assert service.user.persisted?
    assert service.agency.persisted?
    assert_equal 1, service.user.memberships.count
    assert service.user.memberships.first.owner?
    assert service.user.memberships.first.active?
  end

  test "agency name is generated from user full name" do
    service = Registration.new(user_params: valid_user_params).call

    assert_equal "Jane Doe's agency", service.agency.name
  end

  test "slug is generated from agency name" do
    service = Registration.new(user_params: valid_user_params).call

    assert_equal "jane-doe-s-agency", service.agency.slug
  end

  test "users with the same full name get separate agencies" do
    Registration.new(user_params: valid_user_params).call
    service = Registration.new(user_params: valid_user_params.merge(email: "jane2@example.com")).call

    assert service.success?
    assert_equal "Jane Doe's agency", service.agency.name
    assert_equal "jane-doe-s-agency-1", service.agency.slug
  end

  test "exposes user and agency via readers after successful call" do
    service = Registration.new(user_params: valid_user_params).call

    assert_equal "jane@example.com", service.user.email
    assert_equal "Jane Doe's agency", service.agency.name
  end

  test "returns failure and rolls back all records when user is invalid" do
    service = Registration.new(user_params: valid_user_params.merge(email: "not-an-email")).call

    assert_not service.success?
    assert_equal 0, User.where(email: "not-an-email").count
    assert_equal 0, Agency.where(name: "Jane Doe's agency").count
  end

  test "returns user errors when user params are invalid" do
    service = Registration.new(user_params: valid_user_params.merge(email: "")).call

    assert_not service.success?
    assert service.user.errors[:email].any?
  end
end
