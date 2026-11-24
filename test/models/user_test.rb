require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "requires first_name and last_name" do
    user = User.new(email: "x@example.com", password: "password123", agency: agencies(:acme))

    assert_not user.valid?
    assert user.errors[:first_name].any?
    assert user.errors[:last_name].any?
  end

  test "full_name joins first and last name" do
    assert_equal "Alice Smith", users(:one).full_name
  end

  test "requires email" do
    user = User.new(first_name: "Alice", last_name: "Smith", password: "password123", agency: agencies(:acme))

    assert_not user.valid?
    assert user.errors[:email].any?
  end

  test "email must be unique" do
    User.create!(first_name: "Alice", last_name: "Smith", email: "dup@example.com", password: "password123", agency: agencies(:acme))
    user = User.new(first_name: "Bob", last_name: "Smith", email: "dup@example.com", password: "password123", agency: agencies(:acme))

    assert_not user.valid?
    assert user.errors[:email].any?
  end

  test "requires agency" do
    user = User.new(first_name: "Alice", last_name: "Smith", email: "x@example.com", password: "password123")

    assert_not user.valid?
    assert user.errors[:agency].any?
  end

  test "belongs to agency" do
    assert_equal agencies(:acme), users(:one).agency
  end
end
