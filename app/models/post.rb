class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  has_many :comments
  has_many :likes
  after_create :update_user_posts_counter
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def update_user_posts_counter
    user.update(posts_counter: user.posts.count)
    # user.reload
  end

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end
