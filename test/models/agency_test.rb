require "test_helper"

class AgencyTest < ActiveSupport::TestCase
  test "validates presence of name" do
    agency = Agency.new

    assert_not agency.valid?
    assert agency.errors[:name].any?
  end
end
