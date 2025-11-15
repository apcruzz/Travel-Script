class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[new create]

  def new
    @user = User.new
  end

  def index
    @users = [ Current.user ]
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      redirect_to root_path, notice: "Welcome, #{@user.name}! Your account has been created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = Current.user
  end

  def update
    @user = Current.user

    # require a password verification before updating
    # if @user.authenticate(params[:user][:password_challenge])
      if @user.update(user_update_params)
        redirect_to root_path, notice: "Your account has been updated."
      else
        render :edit, status: :unprocessable_entity
      end
  end

  def destroy
    @user = Current.user
    @user.destroy
    redirect_to root_path, alert: "Your account has been deleted."
  end

  def show
    @user = Current.user
  end

  private

  def user_params
    params.expect(user: [:name, :email_address, :password, :password_confirmation])
    # tried using expect but was not working, permit does.
  end
  def user_update_params
    params.expect(user: [:name, :email_address, :password, :password_confirmation, :password_challenge]).with_defaults(password_challenge: "")
    # tried using expect but was not working, permit does.
  end
end
