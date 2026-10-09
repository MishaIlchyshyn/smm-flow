require "test_helper"

class AgencyTest < ActiveSupport::TestCase
  test "generates slug from name on create" do
    agency = Agency.create!(name: "My New Agency")

    assert_equal "my-new-agency", agency.slug
  end

  test "appends incrementing counter when base slug is already taken" do
    Agency.create!(name: "Test Corp")
    a2 = Agency.create!(name: "Test-Corp")
    a3 = Agency.create!(name: "Test Corp!")

    assert_equal "test-corp-1", a2.slug
    assert_equal "test-corp-2", a3.slug
  end

  test "each agency with a unique name gets a distinct slug" do
    a1 = Agency.create!(name: "Alpha Agency")
    a2 = Agency.create!(name: "Beta Agency")

    assert_not_equal a1.slug, a2.slug
  end

  test "does not regenerate slug on update" do
    agency = Agency.create!(name: "Original Name")
    original_slug = agency.slug

    agency.update!(name: "Updated Name")

    assert_equal original_slug, agency.slug
  end

  test "validates presence of name" do
    agency = Agency.new

    assert_not agency.valid?
    assert agency.errors[:name].any?
  end
end
