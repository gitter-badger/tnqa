Tnqa::Application.routes.draw do
  devise_for :users
  
  resources :users
  resources :questions


  root :to => "questions#index"

end
