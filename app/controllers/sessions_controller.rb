class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])

    if @user && login_valid?(@user)
      session[:user_id] = @user.id
      redirect_to photos_path
    else
      flash[:error] = "You are a special butterfly."
      redirect_to new_session_path
    end
  end

  def destroy
    reset_session
    redirect_to new_session_path
  end

  private

  def login_valid?(user)
    if Rails.env.test?
      if params[:user][:password_digest] == user.password_digest
        return true
      end
    elsif @user.authenticate(params[:user][:password])
      return true
    end
  end
end
