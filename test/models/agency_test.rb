require "test_helper"

class AgencyTest < ActiveSupport::TestCase
  test "generates slug from name on create" do
    agency = Agency.create!(name: "My New Agency", timezone: "UTC")

    assert_equal "my-new-agency", agency.slug
  end

  test "appends incrementing counter when base slug is already taken" do
    Agency.create!(name: "Test Corp", timezone: "UTC")
    a2 = Agency.create!(name: "Test-Corp", timezone: "UTC")
    a3 = Agency.create!(name: "Test Corp!", timezone: "UTC")

    assert_equal "test-corp-1", a2.slug
    assert_equal "test-corp-2", a3.slug
  end

  test "each agency with a unique name gets a distinct slug" do
    a1 = Agency.create!(name: "Alpha Agency", timezone: "UTC")
    a2 = Agency.create!(name: "Beta Agency", timezone: "UTC")

    assert_not_equal a1.slug, a2.slug
  end

  test "does not regenerate slug on update" do
    agency = Agency.create!(name: "Original Name", timezone: "UTC")
    original_slug = agency.slug

    agency.update!(name: "Updated Name")

    assert_equal original_slug, agency.slug
  end

  test "validates presence of name, slug, and timezone" do
    agency = Agency.new

    assert_not agency.valid?
    assert agency.errors[:name].any?
    assert agency.errors[:timezone].any?
  end
end
