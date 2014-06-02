Tnqa::Application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, only: [:show, :index]
  get 'tags/:tag', to: 'questions#index', as: :tag

  resources :questions do
    resources :comments
    resources :answers do
      resources :comments
    end
  end

  resources :answers do
    resources :comments
  end

  resources :comments

  resource :votes, only: [:create, :destroy]

  root :to => "questions#index"
end
