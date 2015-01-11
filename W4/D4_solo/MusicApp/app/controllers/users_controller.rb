class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])

    render :show
  end

  def new
    if logged_in?
      redirect_to user_url(current_user)
    else
      @user = User.new
      render :new
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login_user!(@user)
      redirect_to user_url(@user)
    else
      @user = User.new
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
