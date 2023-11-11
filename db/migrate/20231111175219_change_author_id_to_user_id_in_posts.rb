class ChangeAuthorIdToUserIdInPosts < ActiveRecord::Migration[7.1]
  def change
    rename_column :posts, :author_id, :user_id
  end
end
