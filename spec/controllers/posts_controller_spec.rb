require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      user = User.create(name: 'John Doe')

      get :index, params: { user_id: user.id }
      expect(response).to be_successful
    end

    it 'renders the index template' do
      user = User.create(name: 'John Doe')

      get :index, params: { user_id: user.id }
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      user = User.create(name: 'John Doe')
      post = Post.create(title: 'Sample Post', text: 'something', author_id: user.id)

      # Use the route helper method to generate the path
      get :show, params: { id: post.id, user_id: user.id }
      expect(response).to be_successful
    end

    it 'renders the show template' do
      user = User.create(name: 'John Doe')
      post = Post.create(title: 'Sample Post', text: 'something', author_id: user.id)

      # Use the route helper method to generate the path
      get :show, params: { id: post.id, user_id: user.id }
      expect(response).to render_template(:show)
    end
  end
end
