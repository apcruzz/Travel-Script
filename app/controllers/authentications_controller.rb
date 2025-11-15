class AuthenticationsController < ApplicationController
  allow_unauthenticated_access only: %i[ create ]

  def create
    # render json: user_hash
    #  return
    user = User.where(uid: user_hash[:uid], provider: user_hash[:provider]).first
    if user
      # User found - login
      start_new_session_for user
      redirect_to root_path, notice: "Your are Login."
    else
      # Create user, save them, login
      user = User.new_form_hash user_hash
      if user.save
        start_new_session_for user
        redirect_to root_path, notice: "You are Signed up."
      else
        session[:user_hash] = user_hash
        redirect_to sign_up, notice: "Please add the missing information"

      end
    end
  end

  private
  def auth_hash
    request.env["omniauth.auth"]
  end

  def user_hash
    return @hash if @hash
    hash = {}
    hash[:uid] = auth_hash["uid"]
    hash[:provider] = auth_hash["provider"]
    if auth_hash["info"]
      hash[:name] = auth_hash["info"]["name"]
      hash[:email_address] = auth_hash["info"]["email"]
    end
    if auth_hash["credentials"]
      hash[:token] = auth_hash["credentials"]["token"]
    end
    @hash = hash
  end
end
