require "test_helper"

class AgencyTest < ActiveSupport::TestCase
  test "has many users" do
    assert_includes agencies(:acme).users, users(:one)
  end
end
