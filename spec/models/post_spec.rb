# spec/models/post_spec.rb
require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John Doe', bio: 'Some bio content') }

  describe 'associations' do
    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'has many comments' do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq :has_many
    end

    it 'has many likes' do
      association = described_class.reflect_on_association(:likes)
      expect(association.macro).to eq :has_many
    end
  end

  describe 'validations' do
    it 'validates the presence of title' do
      post = Post.new # Assuming Post is your model name
      post.valid?
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'validates the length of title' do
      post = Post.new(title: 'a' * 251) # Assuming Post is your model name
      post.valid?
      expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
    end

    it 'validates the numericality of comments_counter' do
      post = Post.new(comments_counter: 'not_a_number')
      post.valid?
      expect(post.errors[:comments_counter]).to include('is not a number')
    end

    it 'validates the numericality of likes_counter' do
      post = Post.new(likes_counter: 'not_a_number')
      post.valid?
      expect(post.errors[:likes_counter]).to include('is not a number')
    end
  end
  describe 'callbacks' do
    it 'calls update_user_posts_counter after create' do
      # Make sure to provide the user association when creating a post
      user.posts.create(title: 'Post Title', text: 'Post content')
      user.reload
      expect(user.posts_counter).to eq(1)
    end
  end

  describe '#update_user_posts_counter' do
    it 'updates user posts_counter' do
      user = User.new(name: 'John Doe', bio: 'Some bio')
      user.save!

      post = Post.new(title: 'Post Title', text: 'Post content', user:)
      post.save!

      post.update_user_posts_counter

      user.reload # Ensure the user object is refreshed from the database
      expect(user.posts_counter).to eq(1)
    end
  end

  describe '#recent_comments' do
    it 'returns recent comments for the post' do
      post = user.posts.create(title: 'Post Title', text: 'Post content')

      post.comments.create(user:, text: 'Comment 1')
      comment2 = post.comments.create(user:, text: 'Comment 2')
      comment3 = post.comments.create(user:, text: 'Comment 3')

      expect(post.recent_comments(2)).to eq([comment3, comment2])
    end
  end
end
