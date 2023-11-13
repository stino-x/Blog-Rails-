# spec/models/like_spec.rb

require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'John Doe', bio: 'Some bio content') }
  let(:post) { user.posts.create(title: 'Post Title', text: 'Post content') }

  describe 'associations' do
    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to a post' do
      association = described_class.reflect_on_association(:post)
      expect(association.macro).to eq :belongs_to
    end
  end

  describe 'callbacks' do
    it 'calls update_likes_counter after create' do
      user.likes.create(post:)
      post.reload
      expect(post.likes_counter).to eq(1)
    end

    it 'calls update_likes_counter after destroy' do
      like = user.likes.create(post:)
      like.destroy
      post.reload
      expect(post.likes_counter).to eq(0)
    end
  end

  describe 'callbacks' do
    it 'calls update_likes_counter after create' do
      user.likes.create(post:)
      post.reload
      expect(post.likes_counter).to eq(1)
    end

    it 'calls update_likes_counter after destroy' do
      like = user.likes.create(post:)
      like.destroy
      post.reload
      expect(post.likes_counter).to eq(0)
    end
  end
end
