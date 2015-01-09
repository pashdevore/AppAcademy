class UsersController < ApplicationController

  def new
    @user = User.new

    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login_user!(@user)

      render :show
    else
      redirect_to "/user/new"
    end
  end

  def show
    @user = current_user

    render :show
  end

  private
  def user_params
    # only want to permit mass setting of password - not password_digest
    params.require(:user).permit(:email, :password)
  end
end
