# spec/requests/users_controller_spec.rb
require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    it 'returns a successful response' do
      get users_path
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'assigns all users to @users' do
      user1 = User.create(name: 'John Doe')
      user2 = User.create(name: 'Jane Doe')

      get users_path
      expect(assigns(:users)).to eq([user1, user2])
    end

    it 'displays the correct placeholder text in the response body' do
      get users_path
      expect(response.body.to_s).to include('Here is a list of all posts for a user')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user' do
        expect do
          post users_path, params: { user: { name: 'John Doe' } }
        end.to change(User, :count).by(1)
      end
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      user = User.create(name: 'John Doe')
      get user_path(user)
      expect(response).to be_successful
    end

    it 'renders the show template' do
      user = User.create(name: 'John Doe')
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'assigns the requested user to @user' do
      user = User.create(name: 'John Doe')
      get user_path(user)
      expect(assigns(:user)).to eq(user)
    end

    it 'displays the correct placeholder text in the response body' do
      user = User.create(name: 'John Doe')
      get user_path(user)
      expect(response.body.to_s).to include('Here is the info for a particular post')
    end
  end
end
