class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :text, null: false
      t.integer :comments_counter, default: 0
      t.integer :likes_counter, default: 0

      # Add the author_id column to reference the users table
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
