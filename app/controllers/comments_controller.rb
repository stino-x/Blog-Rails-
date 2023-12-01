class CommentsController < ApplicationController
  before_action :set_user_and_post, only: %i[new create]

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(comment_params)
    if @comment.save
      flash[:success] = 'Comment Added Successfully'
      redirect_to user_post_path(@user, @post)
    else
      flash.now[:error] = 'Failed To Create Comment'
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment
      @comment.destroy
      flash[:success] = 'Comment successfully deleted'
      redirect_to user_post_path(@comment.user, @comment.post)
    else
      flash[:error] = 'Comment not found'
      redirect_to some_path # Redirect to an appropriate path if the comment is not found
    end
  end

  private

  def set_user_and_post
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text, :user_id).merge(user_id: current_user.id)
  end
end
