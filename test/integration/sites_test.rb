require "test_helper"

class SitesTest < ActionDispatch::IntegrationTest
  test "root page loads" do
    visit root_path

    assert_text "Connect"
  end

  test "about page loads" do
    visit about_path

    assert_text "Travel Script"
  end
end
