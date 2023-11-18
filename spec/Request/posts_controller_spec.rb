require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    it 'returns a successful response' do
      user = User.create(name: 'John Doe')

      get user_posts_path(user)
      expect(response).to be_successful
    end

    it 'renders the index template' do
      user = User.create(name: 'John Doe')

      get user_posts_path(user)
      expect(response).to render_template(:index)
    end

    it 'displays the correct placeholder text in the response body' do
      user = User.create(name: 'John Doe')

      get user_posts_path(user)
      expect(response.body.to_s).to include('Here is a list of all the posts from this user')
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      user = User.create(name: 'John Doe')
      post = Post.create(title: 'Sample Post', text: 'something', author_id: user.id)

      get user_post_path(user, post)
      expect(response).to be_successful
    end

    it 'renders the show template' do
      user = User.create(name: 'John Doe')
      post = Post.create(title: 'Sample Post', text: 'something', author_id: user.id)

      get user_post_path(user, post)
      expect(response).to render_template(:show)
    end

    it 'displays the correct placeholder text in the response body' do
      user = User.create(name: 'John Doe')
      post = Post.create(title: 'Sample Post', text: 'something', author_id: user.id)

      get user_post_path(user, post)
      expect(response.body.to_s).to include('Here is the info for a particular post')
    end
  end
end
