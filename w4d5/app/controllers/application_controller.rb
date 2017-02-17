class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :logged_in?

  def current_user
    if session[:session_token]
      @current_user ||= User.find_by(session_token: session[:session_token])
    else
      nil
    end
  end

  def logged_in?
    !current_user.nil?
  end

end
