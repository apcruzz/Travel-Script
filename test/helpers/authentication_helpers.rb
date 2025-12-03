module AuthenticationHelpers
  def login_user(user)
    visit login_path
    fill_in "Email address", with: user.email_address
    fill_in "Password", with: user.password
    click_button "Log In"
  end

  def login_a_user(options = {})
    user = FactoryBot.create :user, options
    login_user(user)
    user
  end
end
