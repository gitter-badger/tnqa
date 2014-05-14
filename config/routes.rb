Tnqa::Application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  
  resources :questions do
   resources :answers
 end

  root :to => "questions#index"

  


end
