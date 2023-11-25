class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :comments
  has_many :likes
  validates :name, presence: true, length: { maximum: 100 }
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def likes?(post)
    likes.exists?(post:)
  end
end
