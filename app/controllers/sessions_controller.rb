class SessionsController < ApplicationController
  def new

    render :login
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user.nil?
      flash.now[:error] = 'Invalid username or password'
      render :login
    else
      flash[:info] = 'Login successful!'
      login!(@user)
      redirect_to user_url(@user)
    end

  end

  def destroy
    logout!
    flash[:info] = 'Logout successful'
    redirect_to login_url
  end
end