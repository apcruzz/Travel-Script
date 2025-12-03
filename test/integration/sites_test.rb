require "test_helper"

class SitesTest < ActionDispatch::IntegrationTest
  test "root page loads" do
    visit root_path

    assert_text "Hello"
  end
end
