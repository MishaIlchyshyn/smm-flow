require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "requires full_name" do
    user = User.new(email: "x@example.com", password: "password123", agency: agencies(:acme))

    assert_not user.valid?
    assert user.errors[:full_name].any?
  end

  test "requires email" do
    user = User.new(full_name: "Alice", password: "password123", agency: agencies(:acme))

    assert_not user.valid?
    assert user.errors[:email].any?
  end

  test "email must be unique" do
    User.create!(full_name: "Alice", email: "dup@example.com", password: "password123", agency: agencies(:acme))
    user = User.new(full_name: "Bob", email: "dup@example.com", password: "password123", agency: agencies(:acme))

    assert_not user.valid?
    assert user.errors[:email].any?
  end

  test "requires agency" do
    user = User.new(full_name: "Alice", email: "x@example.com", password: "password123")

    assert_not user.valid?
    assert user.errors[:agency].any?
  end

  test "belongs to agency" do
    assert_equal agencies(:acme), users(:one).agency
  end
end
