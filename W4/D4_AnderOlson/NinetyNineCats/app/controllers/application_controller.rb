class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    login_info = Login.find_by(token: session[:session_token])
    if login_info
      login_info.user
    else
      nil
    end
  end

  def create_session_token
    SecureRandom.urlsafe_base64
  end

  def login_user!
    @user = User.find_by_credentials(params[:user][:user_name],
                                     params[:user][:password])
    if @user
      new_token = create_session_token
      session[:session_token] = new_token
      userid = @user.id
      user_info = {user_id: userid, token: new_token}
      Login.create(user_info)

      redirect_to cats_path
    else
      render :new
    end
  end
end
