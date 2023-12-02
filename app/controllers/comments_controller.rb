class CommentsController < ApplicationController
  before_action :set_user_and_post, only: %i[new create]

  def index_api
    @comments = Comment.where(post_id: params[:post_id])
    respond_to do |format|
      format.json { render json: @comments }
    end
  end

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.html do
          flash[:success] = 'Comment Added Successfully'
          redirect_to user_post_path(@user, @post)
        end
        format.json { render json: @comment, status: :created }
      else
        format.html do
          flash.now[:error] = 'Failed To Create Comment'
          render :new
        end
        format.json { render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity }
      end
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
