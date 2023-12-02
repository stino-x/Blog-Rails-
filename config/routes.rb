Rails.application.routes.draw do
  devise_for :users
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy] do
        collection do
          get :index_api, as: 'index', defaults: { format: :json }
        end
      end
      resources :likes, only: [:create, :destroy]
    end
    collection do
      get :index_api, as: 'index', defaults: { format: :json }
    end
  end
  # Defines the root path route ("/")
  root "users#index"
end
