class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    #WRITE FIND BY CREDENTIUALS AND LOGIN
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if @user.save
      login(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    @user = current_user

    logout(@user)
    redirect_to new_session_url
  end

  private
  def session_params
    params.require(:user).permit(:username, :password)
  end
end
