class SessionsController < ApplicationController

  def new
    @user = User.new

    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email],
                                     params[:user][:password])
    if @user
      login_user!(@user)
      redirect_to user_url(@user)
    else
      @user = User.new
      render :new
    end
  end

  def destroy
    @user = current_user

    if @user
      logout_user!(@user)
      redirect_to new_session_url
    else
      @user = User.new
      render :new
    end
  end
end
