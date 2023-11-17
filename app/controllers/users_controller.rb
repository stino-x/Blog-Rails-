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
    @user = User.find(params[:id])
  end

  def edit; end

  def update; end

  def destroy
    @User = User.find(params[:id])
    @User.destroy
    redirect_to :back
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
