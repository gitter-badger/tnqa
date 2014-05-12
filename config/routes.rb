Tnqa::Application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  
  resources :users
  resources :questions


  root :to => "questions#index"

  


end
