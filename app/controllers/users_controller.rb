class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new; end

  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to '/posts'
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end

  def show
    if params[:id] == 'sign_out'
      sign_out_current_user
      redirect_to new_user_session_path, notice: 'You have signed out successfully!'
    else
      @user = User.find(params[:id])
    end
  end

  private

  def sign_out_current_user
    sign_out(current_user)
    reset_session
  end

  def edit; end

  def update; end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to :back
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
