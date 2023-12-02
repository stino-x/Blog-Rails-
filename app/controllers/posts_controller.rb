class PostsController < ApplicationController
  before_action :set_user, only: %i[index new create]
  before_action :set_post, only: %i[show destroy]

  def index
    @posts = Post.includes(:comments).paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:user_id])
    @like = current_user.likes.find_by(post: @post)
  end

  def destroy
    if @post
      @post.destroy
      flash[:success] = 'Post successfully deleted'
    else
      flash[:error] = 'Post not found'
    end

    redirect_to user_posts_path(author_id: current_user.id)
  end

  def new
    @post = @user.posts.build
  end

  def create
    @post = Post.new(post_params)
    @post.author = @user

    if @post.save
      flash[:success] = 'New post successfully added!'
      redirect_to user_post_path(@user, @post)
    else
      flash.now[:error] = 'Post creation failed'
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
