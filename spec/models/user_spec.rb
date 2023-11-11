require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has many posts' do
      association = described_class.reflect_on_association(:posts)
      expect(association.macro).to eq :has_many
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
    it 'validates the presence of name' do
      user = User.new
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    # Uncomment the following block if you want to test bio validation
    # it 'allows nil for bio' do
    #   user = User.new(bio: nil)
    #   user.valid?
    #   expect(user.errors[:bio]).not_to include("can't be blank")
    # end

    it 'validates the numericality of posts_counter' do
      user = User.new(posts_counter: 'not_a_number')
      user.valid?
      expect(user.errors[:posts_counter]).to include('is not a number')
    end
  end

  describe 'custom methods' do
    it 'returns the most recent posts' do
      user = User.create(name: 'John Doe', bio: 'Some bio content')
      # Adjust this based on your model attributes

      post1 = Post.create(title: 'Post 1', text: 'Content 1', user:, created_at: 1.day.ago)
      post2 = Post.create(title: 'Post 2', text: 'Content 2', user:, created_at: 2.days.ago)
      post3 = Post.create(title: 'Post 3', text: 'Content 3', user:, created_at: 3.days.ago)

      expect(user.recent_posts).to eq([post1, post2, post3])
    end
  end
end
