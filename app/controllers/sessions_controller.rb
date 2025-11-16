class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def create
    user = User.find_by(email_address: params[:email_address])
    if user&.authenticate(params[:password])
      start_new_session_for user
      redirect_to after_authentication_url, notice: "Welcome back, #{user.name}!"
    else
      flash.now[:alert] = "Invalid email or password, from sessions"
      render "sites/index", status: :unprocessable_entity
    end
  rescue BCrypt::Errors::InvalidHash
    redirect_to root_path, alert: "Invalid password, did you signup with Github?"
  end

  def destroy
    terminate_session
    redirect_to root_path, notice: "Logged out successfully."
  end
end
