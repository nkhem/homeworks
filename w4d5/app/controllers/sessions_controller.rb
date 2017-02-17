class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if user
      session[:session_token] = user.reset_session_token!
      redirect_to user_url(user)
    else
      flash[:errors] = ["Invalid login credentials"]
      redirect_to new_session_url
    end
  end

  def destroy
    if logged_in?
      current_user.reset_session_token!
      session[:session_token], @current_user = nil, nil
      redirect_to users_url
    else
      redirect_to new_session_url
    end
  end

end
