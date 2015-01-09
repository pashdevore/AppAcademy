class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  helper_method :current_user, :all_bands

  def current_user
    current_user = User.find_by(token: session[:session_token])
    if current_user
      return current_user
    else
      nil
    end
  end

  def all_bands
    Band.order('name')
  end

  def login_user!(user)
    # if we've gotten here, validations have passed

    # 1) look up user by credentials
    @user = User.find_by_credentials(params[:user][:email],
                                     params[:user][:password])
    if @user
      # 2) create and reset session token for user cookie and db
      new_token = @user.reset_session_token!
      session[:session_token] = new_token
    else
      render :new
    end
  end
end
