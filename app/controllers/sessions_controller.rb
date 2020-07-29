class SessionsController < ApplicationController
  def new
    render :login
  end

  def create
    if params[:user][:confirm_password]
      unless params[:user][:password] == params[:user][:confirm_password]
        flash.now[:error] = 'Passwords do not match'
        render :login
      end
    else
      @user = User.find_by_credentials(
        params[:user][:username],
        params[:user][:password])

      if @user.nil?
        flash.now[:error] = 'Invalid username or password'
        render :login
      else
        flash[:info] = 'Login successful!'
        login!(@user)
        redirect_to feed_url
      end
    end
  end

  def destroy
    logout!
    flash[:info] = 'Logout successful'
    redirect_to login_url
  end
end