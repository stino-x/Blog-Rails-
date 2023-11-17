class LikesController < ApplicationController
  def create
    @like = Like.create(like_params)
    redirect_to :back
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_to :back
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end
