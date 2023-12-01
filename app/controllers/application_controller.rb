class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :likes?

  private

  def likes?(post)
    current_user.likes.where(post:).exists?
  end

  def current_user
    @current_user ||= User.first
  end

  helper_method :current_user
end
