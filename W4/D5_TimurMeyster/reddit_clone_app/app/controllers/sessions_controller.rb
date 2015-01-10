class SessionsController < ApplicationController

  def new
    @user = User.new

    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username],
                                     params[:user][:password])
    if @user
      flash.notice = ""
      login_user!(@user)
      redirect_to user_url(@user)
    else
      flash.notice = "User does not exist"
      @user = User.new
      render :new
    end
  end

  def destroy
    @user = current_user

    if @user
      flash.notice = ""
      logout_user(@user)
      render :new
    else
      flash.notice = "You cannot sign out!"
      @user = User.new
      render :new
    end
  end
end
