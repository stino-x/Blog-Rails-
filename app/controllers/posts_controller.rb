class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  # def update
  #   if @post.update(post_params)
  #     redirect_to user_post_path(@user, @post), notice: 'Post updated successfully.'
  #   else
  #     render :edit
  #   end
  # end

  # def edit
  #   @post = Post.find(params[:id])
  # end

  def create
    @post = Post.create(post_params)
    if @post.valid?
      session[:post_id] = @post.id
      redirect_to posts_path
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to :back
    end
  end

  def show
    @post = Post.find(params[:id])
    # @author_name = @post.author.name
    # @post_text = @post.text
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
