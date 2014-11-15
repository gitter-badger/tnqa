Tnqa::Application.routes.draw do
  use_doorkeeper
  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks' }
  resources :users, only: [:show, :index]
  get 'tags/:tag', to: 'questions#index', as: :tag

  resources :questions do
    collection do
      get :top, action: :index, type: :top
      get :unanswered, action: :index, type: :unanswered
      get :recent, action: :index, type: :recent     
    end
    resources :comments
    resources :answers do
      resources :comments
    end
  end

  resources :answers do
    resources :comments
  end

  resources :comments
  resources :tags, only: [:index]

  resource :votes, only: [:create, :destroy]
  resource :favorites, only: [:create, :destroy]
  resource :subscriptions, only: [:create, :destroy]

  namespace :api do
    namespace :v1 do
      resources :profiles do
        get :me, on: :collection
      end
    end
  end

  root :to => "questions#index"
end
