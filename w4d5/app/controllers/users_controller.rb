class UsersController < ApplicationController
  def index
    render :index
  end

  def new
    if logged_in?
      redirect_to users_url
    else
      @user = User.new
      render :new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:session_token] = @user.reset_session_token!
      redirect_to user_url(current_user.id)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def show
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :confirmation_password)
  end
end
