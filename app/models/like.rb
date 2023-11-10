class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post
    after_create :update_likes_counter
    after_destroy :update_likes_counter

    private

    def update_likes_counter
      post.update(likes_counter: likes.count)
    end
  end
end
