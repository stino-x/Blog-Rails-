class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def update
    @post = Post.find(params[:id])
    if Post.update(post_params)
      redirect_to Post_path(Post), notice: 'Post updated successfully.'
    else
      render :edit
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.create(post_params)
    if @post.valid?
      session[:post_id] = @post.id
      redirect_to '/posts'
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to :back
    end
  end

  def show
    @post = Post.find_by_id(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to :back
  end

  private

  def post_params
    params.require(:post).permit(:name)
  end
end
