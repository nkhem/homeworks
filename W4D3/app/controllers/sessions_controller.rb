class SessionsController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:destroy]

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params[:user_name],user_params[:password])
    login_user(@user)
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token], @current_user = nil, nil
      render :destroy
    else
      redirect_to new_session_url
    end
  end

  private

  def require_login
    if logged_in?
      redirect_to cats_url
    end
  end

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
