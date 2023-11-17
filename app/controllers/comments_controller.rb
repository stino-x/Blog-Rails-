class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    redirect_to :back
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id)
  end
end
