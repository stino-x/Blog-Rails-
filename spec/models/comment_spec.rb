require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'John Doe', bio: 'Some bio content') }
  let(:post) { Post.create(title: 'Post Title', text: 'Post content', user:) } # Change 'author' to 'user'

  it 'belongs to a post' do
    comment = Comment.new(text: 'Comment text', user:, post:) # Change 'author' to 'user'
    expect(comment.post).to eq(post)
  end

  it 'increments the post comments counter after creation' do
    expect do
      Comment.create(text: 'Comment text', user:, post:) # Change 'author' to 'user'
      post.reload
    end.to change { post.comments_counter }.by(1)
  end

  it 'decrements the post comments counter after destruction' do
    comment = Comment.create(text: 'Comment text', user:, post:) # Change 'author' to 'user'
    expect do
      comment.destroy
      post.reload
    end.to change { post.comments_counter }.by(-1)
  end

  it 'validates presence of text' do
    comment = Comment.new(user:, post:, text: nil)
    comment.valid?
    expect(comment.errors[:text]).to include("can't be blank")
  end
end
