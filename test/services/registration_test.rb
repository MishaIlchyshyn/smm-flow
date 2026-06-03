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

  def valid_agency_params
    { name: "Jane's Agency", timezone: "Eastern Time (US & Canada)" }
  end

  test "creates user, agency, and owner membership on success" do
    service = Registration.new(user_params: valid_user_params, agency_params: valid_agency_params).call

    assert service.success?
    assert service.user.persisted?
    assert service.agency.persisted?
    assert_equal 1, service.user.memberships.count
    assert service.user.memberships.first.owner?
    assert service.user.memberships.first.active?
  end

  test "slug is generated from agency name" do
    service = Registration.new(user_params: valid_user_params, agency_params: valid_agency_params).call

    assert_equal "jane-s-agency", service.agency.slug
  end

  test "exposes user and agency via readers after successful call" do
    service = Registration.new(user_params: valid_user_params, agency_params: valid_agency_params).call

    assert_equal "jane@example.com", service.user.email
    assert_equal "Jane's Agency", service.agency.name
  end

  test "returns failure and rolls back all records when user is invalid" do
    service = Registration.new(user_params: valid_user_params.merge(email: "not-an-email"), agency_params: valid_agency_params).call

    assert_not service.success?
    assert_equal 0, User.where(email: "not-an-email").count
    assert_equal 0, Agency.where(name: "Jane's Agency").count
  end

  test "returns user errors when user params are invalid" do
    service = Registration.new(user_params: valid_user_params.merge(email: ""), agency_params: valid_agency_params).call

    assert_not service.success?
    assert service.user.errors[:email].any?
  end

  test "returns failure and rolls back all records when agency is invalid" do
    service = Registration.new(user_params: valid_user_params, agency_params: { name: "", timezone: "Eastern Time (US & Canada)" }).call

    assert_not service.success?
    assert_equal 0, User.where(email: "jane@example.com").count
  end

  test "merges agency errors into user when agency params are invalid" do
    service = Registration.new(user_params: valid_user_params, agency_params: { name: "", timezone: "Eastern Time (US & Canada)" }).call

    assert_not service.success?
    assert service.user.errors[:agency_name].any?
  end
end
