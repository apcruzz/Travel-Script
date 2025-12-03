require "test_helper"

class UsersTest < ActionDispatch::IntegrationTest
  test "user can create an account" do
    visit root_path

    click_link "Sign Up"
    fill_in "Name", with: "Test User"
    fill_in "Email address", with: "test@testing.com"
    fill_in "Password", with: "secret"
    fill_in "Password confirmation", with: "secret"

    click_button "Sign Up"

    assert_text "Home"
    assert_text "Test User"
    refute_text "Login"
  end

  test "shows errors when creating an account" do
    visit root_path

    click_link "Sign Up"
    fill_in "Name", with: "Test User"
    fill_in "Email address", with: "test@testing.com"
    fill_in "Password", with: "secret"
    fill_in "Password confirmation", with: "wrong"

    click_button "Sign Up"

    assert_text "doesn't match"
    assert_text "Log In"
  end

  test "user can Login" do
    user = FactoryBot.create :user, email_address: "testuser@test.com", password: "password"

    visit login_path

    fill_in "Email address", with: user.email_address
    fill_in "Password", with: "password"

    click_button "Log In"

    assert_text "Welcome back"
    assert_text user.name
    refute_text "Login"
  end

  test "user cannot Login with wrong password" do
    user = FactoryBot.create :user, email_address: "testuser@test.com", password: "password"

    visit login_path

    fill_in "Email address", with: user.email_address
    fill_in "Password", with: "wrong"

    click_button "Log In"

    assert_text "Don’t have an account?"
    refute_text user.name
    assert_text "Login"
  end
end
