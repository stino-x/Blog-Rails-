class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = Like.new(user: current_user, post: @post)

    if @like.save
      flash[:success] = 'Post liked!'
    else
      flash[:error] = 'Like creation failed'
    end

    redirect_to user_post_path(@post.author, @post)
  end

  def destroy
    puts 'Destroy action called!'
    @post = Post.find(params[:post_id])
    @like = current_user.likes.find_by(post: @post)

    if @like.destroy
      flash[:success] = 'Post unliked!'
    else
      flash[:error] = 'Unlike failed'
    end

    redirect_to user_post_path(@post.author, @post)
  end
end
