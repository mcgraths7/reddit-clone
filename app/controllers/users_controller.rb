class UsersController < ApplicationController
  def index
    @users = User.all
    render :index
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new
    @user.username = user_params[:username]
    @user.password = user_params[:password]
    if @user.save
      login!(@user)
      flash[:info] = "Welcome, #{@user.username}"
      redirect_to user_url(@user)
    else
      flash.now[:error] = 'There was a problem... Please try again.'
      render :new
    end
  end

  def show
    @user = selected_user
    if @user
      render :show
    else
      render :not_found
    end
  end

  def edit
    @user = selected_user
    render :edit
  end

  def update
    @user = selected_user
    if @user.update(user_params)
      flash[:info] = 'Update successful!'
      render @user
    else
      flash.now[:error] = 'There was a problem... Please try again'
      render :edit
    end
  end

  def destroy
    @user = selected_user
    if @user.destroy
      render json: "Sorry to see you go!"
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

  def selected_user
    User.find_by(id: params[:id])
  end
end