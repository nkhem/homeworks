class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !(@current_user.nil?)
  end

  def login_user(user= nil)
    if user
      session[:session_token] = user.reset_session_token!
      flash[:welcome] = ["welcome"]
      redirect_to cats_url
    else
      flash[:errors] = ["invalid login credentials"]
      redirect_to new_session_url
    end

  end

end
