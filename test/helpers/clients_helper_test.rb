require "test_helper"

class ClientsHelperTest < ActionView::TestCase
  test "website_label strips scheme, www and trailing slash" do
    assert_equal "harbourbakery.co.uk", website_label("https://www.harbourbakery.co.uk/")
    assert_equal "example.com/shop", website_label("http://example.com/shop/")
    assert_equal "harbourbakery.co.uk", website_label("harbourbakery.co.uk")
  end

  test "website_href adds https when scheme is missing" do
    assert_equal "https://harbourbakery.co.uk", website_href("harbourbakery.co.uk")
    assert_equal "http://example.com", website_href("http://example.com")
  end

  test "kind_label humanizes kind" do
    assert_equal "Client", kind_label("client")
    assert_equal "Lead", kind_label("lead")
  end

  test "kind_options lists Client then Lead" do
    assert_equal [["Client", "client"], ["Lead", "lead"]], kind_options
  end
end
