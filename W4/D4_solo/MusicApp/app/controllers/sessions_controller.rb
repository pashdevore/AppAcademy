class SessionsController < ApplicationController
  def new
    @user = User.new

    render :new
  end

  def create
    login_user!(@user)

    redirect_to "/user"
  end

  def destroy
    # destroy current session
    # 1) find current user and set their token to nil
    @user = current_user
    @user.reset_session_token!
    @user.token = nil

    # 3) redirect to the login page
    redirect_to "/session/new"
  end
end
