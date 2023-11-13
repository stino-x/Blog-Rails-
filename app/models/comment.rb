class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :post
  after_create :update_post_comments_counter
  after_destroy :update_post_comments_counter

  validates :text, presence: true

  private

  def update_post_comments_counter
    post.reload # Ensure you reload the post to get the latest comments count
    post.update(comments_counter: post.comments.count)
  end
end
