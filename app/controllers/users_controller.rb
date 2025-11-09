class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create]
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
    # @user = User.find(params[:id])
    @user = Current.user
  end

  def update
    # @user = User.find(params[:id])
    @user = Current.user
    if @user.update(user_params)
      redirect_to root_path, notice: "Your account has been updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, alert: "Your account has been deleted."
  end

  def show
    # @user = User.find(params[:id])
    @user = Current.user
  end

  private

  def user_params
  params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
    # .expect retturns an error when I make new user. permit works fine.
  end
end
