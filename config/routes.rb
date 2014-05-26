Tnqa::Application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :questions do
    resources :comments
    resources :answers do
      resources :comments
    end
  end

  resources :comments, only: [:destroy, :update]

  get 'tags/:tag', to: 'questions#index', as: :tag

  root :to => "questions#index"
end
