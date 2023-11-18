# spec/controllers/users_controller_spec.rb
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns all users to @users' do
      user1 = User.create(name: 'John Doe')
      user2 = User.create(name: 'Jane Doe')

      get :index
      expect(assigns(:users)).to eq([user1, user2])
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user' do
        expect {
          post :create, params: { user: { name: 'John Doe' } }
        }.to change(User, :count).by(1)
      end
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      user = User.create(name: 'John Doe')
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end

    it 'renders the show template' do
      user = User.create(name: 'John Doe')
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end

    it 'assigns the requested user to @user' do
      user = User.create(name: 'John Doe')
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end
  end
end
