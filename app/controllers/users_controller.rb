class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create]
  def new
    @user = User.new
  end

  def index
  @users = User.all
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
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.expect(user: [ :name, :email_address, :password, :password_confirmation ])
  end
end
